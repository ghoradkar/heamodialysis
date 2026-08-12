import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

class CustomPopup {
  static void showSuccessDialog(
      Function callB, String dialogText, String dialogContent) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                        text: "",
                        fontSize: 16,
                        fontFam: "Lato",
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                        textAlign: TextAlign.center),
                    CustomText(
                        text: dialogText,
                        fontSize: 18,
                        fontFam: "Lato",
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                        textAlign: TextAlign.center),
                    InkWell(
                        onTap: () {
                          callB();
                          // Get.off(const DashScreen());
                        },
                        child: Image.asset(
                          "assets/cancel.png",
                          width: 26,
                          height: 26,
                          color: AppColor.secondaryColor,
                        )),
                  ],
                ).paddingSymmetric(horizontal: 6, vertical: 8),
                Image.asset(
                  'assets/success-popup.png',
                  width: 70,
                  height: 70,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.borderColor),
                      color: const Color(0xffF8F8F8)),
                  child: Column(
                    children: [
                      CustomText(
                          text: dialogContent,
                          fontSize: 16,
                          fontFam: "Lato",
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      CustomButton(
                        primColor: AppColor.primaryBackgroundColor,
                        secColor: AppColor.secondaryColor,
                        buttonText: 'Ok',
                        path: 'assets/check.png',
                        callB: () {
                          callB();
                        },
                        buttonWidth: 80,
                        textColor: Colors.white,
                        iconColor: Colors.white,
                      ),
                    ],
                  ),
                ).paddingOnly(top: 8, bottom: 14, left: 10, right: 10)
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showConfirmationDialog(Function cancelCallB, Function noCallBack,
      Function yesCallB, String dialogText, String dialogContent, String path) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                      text: "",
                      fontSize: 16,
                      fontFam: "Lato",
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.center),
                  CustomText(
                      text: dialogText,
                      fontSize: 16,
                      fontFam: "Lato",
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.center),
                ],
              ).paddingSymmetric(horizontal: 6, vertical: 8),
              Image.asset(
                path,
                width: 70,
                height: 70,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.borderColor),
                    color: const Color(0xffF8F8F8)),
                child: Column(
                  children: [
                    CustomText(
                        text: dialogContent,
                        fontSize: 16,
                        fontFam: "Late",
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                        textAlign: TextAlign.center),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          primColor: AppColor.borderColor,
                          secColor: AppColor.borderColor,
                          buttonText: 'No',
                          path: 'assets/cancel.png',
                          callB: () {
                            noCallBack();
                          },
                          buttonWidth: 80,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                        ),
                        const SizedBox(
                          width: 20,
                          height: 20,
                        ),
                        CustomButton(
                          primColor: AppColor.primaryBackgroundColor,
                          secColor: AppColor.secondaryColor,
                          buttonText: 'Yes',
                          path: 'assets/check.png',
                          callB: () {
                            yesCallB();
                          },
                          buttonWidth: 80,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
              ).paddingOnly(top: 8, bottom: 14, left: 14, right: 14)
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showAlertDialog(Function cancelCallB, Function okCallB,
      String dialogText, String dialogContent, String path,bool isVisible,String successText,Function? noCallB) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                      text: "",
                      fontSize: 16,
                      fontFam: "Lato",
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.center),
                  CustomText(
                      text: dialogText,
                      fontSize: 16,
                      fontFam: "Lato",
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.center),
                  InkWell(
                      onTap: () {
                        cancelCallB();
                        // Get.off(const DashScreen());
                      },
                      child: Image.asset(
                        "assets/cancel.png",
                        width: 24,
                        height: 24,
                        color: AppColor.secondaryColor,
                      )),
                ],
              ).paddingSymmetric(horizontal: 6, vertical: 8),
              Image.asset(
                path,
                width: 70,
                height: 70,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.borderColor),
                    color: const Color(0xffF8F8F8)),
                child: Column(
                  children: [
                    CustomText(
                        text: dialogContent,
                        fontSize: 16,
                        fontFam: "Late",
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                        textAlign: TextAlign.center),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          primColor: AppColor.primaryBackgroundColor,
                          secColor: AppColor.secondaryColor,
                          buttonText: successText,
                          path: 'assets/check.png',
                          callB: () {
                            okCallB();
                          },
                          buttonWidth: 80,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                        ),
                        Visibility(
                          visible: isVisible,
                          child: CustomButton(
                            primColor: AppColor.borderColor,
                            secColor: AppColor.borderColor,
                            buttonText: 'No',
                            path: 'assets/cancel.png',
                            callB: () {
                              noCallB!();
                            },
                            buttonWidth: 80,
                            textColor: Colors.white,
                            iconColor: Colors.white,
                          ).paddingOnly(left: 6),
                        ),
                      ],
                    )
                  ],
                ),
              ).paddingOnly(top: 8, bottom: 14, left: 14, right: 14)
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
