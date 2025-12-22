import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/first_level_controller.dart';
import 'package:heamodialysis/dashboard/nephro_first_level/model/first_level_scrutiny_approval_list.dart';
import 'package:heamodialysis/login/login_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

class FirstLevelServiceDescriptionTab extends StatefulWidget {
  final FirstLevelTmCmScrutinyBean? patient;

  const FirstLevelServiceDescriptionTab({super.key, this.patient});

  @override
  State<FirstLevelServiceDescriptionTab> createState() =>
      _FirstLevelServiceDescriptionTabState();
}

class _FirstLevelServiceDescriptionTabState
    extends State<FirstLevelServiceDescriptionTab> {
  final FirstLevelController firstLevelScrutinyController =
      Get.find<FirstLevelController>();

  final LoginController loginController = Get.find<LoginController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var userData;

  @override
  void initState() {
    getUserData();
    firstLevelScrutinyController.description.text = "";
    super.initState();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ListView.builder(
                itemCount: firstLevelScrutinyController.levelOneList.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: Container(
                          margin: EdgeInsets.only(top: 12.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: ExpansionTile(
                            maintainState: true,
                            collapsedIconColor: AppColor.secondaryColor,
                            iconColor: AppColor.secondaryColor,
                            title: CustomText(
                                text: firstLevelScrutinyController
                                        .levelOneList[index].lvlName ??
                                    '',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                textColor: Colors.black,
                                textAlign: TextAlign.center),
                            subtitle: CustomText(
                                text: firstLevelScrutinyController
                                        .levelOneList[index]
                                        .scrutinyQuestionEn ??
                                    '',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                                textColor: Colors.black,
                                textAlign: TextAlign.start),
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CustomText(
                                          text: "Answer",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start)
                                      .paddingOnly(left: 8),
                                  CustomRadioFieldScrunity(
                                    key: UniqueKey(),
                                    isRequired: false,
                                    radioCallB1: (String value) {
                                      firstLevelScrutinyController
                                          .levelOneList[index]
                                          .tmCmScrutinyBean
                                          .scrutinyAnswer = value;

                                      setState(() {});
                                    },
                                    radioCallB2: (String value) {
                                      firstLevelScrutinyController
                                          .levelOneList[index]
                                          .tmCmScrutinyBean
                                          .scrutinyAnswer = value;
                                      setState(() {});
                                    },
                                    groupVal: firstLevelScrutinyController
                                            .levelOneList[index]
                                            .tmCmScrutinyBean
                                            .scrutinyAnswer ??
                                        "YES",
                                    text: '',
                                    firstRadioText: 'Yes',
                                    secondRadioText: 'No',
                                  ),
                                  CustomTextField(
                                    key: UniqueKey(),
                                    onChanged: (value) async {
                                      firstLevelScrutinyController
                                          .levelOneList[index]
                                          .tmCmScrutinyBean
                                          .scrutinyRemark = value;
                                    },
                                    maxLines: 1,
                                    isReadOnly: false,
                                    keyBoardType: TextInputType.text,
                                    labelText: 'Remark',
                                    hintText: 'Enter',
                                    isRequired: true,
                                    initialValue: firstLevelScrutinyController
                                        .levelOneList[index]
                                        .tmCmScrutinyBean
                                        .scrutinyRemark,
                                    fillColor: Colors.white,
                                    fontSize: 16.sp,
                                  )
                                ],
                              ).paddingOnly(left: 6.w)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.w),
                        alignment: Alignment.center,
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(
                              colors: [
                                AppColor.primaryBackgroundColor,
                                AppColor.secondaryColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            )),
                        child: CustomText(
                          text: (index + 1).toString(),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          textColor: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 4.h);
                }),
            Align(
              alignment: Alignment.centerLeft,
              child: const CustomText(
                      text: "Action",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black,
                      textAlign: TextAlign.left)
                  .paddingOnly(left: 6.w, top: 16.h),
            ),
            CustomRadioField(
              isRequired: false,
              radioCallB1: (value) {
                firstLevelScrutinyController.groupVal = value;
                setState(() {});
              },
              radioCallB2: (value) {
                firstLevelScrutinyController.groupVal = value;
                setState(() {});
              },
              radioCallB3: (value) {
                firstLevelScrutinyController.groupVal = value!;
                setState(() {});
              },
              groupVal: firstLevelScrutinyController.groupVal,
              text: '',
              firstRadioText: 'Approve',
              secondRadioText: 'Reject',
              thirdRadioText: 'Send Back',
              showThirdOption: true,
            ),
            CustomTextField(
              onChanged: (value) {},
              maxLines: 2,
              isReadOnly: false,
              keyBoardType: TextInputType.text,
              labelText: 'Description',
              hintText: 'Enter',
              isRequired: false,
              txtController: firstLevelScrutinyController.description,
              fillColor: Colors.white,
              fontSize: 16.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  primColor: AppColor.primaryBackgroundColor,
                  secColor: AppColor.secondaryColor,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  buttonText: 'Save',
                  path: 'assets/save-next.png',
                  callB: () {
                    if (formKey.currentState?.validate() ?? false) {
                      firstLevelScrutinyController
                              .firstLevelSendReqModel.tmCmScrutinyBean =
                          firstLevelScrutinyController.levelOneList.map((e) {
                        e.tmCmScrutinyBean.unitId =
                            userData['unitId'].toString();

                        e.tmCmScrutinyBean.scrutinyQDetId =
                            e.scrutinyQDetId.toString();
                        return e.tmCmScrutinyBean;
                      }).toList();

                      firstLevelScrutinyController
                              .firstLevelSendReqModel.patientId =
                          firstLevelScrutinyController.questionModel?.patientId
                              .toString();

                      firstLevelScrutinyController
                              .firstLevelSendReqModel.srnId =
                          firstLevelScrutinyController.questionModel?.srnId
                              .toString();

                      firstLevelScrutinyController
                              .firstLevelSendReqModel.srnId =
                          firstLevelScrutinyController.questionModel?.srnId
                              .toString();

                      firstLevelScrutinyController.firstLevelSendReqModel
                          .userId = userData['ui'].toString();

                      firstLevelScrutinyController
                          .firstLevelSendReqModel.treatmentId = "null";

                      firstLevelScrutinyController
                          .firstLevelSendReqModel.serviceCode = "NPV";

                      firstLevelScrutinyController
                          .firstLevelSendReqModel.complaintMasterId = "null";

                      // firstLevelScrutinyController.firstLevelSendReqModel
                      //     .unitId = userData['unitId'].toString();

                      firstLevelScrutinyController.firstLevelSendReqModel
                          .unitId = widget.patient?.unitId.toString();

                      firstLevelScrutinyController
                          .firstLevelSendReqModel.distId = "null";

                      // firstLevelScrutinyController
                      //         .firstLevelSendReqModel.approveRejectFlag =
                      //     firstLevelScrutinyController.groupVal.name == "yes"
                      //         ? "Y"
                      //         : "N";
                      // ✅ SET APPROVE/REJECT/SEND BACK FLAG
                      if (firstLevelScrutinyController.groupVal == CustomRadioButtons.yes) {
                        firstLevelScrutinyController.firstLevelSendReqModel.approveRejectFlag = "Y";
                        debugPrint('✅ Selected Action: APPROVE (Y)');
                      } else if (firstLevelScrutinyController.groupVal == CustomRadioButtons.no) {
                        firstLevelScrutinyController.firstLevelSendReqModel.approveRejectFlag = "N";
                        debugPrint('✅ Selected Action: REJECT (N)');
                      } else if (firstLevelScrutinyController.groupVal == CustomRadioButtons.sendBack) {
                        firstLevelScrutinyController.firstLevelSendReqModel.approveRejectFlag = "S";
                        debugPrint('✅ Selected Action: SEND BACK (S)');
                      }

                      firstLevelScrutinyController
                              .firstLevelSendReqModel.approveRejectRemark =
                          firstLevelScrutinyController.description.text
                              .toString();

                      firstLevelScrutinyController.sendToSecondLevel(
                          true, userData['ut']);
                    } else {
                      CustomMessage.toast("Please fill mandatory field");
                    }
                  },
                  buttonWidth: 100.w,
                ),
                SizedBox(
                  width: 20.w,
                ),
                CustomButton(
                  primColor: AppColor.red,
                  secColor: AppColor.red,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  buttonText: 'Cancel',
                  path: 'assets/cancel.png',
                  callB: () {
                    Get.back();
                  },
                  buttonWidth: 100.w,
                ),
              ],
            ).paddingOnly(top: 10.h),
          ],
        ),
      ),
    );
  }
}

