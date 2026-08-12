import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/new_registration/screens/upload_document_tab.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/controller/ro_desinfection_details_controller.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/ro_maint_details/pro_li_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screens/ro_disinfection_details.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class AddRoDesinfectionDetails extends StatefulWidget {
  final ProLiData? proLiItem;
  final bool? isEdit;

  const AddRoDesinfectionDetails({super.key, this.proLiItem, this.isEdit});

  @override
  State<AddRoDesinfectionDetails> createState() =>
      _AddRoDesinfectionDetailsState();
}

class _AddRoDesinfectionDetailsState extends State<AddRoDesinfectionDetails> {
  final RoDesinfectionDetailsController roMaintDetailsController =
      Get.put(RoDesinfectionDetailsController());

  DateTime? selectedInspection;
  DateTime? selectedNextInspection;

  String formattedDate1 = '';
  String formattedDate2 = '';

  bool hasInternet = true;

  var userData;

  InstituteDataModel? ins;

  MachineData? mac;

  DisinfectData? desIn;

  DoneByData? don;

  @override
  void initState() {
    // TODO: implement initState
    roMaintDetailsController.uploadImage.clear();
    checkInternetAndLoadData();
    super.initState();
  }

  void addCard() {
    // Create a fresh cardData for the new card
    ROFileDetails newCard = ROFileDetails(
        name: 'Upload Image',
        key: 'files',
        isSelected: false,
        isReq: false,
        isView: false);

    // Add the new card to the list
    roMaintDetailsController.uploadImage.add(newCard);

    // Trigger UI update
    setState(() {});
  }

  void removeCard(int index) {
    if (roMaintDetailsController.uploadImage.length > 1) {
      roMaintDetailsController.uploadImage.removeAt(index);
      setState(() {});
    }
  }

  getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    addCard();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    roMaintDetailsController.update();
    if (hasInternet) {
      await getUserData();

      await roMaintDetailsController.getInstituteList();
      await roMaintDetailsController
          .getMachineList(int.parse(userData['unitId'].toString()));
      await roMaintDetailsController.getDisinfecUsed();
      await roMaintDetailsController
          .getDoneByList(int.parse(userData['unitId'].toString()));
      await roMaintDetailsController.getRODisinfectionDoc(
          widget.proLiItem?.roDisinfectionDetailsId ?? "0");
    }
    // setState(() {});
    roMaintDetailsController.update();
    if (widget.isEdit == false || widget.isEdit == null) {
      var ins = roMaintDetailsController.instituteList?.data?.firstWhere(
          (e) => e.unitId == int.parse(userData['unitId'].toString()));
      roMaintDetailsController.initialInsti = ins?.unitName;
      roMaintDetailsController.selectedInsti = ins;
    }
    if (widget.isEdit == true && widget.proLiItem != null) {
      String date1 = widget.proLiItem!.nextInspectionDate!;
      String date2 = widget.proLiItem!.inspectionDate!;

      ins = roMaintDetailsController.instituteList?.data
          ?.firstWhereOrNull((e) => e.unitName == widget.proLiItem?.unitName);
      if (ins != null) {
        roMaintDetailsController.initialInsti = widget.proLiItem?.unitName;
      } else {
        roMaintDetailsController.initialInsti =
            roMaintDetailsController.instituteList?.data?.first.unitName;
      }

      mac = roMaintDetailsController.getMachineNameModel?.data
          ?.firstWhereOrNull(
              (e) => e.machineName == widget.proLiItem?.machineName);
      if (mac != null) {
        roMaintDetailsController.initialMachine = widget.proLiItem?.machineName;
      } else {
        roMaintDetailsController.initialMachine = roMaintDetailsController
            .getMachineNameModel?.data?.first.machineName;
      }

      desIn = roMaintDetailsController.disinfectTypeModel?.data?.firstWhere(
          (e) => e.lookupDetDescEn == widget.proLiItem?.lookupDetDescEn);
      if (desIn != null) {
        roMaintDetailsController.initialDisinfect =
            widget.proLiItem?.lookupDetDescEn;
      } else {
        roMaintDetailsController.initialDisinfect = roMaintDetailsController
            .disinfectTypeModel?.data?.first.lookupDetDescEn;
      }

      don = roMaintDetailsController.doneByModel?.data
          ?.firstWhereOrNull((e) => e.username == widget.proLiItem?.doneBy);
      if (don != null) {
        roMaintDetailsController.initialDoneBy = widget.proLiItem?.doneBy;
      } else {
        roMaintDetailsController.initialDoneBy =
            roMaintDetailsController.doneByModel?.data?.first.username;
      }

      roMaintDetailsController.nextInspecDateController.text = date1;
      roMaintDetailsController.inspectionDateController.text = date2;

      DateFormat format = DateFormat('dd/MM/yyyy');
      DateTime dateTime = format.parse(date1);
      selectedNextInspection = dateTime;

      roMaintDetailsController.commentController.text =
          widget.proLiItem?.comments ?? "";

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.isEdit == true
              ? "Edit RO Disinfection Details"
              : 'Add RO Disinfection Details',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              roMaintDetailsController.initialInsti = null;
              roMaintDetailsController.initialMachine = null;
              roMaintDetailsController.initialDisinfect = null;
              roMaintDetailsController.initialDoneBy = null;
              roMaintDetailsController.nextInspecDateController.text = "";
              roMaintDetailsController.inspectionDateController.text = "";
              roMaintDetailsController.commentController.text = "";
              Get.to(const RoDisinfectionDetails());
              // Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body:
      GetBuilder<RoDesinfectionDetailsController>(
          init: RoDesinfectionDetailsController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ? const AddRoDesinfectionDetailsShimmer()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            MyCustomDropdown(
                              labelText: 'Institute Name',
                              isViewProfile:
                                  userData != null && userData['unitId'] == 1
                                      ? false
                                      : true,
                              items: controller.instituteList?.data
                                      ?.map((e) => e.unitName)
                                      .toList() ??
                                  [],
                              hint: 'Select',
                              isRequired: false,
                              senValue: (value) {
                                roMaintDetailsController.selectedInsti =
                                    controller.instituteList?.data?.firstWhere(
                                        (e) => e.unitName == value);
                                roMaintDetailsController.initialInsti =
                                    roMaintDetailsController
                                        .selectedInsti?.unitName;
                                controller.update();
                              },
                              filledColor: Colors.white,
                              selectedItem:
                                  roMaintDetailsController.initialInsti,
                            ),
                            MyCustomDropdown(
                              selectedItem:
                                  roMaintDetailsController.initialMachine,
                              labelText: 'Machine Name',
                              items: controller.getMachineNameModel?.data
                                      ?.map((e) => e.machineName)
                                      .toList() ??
                                  [],
                              hint: 'Select',
                              isRequired: false,
                              senValue: (value) {
                                roMaintDetailsController.selectedMachine =
                                    controller.getMachineNameModel?.data
                                        ?.firstWhere(
                                            (e) => e.machineName == value);
                                roMaintDetailsController.initialMachine =
                                    roMaintDetailsController
                                        .selectedMachine?.machineName;
                                controller.update();
                              },
                              filledColor: Colors.white,
                            ),
                            MyCustomDropdown(
                              selectedItem:
                                  roMaintDetailsController.initialDisinfect,
                              labelText: 'Type of Disinfection Used',
                              items: controller.disinfectTypeModel?.data
                                      ?.map((e) => e.lookupDetDescEn)
                                      .toList() ??
                                  [],
                              hint: 'Select',
                              isRequired: false,
                              senValue: (value) {
                                roMaintDetailsController.selectedDisinfect =
                                    controller.disinfectTypeModel?.data
                                        ?.firstWhere(
                                            (e) => e.lookupDetDescEn == value);
                                roMaintDetailsController.initialDisinfect =
                                    roMaintDetailsController
                                        .selectedDisinfect?.lookupDetDescEn;
                                controller.update();
                              },
                              filledColor: Colors.white,
                            ),
                            CustomDateField(
                              labelText: 'Inspection Date',
                              hint: 'Select Date',
                              isRequired: false,
                              callB: () {
                                pickInspectionDate(context);
                              },
                              selectedDate: roMaintDetailsController
                                  .inspectionDateController,
                              filledColor: Colors.white,
                              dontDhowPrefix: false,
                            ),
                            CustomDateField(
                              labelText: 'Next Inspection Date',
                              hint: 'Select Date',
                              isRequired: false,
                              callB: () {
                                pickNextInspecDate(context);
                              },
                              selectedDate: roMaintDetailsController
                                  .nextInspecDateController,
                              filledColor: Colors.white,
                              dontDhowPrefix: false,
                            ),
                            CustomTextField(
                              labelText: 'Comments',
                              hintText: 'Enter Comments',
                              isRequired: false,
                              keyBoardType: TextInputType.text,
                              txtController:
                                  roMaintDetailsController.commentController,
                              fillColor: Colors.white,
                              isReadOnly: false,
                              maxLines: 3,
                              fontSize: 16,
                            ),
                            MyCustomDropdown(
                              selectedItem:
                                  roMaintDetailsController.initialDoneBy,
                              labelText: 'Done By',
                              items: controller.doneByModel?.data
                                      ?.map((e) => e.username)
                                      .toList() ??
                                  [],
                              hint: 'Select',
                              isRequired: false,
                              senValue: (value) {
                                roMaintDetailsController.selectedDoneBy =
                                    controller.doneByModel?.data?.firstWhere(
                                        (e) => e.username == value);
                                roMaintDetailsController.initialDoneBy = value;
                                controller.update();
                              },
                              filledColor: Colors.white,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                  text: "Image Upload",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start),
                            ).paddingOnly(left: 10, bottom: 4),
                            ...roMaintDetailsController.uploadImage
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              ROFileDetails? cardData = entry.value;

                              return UploadRODisDocument(
                                fileData: cardData,
                                onFilePick: () {
                                  pickFile(
                                      roMaintDetailsController
                                          .uploadImage[index],
                                      false);
                                },
                                onFileDelete: () {
                                  roMaintDetailsController
                                      .uploadImage[index].isSelected = false;
                                  roMaintDetailsController
                                      .uploadImage[index].isView = false;
                                  roMaintDetailsController
                                      .uploadImage[index].file = null;
                                  setState(() {});
                                },
                                imgNameCallBack: (value) {
                                  roMaintDetailsController
                                      .uploadImage[index].docName = value;
                                },
                                isViewPatient: false,
                                addCard: () {
                                  addCard();
                                },
                                removeCard: () {
                                  removeCard(index);
                                },
                              );
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                  isLoading: controller.isLoading,
                                  buttonText: 'Save',
                                  path: 'assets/save-ro-disinfec.png',
                                  callB: controller.isLoading
                                      ? null
                                      : () {
                                          var inspecDate =
                                              DateFormat('yyyy/MM/dd').parse(
                                                  roMaintDetailsController
                                                      .inspectionDateController
                                                      .text);

                                          if (selectedNextInspection!
                                              .isBefore(inspecDate)) {
                                            CustomMessage.toast(
                                                "Next Inspection Date Should Not Before Inspection Date ");
                                          } else {
                                            if (widget.isEdit == true) {
                                              controller.addRoDisinfectModel
                                                      ?.unitId =
                                                  roMaintDetailsController
                                                          .selectedInsti
                                                          ?.unitId ??
                                                      ins?.unitId;
                                              controller.addRoDisinfectModel
                                                      ?.createdBy =
                                                  roMaintDetailsController
                                                          .selectedDoneBy
                                                          ?.createdBy ??
                                                      don?.createdBy;
                                              controller.addRoDisinfectModel
                                                  ?.inspectionDate = formattedDate1
                                                      .isEmpty
                                                  ? roMaintDetailsController
                                                      .inspectionDateController
                                                      .text
                                                  // sendConvertedDateToAPI(roMaintDetailsController
                                                  //         .inspectionDateController
                                                  //         .text)
                                                  : formattedDate1;
                                              controller.addRoDisinfectModel
                                                      ?.nextInspectionDate =
                                                  formattedDate2.isEmpty
                                                      ? roMaintDetailsController
                                                          .nextInspecDateController
                                                          .text
                                                      : formattedDate2;
                                              controller.addRoDisinfectModel
                                                      ?.doneBy =
                                                  roMaintDetailsController
                                                          .selectedDoneBy
                                                          ?.username ??
                                                      don?.username;
                                              controller.addRoDisinfectModel
                                                      ?.comments =
                                                  controller
                                                      .commentController.text;
                                              controller.addRoDisinfectModel
                                                      ?.lookupDetId =
                                                  roMaintDetailsController
                                                          .selectedDisinfect
                                                          ?.lookupDetId ??
                                                      desIn?.lookupDetId;
                                              controller.addRoDisinfectModel
                                                      ?.roMachineMasterId =
                                                  roMaintDetailsController
                                                          .selectedMachine
                                                          ?.roMachineMasterId ??
                                                      mac?.roMachineMasterId;
                                              controller.addRoDisinfectModel
                                                      ?.roDisinfectionDetailsId =
                                                  widget.proLiItem
                                                      ?.roDisinfectionDetailsId;
                                              controller
                                                  .addEditRoDisinfectDetails();
                                            } else {
                                              controller.addRoDisinfectModel
                                                      ?.unitId =
                                                  roMaintDetailsController
                                                      .selectedInsti?.unitId;
                                              controller.addRoDisinfectModel
                                                      ?.createdBy =
                                                  roMaintDetailsController
                                                      .selectedDoneBy
                                                      ?.createdBy;
                                              controller.addRoDisinfectModel
                                                      ?.inspectionDate =
                                                  formattedDate1;
                                              controller.addRoDisinfectModel
                                                      ?.nextInspectionDate =
                                                  formattedDate2;
                                              controller.addRoDisinfectModel
                                                      ?.doneBy =
                                                  roMaintDetailsController
                                                      .selectedDoneBy?.username;
                                              controller.addRoDisinfectModel
                                                      ?.comments =
                                                  controller
                                                      .commentController.text;
                                              controller.addRoDisinfectModel
                                                      ?.lookupDetId =
                                                  roMaintDetailsController
                                                      .selectedDisinfect
                                                      ?.lookupDetId;
                                              controller.addRoDisinfectModel
                                                      ?.roMachineMasterId =
                                                  roMaintDetailsController
                                                      .selectedMachine
                                                      ?.roMachineMasterId;
                                              controller.addRoDisinfectModel
                                                  ?.roDisinfectionDetailsId = 0;
                                              controller
                                                  .addEditRoDisinfectDetails();
                                            }
                                          }
                                        },
                                  buttonWidth: 100,
                                  primColor: AppColor.primaryBackgroundColor,
                                  secColor: AppColor.secondaryColor,
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                ),
                                CustomButton(
                                  buttonText: 'Reset',
                                  path: 'assets/refresh.png',
                                  callB: () {
                                    roMaintDetailsController.selectedInsti =
                                        null;
                                    roMaintDetailsController.initialInsti =
                                        null;
                                    roMaintDetailsController.selectedMachine =
                                        null;
                                    roMaintDetailsController.initialMachine =
                                        null;
                                    roMaintDetailsController.selectedDisinfect =
                                        null;
                                    roMaintDetailsController.initialDisinfect =
                                        null;
                                    roMaintDetailsController.selectedDoneBy =
                                        null;
                                    roMaintDetailsController.initialDoneBy =
                                        null;
                                    roMaintDetailsController.uploadImage
                                        .clear();
                                    controller.commentController.text = "";
                                    controller.nextInspecDateController.text =
                                        "";
                                    controller.inspectionDateController.text =
                                        "";

                                    // controller.update();
                                    setState(() {});
                                  },
                                  buttonWidth: 100,
                                  primColor: Colors.grey,
                                  secColor: Colors.grey,
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                ),
                                CustomButton(
                                  buttonText: 'Cancel',
                                  path: 'assets/cancel.png',
                                  callB: () {
                                    Get.back();
                                  },
                                  buttonWidth: 100,
                                  primColor: AppColor.red,
                                  secColor: AppColor.red,
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                ),
                              ],
                            ).paddingOnly(top: 20, bottom: 20)
                          ],
                        ),
                      )
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),

    );
  }

  Future<void> pickFile(ROFileDetails uploadedFile, isEdit) async {
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
        //     newRegistrationController.items.firstWhere((e) => e.key == key);
        uploadedFile.file = file;
        uploadedFile.isSelected = true;
        uploadedFile.isView = false;
        if (isEdit == false) {
          uploadedFile.ids = "0";
        }
      });

      debugPrint(roMaintDetailsController.uploadImage.length.toString());
    } else {
      debugPrint('No file selected.');
    }
  }

  Future<void> pickInspectionDate(BuildContext context) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != selectedInspection) {
      // setState(() {
      selectedInspection = picked;
      // DateFormat formatter = DateFormat('yyyy/MM/dd');
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      formattedDate1 = formatter.format(selectedInspection!);
      roMaintDetailsController.inspectionDateController.text = formattedDate1;

      // });
      roMaintDetailsController.update();
    }
  }

  Future<void> pickNextInspecDate(BuildContext context) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null && picked != selectedNextInspection) {
      // setState(() {
      selectedNextInspection = picked;
      // DateFormat formatter = DateFormat('yyyy/MM/dd');
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      formattedDate2 = formatter.format(selectedNextInspection!);
      roMaintDetailsController.nextInspecDateController.text = formattedDate2;

      // });
      roMaintDetailsController.update();
    }
  }

  // sendConvertedDateToAPI(date){
  //   DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(date);
  //
  //   // Format the parsed date to the desired format
  //   String formattedDate = DateFormat('yyyy/MM/dd').format(parsedDate);
  //   return formattedDate;
  // }

  dateConversion(inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}

