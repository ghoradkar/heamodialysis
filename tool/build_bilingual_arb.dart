// Localization ARB builder.
//
// Reads the two hand-maintained source translation files:
//   l10n_source/app_en.arb   (English  - the template, holds every @key metadata block)
//   l10n_source/app_fr.arb   (French)
//
// and writes the three files that `flutter gen-l10n` consumes - one per
// selectable display mode:
//   lib/l10n/app_en.arb      @@locale: en      English only
//   lib/l10n/app_fr.arb      @@locale: fr      French only
//   lib/l10n/app_en_FR.arb   @@locale: en_FR   Bilingual  "<English> / <French>"
//
// `en_FR` is not a real locale - it is the carrier tag for the bilingual
// display mode. `LocaleController` maps the three in-app options to
// Locale('en'), Locale('fr') and Locale('en','FR').
//
// No call site changes: context.l10n.someKey returns whatever the active
// locale holds - a single-language string or the combined "EN / FR" one.
//
// Usage:
//   dart run tool/build_bilingual_arb.dart            # rebuild all three
//   dart run tool/build_bilingual_arb.dart --gen      # + run `flutter gen-l10n`
//   dart run tool/build_bilingual_arb.dart --sep " - " # custom bilingual separator

import 'dart:convert';
import 'dart:io';

const _sourceDir = 'l10n_source';
const _outDir = 'lib/l10n';
const _defaultSeparator = ' / ';

void main(List<String> args) {
  var separator = _defaultSeparator;
  var runGen = false;

  for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--sep':
      case '--separator':
        separator = _next(args, ++i, '--sep');
        break;
      case '--gen':
        runGen = true;
        break;
      case '-h':
      case '--help':
        stdout.writeln(_usage);
        return;
      default:
        _fail('Unknown argument: ${args[i]}\n\n$_usage');
    }
  }

  final enSource = _readArb('$_sourceDir/app_en.arb');
  final frSource = _readArb('$_sourceDir/app_fr.arb');

  _checkParity(enSource, frSource);

  final en = _build(enSource, frSource, mode: _Mode.en, separator: separator);
  final fr = _build(enSource, frSource, mode: _Mode.fr, separator: separator);
  final bi = _build(enSource, frSource, mode: _Mode.bilingual, separator: separator);

  _writeArb('$_outDir/app_en.arb', en, locale: 'en');
  _writeArb('$_outDir/app_fr.arb', fr, locale: 'fr');
  _writeArb('$_outDir/app_en_FR.arb', bi, locale: 'en_FR');

  final messageCount = en.keys.where((k) => !k.startsWith('@')).length;
  stdout.writeln('OK  keys=$messageCount  separator="$separator"');
  stdout.writeln('Wrote app_en.arb, app_fr.arb, app_en_FR.arb in $_outDir/');

  if (runGen) {
    stdout.writeln('Running: flutter gen-l10n');
    final result = Process.runSync('flutter', ['gen-l10n'], runInShell: true);
    stdout.write(result.stdout);
    stderr.write(result.stderr);
    if (result.exitCode != 0) exit(result.exitCode);
  } else {
    stdout.writeln('Next: flutter gen-l10n');
  }
}

enum _Mode { en, fr, bilingual }

/// Reads an ARB file preserving key order (jsonDecode keeps insertion order).
Map<String, dynamic> _readArb(String path) {
  final file = File(path);
  if (!file.existsSync()) _fail('Source file not found: $path');
  try {
    return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  } on FormatException catch (e) {
    _fail('$path is not valid JSON: ${e.message}');
  }
}

/// Fails if the two sources do not declare exactly the same message keys.
void _checkParity(Map<String, dynamic> en, Map<String, dynamic> fr) {
  bool isMessage(String k) => !k.startsWith('@');
  final enKeys = en.keys.where(isMessage).toSet();
  final frKeys = fr.keys.where(isMessage).toSet();

  final missingInFr = enKeys.difference(frKeys);
  final missingInEn = frKeys.difference(enKeys);
  if (missingInFr.isEmpty && missingInEn.isEmpty) return;

  final buf = StringBuffer('Source files are out of sync:\n');
  if (missingInFr.isNotEmpty) {
    buf.writeln('  Missing in app_fr.arb (${missingInFr.length}):');
    for (final k in missingInFr) {
      buf.writeln('    $k');
    }
  }
  if (missingInEn.isNotEmpty) {
    buf.writeln('  Missing in app_en.arb (${missingInEn.length}):');
    for (final k in missingInEn) {
      buf.writeln('    $k');
    }
  }
  _fail(buf.toString());
}

/// Builds one variant, preserving the English source's key order and its
/// @key metadata blocks verbatim.
Map<String, dynamic> _build(
  Map<String, dynamic> en,
  Map<String, dynamic> fr, {
  required _Mode mode,
  required String separator,
}) {
  final out = <String, dynamic>{};

  en.forEach((key, enValue) {
    if (key == '@@locale') return; // set per output file
    if (key.startsWith('@')) {
      out[key] = enValue; // metadata - copy from English
      return;
    }
    if (enValue is! String) {
      _fail('Non-string value for message key "$key" in app_en.arb');
    }
    final enStr = enValue.trim();
    final frStr = (fr[key] as String).trim();

    switch (mode) {
      case _Mode.en:
        out[key] = enStr;
        break;
      case _Mode.fr:
        out[key] = frStr;
        break;
      case _Mode.bilingual:
        // Same text in both languages (codes, symbols, brand names, "Type",
        // "Email", ...) is emitted once - no "Type / Type".
        out[key] = (enStr == frStr) ? enStr : '$enStr$separator$frStr';
        break;
    }
  });

  return out;
}

void _writeArb(String path, Map<String, dynamic> body, {required String locale}) {
  final ordered = <String, dynamic>{'@@locale': locale, ...body};
  final json = const JsonEncoder.withIndent('  ').convert(ordered);
  // writeAsString uses UTF-8 by default - accented characters are written as
  // real UTF-8 bytes, not escaped. Do NOT re-encode.
  File(path).writeAsStringSync('$json\n');
}

String _next(List<String> args, int i, String flag) {
  if (i >= args.length) _fail('$flag needs a value');
  return args[i];
}

Never _fail(String message) {
  stderr.writeln('ERROR: $message');
  exit(1);
}

const _usage = '''
build_bilingual_arb - merge l10n_source/app_en.arb + app_fr.arb into
                      lib/l10n/{app_en,app_fr,app_en_FR}.arb

  --sep "<text>"   separator for the bilingual variant (default " / ")
  --gen            also run `flutter gen-l10n` afterwards
  -h, --help
''';
