import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/color_constants.dart';

class InternetIssue extends StatelessWidget {
  // const InternetIssue({super.key});

  final Function onRetryPressed;

  const InternetIssue({super.key, required this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height;
    final screenWidth = Get.width;
    return Card(
        elevation: 3.0,
        margin:  EdgeInsets.only(left: 10.w, right: 10.w, top: 40.h),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: screenHeight / 1.19,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Padding(
              padding:  EdgeInsets.only(
                  top: 30.h, bottom: 14.h, left: 14.w, right: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/internet.png",
                    width: 350.w,
                    height: 300.h,
                  ),
                   Center(
                      child: Text(
                        "Oh No! ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                      )),
                  const Center(
                      child: Column(
                        children: [
                          Text(
                            "No Internet found.",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "Check your connection or try again.",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                  Padding(
                    padding:  EdgeInsets.only(top: 100.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: Get.width / 3.5,
                          height: Get.height / 20,
                          child: ElevatedButton(
                            onPressed: () async {
                              // onRetryPressed();

                              // Show loader for a few seconds
                              Get.defaultDialog(
                                title: "Loading",
                                content:
                                const CircularProgressIndicator(),
                              );

                              // Wait for a few seconds
                              await Future.delayed(
                                  const Duration(seconds: 3));

                              // Close the loading dialog
                              Get.back();

                              // Call the retry function
                              onRetryPressed();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0),
                                ),
                                backgroundColor:
                                AppColor.secondaryColor,
                                foregroundColor:
                                AppColor.secondaryColor),
                            child:  Text(
                              "Retry",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
