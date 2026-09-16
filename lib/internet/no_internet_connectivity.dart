import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/l10n/l10n.dart';

class InternetIssue extends StatelessWidget {
  // const InternetIssue({super.key});

  final Function onRetryPressed;

  const InternetIssue({super.key, required this.onRetryPressed,});

  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height;
    final screenWidth = Get.width;
    return Card(
        elevation: 3.0,
       // margin:  EdgeInsets.only(left: 10.w, right: 10.w, top: 40.h),
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
                  top: 30.h, bottom: 14.h, left: 8.w, right: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/no_internet.png",
                    width: 350.w,
                    height: 300.h,
                  ),
                   SizedBox(height: 20,),
                   Center(
                      child: Text(
                        context.l10n.noInternetHeadline,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lato',          // font-family
                          fontSize: 24.sp,             // font-size: 24px
                          fontWeight: FontWeight.w700, // font-weight: 700 (Bold)
                          fontStyle: FontStyle.normal, // font-style: Bold ❌ → normal + w700
                          height: 1.0,                 // line-height: 100%
                          letterSpacing: 0,            // letter-spacing: 0%
                          color: Colors.black,
                        ),
                      )
                   ),
                  SizedBox(height: 40,),
                   Center(
                      child: Column(
                        children: [
                          Text(
                            context.l10n.noInternetMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Lato',          // font-family
                              fontSize: 19.sp,             // font-size: 24px
                              fontWeight: FontWeight.w400, // font-weight: 700 (Bold)
                              fontStyle: FontStyle.normal, // font-style: Bold ❌ → normal + w700
                              height: 1.2,                 // line-height: 100%
                              letterSpacing: 0,            // letter-spacing: 0%
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            context.l10n.noInternetHint,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              height: 1.2,
                              letterSpacing: 0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding:  EdgeInsets.only(top: 100.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: Get.width / 2.5,
                          height: Get.height / 20,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF27A9E3), // start
                                  Color(0xFF07B259), // end
                                ],
                              ),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                // onRetryPressed();

                                // Show loader for a few seconds
                                Get.defaultDialog(
                                  title: context.l10n.commonLoading,
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
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.arrow_forward,
                                        color: Colors.white),
                                    SizedBox(width: 14.w),
                                    Text(
                                      context.l10n.commonRetry,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )

                          ),
                        )
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
