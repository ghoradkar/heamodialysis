import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/new_registration/model/view_patient_model.dart';
import 'package:heamodialysis/new_registration/screens/upload_document_tab.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:intl/intl.dart';

class HistoryOfDialysis extends StatefulWidget {
  final Function callB;
  final bool isViewPatient;
  final ViewPatientModel? viewPatientModel;
  final String? pageTitle;

  const HistoryOfDialysis(
      {super.key,
      required this.callB,
      required this.isViewPatient,
      this.viewPatientModel,
      this.pageTitle});

  @override
  State<HistoryOfDialysis> createState() => _HistoryOfDialysisState();
}

class _HistoryOfDialysisState extends State<HistoryOfDialysis>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final NewRegistrationController newRegistrationController =
      Get.find<NewRegistrationController>();

  @override
  void initState() {
    // if (widget.isViewPatient || widget.pageTitle == 'Edit Patient Details') {
    //   newRegistrationController.dialysisDate.text = '';
    //   newRegistrationController.hospitalName.text = '';
    //   newRegistrationController.lastDialysisDate.text = '';
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.borderColor)),
              child: Column(
                children: [
                   Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                        text: 'First Time Dialysis ?',
                        fontSize: 16.sp,
                        fontFam: "Lato",
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                  ).paddingOnly(left: 6.w, top: 10.h),
                  CustomRadioField(
                    isRequired: false,
                    radioCallB1: (value) {
                      newRegistrationController.groupVal = value;
                      setState(() {});
                    },
                    radioCallB2: (value) {
                      newRegistrationController.groupVal = value;
                      setState(() {});
                    },
                    groupVal: newRegistrationController.groupVal,
                    text: '',
                    firstRadioText: 'Yes',
                    secondRadioText: 'No',
                  ),
                  Visibility(
                    visible: newRegistrationController.groupVal ==
                        CustomRadioButtons.no,
                    child: Column(
                      children: [
                        CustomDateField(
                          isViewProfile: widget.isViewPatient,
                          labelText: 'First Dialysis Session Date',
                          hint: 'Select',
                          isRequired: true,
                          callB: () {
                            _selectDate(context);
                          },
                          selectedDate: newRegistrationController.dialysisDate,
                          filledColor: Colors.white,
                          dontDhowPrefix: false,
                        ),
                        CustomTextField(
                          maxLines: 1,
                          isReadOnly: widget.isViewPatient ? true : false,
                          keyBoardType: TextInputType.streetAddress,
                          labelText: 'Last Dialysis Hospital Name',
                          hintText: 'Enter',
                          isRequired: true,
                          txtController: newRegistrationController.hospitalName,
                          fillColor: Colors.white,
                          fontSize: 16.sp,
                        ),
                        CustomDateField(
                          isViewProfile: widget.isViewPatient,
                          labelText: 'Last Dialysis Session Date',
                          hint: 'Select',
                          isRequired: true,
                          callB: () {
                            _selectDate1(context);
                          },
                          selectedDate:
                              newRegistrationController.lastDialysisDate,
                          filledColor: Colors.white,
                          dontDhowPrefix: false,
                        ),

                        CustomUploadButton(
                          isSelected: newRegistrationController
                              .historyOfDialysis.isSelected,
                          index: 0,
                          title:
                              newRegistrationController.historyOfDialysis.name,
                          callB: () {
                            pickFile(newRegistrationController
                                .historyOfDialysis.key);
                          },
                          callDelete: () {
                            // newRegistrationController.items[index].isSelected = false;
                            newRegistrationController
                                .historyOfDialysis.isSelected = false;
                            newRegistrationController.historyOfDialysis.file =
                                null;
                            setState(() {});
                          },
                          viewCallBack: () {
                            Get.to(() => CustomViewer(
                                  fileUrl: newRegistrationController
                                      .historyOfDialysis.file!.path,
                                ));
                            // }
                          },
                          // isReq:
                          //     newRegistrationController.historyOfDialysis.isReq,
                          isReq: true,
                          isViewProfile: widget.isViewPatient,
                          showIndex: false,
                        ).paddingOnly(bottom: 8.h, left: 5.w, right: 5.w, top: 8.h),

                        // CustomDocUploadField(
                        //   labelText: 'Upload Document',
                        //   hint: 'Select',
                        //   isRequired: true,
                        //   callB: () {
                        //     pickFile();
                        //   },
                        //   selectedDate: newRegistrationController.imagePath,
                        //   filledColor: Colors.white,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ).paddingOnly(top: 10.h, left: 4.w, right: 4.w),
             SizedBox(
              height: 40.h,
            ),
            Visibility(
              visible: widget.isViewPatient == false,
              child: CustomButton(
                primColor: AppColor.primaryBackgroundColor,
                secColor: AppColor.secondaryColor,
                textColor: Colors.white,
                iconColor: Colors.white,
                buttonText: 'Save & Next',
                path: 'assets/save-next.png',
                callB: () {

                  if (formKey.currentState?.validate() ?? false) {
                    if (newRegistrationController.historyOfDialysis.file !=
                            null &&
                        newRegistrationController.groupVal ==
                            CustomRadioButtons.no) {
                      widget.callB();
                    } else if (newRegistrationController.groupVal ==
                        CustomRadioButtons.yes) {
                      widget.callB();
                    } else {
                      CustomMessage.toast("Please select document");
                    }
                  }

                },
                buttonWidth: 160.w,
              ),
            ),
             SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
  //   );
  //
  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     String extension = file.path.split('.').last.toLowerCase();
  //     int fileSizeInBytes = await file.length();
  //     double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
  //
  //     if (['jpg', 'jpeg', 'png'].contains(extension) && fileSizeInMB > 10) {
  //       debugPrint('Image should not exceed 10 MB.');
  //       return;
  //     }
  //
  //     setState(() {
  //       newRegistrationController.uploadedFile = file;
  //       newRegistrationController.imagePath.text = file.path;
  //     });
  //   } else {
  //     debugPrint('No file selected.');
  //   }
  // }

  Future<void> pickFile(String key) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String extension = file.path.split('.').last.toLowerCase();
      int fileSizeInBytes = await file.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (['jpg', 'jpeg', 'png'].contains(extension) && fileSizeInMB > 10) {
        debugPrint('Image should not exceed 10 MB.');
        return;
      }

      setState(() {
        // FileDetails uploadedFile =
        // newRegistrationController.items.firstWhere((e) => e.key == key);

        FileDetails uploadedFile = newRegistrationController.historyOfDialysis;
        uploadedFile.file = file;
        uploadedFile.isSelected = true;
      });

      debugPrint(newRegistrationController.historyOfDialysis.name.toString());
    } else {
      debugPrint('No file selected.');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != newRegistrationController.selectedDate2) {
      // setState(() {
      newRegistrationController.selectedDate2 = picked;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      newRegistrationController.formattedDateDBOHistoryOfD =
          formatter.format(newRegistrationController.selectedDate2!);
      newRegistrationController.dialysisDate.text =
          newRegistrationController.formattedDateDBOHistoryOfD ?? "";

      // });
      setState(() {});
      // newRegistrationController.refreshUi();
    }
  }

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != newRegistrationController.selectedDate1) {
      // setState(() {
      newRegistrationController.selectedDate1 = picked;
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      newRegistrationController.formattedDateDBOHistoryOfD =
          formatter.format(newRegistrationController.selectedDate1!);
      newRegistrationController.lastDialysisDate.text =
          newRegistrationController.formattedDateDBOHistoryOfD ?? "";

      // });
      setState(() {});
      // newRegistrationController.refreshUi();
    }
  }

  // void setValuesIfViewPatient() {
  //   if (widget.viewPatientModel?.data?.firstTimeDialysisFlag == null ||
  //       widget.viewPatientModel?.data?.firstTimeDialysisFlag == "Y") {
  //     newRegistrationController.groupVal = CustomRadioButtons.yes;
  //   } else {
  //     newRegistrationController.groupVal = CustomRadioButtons.no;
  //     newRegistrationController.hospitalName.text = widget.viewPatientModel?.data?.previoushospitalName ?? "";
  //     DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(widget.viewPatientModel?.data?.sstartSessionDate);
  //
  //     // Format the DateTime to "dd/MM/yy"
  //     String formattedDate = DateFormat('dd/MM/yy').format(dateTime);
  //     newRegistrationController.dialysisDate.text = formattedDate;
  //
  //     DateTime dateTime1 = DateTime.fromMillisecondsSinceEpoch(widget.viewPatientModel?.data?.hospitalsessionDate);
  //
  //     // Format the DateTime to "dd/MM/yy"
  //     String formattedDate1 = DateFormat('dd/MM/yy').format(dateTime1);
  //     newRegistrationController.lastDialysisDate.text =formattedDate1;
  //   }
  // }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
