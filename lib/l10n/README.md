# Localization (English / French / bilingual)

The user picks the display mode at runtime from the `LanguageSwitcher`
(`EN` / `FR` / `EN/FR`):

| Mode | `context.l10n.colPatientName` returns |
|---|---|
| English | `Patient Name` |
| Français | `Nom du patient` |
| Bilingue | `Patient Name / Nom du patient` |

No call sites change. The two hand-maintained translation files are compiled
into **three** ARB variants; `LocaleController` swaps between them live.

## Layout

| Path | Purpose |
|---|---|
| `l10n_source/app_en.arb` | **Edit here.** English - the template, holds every `@key` metadata block. |
| `l10n_source/app_fr.arb` | **Edit here.** French. Must have exactly the same keys as `app_en.arb`. |
| `tool/build_bilingual_arb.dart` | Compiles the two sources → the three generated ARBs below. |
| `lib/l10n/app_en.arb` | **Generated - do not edit.** English only, `@@locale: en`. |
| `lib/l10n/app_fr.arb` | **Generated - do not edit.** French only, `@@locale: fr`. |
| `lib/l10n/app_en_FR.arb` | **Generated - do not edit.** Bilingual `"EN / FR"`, `@@locale: en_FR`. `en_FR` is a synthetic carrier tag for "bilingual mode", **not** a real locale. |
| `l10n.yaml` (repo root) | gen-l10n config. Template = `app_en.arb`, output class `AppLocalizations`, output dir `lib/l10n/gen`. |
| `lib/l10n/gen/` | Generated code (`AppLocalizationsEn`, `AppLocalizationsFr`, `AppLocalizationsEnFr`). Committed. |
| `lib/l10n/locale_controller.dart` | `LocaleController` (GetX). Modes: `english` / `french` / `bilingual` (= `Locale('en','FR')`). Default = `bilingual`. Persists to SharedPreferences (`kAppLocale` = `en` / `fr` / `en_FR`). |
| `lib/l10n/l10n.dart` | Single import. `context.l10n` + context-less `l10n` getter. |
| `lib/widgets/language_switcher.dart` | 3-segment `EN` / `FR` / `EN/FR` toggle. |

## Workflow: adding / changing a string

1. Edit **`l10n_source/app_en.arb`** and **`l10n_source/app_fr.arb`** (both, same key).
2. Regenerate (one command):
   ```
   dart run tool/build_bilingual_arb.dart --gen
   ```
   (`--gen` compiles the sources into `lib/l10n/app_{en,fr,en_FR}.arb` **and**
   runs `flutter gen-l10n`.)
3. Commit the source files, the three generated `lib/l10n/*.arb`, and `lib/l10n/gen/`.

The builder **fails** if the two source files don't declare the same keys.

### Bilingual merge rules

- `"Save"` + `"Enregistrer"` → `"Save / Enregistrer"`.
- Placeholders are kept in both halves:
  `"{field} is required"` + `"{field} est obligatoire"` →
  `"{field} is required / {field} est obligatoire"` (gen-l10n allows a
  placeholder used more than once).
- If English == French (codes, `Type`, `Email`, brand names) the value is
  emitted **once** - no `Type / Type`.
- `@key` metadata is copied from the English source.
- Separator override: `dart run tool/build_bilingual_arb.dart --sep " - " --gen`.

## Usage in code

```dart
import 'package:heamodialysis/l10n/l10n.dart';

// In a widget - returns whatever the active mode holds:
Text(context.l10n.commonSave)

// In a GetX controller / repository / toast helper (no BuildContext):
CustomMessage.toast(l10n.commonSomethingWentWrong);
```

## Key naming convention

- Shared/reused strings: `common<Thing>` - e.g. `commonSave`, `commonNoDataFound`.
- Module strings: `<module><Screen or area><Element>` - e.g.
  `loginUsernameLabel`, `roLogSheetAddTitle`, `nephroDeskPrescriptionTab`.
- Strings with runtime values use ARB placeholders, never string concatenation:
  `"fieldRequired": "{field} is required"` → `l10n.fieldRequired(label)`.

## DO NOT translate

These are API-contract values compared in code and/or sent to the backend.
Translating them breaks logic:

