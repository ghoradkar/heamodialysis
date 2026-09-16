import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class DashCard extends StatelessWidget {
  final String? title;
  final String? firstCount;
  final String? secondCount;
  final String? pendingCount;
  final String? complateCount;
  final String? firstCountText;
  final String? secondCountText;
  final String iconPath;
  final bool? isVisiableRow;
  final bool? isVisiableCol;
  final bool isSecondCount;
  final bool? isInfoVisible;
  final Function? onInfoClick;
  final double cardHeight;

  const DashCard(
      {super.key,
      this.title,
      this.firstCount,
      this.secondCount,
      this.firstCountText,
      this.secondCountText,
      required this.iconPath,
      this.isVisiableRow,
      this.pendingCount,
      this.complateCount,
      this.isVisiableCol,
      required this.isSecondCount,
      this.onInfoClick,
      this.isInfoVisible,
      required this.cardHeight});

  @override
  Widget build(BuildContext context) {
    double height = cardHeight;
    if (isVisiableRow == true || isVisiableCol == true) {
      height = cardHeight < 120.h ? 120.h : cardHeight;
    } else {
      height = cardHeight < 108.h ? 108.h : cardHeight;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
      child: Column(

        children: [
          SizedBox(
            height: 35.h,
            child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
             //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  iconPath,
                  width: 26.w,
                  height: 26.w,
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: CustomText(
                    text: title ?? "",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    textColor: Colors.black,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          InkWell(
            onTap: () {
              if (onInfoClick != null) {
                onInfoClick!();
              }
            },
            child: Container(
              // width: 180,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.4), // Shadow color
                    spreadRadius: 1, // How much the shadow should spread
                    blurRadius: 4, // How soft the shadow should appear
                    offset:
                        const Offset(1, 1), // The position of the shadow (x, y)
                  ),
                ],
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFe9f6fb),
                    Color(0xFFe6f7ef),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: firstCount ?? "",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                textColor:AppColor.grey,
                                textAlign: TextAlign.start),
                            CustomText(
                                text: firstCountText ?? "",
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                textColor: AppColor.grey,
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      if (isSecondCount) ...[
                        SizedBox(
                          width: 6.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: secondCount ?? "",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  textColor:  AppColor.grey,
                                  textAlign: TextAlign.start),
                              CustomText(
                                  text: secondCountText ?? "",
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                  textColor:  AppColor.grey,
                                  textAlign: TextAlign.start),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  Visibility(
                      visible: isVisiableRow == true,
                      child: SizedBox(
                        height: 8.h,
                      )),
                  Visibility(
                    visible: isVisiableRow == true,
                    // Scale the whole "Pending .. Complete .." line down to fit
                    // the card width - the labels are much wider in French /
                    // bilingual mode and would otherwise overflow.
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                              text: context.l10n.dashPending,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              textColor: AppColor.grey,
                              textAlign: TextAlign.start),
                          SizedBox(
                            width: 4.w,
                          ),
                          CustomText(
                              text: pendingCount ?? "",
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              textColor: AppColor.grey,
                              textAlign: TextAlign.start),
                          SizedBox(width: 14.w),
                          CustomText(
                              text: context.l10n.dashComplete,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              textColor: AppColor.grey,
                              textAlign: TextAlign.start),
                          SizedBox(
                            width: 3.w,
                          ),
                          CustomText(
                              text: complateCount ?? "",
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              textColor: AppColor.grey,
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isVisiableCol == true,
                      child: SizedBox(
                        height: 6.h,
                      )),
                  Visibility(
                    visible: isVisiableCol == true,
                    child: CustomText(
                        text: context.l10n.dashTotalPending,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        textColor:  AppColor.grey,
                        textAlign: TextAlign.start),
                  ),
                  Visibility(
                      visible: isVisiableCol == true,
                      child: SizedBox(
                        width: 4.w,
                      )),
                  Visibility(
                    visible: isVisiableCol == true,
                    child: CustomText(
                        text: pendingCount ?? "",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColor.grey,
                        textAlign: TextAlign.start),
                  ),
                  Visibility(
                      visible: isVisiableCol == true, child: const Spacer()),
                  Visibility(
                    visible: isVisiableCol == true,
                    child: CustomText(
                        text: context.l10n.dashTotalComplete,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                        textColor:  AppColor.grey,
                        textAlign: TextAlign.start),
                  ),
                  Visibility(
                      visible: isVisiableCol == true,
                      child: SizedBox(
                        width: 4.w,
                      )),
                  Visibility(

                    visible: isVisiableCol == true,
                    child: CustomText(
                        text: complateCount ?? "",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        textColor: AppColor.grey,
                        textAlign: TextAlign.start),
                  ),
                  Visibility(
                    visible: isInfoVisible == true,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            if (onInfoClick != null) {
                              onInfoClick!();
                            }
                          },
                          child: Image.asset(
                            'assets/info.png',
                            color: AppColor.primaryBackgroundColor,
                            width: 24.w,
                            height: 24.h,
                          )),
                    ),
                  )
                ],
              ).paddingSymmetric(vertical: 6.h, horizontal: 6.w),
            ),
          ),
        ],
      ),
    );
  }
}
