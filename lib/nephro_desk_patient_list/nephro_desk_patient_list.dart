import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/nephro_second_level/nephro_second_level.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/edit_nephro_desk.dart';
import 'package:heamodialysis/nephro_desk_patient_list/nephro_controller.dart';
import 'package:heamodialysis/nephro_desk_patient_list/nephro_desk_dropdown.dart';
import 'package:heamodialysis/nephro_desk_patient_list/nepro_card.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/schedular/screens/patient_history_schedular.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

import '../widgets/custom_shimmer_loader.dart';

class NephroDeskPatientList extends StatefulWidget {
  final String appBarTitle;

  const NephroDeskPatientList({super.key, required this.appBarTitle});

  @override
  State<NephroDeskPatientList> createState() => _NephroDeskPatientListState();
}

class _NephroDeskPatientListState extends State<NephroDeskPatientList> {
  final NephroController nephroController = Get.put(NephroController());

  bool hasInternet = true;
  LookupList? dropDownValue;
  PatientStatus? selectedStatus;
  UnitList? dropDownValue2;
  var userData;

  List<String> cardItemDetailsList = [
    'Patient Id',
    'Patient Name',
    'Age',
    'Mobile No',
    'Treatment Id',
    'Gender',
    'Appointment Date',
    'Slot',
    'Viral Load Status'
  ];

  List<PatientStatus> statusList = [
    PatientStatus('All', 'N'),
    PatientStatus('Pending', 'Y')
  ];

  @override
  void initState() {
    super.initState();
    checkInternetAndLoadData();
  }

