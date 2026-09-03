import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/controller/first_level_controller.dart';
import 'package:heamodialysis/dashboard/model/first_level_scrutiny_approval_list.dart';
import 'package:heamodialysis/login/controller/login_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_expandable.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';


class SecondLevelServiceDescriptionTab extends StatefulWidget {
  final FirstLevelTmCmScrutinyBean? patient;

  const SecondLevelServiceDescriptionTab({super.key, this.patient});

  @override
  State<SecondLevelServiceDescriptionTab> createState() =>
      _SecondLevelServiceDescriptionTabState();
}

class _SecondLevelServiceDescriptionTabState
    extends State<SecondLevelServiceDescriptionTab> {
  final FirstLevelController firstLevelScrutinyController =
      Get.find<FirstLevelController>();

  final LoginController loginController = Get.find<LoginController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var userData;

  int selectedIndex = 0;

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
            CustomRadioFieldScrunity(
              isRequired: false,
              radioCallB1: (String value) {
                firstLevelScrutinyController.groupValLevel = value;
                selectedIndex = 0;
                setState(() {});
              },
              radioCallB2: (String value) {
                firstLevelScrutinyController.groupValLevel = value;
                selectedIndex = 1;

                setState(() {});
              },
              groupVal: firstLevelScrutinyController.groupValLevel ?? "Level1",
              text: '',
              firstRadioText: 'Level1',
              secondRadioText: 'Level2',
              val1: 'Level1',
              val2: 'Level2',
            ),
            IndexedStack(
              index: selectedIndex, // Controls which child is displayed
              children: <Widget>[
                ListView.builder(
                    itemCount:
                        firstLevelScrutinyController.levelOneAnswerList.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CustomExpandableContainer(
                            text: firstLevelScrutinyController.levelOneList[index].scrutinyQuestionEn ?? '',
                            child: Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(top: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,border: Border.all(color: Colors.grey.shade300,width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CustomText(
                                      text: "Answer",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start)
                                      .paddingOnly(left: 8.w),
                                  CustomRadioFieldScrunity(
                                    key: UniqueKey(),
                                    isRequired: false,
                                    radioCallB1: (String value) {},
                                    radioCallB2: (String value) {},
                                    groupVal: firstLevelScrutinyController
                                        .levelOneAnswerList[index]
                                        .scrutinyAnswer ??
                                        "YES",
                                    text: '',
                                    firstRadioText: 'Yes',
                                    secondRadioText: 'No',
                                    val1: 'YES',
                                    val2: 'NO',
                                  ),
                                  CustomTextField(
                                    key: UniqueKey(),
                                    onChanged: (value) {
                                      //
                                      //
                                      // firstLevelScrutinyController.answerList?.details
                                      //     ?.listTtServiceRequestMovementBean?[index]
                                      //     .scrutinyRemarks = value;
                                    },
                                    maxLines: 1,
                                    isReadOnly: true,
                                    keyBoardType: TextInputType.text,
                                    labelText: 'Remark',
                                    hintText: 'Enter',
                                    isRequired: true,
                                    initialValue:
                                    firstLevelScrutinyController
                                        .levelOneAnswerList[index]
                                        .scrutinyRemarks,
                                    fillColor: Colors.white,
                                    fontSize: 16.sp,
                                  )
                                  // Add your CustomRadioFieldScrunity or CustomTextField here
                                ],
                              ),
                            ),
                          )

/*
                          Theme(
                            data: ThemeData()
                                .copyWith(dividerColor: Colors.transparent),
                            child: Container(
                              margin: EdgeInsets.only(top: 12.h),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),border: Border.all(color:Colors.grey.shade300,width: 1)),
                              child: ExpansionTile(
                                maintainState: true,
                                collapsedIconColor: AppColor.secondaryColor,
                                iconColor: AppColor.secondaryColor,
                                title :CustomText(
                                  // text: firstLevelScrutinyController
                                  //     .levelOneList[index]
                                  //     .scrutinyQuestionEn ??
                                  //     '',
                                    text: index <
                                        firstLevelScrutinyController
                                            .levelOneList.length
                                        ? firstLevelScrutinyController
                                        .levelOneList[index]
                                        .scrutinyQuestionEn ??
                                        ''
                                        : '',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    textColor: Colors.black,
                                    textAlign: TextAlign.start),
                                // title: CustomText(
                                //     text: firstLevelScrutinyController
                                //             .levelOneAnswerList[index]
                                //             .scrutinyLVL ??
                                //         '',
                                //     fontSize: 16.sp,
                                //     fontWeight: FontWeight.w500,
                                //     textColor: Colors.black,
                                //     textAlign: TextAlign.center),
                                // subtitle: CustomText(
                                //     // text: firstLevelScrutinyController
                                //     //     .levelOneList[index]
                                //     //     .scrutinyQuestionEn ??
                                //     //     '',
                                //     text: index <
                                //             firstLevelScrutinyController
                                //                 .levelOneList.length
                                //         ? firstLevelScrutinyController
                                //                 .levelOneList[index]
                                //                 .scrutinyQuestionEn ??
                                //             ''
                                //         : '',
                                //     fontSize: 16.sp,
                                //     fontWeight: FontWeight.normal,
                                //     textColor: Colors.black,
                                //     textAlign: TextAlign.start),
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      CustomText(
                                          text: "Answer",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start)
                                          .paddingOnly(left: 8.w),
                                      CustomRadioFieldScrunity(
                                        key: UniqueKey(),
                                        isRequired: false,
                                        radioCallB1: (String value) {},
                                        radioCallB2: (String value) {},
                                        groupVal: firstLevelScrutinyController
                                            .levelOneAnswerList[index]
                                            .scrutinyAnswer ??
                                            "YES",
                                        text: '',
                                        firstRadioText: 'Yes',
                                        secondRadioText: 'No',
                                        val1: 'YES',
                                        val2: 'NO',
                                      ),
                                      CustomTextField(
                                        key: UniqueKey(),
                                        onChanged: (value) {
                                          //
                                          //
                                          // firstLevelScrutinyController.answerList?.details
                                          //     ?.listTtServiceRequestMovementBean?[index]
                                          //     .scrutinyRemarks = value;
                                        },
                                        maxLines: 1,
                                        isReadOnly: true,
                                        keyBoardType: TextInputType.text,
                                        labelText: 'Remark',
                                        hintText: 'Enter',
                                        isRequired: true,
                                        initialValue:
                                        firstLevelScrutinyController
                                            .levelOneAnswerList[index]
                                            .scrutinyRemarks,
                                        fillColor: Colors.white,
                                        fontSize: 16.sp,
                                      )
                                    ],
                                  ).paddingOnly(left: 6.w)
                                ],
                              ),
                            ),
                          ),

*/

                          // Container(
                          //   margin: EdgeInsets.only(left: 16.w),
                          //   alignment: Alignment.center,
                          //   width: 28.w,
                          //   height: 28.h,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(50),
                          //       gradient: LinearGradient(
                          //         colors: [
                          //           AppColor.primaryBackgroundColor,
                          //           AppColor.secondaryColor
                          //         ],
                          //         begin: Alignment.topLeft,
                          //         end: Alignment.bottomCenter,
                          //       )),
                          //   child: CustomText(
                          //     text: (index + 1).toString(),
                          //     fontSize: 12.sp,
                          //     fontWeight: FontWeight.w500,
                          //     textColor: Colors.white,
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                        ],
                      ).paddingSymmetric(vertical: 4.h);
                    }),
                Column(
                  children: [
                    ListView.builder(
                        itemCount:
                            firstLevelScrutinyController.levelSecondList.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              CustomExpandableContainer(
                                text: firstLevelScrutinyController
                                    .levelSecondList[index]
                                    .scrutinyQuestionEn ??
                                    '',
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,border: Border.all(color: Colors.grey.shade300,width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      CustomText(
                                          text: "Answer",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start)
                                          .paddingOnly(left: 8.w),
                                      CustomRadioFieldScrunity(
                                        key: UniqueKey(),
                                        isRequired: false,
                                        radioCallB1: (String value) {
                                          firstLevelScrutinyController
                                              .levelSecondList[index]
                                              .tmCmScrutinyBean
                                              .scrutinyAnswer = value;

                                          setState(() {});
                                        },
                                        radioCallB2: (String value) {
                                          firstLevelScrutinyController
                                              .levelSecondList[index]
                                              .tmCmScrutinyBean
                                              .scrutinyAnswer = value;
                                          setState(() {});
                                        },
                                        groupVal:
                                        firstLevelScrutinyController
                                            .levelSecondList[index]
                                            .tmCmScrutinyBean
                                            .scrutinyAnswer ??
                                            "YES",
                                        text: '',
                                        firstRadioText: 'Yes',
                                        secondRadioText: 'No',
                                        val1: 'YES',
                                        val2: 'NO',
                                      ),
                                      CustomTextField(
                                        key: UniqueKey(),
                                        onChanged: (value) async {
                                          firstLevelScrutinyController
                                              .levelSecondList[index]
                                              .tmCmScrutinyBean
                                              .scrutinyRemark = value;
                                        },
                                        maxLines: 1,
                                        isReadOnly: false,
                                        keyBoardType: TextInputType.text,
                                        labelText: 'Remark',
                                        hintText: 'Enter',
                                        isRequired: true,
                                        initialValue:
                                        firstLevelScrutinyController
                                            .levelSecondList[index]
                                            .tmCmScrutinyBean
                                            .scrutinyRemark,
                                        fillColor: Colors.white,
                                        fontSize: 16.sp,
                                      )

                                    ],
                                  ),
                                ),
                              ),
                              // Theme(
                              //   data: ThemeData()
                              //       .copyWith(dividerColor: Colors.transparent),
                              //   child: Container(
                              //     margin: EdgeInsets.only(top: 12.h),
                              //     decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         borderRadius: BorderRadius.circular(10)),
                              //     child: ExpansionTile(
                              //       maintainState: true,
                              //       collapsedIconColor: AppColor.secondaryColor,
                              //       iconColor: AppColor.secondaryColor,
                              //       title: Text(''),
                              //       // CustomText(
                              //       //     text: firstLevelScrutinyController
                              //       //             .levelSecondList[index]
                              //       //             .lvlName ??
                              //       //         '',
                              //       //     fontSize: 16.sp,
                              //       //     fontWeight: FontWeight.w500,
                              //       //     textColor: Colors.black,
                              //       //     textAlign: TextAlign.center),
                              //       subtitle: CustomText(
                              //           text: firstLevelScrutinyController
                              //                   .levelSecondList[index]
                              //                   .scrutinyQuestionEn ??
                              //               '',
                              //           fontSize: 16.sp,
                              //           fontWeight: FontWeight.normal,
                              //           textColor: Colors.black,
                              //           textAlign: TextAlign.start),
                              //       children: [
                              //         Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.stretch,
                              //           children: [
                              //             CustomText(
                              //                     text: "Answer",
                              //                     fontSize: 16.sp,
                              //                     fontWeight: FontWeight.w500,
                              //                     textColor: Colors.black,
                              //                     textAlign: TextAlign.start)
                              //                 .paddingOnly(left: 8.w),
                              //             CustomRadioFieldScrunity(
                              //               key: UniqueKey(),
                              //               isRequired: false,
                              //               radioCallB1: (String value) {
                              //                 firstLevelScrutinyController
                              //                     .levelSecondList[index]
                              //                     .tmCmScrutinyBean
                              //                     .scrutinyAnswer = value;
                              //
                              //                 setState(() {});
                              //               },
                              //               radioCallB2: (String value) {
                              //                 firstLevelScrutinyController
                              //                     .levelSecondList[index]
                              //                     .tmCmScrutinyBean
                              //                     .scrutinyAnswer = value;
                              //                 setState(() {});
                              //               },
                              //               groupVal:
                              //                   firstLevelScrutinyController
                              //                           .levelSecondList[index]
                              //                           .tmCmScrutinyBean
                              //                           .scrutinyAnswer ??
                              //                       "YES",
                              //               text: '',
                              //               firstRadioText: 'Yes',
                              //               secondRadioText: 'No',
                              //               val1: 'YES',
                              //               val2: 'NO',
                              //             ),
                              //             CustomTextField(
                              //               key: UniqueKey(),
                              //               onChanged: (value) async {
                              //                 firstLevelScrutinyController
                              //                     .levelSecondList[index]
                              //                     .tmCmScrutinyBean
                              //                     .scrutinyRemark = value;
                              //               },
                              //               maxLines: 1,
                              //               isReadOnly: false,
                              //               keyBoardType: TextInputType.text,
                              //               labelText: 'Remark',
                              //               hintText: 'Enter',
                              //               isRequired: true,
                              //               initialValue:
                              //                   firstLevelScrutinyController
                              //                       .levelSecondList[index]
                              //                       .tmCmScrutinyBean
                              //                       .scrutinyRemark,
                              //               fillColor: Colors.white,
                              //               fontSize: 16.sp,
                              //             )
                              //
                              //           ],
                              //         ).paddingOnly(left: 6)
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   margin: EdgeInsets.only(left: 16.w),
                              //   alignment: Alignment.center,
                              //   width: 28.w,
                              //   height: 28.h,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(50),
                              //       gradient: LinearGradient(
                              //         colors: [
                              //           AppColor.primaryBackgroundColor,
                              //           AppColor.secondaryColor
                              //         ],
                              //         begin: Alignment.topLeft,
                              //         end: Alignment.bottomCenter,
                              //       )),
                              //   child: CustomText(
                              //     text: (index + 1).toString(),
                              //     fontSize: 12,
                              //     fontWeight: FontWeight.w500,
                              //     textColor: Colors.white,
                              //     textAlign: TextAlign.center,
                              //   ),
                              // ),
                            ],
                          ).paddingSymmetric(vertical: 4.h);
                        }),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                              text: "Action",
                              fontSize: 16.sp,
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
                      groupVal: firstLevelScrutinyController.groupVal,
                      text: '',
                      firstRadioText: 'Approve',
                      secondRadioText: 'Reject',
                      thirdRadioText: 'Send Back',
                      showThirdOption: true,
                      radioCallB3: (value) {
                        firstLevelScrutinyController.groupVal = value!;
                      },
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
                    Visibility(
                      visible: firstLevelScrutinyController.groupValLevel ==
                          "Level2",
                      child: Row(
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
                                        .firstLevelSendReqModel
                                        .tmCmScrutinyBean =
                                    firstLevelScrutinyController.levelSecondList
                                        .map((e) {
                                  e.tmCmScrutinyBean.unitId =
                                      userData['unitId'].toString();
                                  // e.tmCmScrutinyBean.unitId = userData['unitId'];

                                  e.tmCmScrutinyBean.scrutinyQDetId =
                                      e.scrutinyQDetId.toString();
                                  return e.tmCmScrutinyBean;
                                }).toList();

                                firstLevelScrutinyController
                                        .firstLevelSendReqModel.patientId =
                                    firstLevelScrutinyController
                                        .questionModel?.patientId
                                        .toString();

                                firstLevelScrutinyController
                                        .firstLevelSendReqModel.srnId =
                                    firstLevelScrutinyController
                                        .questionModel?.srnId
                                        .toString();

                                firstLevelScrutinyController
                                        .firstLevelSendReqModel.srnId =
                                    firstLevelScrutinyController
                                        .questionModel?.srnId
                                        .toString();

                                firstLevelScrutinyController
                                    .firstLevelSendReqModel
                                    .userId = userData['user_ID'].toString();

                                firstLevelScrutinyController
                                    .firstLevelSendReqModel
                                    .treatmentId = "null";

                                firstLevelScrutinyController
                                    .firstLevelSendReqModel.serviceCode = "NPV";

                                firstLevelScrutinyController
                                    .firstLevelSendReqModel
                                    .complaintMasterId = "null";

                                // firstLevelScrutinyController.firstLevelSendReqModel
                                //     .unitId = userData['unitId'];

                                firstLevelScrutinyController
                                    .firstLevelSendReqModel
                                    .unitId = widget.patient?.unitId.toString();
                                firstLevelScrutinyController
                                    .firstLevelSendReqModel.distId = "null";
                                // FIX THIS PART - Handle all three cases properly
                                if (firstLevelScrutinyController.groupVal ==
                                    CustomRadioButtons.yes) {
                                  firstLevelScrutinyController
                                      .firstLevelSendReqModel
                                      .approveRejectFlag = "Y";
                                } else if (firstLevelScrutinyController
                                        .groupVal ==
                                    CustomRadioButtons.no) {
                                  firstLevelScrutinyController
                                      .firstLevelSendReqModel
                                      .approveRejectFlag = "N";
                                } else if (firstLevelScrutinyController
                                        .groupVal ==
                                    CustomRadioButtons.sendBack) {
                                  // For Send Back, use "S" as shown in your API
                                  firstLevelScrutinyController
                                      .firstLevelSendReqModel
                                      .approveRejectFlag = "S";
                                }
                                // firstLevelScrutinyController
                                //         .firstLevelSendReqModel
                                //         .approveRejectFlag =
                                //     firstLevelScrutinyController
                                //                 .groupVal.name ==
                                //             "yes"
                                //         ? "Y"
                                //         : "N";

                                firstLevelScrutinyController
                                        .firstLevelSendReqModel
                                        .approveRejectRemark =
                                    firstLevelScrutinyController
                                        .description.text
                                        .toString();

                                firstLevelScrutinyController.sendToSecondLevel(
                                    false, userData['user_Type']);
                              } else {
                                CustomMessage.toast(
                                    "Please fill mandatory field");
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
                    ),
                  ],
                )
              ],
            ),
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
  final String val1;
  final String val2;
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
      required this.secondRadioText,
      required this.val1,
      required this.val2});

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
              fontSize: 16,
            ),
          ),
        if (text.isNotEmpty)
          SizedBox(
            width: 30.w,
          ),
        Radio(
          activeColor: AppColor.secondaryColor.withOpacity(0.5),
          value: val1,
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
          activeColor: AppColor.secondaryColor.withOpacity(0.5),
          value: val2,
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