class UploadRODisDocument extends StatelessWidget {
  final ROFileDetails fileData;
  final Function(String)? imgNameCallBack;
  final Function onFilePick;
  final Function onFileDelete;
  final bool isViewPatient;
  final Function addCard;
  final Function removeCard;

  const UploadRODisDocument(
      {super.key,
      required this.fileData,
      this.imgNameCallBack,
      required this.onFilePick,
      required this.onFileDelete,
      required this.isViewPatient,
      required this.addCard,
      required this.removeCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          CustomTextField(
            key: UniqueKey(),
            labelText: 'Image Name',
            hintText: 'Enter',
            isRequired: false,
            keyBoardType: TextInputType.text,
            initialValue: fileData.docName,
            fillColor: Colors.white,
            isReadOnly: false,
            maxLines: 1,
            onChanged: (value) {
              if (imgNameCallBack != null) {
                imgNameCallBack!(value);
              }
            },
            fontSize: 16,
          ),
          const SizedBox(
            height: 6,
          ),
          CustomUploadButton(
            key: UniqueKey(),
            isSelected: fileData.isSelected,
            index: 0,
            title: fileData.name,
            callB: () {
              // pickFile(newRegistrationController
              //     .relativeDoc.key);
              onFilePick();
            },
            callDelete: () {
              onFileDelete();

              // fileData.isSelected = false;
              // fileData.file =
              //  null;
              //  setState(() {});
            },
            viewCallBack: () {
              Get.to(() => CustomViewer(
                    fileUrl: fileData.file!.path,
                  ));
              // }
            },
            isReq: fileData.isReq,
            isViewProfile: isViewPatient,
            showIndex: false,
          ).paddingOnly(bottom: 8, left: 5, right: 5),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  addCard();
                },
                icon: const Icon(Icons.add_circle_outline),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {
                  removeCard();
                },
                icon: const Icon(Icons.remove_circle_outline),
                color: AppColor.red,
              )
            ],
          )
        ],
      ),
    ).paddingSymmetric(vertical: 2, horizontal: 10);
  }
}

class ROFileDetails {
  String name;
  String? docName;
  String? ids;
  String key;
  bool isSelected;
  bool isReq;
  File? file;
  bool? isView;

  ROFileDetails(
      {required this.name,
      required this.key,
      required this.isSelected,
      required this.isReq,
      this.file,
      this.ids,
      this.docName,
      this.isView});
}
