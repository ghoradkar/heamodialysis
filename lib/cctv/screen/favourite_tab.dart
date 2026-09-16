// import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
// import 'package:get/get.dart';
// import 'package:heamodialysis/discharge_form/model/discharge_list.dart';
// import 'package:heamodialysis/utils/color_constants.dart';
// import 'package:heamodialysis/widgets/custom_text.dart';
//
// class FavouriteTab extends StatefulWidget {
//   const FavouriteTab({super.key});
//
//   @override
//   State<FavouriteTab> createState() => _FavouriteTabState();
// }
//
// class _FavouriteTabState extends State<FavouriteTab> {
//   List<String> cardItemDetailsList = ['Institute Name','Date'];
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 5,
//         // itemCount: controller.dischargeList?.length,
//         itemBuilder: (context, index) {
//           return FavCardList(
//               patientList: DischargeListModel(
//                   patientId: 12,
//                   centerPatientId: '',
//                   fName: 'Chellaram Hospital - Diabetes Care & Multispecialty',
//                   mobile: '',
//                   gender: ' 21 April 2025 ',
//                   age: 20,
//                   blockFlag: ''),
//               // patientList: controller.dischargeList[index],
//               cardItemDetailsList: cardItemDetailsList,
//               path1: "assets/favourite.png",
//               callB1: () {
//                 // Get.to(() => const CctvCameraDetails());
//
//                 // Get.to(() => DialysisEventDetails(
//                 //     dialysisEventDet:
//                 //         controller.dialysisEventList[index]));
//               });
//         });
//   }
// }
//
// class FavCardList extends StatelessWidget {
//   final DischargeListModel patientList;
//   final List<String> cardItemDetailsList;
//   final String? path1;
//   final Function callB1;
//
//   const FavCardList({
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
//             child: Column(
//               children: [
//                 patientDetailsCard(
//                     cardItemDetailsList[0], patientList.fName.toString())
//                     .paddingOnly(left: 4,  right: 4),
//                 patientDetailsCard(
//                     cardItemDetailsList[1], patientList.gender.toString())
//                     .paddingOnly(left: 6,  right: 4),
//               ],
//             ),
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
//
