import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/add_edit_diet.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/diet_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/add_edit_diet.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/registered_patient_list/screens/registered_patient_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_card.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/status_dialog.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/custom_shimmer_loader.dart';

// import '../../../widgets/custom_card.dart';
// import '../../../widgets/custom_shimmer_loader.dart';

class DietScreen extends StatefulWidget {
  final NephroList? patientData;

  const DietScreen({super.key, this.patientData});

  @override
  State<DietScreen> createState() => _DietScreenState();
}

class _DietScreenState extends State<DietScreen> {
  final NephroController nephroController = Get.put(NephroController());
  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Template Name',
    'From',
    'To',
    'Diet by'
    // 'Comments',
  ];

  List<SearchByPatient> searchByList = [
    SearchByPatient('1', 'Dialysis Center'),
    SearchByPatient('2', 'State')
  ];

  SearchedData? dropDownValue;
  SearchByPatient? dropDownValue2;

  var userData;

  RadioButtons? radioButtons = RadioButtons.existingAbhaId;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    nephroController.update();
    if (hasInternet) {
      await nephroController.getDietList(widget.patientData?.treatmentId);
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NephroController>(
        init: nephroController,
        builder: (controller) {
          return hasInternet
              ? controller.isLoading
                  ? Center(child: buildShimmerLoader())
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.to(AddEditDiet(
                                    proLiItem: widget.patientData,
                                    userData: userData,
                                    isEdit: false,
                                  ));
                                },
                                child:
                                    Image.asset("assets/add-pre-dialysis.png")),
                            const SizedBox(
                              width: 8,
                            ),
                            Image.asset("assets/download.png")
                          ],
                        ).paddingOnly(right: 8, top: 2, bottom: 4),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.dietList?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DietCard(
                                index: index,
                                roList: controller.dietList?[index],
                                cardItemDetailsList: cardItemDetailsList,
                                path1: "assets/edit.png",
                                path2: "assets/delete-bin.png",
                                callB1: (index) async {
                                  await controller.getDietDetailsOnClick(
                                      controller.dietList?[index].dietMasterId);
                                  Get.to(() => AddEditDiet(
                                        userData: userData,
                                        proLiItem: widget.patientData,
                                        dietDetails:
                                            controller.dietList?[index],
                                        isEdit: true,
                                      ));
                                },
                                callB2: (index) async {
                                  showCustomSnackBar(
                                      context: context,
                                      topTitle: 'Delete Diet',
                                      title:
                                          'Are you sure\nyou want to delete this Diet?',
                                      img: 'assets/delete-photo.png',
                                      onPress2: () async {
                                        await controller.deleteDiet(
                                            controller.dietList?[index].dietMasterId,
                                            controller.dietList?[index].userId,
                                            widget.patientData?.treatmentId);
                                        Get.back();
                                      },
                                      onPress1: () {
                                        Get.back();

                                      },
                                      buttonTitle: 'No',
                                      buttonTitle2: 'Yes'
                                  );
                                  // await controller.deleteDiet(
                                  //     controller.dietList?[index].dietMasterId,
                                  //     controller.dietList?[index].userId,
                                  //     widget.patientData?.treatmentId);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )
              : InternetIssue(
                  onRetryPressed: () {
                    checkInternetAndLoadData();
                  },
                );
        });
  }
}

class DietCard extends StatelessWidget {
  final GetListOfOpdDietDto? roList;
  final List<String> cardItemDetailsList;
  final String? path1;
  final String? path2;
  final Function callB1;
  final Function callB2;

  final int index;

  const DietCard({
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
      children: [
        Card(
          elevation: 7,
          // height: 130,
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
                        children: [
                          Expanded(
                            child: patientDetailsCard(cardItemDetailsList[0],
                                roList?.templateName ?? "-"),
                          ),
                          SizedBox(
                            width: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                patientCardActions(path1!, () {
                                  callB1(index);
                                  // Get.to(() => BookAppointmentScreen(
                                  //     patientData: patientList[index]));
                                }, null),
                                patientCardActions(path2!, () {
                                  callB2(index);
                                }, null)
                                // .paddingOnly(top: 16),
                              ],
                            ),
                          )
                        ],
                      ),
                      patientDetailsCard(
                          cardItemDetailsList[1], roList?.fromDate ?? "-"),
                      patientDetailsCard(
                          cardItemDetailsList[2], roList?.toDate ?? "-"),

                      patientDetailsCard(
                          cardItemDetailsList[3], roList?.userName ?? ''),

                      //     roList?.fName ?? ''),
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
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       patientCardActions(path1!, () {
                //         callB1(index);
                //         // Get.to(() => BookAppointmentScreen(
                //         //     patientData: patientList[index]));
                //       }, null),
                //       patientCardActions(path2!, () {
                //         callB2(index);
                //       }, null)
                //           .paddingOnly(top: 16),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ).paddingAll(8.0),
      ],
    ).paddingSymmetric(vertical: 4);
  }

  // Widget patientDetailsCard(String text, String? details) {
  //   return Row(
  //     children: [
  //       CustomText(
  //           text: "$text :",
  //           fontSize: 13,
  //           fontFam: "Lato",
  //           fontWeight: FontWeight.normal,
  //           textColor: Colors.black,
  //           textAlign: TextAlign.start)
  //           .paddingSymmetric(vertical: 2),
  //       Expanded(
  //         child: CustomText(
  //             text: details ?? "",
  //             fontSize: 13,
  //             fontFam: "Lato",
  //             fontWeight: FontWeight.normal,
  //             textColor: Colors.grey,
  //             textAlign: TextAlign.start)
  //             .paddingSymmetric(vertical: 2),
  //       ),
  //     ],
  //   );
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