class CustomRadioFieldScrunity extends StatelessWidget {
  final String text;
  final bool isRequired;
  final Function radioCallB1;
  final Function radioCallB2;
  final String? groupVal;
  final String firstRadioText;
  final String secondRadioText;

  const CustomRadioFieldScrunity(
      {super.key,
      required this.isRequired,
      required this.radioCallB1,
      required this.radioCallB2,
      this.groupVal,
      required this.text,
      required this.firstRadioText,
      required this.secondRadioText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (text.isNotEmpty)
          CustomText(
            text: text,
            fontSize: 14.sp,
            fontFam: 'Lato',
            fontWeight: FontWeight.normal,
            textColor: Colors.black,
            textAlign: TextAlign.center,
          ),
        if (isRequired)
          Text(
            ' *',
            style: TextStyle(
              color: AppColor.red,
              fontSize: 16.sp,
            ),
          ),
        if (text.isNotEmpty)
          SizedBox(
            width: 30.w,
          ),
        Radio(
          activeColor: AppColor.secondaryColor,
          value: "YES",
          groupValue: groupVal,
          onChanged: (value) {
            radioCallB1(value);
          },
        ),
        CustomText(
          text: firstRadioText,
          fontSize: 14.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.normal,
          textColor: Colors.black,
          textAlign: TextAlign.center,
        ),
        SizedBox(width: 30.w),
        Radio(
          activeColor: AppColor.secondaryColor,
          value: "NO",
          groupValue: groupVal,
          onChanged: (value) {
            radioCallB2(value);
          },
        ),
        CustomText(
          text: secondRadioText,
          fontSize: 14.sp,
          fontFam: 'Lato',
          fontWeight: FontWeight.normal,
          textColor: Colors.black,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
