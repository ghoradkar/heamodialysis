// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:heamodialysis/cctv/screen/cctv_camera_details.dart';
// import 'package:heamodialysis/cctv/controller/cctv_controller.dart';
// import 'package:heamodialysis/discharge_form/model/discharge_list.dart';
// import 'package:heamodialysis/internet/no_internet_connectivity.dart';
// import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
// import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
// import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
// import 'package:heamodialysis/utils/color_constants.dart';
// import 'package:heamodialysis/widgets/custom_text.dart';
// import 'package:heamodialysis/widgets/custom_textfield.dart';
//
// import '../../widgets/custom_shimmer_loader.dart';
//
// class CctvFilter extends StatefulWidget {
//   final dynamic userData;
//
//   const CctvFilter({super.key, this.userData});
//
//   @override
//   State<CctvFilter> createState() => _CctvFilterState();
// }
//
// class _CctvFilterState extends State<CctvFilter> {
//   final NewRegistrationController newRegistrationController =
//   Get.find<NewRegistrationController>();
//
//   final CctvController cctvController = Get.put(CctvController());
//
//   List<String> cardItemDetailsList = ['Institute Name'];
//   bool isListenerAdded = false;
//   SearchedData? dropDownValue;
//   SearchedData? dropDownValue2;
//
//   TextEditingController valueController = TextEditingController();
//
//   @override
//   void initState() {
//     debugPrint("initState called");
//     checkInternetAndLoadData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const CustomText(
//           text: 'CCTV Camera',
//           fontSize: 18.0,
//           fontFam: 'Lato',
//           fontWeight: FontWeight.w400,
//           textColor: Colors.black,
//           textAlign: TextAlign.start,
//         ),
//         leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Image.asset('assets/arrow-left.png')),
//       ),
//       body: GetBuilder<CctvController>(
//           init: cctvController,
//           builder: (controller) {
//             return controller.hasInternet
//                 ? controller.isLoading
//                 ?  Center(child: buildShimmerLoader())
//                 : Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 6, horizontal: 2),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.white,
//                       border:
//                       Border.all(color: const Color(0xFFEEEEEE))),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: SearchableDropDown(
//                               selectedItem: newRegistrationController
//                                   .selectedStateVal,
//                               isViewPatient: true,
//                               list: newRegistrationController
//                                   .stateModel?.data
//                                   ?.map((e) => e.stateName)
//                                   .toList() ??
//                                   [],
//                               onChanged: (value) {
//                                 newRegistrationController
//                                     .selectedStateObj =
//                                     newRegistrationController
//                                         .stateModel?.data
//                                         ?.firstWhere((e) =>
//                                     e.stateName == value);
//                                 newRegistrationController
//                                     .selectedStateVal =
//                                     newRegistrationController
//                                         .selectedStateObj?.stateName;
//                                 newRegistrationController.update();
//                                 debugPrint(
//                                     'changing value to: $value');
//                               },
//                               onSearched: (searchdText) {
//                                 return searchState(searchdText);
//                               },
//                               hintText: 'State',
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Expanded(
//                             child: SearchableDropDown(
//                               selectedItem: newRegistrationController
//                                   .selectedDivVal,
//                               isViewPatient: true,
//                               list: newRegistrationController
//                                   .divisionModel?.data
//                                   ?.map((e) => e.divName ?? '')
//                                   .where(
//                                       (name) => name.isNotEmpty)
//                                   .toList() ??
//                                   [],
//                               onChanged: (value) {
//                                 newRegistrationController
//                                     .selectedDivisionObj =
//                                     newRegistrationController
//                                         .divisionModel?.data
//                                         ?.firstWhere((e) =>
//                                     e.divName == value);
//                                 newRegistrationController
//                                     .selectedDivVal = value;
//                                 newRegistrationController.update();
//                                 debugPrint(
//                                     'Division changed to: $value');
//                               },
//                               onSearched: searchDivision,
//                               hintText: 'Division',
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: SearchableDropDown(
//                               selectedItem: newRegistrationController
//                                   .selectedPerDist,
//                               isViewPatient: true,
//                               list: newRegistrationController
//                                   .districtModel?.data
//                                   ?.map((e) => e.districtName)
//                                   .toList() ??
//                                   [],
//                               onChanged: (value) {
//                                 newRegistrationController
//                                     .perSelectedDistObj =
//                                     newRegistrationController
//                                         .districtModel?.data
//                                         ?.firstWhere((e) =>
//                                     e.districtName == value);
//                                 newRegistrationController
//                                     .selectedPerDist =
//                                     newRegistrationController
//                                         .perSelectedDistObj
//                                         ?.districtName;
//                                 newRegistrationController.update();
//                                 debugPrint(
//                                     'changing value to: $value');
//                               },
//                               onSearched: (searchdText) {
//                                 return searchDistrict(searchdText);
//                               },
//                               hintText: 'District',
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Expanded(
//                             child: SearchableDropDown(
//                               selectedItem: newRegistrationController
//                                   .selectedPerTaluka,
//                               isViewPatient: true,
//                               list: newRegistrationController
//                                   .talukaModel?.data
//                                   ?.map((e) => e.talukaName)
//                                   .toList() ??
//                                   [],
//                               onChanged: (value) {
//                                 newRegistrationController
//                                     .perSelectedTalukaObject =
//                                     newRegistrationController
//                                         .talukaModel?.data
//                                         ?.firstWhere((e) =>
//                                     e.talukaName == value);
//                                 newRegistrationController
//                                     .selectedPerTaluka =
//                                     newRegistrationController
//                                         .perSelectedTalukaObject
//                                         ?.talukaName;
//                                 newRegistrationController.update();
//                                 debugPrint(
//                                     'changing value to: $value');
//                               },
//                               onSearched: (searchdText) {
//                                 return searchTaluka(searchdText);
//                               },
//                               hintText: 'Taluka',
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       SearchableDropDown(
//                         selectedItem: newRegistrationController
//                             .selectedInstitute,
//                         isViewPatient: true,
//                         list: newRegistrationController
//                             .instituteList?.data
//                             ?.map((e) => e.unitName)
//                             .toList() ??
//                             [],
//                         onChanged: (value) {
//                           newRegistrationController
//                               .selectedInstitute = value;
//                           newRegistrationController.update();
//                         },
//                         onSearched: (searchdText) {
//                           return searchInst(searchdText);
//                         },
//                         hintText: 'Institute Name',
//                       ),
//
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: InkWell(
//                           onTap: () async {
//                             InstituteDataModel? inst =
//                             newRegistrationController
//                                 .instituteList?.data
//                                 ?.firstWhere(
//                                     (e) =>
//                                 e.unitName ==
//                                     newRegistrationController
//                                         .selectedInstitute,
//                                 orElse: () =>
//                                     InstituteDataModel());
//
//                             await cctvController.getInstitudeWiseCctvList(
//                                 newRegistrationController.selectedStateObj
//                                     ?.stateID != null
//                                     ? newRegistrationController
//                                     .selectedStateObj!.stateID
//                                     .toString()
//                                     : "",
//                                 newRegistrationController.selectedDivisionObj
//                                     ?.divId != null
//                                     ? newRegistrationController
//                                     .selectedDivisionObj?.divId
//                                     .toString()
//                                     : "",
//                                 newRegistrationController
//                                     .perSelectedDistObj
//                                     ?.districtID !=
//                                     null
//                                     ? newRegistrationController
//                                     .perSelectedDistObj
//                                     ?.districtID
//                                     .toString()
//                                     : '',
//                                 newRegistrationController
//                                     .perSelectedTalukaObject
//                                     ?.talukaID !=
//                                     null
//                                     ? newRegistrationController
//                                     .perSelectedTalukaObject
//                                     ?.talukaID
//                                     .toString()
//                                     : '',
//                                 inst?.unitId != null
//                                     ? inst!.unitId.toString()
//                                     : '');
//                           },
//                           child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 8),
//                               alignment: Alignment.center,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 borderRadius:
//                                 BorderRadius.circular(10),
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     AppColor.primaryBackgroundColor,
//                                     AppColor.secondaryColor
//                                   ],
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomCenter,
//                                 ),
//                               ),
//                               child: const Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.search,
//                                     color: Colors.white,
//                                   ),
//                                   CustomText(
//                                       text: "Search",
//                                       fontSize: 16,
//                                       fontFam: "Lato",
//                                       fontWeight: FontWeight.normal,
//                                       textColor: Colors.white,
//                                       textAlign: TextAlign.start),
//                                 ],
//                               )),
//                         ),
//                       ).paddingOnly(top: 6, bottom: 6, right: 6),
//                     ],
//                   ),
//                 ).paddingSymmetric(vertical: 6, horizontal: 10),
//                 Expanded(
//                   child: ListView.builder(
//                       itemCount:
//                       cctvController.institudeWiseCctv?.length,
//                       // itemCount: controller.dischargeList?.length,
//                       itemBuilder: (context, index) {
//                         return CctvCardList(
//                             patientList: DischargeListModel(
//                                 patientId: 12,
//                                 centerPatientId: '',
//                                 fName: cctvController
//                                     .institudeWiseCctv?[index]
//                                     .unitName ??
//                                     '',
//                                 mobile: '',
//                                 gender: 'female',
//                                 age: 20,
//                                 blockFlag: ''),
//                             // patientList: controller.dischargeList[index],
//                             cardItemDetailsList: cardItemDetailsList,
//                             path1: "assets/eye.png",
//                             callB1: () async {
//
//                               debugPrint(
//                                   "Selected: ${cctvController
//                                       .institudeWiseCctv?[index].unitName}");
//
//                               if (cctvController.institudeWiseCctv !=
//                                   null &&
//                                   index <
//                                       cctvController
//                                           .institudeWiseCctv!
//                                           .length) {
//                                 Get.to(() =>
//                                     CctvCameraDetails(
//                                       selectedState:
//                                       newRegistrationController
//                                           .selectedStateObj !=
//                                           null
//                                           ? newRegistrationController
//                                           .selectedStateObj
//                                           ?.stateID
//                                           .toString()
//                                           : "",
//                                       selectedDiv: newRegistrationController
//                                           .selectedDivisionObj !=
//                                           null
//                                           ? newRegistrationController
//                                           .selectedDivisionObj
//                                           ?.divId
//                                           .toString()
//                                           : "",
//                                       selectedDist: newRegistrationController
//                                           .perSelectedDistObj !=
//                                           null
//                                           ? newRegistrationController
//                                           .perSelectedDistObj
//                                           ?.districtID
//                                           .toString()
//                                           : "",
//                                       selectedTaluka: newRegistrationController
//                                           .perSelectedTalukaObject !=
//                                           null
//                                           ? newRegistrationController
//                                           .perSelectedTalukaObject
//                                           ?.talukaID
//                                           .toString()
//                                           : '',
//                                       selectedInst: newRegistrationController
//                                           .selectedInstitute !=
//                                           null
//                                           ? newRegistrationController
//                                           .instituteList?.data
//                                           ?.firstWhere((e) =>
//                                       e.unitName ==
//                                           newRegistrationController
//                                               .selectedInstitute)
//                                           .unitId
//                                           .toString()
//                                           : cctvController
//                                           .institudeWiseCctv![
//                                       index]
//                                           .unitId,
//                                       institudeWiseCctv:
//                                       cctvController
//                                           .institudeWiseCctv![
//                                       index],
//                                     ));
//                               }
//                             });
//                       }),
//                 ),
//               ],
//             ).paddingSymmetric(horizontal: 10)
//                 : InternetIssue(
//               onRetryPressed: () {
//                 checkInternetAndLoadData();
//               },
//             );
//           }),
//     );
//   }
//
//   Future<List<String>> searchTaluka(String query) async {
//     // Return an empty list if data is null
//     return newRegistrationController.talukaModel?.data
//         ?.where((e) {
//       return e.talukaName!.toLowerCase().contains(query.toLowerCase());
//     })
//         .map((e) => e.talukaName ?? "")
//         .toList() ??
//         [];
//   }
//
//   Future<List<String>> searchInst(String query) async {
//     // Return an empty list if data is null
//     return newRegistrationController
//         .instituteList?.data
//         ?.where((e) {
//       return e.unitName!.toLowerCase().contains(query.toLowerCase());
//     })
//         .map((e) => e.unitName ?? "")
//         .toList() ??
//         [];
//   }
//
//   Future<List<String>> searchDistrict(String query) async {
//     // Return an empty list if data is null
//     return newRegistrationController.districtModel?.data
//         ?.where((e) {
//       return e.districtName!
//           .toLowerCase()
//           .contains(query.toLowerCase());
//     })
//         .map((e) => e.districtName ?? "")
//         .toList() ??
//         [];
//   }
//
//   Future<List<String>> searchDivision(String query) async {
//     // Return an empty list if data is null
//     return newRegistrationController.divisionModel?.data
//         ?.where((e) {
//       return e.divName!.toLowerCase().contains(query.toLowerCase());
//     })
//         .map((e) => e.divName ?? "")
//         .toList() ??
//         [];
//   }
//
//   checkInternetAndLoadData() async {
//     // Load user data (if needed)
//     debugPrint("Checking internet and loading data...");
//
//     // Check the internet connection
//     var connectivityResult = await Connectivity().checkConnectivity();
//     debugPrint("Connectivity status: $connectivityResult");
//     if (connectivityResult == ConnectivityResult.none) {
//       debugPrint("No internet connection");
//     } else {
//       debugPrint("Internet is available");
//       cctvController.hasInternet = true;
//     }
//
//     if (cctvController.hasInternet) {
//       newRegistrationController.selectedDivVal = null;
//       newRegistrationController.selectedDivVal = null;
//       newRegistrationController.selectedPerDist = null;
//       newRegistrationController.selectedPerTaluka = null;
//       newRegistrationController.selectedInstitute = null;
//       newRegistrationController.selectedStateVal = null;
//       loadData();
//       cctvController.update();
//     } else {
//       debugPrint("No internet connection."); // Debug print if no internet
//     }
//   }
//
//   Future<List<String>> searchState(String query) async {
//     return newRegistrationController.stateModel?.data
//         ?.where((e) =>
//     e.stateName?.toLowerCase().contains(query.toLowerCase()) ??
//         false)
//         .map((e) => e.stateName ?? "")
//         .toList() ??
//         [];
//   }
//
//   Future<void> loadData() async {
//     await cctvController.getInstitudeWiseCctvList('', '', '', '', '');
//     await newRegistrationController.getInstituteList();
//     await newRegistrationController.getStateList();
//     await newRegistrationController.getDistrictList();
//     await newRegistrationController.getTalukaList();
//     await newRegistrationController.getDivisionList();
//   }
// }
//
// class CctvCardList extends StatelessWidget {
//   final DischargeListModel patientList;
//   final List<String> cardItemDetailsList;
//   final String? path1;
//   final Function callB1;
//
//   const CctvCardList({
//     super.key,
//     required this.patientList,
//     required this.cardItemDetailsList,
//     this.path1,
//     required this.callB1,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 70,
//       decoration: BoxDecoration(
//         color: const Color(0xffF8F8F8),
//         borderRadius: BorderRadius.circular(6),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             spreadRadius: 2,
//             blurRadius: 4,
//             offset: const Offset(0, 0.5), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: patientDetailsCard(
//                 cardItemDetailsList[0], patientList.fName.toString())
//                 .paddingOnly(left: 6, top: 2, bottom: 2, right: 4),
//           ),
//           Container(
//             width: 45,
//             decoration: BoxDecoration(
//               color: AppColor.darkBlue,
//               borderRadius: const BorderRadius.only(
//                   topRight: Radius.circular(6),
//                   bottomRight: Radius.circular(6)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 patientCardActions(path1!, () {
//                   callB1();
//                   // Get.to(() => BookAppointmentScreen(
//                   //     patientData: patientList[index]));
//                 }, null),
//               ],
//             ),
//           )
//         ],
//       ),
//     ).paddingAll(8.0);
//   }
//
//   Widget patientDetailsCard(String text, String details) {
//     return Row(
//       children: [
//         CustomText(
//             text: "$text : ",
//             fontSize: 13,
//             fontFam: "Lato",
//             fontWeight: FontWeight.normal,
//             textColor: Colors.black,
//             textAlign: TextAlign.start)
//             .paddingSymmetric(vertical: 2),
//         Expanded(
//           child: CustomText(
//               text: details,
//               fontSize: 13,
//               fontFam: "Lato",
//               fontWeight: FontWeight.normal,
//               textColor: Colors.grey,
//               textAlign: TextAlign.start)
//               .paddingSymmetric(vertical: 2),
//         ),
//       ],
//     );
//   }
//
//   Widget patientCardActions(String path, Function callB, bool? yes) {
//     return InkWell(
//         onTap: () {
//           callB();
//         },
//         child: Image.asset(
//           width: 22,
//           height: 22,
//           path,
//           color: Colors.white,
//         ));
//   }
// }