- User role codes: `NEPHROLOGIST`, `DOCTOR`, `SUPER ADMIN`, `ADMIN`, `TECHNICIAN`,
  `Technician`, `nurse`, `OPERATION HEAD`, `OPERATIONAL TEAM`, `MIS`,
  `CLUSTER HEAD DISTRICT`, `CLUSTER HEAD DIVISION`, `INVOICE SECOND APPROVAL`,
  `INVOICE GENERATION`, `DIETICIAN`, `HOD ONE`.
- Login status codes: `Success`, `OTP_REQUIRED`.
- Any value used as a `Map` key, `switch` case, or equality check against a
  server string.

## Known refactors (Phase 1)

1. **`widgets/custom_textfield.dart`** - DONE. `CustomTextField` / `DoubleTextField`
   now take an optional `fieldKey` (see `FieldKeys`) used for all input-formatter /
   validation branching; `labelText` is display-only and falls back as the key when
   `fieldKey` is omitted (so un-migrated call sites keep working). As each screen is
   localized, pass `fieldKey: FieldKeys.mobileNo` + `labelText: <localized>`.
2. **`widgets/cust_toast.dart`, `Get.snackbar`, `Get.dialog`** - many call sites
   live in controllers. Use the context-less `l10n` getter from `l10n.dart`.
   `custom_popup.dart` already migrated this way.
3. **`main.dart` + `device_preview`** - DevicePreview is `enabled: false` and does
   not feed its locale into `GetMaterialApp`. If DevicePreview locale tooling is
   ever enabled, wire `locale`/`builder` through `DevicePreview`.

## Progress

