// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
// import 'package:get/get.dart';
// import 'package:heamodialysis/internet/no_internet_connectivity.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/model/choose_package_list_model.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/choose_package.dart';
// import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/diagnostic_inv.dart';
// import 'package:heamodialysis/new_registration/new_registration_controller.dart';
// import 'package:heamodialysis/utils/color_constants.dart';
// import 'package:heamodialysis/widgets/custom_text.dart';
//
// class LabInvestigation extends StatefulWidget {
//   final ChoosePackageListModel? choosePackageListModel;
//
//   const LabInvestigation({super.key, this.choosePackageListModel});
//
//   @override
//   State<LabInvestigation> createState() => _LabInvestigationState();
// }
//
// class _LabInvestigationState extends State<LabInvestigation>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;
//
//   final NewRegistrationController newRegistrationController =
//       Get.put(NewRegistrationController());
//   bool hasInternet = true;
//
//   bool isAdded = false;
//
//   @override
//   void initState() {
//     checkInternetAndLoadData();
//
//     tabController = TabController(length: 2, vsync: this);
//     tabController.addListener(() {
//       // setState(() {}); // Update the UI when the tab changes
//       newRegistrationController.refreshUi();
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }
//
//   checkInternetAndLoadData() async {
//     List<ConnectivityResult> connectivityResult =
//         await Connectivity().checkConnectivity();
//     // setState(() {
//     hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
//         connectivityResult.contains(ConnectivityResult.wifi));
//     // });
//     newRegistrationController.refreshUi();
//     if (hasInternet) {}
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<NewRegistrationController>(
//         init: NewRegistrationController(),
//         builder: (controller) {
//           return hasInternet
//               ? controller.isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : Column(
//                       children: [
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         TabBar(
//                           controller: tabController,
//                           dividerColor: Colors.transparent,
//                           indicatorColor: Colors.transparent,
//                           padding: EdgeInsets.zero,
//                           indicatorPadding: EdgeInsets.zero,
//                           labelPadding: EdgeInsets.zero,
//                           tabs: [
//                             buildTab(0, "Choose Package"),
//                             buildTab(1, "Add new test with Package"),
//                           ],
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             controller: tabController,
//                             children: [
//                               isAdded == false
//                                   ? ChoosePackage(
//                                       onAdd: (value) {
//                                         isAdded = value;
//                                         setState(() {});
//                                       },
//                                 choosePackageListModel: widget.choosePackageListModel, label: '',
//                                     )
//                                   : TestNameList(
//                                       onAdd: (value) {
//                                         isAdded = value;
//                                         setState(() {});
//                                       },
//                                 choosePackageListModel: widget.choosePackageListModel,
//
//                                     ),
//                               ChoosePackage(
//                                 onAdd: () {},
//                                 choosePackageListModel: widget.choosePackageListModel, label: '',
//
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ).paddingSymmetric(horizontal: 6)
//               : InternetIssue(
//                   onRetryPressed: () {
//                     checkInternetAndLoadData();
//                   },
//                 );
//         });
//   }
//
//   Widget buildTab(int index, String text) {
//     bool isSelected = tabController.index == index;
//     return Container(
//       width: 210,
//       // height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 0.8, vertical: 6),
//       decoration: BoxDecoration(
//           // color: isSelected ? Colors.blue.shade200 : Colors.transparent,
//           gradient: isSelected
//               ? LinearGradient(
//                   colors: [
//                     AppColor.primaryBackgroundColor,
//                     AppColor.secondaryColor
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomCenter,
//                 )
//               : const LinearGradient(
//                   colors: [
//                     Colors.transparent,
//                     Colors.transparent,
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomCenter,
//                 ),
//           borderRadius: setBorderRadiusIndexWise(index),
//           border: Border.all(color: const Color(0xffE1E1E1))),
//       // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Container(
//         height: 30,
//         alignment: Alignment.center,
//         child: CustomText(
//           text: text,
//           fontSize: 12.0,
//           fontFam: 'Lato',
//           fontWeight: FontWeight.normal,
//           textColor: isSelected ? Colors.white : const Color(0xff777777),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
//
//   setBorderRadiusIndexWise(index) {
//     if (index == 0) {
//       return const BorderRadius.only(
//           topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
//     } else if (index == 1) {
//       // return BorderRadius.zero;
//       return const BorderRadius.only(
//           topRight: Radius.circular(10), bottomRight: Radius.circular(10));
//     }
//     // else if (index == 3) {
//     //   return const BorderRadius.only(
//     //       topRight: Radius.circular(10), bottomRight: Radius.circular(10));
//     // }
//   }
// }
