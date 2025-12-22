import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/add_prescription.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/prescription_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/nephro_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/registered_patient_list/screens/registered_patient_list.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class Prescription extends StatefulWidget {
  final NephroList? patientData;

  const Prescription({super.key, this.patientData});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  final NephroController nephroController = Get.find<NephroController>();

  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Medicine Name',
    'Prep',
    'Strength',
    'Dose',
    'Unit',
    'Frequency',
    'Instructions',
    'Quantity',
    'Prescribed by',
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
      await nephroController.getPrescriptionList(
          widget.patientData?.treatmentId.toString(),
          userData['unitId'].toString());

      await nephroController.getPrepList();
      await nephroController.getUnitList();
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
              ?  Center(child: buildShimmerLoader())
              : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(AddPrescription(
                          patientData: widget.patientData,
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
              ).paddingOnly(right: 8),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.prescrriptionList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PrescriptionDiagCard(
                      index: index,
                      prescriptionItem:
                      controller.prescrriptionList?[index],
                      cardItemDetailsList: cardItemDetailsList,
                      path1: "assets/edit.png",
                      path2: "assets/delete-bin.png",
                      callB1: (index) {
                        Get.to(() =>
                            AddPrescription(
                              patientData: widget.patientData,
                              prescriptionDtoSp: controller
                                  .prescrriptionList?[index],
                              isEdit: true,
                            ));
                      },
                      callB2: (index) async{
                       await controller.deletePrescriptin(userData['unitId']
                            .toString(), controller
                            .prescrriptionList?[index].prescriptionId
                            .toString(), userData['ui'].toString(), widget
                            .patientData?.treatmentId.toString());
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

class PrescriptionDiagCard extends StatelessWidget {
  final ListOpdPrescriptionDtoSp? prescriptionItem;
  final List<String> cardItemDetailsList;
  final String? path1;
  final String? path2;
  final Function callB1;
  final Function callB2;

  final int index;

  const PrescriptionDiagCard({
    super.key,
    this.prescriptionItem,
    required this.cardItemDetailsList,
    this.path1,
    this.path2,
    required this.callB1,
    required this.callB2,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      // height: 195,
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
                            prescriptionItem?.medicineName ?? "-"),
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
                        ],),
                      )
                    ],
                  ),

                  patientDetailsCard(cardItemDetailsList[6],
                      prescriptionItem?.instructionName ?? ''),

                  patientDetailsCard(
                      cardItemDetailsList[8], prescriptionItem?.userName ?? ''),
                  Row(
                    children: [
                      Expanded(
                        child: patientDetailsCard(cardItemDetailsList[1],
                            prescriptionItem?.prepName ?? "-"),
                      ),
                      Expanded(
                        child: patientDetailsCard(cardItemDetailsList[2],
                            prescriptionItem?.strength ?? "-"),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: patientDetailsCard(
                            cardItemDetailsList[3], prescriptionItem?.dose ?? ''),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: patientDetailsCard(cardItemDetailsList[4],
                            prescriptionItem?.unitName.toString() ?? ''),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: patientDetailsCard(cardItemDetailsList[7],
                            prescriptionItem?.qty.toString() ?? ''),
                      ),
                      Expanded(
                        child: patientDetailsCard(cardItemDetailsList[5],
                            prescriptionItem?.frequency.toString() ?? ''),
                      ),
                    ],
                  ),

                  // patientDetailsCard(cardItemDetailsList[9],
                  //     prescriptionItem?.userName ?? "-"),
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
    )
        .paddingOnly(top: 8, bottom: 8, left: 8, right: 8)
        .paddingSymmetric(vertical: 8);
  }

  Widget patientDetailsCard(String text, String? details) {
    return Row(
      children: [
        CustomText(
            text: "$text :",
            fontSize: 13,
            fontFam: "Lato",
            fontWeight: FontWeight.normal,
            textColor: Colors.black,
            textAlign: TextAlign.start)
            .paddingSymmetric(vertical: 2),
        Expanded(
          child: CustomText(
              text: details ?? "",
              fontSize: 13,
              fontFam: "Lato",
              fontWeight: FontWeight.normal,
              textColor: Colors.grey,
              textAlign: TextAlign.start)
              .paddingSymmetric(vertical: 2),
        ),
      ],
    );
  }

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
