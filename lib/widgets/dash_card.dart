import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: CustomText(
                  text: title ?? "",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.black,
                  textAlign: TextAlign.start,
                  //overflow: TextOverflow.ellipsis,   // prevents overflow
                ),
              ),
            ],
          ),
         const SizedBox(height:10),
          InkWell(
            onTap: () {
              if (onInfoClick != null) {
                onInfoClick!();
              }
            },
            child: Container(
              // width: 180,
              height: cardHeight,
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
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
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
                      SizedBox(
                        width: 6.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: isSecondCount,
                            child: CustomText(
                                text: secondCount ?? "",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                textColor:  AppColor.grey,
                                textAlign: TextAlign.start),
                          ),
                          Visibility(
                            visible: isSecondCount,
                            child: CustomText(
                                text: secondCountText ?? "",
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                textColor:  AppColor.grey,
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                      visible: isVisiableRow == true,
                      child: SizedBox(
                        height: 8.h,
                      )),
                  Visibility(
                    visible: isVisiableRow == true,
                    child: Row(
                      children: [
                        CustomText(
                            text: "Pending",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            textColor:  AppColor.grey,
                            textAlign: TextAlign.start),
                        SizedBox(
                          width: 4.w,
                        ),
                        CustomText(
                            text: pendingCount ?? "",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            textColor:  AppColor.grey,
                            textAlign: TextAlign.start),
                        const Spacer(),
                        CustomText(
                            text: "Complete",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            textColor:  AppColor.grey,
                            textAlign: TextAlign.start),
                        SizedBox(
                          width: 3.w,
                        ),
                        CustomText(
                            text: complateCount ?? "",
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            textColor:  AppColor.grey,
                            textAlign: TextAlign.start),
                      ],
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
                        text: "Total Pending",
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
                        text: "Total Complete",
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
