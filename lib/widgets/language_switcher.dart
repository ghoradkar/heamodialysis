import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/utils/color_constants.dart';

/// Compact EN / FR / EN·FR segmented toggle. Reads and updates
/// [LocaleController], so every screen using `context.l10n` rebuilds in the
/// chosen display mode (English only, French only, or both side by side).
///
/// Set [onColor] true when placing it on the coloured gradient header
/// (white text) instead of a neutral surface (dark text).
class LanguageSwitcher extends StatelessWidget {
  final bool onColor;

  const LanguageSwitcher({super.key, this.onColor = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<LocaleController>()
        ? Get.find<LocaleController>()
        : Get.put(LocaleController(), permanent: true);

    final trackColor =
        onColor ? Colors.white.withValues(alpha: 0.18) : const Color(0xffF2F2F2);
    final activePillColor = onColor ? Colors.white : AppColor.primaryBackgroundColor;
    final activeTextColor = onColor ? AppColor.primaryBackgroundColor : Colors.white;
    final inactiveTextColor = onColor ? Colors.white70 : AppColor.grey;

    return Tooltip(
      message: context.l10n.changeLanguage,
      child: Obx(() {
        final current = controller.locale.value;
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Segment(
                label: 'EN',
                active: current == LocaleController.english,
                activePillColor: activePillColor,
                activeTextColor: activeTextColor,
                inactiveTextColor: inactiveTextColor,
                onTap: () => controller.setLocale(LocaleController.english),
              ),
              _Segment(
                label: 'FR',
                active: current == LocaleController.french,
                activePillColor: activePillColor,
                activeTextColor: activeTextColor,
                inactiveTextColor: inactiveTextColor,
                onTap: () => controller.setLocale(LocaleController.french),
              ),
              _Segment(
                label: 'EN/FR',
                active: current == LocaleController.bilingual,
                activePillColor: activePillColor,
                activeTextColor: activeTextColor,
                inactiveTextColor: inactiveTextColor,
                onTap: () => controller.setLocale(LocaleController.bilingual),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _Segment extends StatelessWidget {
  final String label;
  final bool active;
  final Color activePillColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final VoidCallback onTap;

  const _Segment({
    required this.label,
    required this.active,
    required this.activePillColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: active ? activePillColor : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w800,
              color: active ? activeTextColor : inactiveTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
