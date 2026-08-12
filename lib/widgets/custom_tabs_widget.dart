import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_constants.dart';
import 'custom_text.dart';
Widget buildButton({
  required int index,
  required int currentPage,
  required String text,
  VoidCallback? onTap,
}) {


  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: 80.w,
      height: 70.h,
      child: Stack(
        children: [

          /// 🔹 Main Card
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 2.w),
            decoration: BoxDecoration(
              gradient: currentPage == index
                  ? LinearGradient(
                colors: [
                  AppColor.primaryBackgroundColor,
                  AppColor.secondaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              )
                  : const LinearGradient(
                colors: [Colors.white, Colors.white],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: currentPage == index
                    ? AppColor.secondaryColor
                    : AppColor.borderColor,
              ),
            ),
            child: CustomText(
              text: text,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              textColor:
              currentPage == index ? Colors.white : Color(0xFF777777),
              textAlign: TextAlign.center,
            ),
          ),

          /// ✅ Check Icon – Top Right
          Positioned(
            top: 4,
            right: 4,
            child: Icon(
              Icons.check_circle,
              size: 16,
              color: currentPage == index
                  ? Colors.white
                  : Colors.transparent, // hide when not selected
            ),
          ),
        ],
      ),
    ),
  );
}