- **Phase 0** - DONE (infra, switcher, `common*` seed).
- **Phase 1** - in progress:
  - DONE: `custom_textfield.dart` (fieldKey refactor + validator/hint strings),
    `custom_popup.dart`, `custom_table.dart`, `date_picker.dart`, `bar_chart.dart`,
    `internet/no_internet_connectivity.dart`, `splash_screen.dart`,
    `dashboard/widget/drawer_screen.dart` (all menu labels + version), switcher in
    login + drawer.
  - DONE: full `login/` module - `login_screen.dart`, `otp_screen.dart`,
    `logout_screen.dart`, `login_navigation.dart`, `login_controller.dart`.
    Server-returned `status` strings ("Success", "OTP_REQUIRED", "Invalid User",
    "Invalid or Expired OTP") left untouched - still compared in code. Only the
    client-side `?? fallback` and client-composed toasts were localized; full
    server-message i18n needs a status->key mapper or backend support (Phase 3).
  - DONE: `utils/status_update_screen.dart` ("Go Back"). `session_manager.dart`
    has no user-facing strings. `utils/custom_shimmer_loader.dart` contains a
    dead sample `PatientListPage` with mock data - not wired to any route, left
    as-is (delete in a cleanup pass, don't localize).
  - **Phase 1 complete.** Remaining feature-bound widget literals (`dash_card`,
    `patient_card_details`, `scheme_performance_chart`,
    `widgets/custom_shimmer_loader` dialog/legend) are localized with their
    Phase 2 module.

- **Phase 2** - IN PROGRESS.
  - **dashboard module: DONE.** All screens + widgets localized:
    - shared widgets: `dialysis_session_technician`, `functional_center_table`,
      `table_bill_generation`, `dash_info_table_techni`, `dash_info_table_admin`
      (6 tables), `dash_info_table_total` (4 tables), `widgets/dash_card`,
      `widgets/scheme_performance_chart`. `widgets/new_dashcard` & `radila_chart`
      have no literals.
    - screens: `technician/institutewise_dashboard_screen` (main landing),
      `super_admin/super_admin_dash_screen`, `super_admin/operational_head`,
      `cluster_dashboard/*` (2), `mis/mis_dash`, `nephro_first_level/*` (5),
      `nephro_second_level/*` (5).
    - `dashboard_controller` / `first_level_controller` carry no client-facing
      literals (server `data['message']` toasts left as-is).
    - Namespaces added: `col*` (shared column headers incl. `\n` compound MIS
      headers), `dash*` (card titles/count-labels), `mis*`, `nephro*`, `chart*`.
    - Card `\n` line-breaks in count labels were dropped (text wraps naturally);
      trailing `" : "` on patient-card labels kept via `"${l10n.key} : "`.
    - `scrutiny_*_list` screens: the `cardItemDetailsList` instance field became
      `_cardItemDetailsList(context)` so labels can localize.
    - ~6 `use_build_context_synchronously` info lints remain per screen where
      `context.l10n` is read in a `Get.to(...)` inside an async `showPopUp`/
      `showData` callback - benign (navigation, context always valid); not errors.

- **new_registration: DONE.** All 5 screens + controller. `pageTitle` stays an
  English key (compared as string) - mapped to a localized label for AppBar
  display via `_localizedPageTitle`. Dropdown fallback option lists
  (Male/Female/education/occupation/socio-eco) left English - their values feed
  `switch/case` -> backend int codes. `reg*` + `tab*` namespaces.
- **registered_patient_list: DONE.** 2 screens + controller + `widgets/patient_card_details`
  + `widgets/registered_patient_cardlist`. `cardItemDetailsList` fields ->
  `_cardItemDetailsList(context)`. `UserType`/`ApprovalStatus`/`Approved`/`Success`
  left (JSON keys / server codes).
- **schedular: DONE.** 9 screens + controller + 3 `model/` widget files
  (schedular_pre_dialysis / post_dialysis / consultation_details - these are
  clinical-detail views, not data models). Introduced `clin*` shared namespace
  for dialysis-parameter labels (Dry Weight, Access Site, Dialyser Type, Pulse,
  etc.) - dialysis_queue will reuse it. `sched*` for schedular-specific.

- **dialysis_queue: DONE.** 45 non-model files across consumable_entry, dialysis_event,
  hd_chart, investigation, post_dialysis, pre_dialysis (+ patient_history tabs).
  `dq*` namespace; heavy `clin*` reuse. Test/placeholder literals ("Aarshdeep
  Hospital", "Cancelggg", sample dates, "Ultraflux AV 600S") left as-is.
- **nephro_desk_patient_list: DONE.** 29 non-model files. `nephro*` namespace.
  "ICD10"/"ICDO" (coding-standard names) left. Marathi/Hindi instruction-field
  labels keyed as `nephroInstructionMarathi/Hindi` (were in Devanagari script).
- **discharge_form, machine_status, billing, book_appointment, capture_photo,
  cctv, upload_document: DONE.** `disch*`, `mach*`, `bill*`, `book*`, `photo*`,
  `cctv*`, `upload*` namespaces. Viral-status legend labels (HIV+, Hepatitis C+,
  Negative) localized as display.
- **ro_maintenance, patient_health_trends: DONE.** `ro*` (water-treatment params:
  TDS/PSI/flow labels keep their unit suffixes), `pht*` (chart/report labels).

**Phase 2 COMPLETE - all 15 feature modules localized.** ARB ~730 keys, EN/FR
parity, 0 analyzer errors project-wide. Elevated `use_build_context_synchronously`
and `prefer_const` info-lint counts are the known cost of the perl-batch approach
(de-consting widgets when injecting `context.l10n`); none are errors.

## Phase 3 (QA - not started)

- Sweep for missed literals per module (grep `text: '`, `labelText: "`, toasts).
- Verify no do-not-translate value was touched (role/status codes, switch/case
  dropdown keys, JSON field names, `pageTitle` logic comparisons).
- Native French review - clinical/nephrology terminology (`clin*`, `nephro*`, `ro*`).
- Re-tighten `const` where the perl over-removed it (info lints only).
- Server-returned message localization (needs status->key mapper or backend i18n).
- Live locale-switch test on every screen + French overflow pass.

<!-- old ordering, kept for reference -->
- Phase 2 module order was: new_registration ->
  registered_patient_list -> schedular -> dialysis_queue ->
  nephro_desk_patient_list -> discharge_form -> ro_maintenance -> machine_status
  -> billing -> book_appointment -> patient_health_trends -> upload_document ->
  capture_photo -> cctv.

## Module rollout order

Phase 1 (cross-cutting): `widgets/*` literals, `internet/`, `utils/` messages,
`splash/`, `dashboard/widget/drawer_screen.dart`, `login/`, full `common*` block.

Phase 2 (one batch per module): dashboard → new_registration →
registered_patient_list → schedular → dialysis_queue → nephro_desk_patient_list →
discharge_form → ro_maintenance → machine_status → billing → book_appointment →
patient_health_trends → upload_document → capture_photo → cctv.

Phase 3: sweep for missed literals, verify no do-not-translate value was touched,
native French review (nephrology domain), overflow pass, live-switch + persistence test.
