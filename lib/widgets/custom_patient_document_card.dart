import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'custom_text.dart';

Widget patientDocumentCard({
  String? title,
  String? value,
  IconData? icon,
  int? index, // Add index parameter
  VoidCallback? onEyePressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Card container
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Title
                    if (title != null)
                      CustomText(
                        text: title,
                        fontSize: 12.sp,
                        textColor: Color(0xFF000000),
                        textAlign: TextAlign.center,
                        fontFam: "Lato",
                        fontWeight: FontWeight.w400,
                      ).paddingOnly(left: 8.w, bottom: 4.h),

                    // Value
                    if (value != null)
                      CustomText(
                        text: value,
                        fontSize: 12.sp,
                        textColor: Color(0xFF484848),
                        textAlign: TextAlign.center,
                        fontFam: "Lato",
                        fontWeight: FontWeight.w400,
                      ).paddingOnly(left: 8.w, bottom: 4.h),
                  ],
                ),

                // Optional icon
                if (icon != null)
                  IconButton(
                    onPressed: onEyePressed,
                    icon: Icon(
                      icon,
                      color: Color(0xFF257BAB),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Circular badge on top-left
        Positioned(
          top: -25,
          left: 11,
          child: Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF27A9E3),
                  Color(0xFF07B259),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                (index != null ? (index + 1).toString() : "1"), // Dynamic index number
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}