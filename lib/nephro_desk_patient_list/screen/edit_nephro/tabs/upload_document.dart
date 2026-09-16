import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/uploaded_document_nephro.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/registered_patient_list/screen/registered_patient_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/custom_shimmer_loader.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_card.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/status_dialog.dart';
import 'package:intl/intl.dart';


class UploadDocument extends StatefulWidget {
  final NephroList? patientData;

  const UploadDocument({super.key, this.patientData});

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  final Connectivity _connectivity = Connectivity();
  bool _isNetworkAvailable = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  final NephroController nephroController = Get.put(NephroController());
  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Document Name',
    'Note',
    'Date & Time'
    // 'Comments',
  ];

  SearchedData? dropDownValue;
  SearchByPatient? dropDownValue2;

  var userData;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    // Initialize data in proper sequence
    _initializeData();
  }

  Future<void> _initializeData() async {
    await getUserData(); // Wait for user data first
    await checkInternetAndLoadData(); // Then load documents
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    nephroController.update();

    if (hasInternet && userData != null) {
      debugPrint("=== LOADING UPLOADED DOCS ===");
      debugPrint("PatientId: ${widget.patientData?.patientId}");
      debugPrint("TreatmentId: ${widget.patientData?.treatmentId}");
      debugPrint("UnitId: ${userData['unitId']}");

      await nephroController.getUploadedDocNephro(
          widget.patientData?.patientId,
          widget.patientData?.treatmentId, // ✅ Safe access from widget
          userData['unitId']);

      debugPrint(
          "Uploaded docs count: ${nephroController.uploadedDocList?.length}");
      debugPrint("===========================");
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint("User data loaded: $userData");
  }

  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  // Update connection status handler
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final isConnected = results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi,
    );

    setState(() {
      _isNetworkAvailable = isConnected;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isNetworkAvailable
        ? GetBuilder<NephroController>(
            init: nephroController,
            builder: (controller) {
              if (controller.isLoading) {
                return Center(child: buildShimmerLoader());
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              isDismissible: false,
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Container(
                                      margin: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF8F8F8),
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withValues(alpha: 0.1),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: const Offset(0,
                                                0.5), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                        text: context.l10n.regUploadDocument,
                                                        fontSize: 16,
                                                        fontFam: "Lato",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        textColor: Colors.black,
                                                        textAlign:
                                                            TextAlign.start)
                                                    .paddingSymmetric(
                                                        vertical: 4),
                                                InkWell(
                                                    onTap: () {
                                                      nephroController.imagePath
                                                          .clear();
                                                      nephroController
                                                          .uploadComment
                                                          .clear();
                                                      Get.back();
                                                    },
                                                    child: Image.asset(
                                                      "assets/cancel.png",
                                                      width: 30,
                                                      height: 30,
                                                      color: AppColor
                                                          .primaryBackgroundColor,
                                                    )),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomDocUploadField(
                                                  labelText: context.l10n.regUploadDocument,
                                                  hint: context.l10n.nephroSelectFileToUpload,
                                                  isRequired: true,
                                                  callB: () {
                                                    pickFile();
                                                  },
                                                  selectedDate:
                                                      controller.imagePath,
                                                  filledColor: Colors.white,
                                                ),
                                                // InkWell(
                                                //   onTap: () {
                                                //     pickFile();
                                                //   },
                                                //   child: Container(
                                                //     height: 140,
                                                //     width: double.infinity,
                                                //     decoration: BoxDecoration(
                                                //       color: const Color(0xffF2F2F2),
                                                //       borderRadius: BorderRadius.circular(12),
                                                //       border: Border.all(color: Colors.grey.shade300),
                                                //     ),
                                                //     child: Column(
                                                //       mainAxisAlignment: MainAxisAlignment.center,
                                                //       children: [
                                                //         Image.asset(
                                                //           "assets/file-list-3-line.png", // ek simple upload icon
                                                //           height: 40,
                                                //           color: AppColor.primaryBackgroundColor,
                                                //         ),
                                                //         SizedBox(height: 10),
                                                //         RichText(
                                                //           text: const TextSpan(
                                                //             children: [
                                                //               TextSpan(
                                                //                 text: context.l10n.nephroSelectFileToUpload,
                                                //                 style: TextStyle(
                                                //                   fontSize: 14,
                                                //                   color: Colors.black,
                                                //                 ),
                                                //               ),
                                                //               TextSpan(
                                                //                 text: " *",
                                                //                 style: TextStyle(
                                                //                   fontSize: 14,
                                                //                   color: Colors.red,
                                                //                 ),
                                                //               ),
                                                //             ],
                                                //           ),
                                                //         ),
                                                //         if (nephroController.imagePath.text.isNotEmpty) ...[
                                                //           SizedBox(height: 6),
                                                //           Text(
                                                //             nephroController.imagePath.text,
                                                //             style: const TextStyle(fontSize: 12, color: Colors.grey),
                                                //           )
                                                //         ]
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),

                                                CustomTextField(
                                                  labelText: context.l10n.commonComments,
                                                  hintText: context.l10n.nephroEnterComments,
                                                  isRequired: false,
                                                  keyBoardType:
                                                      TextInputType.text,
                                                  txtController:
                                                      nephroController
                                                          .uploadComment,
                                                  fillColor: Colors.white,
                                                  isReadOnly: false,
                                                  maxLines: 3,
                                                  fontSize: 16,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomButton(
                                                      isLoading:
                                                          controller.isLoading,
                                                      buttonText: context.l10n.commonSave,
                                                      path:
                                                          'assets/save-ro-disinfec.png',
                                                      callB: controller
                                                              .isLoading
                                                          ? null
                                                          : () async {

                                                              await nephroController.uploadDocuments(
                                                                  widget
                                                                      .patientData
                                                                      ?.patientId
                                                                      .toString(),
                                                                  widget
                                                                      .patientData
                                                                      ?.treatmentId
                                                                      .toString(),
                                                                  nephroController
                                                                      .uploadComment
                                                                      .text,
                                                                  userData['unitId']
                                                                      .toString(),
                                                                  userData['user_ID']
                                                                      .toString()
                                                              );
                                                              Get.back();
                                                              },
                                                      buttonWidth: 100,
                                                      primColor: AppColor
                                                          .primaryBackgroundColor,
                                                      secColor: AppColor
                                                          .secondaryColor,
                                                      textColor: Colors.white,
                                                      iconColor: Colors.white,
                                                    ).paddingOnly(
                                                        top: 20, bottom: 20),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    CustomButton(
                                                      buttonText: context.l10n.commonCancel,
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
                                                )
                                              ],
                                            ),
                                          ]));
                                });
                              },
                            );
                          },
                          child: Image.asset("assets/upload.png")),
                      SizedBox(
                        width: 8,
                      ),
                      Image.asset("assets/download.png")
                    ],
                  ).paddingOnly(right: 8, top: 10),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: nephroController.uploadedDocList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return UploadCard(
                          index: index,
                          roList: nephroController.uploadedDocList?[index],
                          cardItemDetailsList: cardItemDetailsList,
                          path1: "assets/eye.png",
                          path2: "assets/delete-bin.png",
                          callB1: (index) async {
                            // Get.to(() => const CustomViewer(
                            //       fileUrl:
                            //           'https://morth.nic.in/sites/default/files/dd12-13_0.pdf',
                            //     ));
                            await nephroController.viewUploadedDoc(
                                nephroController
                                    .uploadedDocList?[index].doctorDeskFile,
                                nephroController
                                    .uploadedDocList![index].documentId
                                    .toString());
                          },
                          callB2: (index) async {
                            showCustomSnackBar(
                                context: context,
                                topTitle: 'Delete Document',
                                title:
                                'Are you sure\nyou want to delete this Document?',
                                img: 'assets/delete-photo.png',
                                onPress2: () async {
                                  await nephroController.deleteUploadedImage(
                                      nephroController
                                          .uploadedDocList?[index].documentId,
                                      userData['user_ID'],
                                      widget.patientData?.patientId,
                                      widget.patientData?.treatmentId,
                                      userData['unitId']);
                                  Get.back();
                                },
                                onPress1: () {
                                  Get.back();

                                },
                                buttonTitle: 'No',
                                buttonTitle2: 'Yes'
                            );

                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            })
        : InternetIssue(
            onRetryPressed: () async {
              final result = await _connectivity.checkConnectivity();
              _updateConnectionStatus(result);
            },
          );
  }

  Future<void> pickFile() async {
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
        nephroController.uploadedFile = file;
        nephroController.imagePath.text = file.path.split('/').last;
      });
    } else {
      debugPrint('No file selected.');
    }
  }
}