  checkInternetAndLoadData() async {
    await getUserData();
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    debugPrint('Internet status: $hasInternet');
    nephroController.update();

    if (hasInternet) {
      try {
        debugPrint('Calling ...');

        await nephroController.getNephroList(
            'PNA',
            '',
            userData['unitId'].toString(),
            userData['district'] != null
                ? userData['district'].toString()
                : "0",
            "N");
        await nephroController
            .searchByDropDownList(userData['district'].toString());
        await nephroController.getListOfPackage(userData['unitId'].toString());

        if (nephroController.searchByModel?.lookupList != null ||
            nephroController.searchByModel!.lookupList!.isNotEmpty) {
          dropDownValue = nephroController.searchByModel!.lookupList!.first;
          nephroController.update();
        }
      } catch (e) {
        debugPrint('Error while calling getNephroList: $e');
      }
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    debugPrint('User data retrieved: $userData');
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NephroController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title:  CustomText(
            text: 'Doctor Desk Patient List',
            fontSize: 18.sp,
            fontFam: 'Lato',
            fontWeight: FontWeight.w400,
            textColor: Colors.black,
            textAlign: TextAlign.start,
          ),
          leading: InkWell(
              onTap: () {
                Get.back();
               // Get.offAll(() => const NephroSecondLevel());
              },
              child: Image.asset('assets/arrow-left.png')),
          actions: [
            InkWell(
              onTap: () {
                // dropDownValue2 = searchByList[0];
                showModalBottomSheet(
                  isDismissible: false,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        padding:  EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: const Color(0xffF8F8F8),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 0.5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 CustomText(
                                        text: "Search",
                                        fontSize: 16.sp,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start)
                                    .paddingSymmetric(vertical: 4),
                                InkWell(
                                    onTap: () {
                                      dropDownValue = null;
                                      nephroController.valueController.text =
                                          "";
                                      Get.back();
                                    },
                                    child: Image.asset(
                                      "assets/cancel.png",
                                      width: 30.w,
                                      height: 30.h,
                                      color: AppColor.primaryBackgroundColor,
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 CustomText(
                                        text: "Search By",
                                        fontSize: 16.sp,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: const Color(0xff515151),
                                        textAlign: TextAlign.start)
                                    .paddingOnly(top: 10.h, bottom: 4.h),
                                Container(
                                  // width: 180,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFE1E1E1)),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: 12.w),
                                  child: DropdownButton<LookupList>(
                                    isExpanded: true,
                                    value: dropDownValue,
                                    hint: const Text("select"),
                                    onChanged: (LookupList? newValue) {
                                      dropDownValue = newValue!;
                                      setState(() {});
                                    },
                                    items: nephroController
                                        .searchByModel?.lookupList
                                        ?.map<DropdownMenuItem<LookupList>>(
                                            (LookupList value) {
                                      return DropdownMenuItem<LookupList>(
                                        value: value,
                                        child:
                                            Text(value.lookupDetDescEn ?? ""),
                                      );
                                    }).toList(),
                                    underline: const SizedBox(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: AppColor.primaryBackgroundColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                             SizedBox(
                              height: 4.h,
                            ),
                             Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                  text: "Value",
                                  fontSize: 16.sp,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.normal,
                                  textColor: const Color(0xff515151),
                                  textAlign: TextAlign.start),
                            ).paddingOnly(top: 12.h, bottom: 4.h),
                            TextField(
                                inputFormatters: [UpperCaseTextFormatter()],
                                controller: nephroController.valueController,
                                decoration: const InputDecoration(
                                  labelText: 'Patient Id, name, mobile no etc.',
                                  labelStyle:
                                      TextStyle(color: Color(0xFFE1E1E1)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFE1E1E1)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFE1E1E1)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 CustomText(
                                        text: "Clinical History Status",
                                        fontSize: 16.sp,
                                        fontFam: "Lato",
                                        fontWeight: FontWeight.normal,
                                        textColor: const Color(0xff515151),
                                        textAlign: TextAlign.start)
                                    .paddingOnly(top: 10.h, bottom: 4.h),
                                Container(
                                  // width: 180,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFE1E1E1)),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: 12.w),
                                  child: DropdownButton<PatientStatus>(
                                    isExpanded: true,
                                    value: selectedStatus,
                                    hint: const Text("select"),
                                    onChanged: (PatientStatus? newValue) {
                                      selectedStatus = newValue!;
                                      setState(() {});
                                    },
                                    items: statusList
                                        .map<DropdownMenuItem<PatientStatus>>(
                                            (PatientStatus value) {
                                      return DropdownMenuItem<PatientStatus>(
                                        value: value,
                                        child: Text(value.title ?? ""),
                                      );
                                    }).toList(),
                                    underline: const SizedBox(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: AppColor.primaryBackgroundColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                             SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                        padding:  EdgeInsets.symmetric(
                                            vertical: 8.h),
                                        alignment: Alignment.center,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColor.red,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/cancel.png"),
                                             CustomText(
                                                text: "Cancel",
                                                fontSize: 16.sp,
                                                fontFam: "Lato",
                                                fontWeight: FontWeight.normal,
                                                textColor: Colors.white,
                                                textAlign: TextAlign.start),
                                          ],
                                        )),
                                  ),
                                ).paddingOnly(top: 20.h),
                                 SizedBox(
                                  width: 14.w,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      // nephroController.getNephroList(
                                      //     dropDownValue?.lookupDetValue ?? "",
                                      //     nephroController.valueController.text,
                                      //     dropDownValue2?.unitId != null
                                      //         ? dropDownValue2!.unitId
                                      //             .toString()
                                      //         : "0",
                                      //     userData['district'].toString(),
                                      //     selectedStatus?.status);
                                      nephroController.getNephroList(
                                          dropDownValue?.lookupDetValue ?? "",
                                          nephroController.valueController.text,
                                          userData['unitId'].toString(),
                                          userData['district'] != null
                                              ? userData['district'].toString()
                                              : '0',
                                          selectedStatus?.status);
                                      Get.back();
                                    },
                                    child: Container(
                                        padding:  EdgeInsets.symmetric(
                                            vertical: 8.h),
                                        alignment: Alignment.center,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor.primaryBackgroundColor,
                                              AppColor.secondaryColor
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child:  Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.search,
                                              color: Colors.white,
                                            ),
                                            CustomText(
                                                text: "Search",
                                                fontSize: 16.sp,
                                                fontFam: "Lato",
                                                fontWeight: FontWeight.normal,
                                                textColor: Colors.white,
                                                textAlign: TextAlign.start),
                                          ],
                                        )),
                                  ),
                                ).paddingOnly(top: 20),
                              ],
                            )
                          ],
                        ),
                      );
                    });
                  },
                );
              },
              child: Padding(
                padding:  EdgeInsets.only(right: 8.w),
                child: Image.asset("assets/filter-line.png"),
              ),
            ),
             SizedBox(
              width: 2.w,
            ),
          ],
        ),
        body: hasInternet
            ? controller.isLoading
                ?  Center(child: buildShimmerLoader())
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.nephroList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return NeproCard(
                        patient: controller.nephroList?[index],
                        // isSecondColumnVisiable: true,
                        path1: "assets/file-list.png",
                        path2: "assets/edit.png",

                        callB1: () {
                          PatientData patientData = PatientData(
                            patientId: controller.nephroList![index].patientId!,
                            patientName: controller.nephroList?[index].fName,
                            treatmentId:
                                controller.nephroList?[index].treatmentId !=
                                        null
                                    ? controller.nephroList![index].treatmentId!
                                    : null,
                            gender: controller.nephroList?[index].gender,
                            age: controller.nephroList?[index].age != null
                                ? controller.nephroList![index].age!
                                : null,
                          );

                          Get.to(() => PatientHistorySchedular(
                                patientData: patientData,
                              ));
                        },

                        callB3: () {
                          Get.to(() => EditNephroDesk(
                                patientData: controller.nephroList?[index],
                                appBarTitle: widget.appBarTitle,
                              ));
                        },

                        cardItemDetailsList: cardItemDetailsList,
                      );
                    },
                  )
            : InternetIssue(
                onRetryPressed: () {
                  checkInternetAndLoadData();
                },
              ),
        // body: GetBuilder<NephroController>(
        //   init: nephroController,
        //   builder: (controller) {
        //     return hasInternet
        //         ? controller.isLoading
        //             ? const Center(child: CircularProgressIndicator())
        //             : ListView.builder(
        //                 shrinkWrap: true,
        //                 itemCount: controller.nephroList?.length ?? 0,
        //                 itemBuilder: (BuildContext context, int index) {
        //                   return NeproCard(
        //                     patient: controller.nephroList?[index],
        //                     isSecondColumnVisiable: true,
        //                     path1: "assets/file-list.png",
        //                     path2: "assets/video_call.png",
        //                     path3: "assets/edit.png",
        //                     path4: "assets/phone.png",
        //                     path5: "assets/phone.png",
        //                     callB1: () {
        //                       PatientData patientData = PatientData(
        //                         patientId: controller.nephroList![index].patientId!,
        //                         patientName:
        //                             controller.nephroList?[index].fName,
        //                         treatmentId:
        //                             controller.nephroList?[index].treatmentId !=
        //                                     null
        //                                 ? controller
        //                                 .nephroList![index].treatmentId!
        //                                 : null,
        //                         gender: controller.nephroList?[index].gender,
        //                         age: controller.nephroList?[index].age != null
        //                             ? controller.nephroList![index].age!
        //                             : null,
        //                       );
        //
        //                       Get.to(() => PatientHistorySchedular(
        //                             patientData: patientData,
        //                           ));
        //                     },
        //                     callB2: () {
        //                       debugPrint('Video call pressed');
        //                     },
        //                     callB3: () {
        //                       Get.to(() => EditNephroDesk(
        //                             patientData: controller.nephroList?[index], appBarTitle: widget.appBarTitle,
        //                           ));
        //                     },
        //                     callB4: () {
        //                       // Implement cancellation logic if needed
        //                     },
        //                     callB5: () {},
        //                     cardItemDetailsList: cardItemDetailsList,
        //                   );
        //                 },
        //               )
        //         : InternetIssue(
        //             onRetryPressed: () {
        //               checkInternetAndLoadData();
        //             },
        //           );
        //   },
        // ),
      );
    });
  }
}

class PatientStatus {
  String? title;
  String? status;

  PatientStatus(this.title, this.status);
}