class UploadCard extends StatelessWidget {
  final UploadedDocumentNephro? roList;
  final List<String> cardItemDetailsList;
  final String? path1;
  final String? path2;
  final Function callB1;
  final Function callB2;

  final int index;

  const UploadCard({
    super.key,
    this.roList,
    required this.cardItemDetailsList,
    this.path1,
    this.path2,
    required this.callB1,
    required this.callB2,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 8,
          // height: 90,
          // width: double.infinity,
          // decoration: BoxDecoration(
          //   color: const Color(0xffF8F8F8),
          //   borderRadius: BorderRadius.circular(6),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black.withValues(alpha: 0.1),
          //       spreadRadius: 2,
          //       blurRadius: 4,
          //       offset: const Offset(0, 0.5), // changes position of shadow
          //     ),
          //   ],
          // ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: patientDetailsCard(cardItemDetailsList[0],
                                roList?.doctorDeskFile.toString() ?? "-"),
                          ),
                          SizedBox(
                            width: 60,
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                patientCardActions(path1!, () {
                                  callB1(index);
                                  // Get.to(() => BookAppointmentScreen(
                                  //     patientData: patientList[index]));
                                }, null)
                                    .paddingOnly(top: 4, bottom: 4),
                                patientCardActions(path2!, () {
                                  callB2(index);
                                }, null)
                                    .paddingOnly(top: 4, bottom: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                      patientDetailsCard(
                          cardItemDetailsList[1], roList?.remark ?? "-"),
                      patientDetailsCard(
                          cardItemDetailsList[2],
                          roList?.createdDate != null
                              ? formatReadableDate(roList?.createdDate)
                              : "-"),
                    ],
                  ).paddingSymmetric(vertical: 4, horizontal: 2),
                ),
                // Container(
                //   width: 50,
                //   decoration: BoxDecoration(
                //     color: AppColor.darkBlue,
                //     borderRadius: const BorderRadius.only(
                //         topRight: Radius.circular(6),
                //         bottomRight: Radius.circular(6)),
                //   ),
                //   child: Column(
                //     // crossAxisAlignment: CrossAxisAlignment.stretch,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       patientCardActions(path1!, () {
                //         callB1(index);
                //         // Get.to(() => BookAppointmentScreen(
                //         //     patientData: patientList[index]));
                //       }, null)
                //           .paddingOnly(top: 4, bottom: 4),
                //       patientCardActions(path2!, () {
                //         callB2(index);
                //       }, null)
                //           .paddingOnly(top: 4, bottom: 4),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ).paddingAll(8.0),
        Positioned(
          top: -11,
          left: 25,
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xff27A9E3),
                  Color(0xff07B259),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                '${index + 1}', // 🔥 index starts from 0 → +1
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 4);
  }

  String formatReadableDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate).toLocal();
    DateFormat formatter = DateFormat('dd MMM yyyy, hh:mm a');
    return formatter.format(dateTime);
  }

  // Widget patientDetailsCard(String label, String? details) {
  //   return RichText(
  //     text: TextSpan(
  //       children: [
  //         TextSpan(
  //           text: "$label: ",
  //           style: TextStyle(
  //             fontSize: 14,
  //             fontFamily: "Lato",
  //             fontWeight: FontWeight.w400,
  //             color: Colors.black, // Label color
  //           ),
  //         ),
  //         TextSpan(
  //           text: details ?? "",
  //           style: TextStyle(
  //             fontSize: 14,
  //             fontFamily: "Lato",
  //             fontWeight: FontWeight.w400,
  //             color: Colors.grey, // Details ka color
  //           ),
  //         ),
  //       ],
  //     ),
  //     // maxLines: 2,
  //     // overflow: TextOverflow.ellipsis,
  //   ).paddingSymmetric(vertical: 2);
  // }

  dateConversion(inputDate) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(inputDate);
    String convertedDate = DateFormat('yyyy-MM-dd').format(date);
    return convertedDate;
  }

  Widget patientCardActions(String path, Function callB, bool? yes) {
    return InkWell(
        onTap: () {
          callB();
        },
        child: Image.asset(
          path,
          color: yes == null ? AppColor.darkBlue : AppColor.darkBlue,
        ));
  }
}
