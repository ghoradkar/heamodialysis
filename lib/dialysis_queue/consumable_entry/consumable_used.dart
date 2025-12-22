import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/consumable_entry/add_consumable.dart';
import 'package:heamodialysis/dialysis_queue/consumable_entry/model/consumable_list_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_list_model.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/controller/ro_machine_issue_log_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/patient_card_details.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class ConsumableUsed extends StatefulWidget {
  final DialysisEventListModel? preDialysisData;

  // final List<HistoryData>? historyList;

  const ConsumableUsed({super.key, this.preDialysisData});

  @override
  State<ConsumableUsed> createState() => _ConsumableUsedState();
}

class _ConsumableUsedState extends State<ConsumableUsed> {
  bool isExpanded = false;
  final RoMachineIssueLogController roMachineIssueController =
      Get.put(RoMachineIssueLogController());
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());
  bool hasInternet = true;

  @override
  void initState() {
    // cardDataList.add(CardData(productName: '', quantity: 0, remark: ''));
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
    roMachineIssueController.update();
    if (hasInternet) {
      await roMachineIssueController
          .getConsumableList(widget.preDialysisData?.patientId);
      await newRegistrationController
          .viewPatientData(widget.preDialysisData?.patientId);
    }
    // setState(() {});
    roMachineIssueController.update();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoMachineIssueLogController>(
        init: roMachineIssueController,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title:  CustomText(
                text: 'Physical Entry of Consumable Used',
                fontSize: 18.sp,
                fontFam: 'Lato',
                fontWeight: FontWeight.w400,
                textColor: Colors.black,
                textAlign: TextAlign.start,
              ),
              leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset('assets/arrow-left.png')),
              actions: [
                InkWell(
                        onTap: () {
                          Get.to(() => AddConsumable(
                                preDialysisData: widget.preDialysisData,
                              ));
                        },
                        child: Image.asset('assets/add-pre-dialysis.png'))
                    .paddingOnly(right: 4.w)
              ],
            ),
            body: hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : Column(
                        children: [
                          PatientCardDetails(
                            isExpand: (value) {
                              isExpanded = value;
                              setState(() {});
                            },
                            isExpanded: isExpanded,
                            isFromAddPredialysis: true,
                            // patientId: widget.preDialysisData?.patientId != null
                            //     ? widget.preDialysisData!.patientId.toString()
                            //     : "",
                            // patientName: widget.preDialysisData?.fName != null
                            //     ? widget.preDialysisData!.fName.toString()
                            //     : "",
                            // gender: widget.preDialysisData?.gender ?? "",
                            // refDoc:
                            //
                            //         "",
                            // age: widget.preDialysisData?.age != null
                            //     ? widget.preDialysisData!.age.toString()
                            //     : '',
                            refBy: "",
                            schemaAdopted: '',
                            patientDetails:
                                newRegistrationController.viewPatientModel,
                          ).paddingSymmetric(vertical: 10.h),

                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    controller.consumableListModel?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return dialysisHistoryCard(index,
                                      controller.consumableListModel?[index]);
                                }),
                          )
                          // dialysisHistoryCard(0),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // dialysisHistoryCard(1),
                        ],
                      ).paddingSymmetric(horizontal: 4.w)
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  ),
          );
        });
  }

  Widget dialysisHistoryCard(int index, ConsumableListModel? item) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        // borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColor.borderColor)
      ),
      child: Stack(
        children: [
          Column(
            children: [
               SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.borderColor)),
                padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                         CustomText(
                            text: "Order ID :",
                            fontSize: 14.sp,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: item?.productOrderId.toString() ?? '',
                            fontSize: 14.sp,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         CustomText(
                            text: "Product Name  :",
                            fontSize: 14.sp,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        Expanded(
                          child: CustomText(
                              // text: formatDateFromTimestamp(cardData.dialysisStartDate) ?? "",
                              text: item?.productName ?? '',
                              fontSize: 14.sp,
                              fontFam: "Lato",
                              fontWeight: FontWeight.w400,
                              textColor: Colors.black,
                              textAlign: TextAlign.start),
                        ),
                        Row(
                          children: [
                             CustomText(
                                text: "Batch No :",
                                fontSize: 14.sp,
                                fontFam: "Lato",
                                fontWeight: FontWeight.w500,
                                textColor: Colors.black,
                                textAlign: TextAlign.start),
                            CustomText(
                                // text: formatDateFromTimestamp(cardData.dialysisStartDate) ?? "",
                                text: item?.batchNumber ?? '',
                                fontSize: 14.sp,
                                fontFam: "Lato",
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         CustomText(
                            text: "Expiry Date :",
                            fontSize: 14.sp,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: formatDateFromTimestamp(
                                item?.itemGrnExpiryDate ?? ""),
                            fontSize: 14.sp,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        Row(
                          children: [
                             CustomText(
                                text: "Available Quantity :",
                                fontSize: 14.sp,
                                fontFam: "Lato",
                                fontWeight: FontWeight.w500,
                                textColor: Colors.black,
                                textAlign: TextAlign.start),
                            CustomText(
                                text: item?.consumedQuantity.toString() ?? '',
                                fontSize: 14.sp,
                                fontFam: "Lato",
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                         CustomText(
                            text: "Consumed Quantity :",
                            fontSize: 14.sp,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            // text: cardData.dialyserRemarks ?? "",
                            text: item?.usedQuantity.toString() ?? '',
                            fontSize: 14.sp,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0.8,
            child: Container(
              alignment: Alignment.center,
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                  colors: [
                    AppColor.primaryBackgroundColor,
                    AppColor.secondaryColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  String formatDateFromTimestamp(String timestamp) {
    if (timestamp.isNotEmpty) {
      String originalDate = timestamp;

      DateTime parsedDate = DateTime.parse(originalDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

      debugPrint(formattedDate); // Output: 2025-11-1
      return formattedDate;
    } else {
      return '';
    }
  }

// Widget customCard(int index, CardData cardData) {
//   return Container(
//     padding: const EdgeInsets.all(8),
//     decoration: BoxDecoration(
//       color: Colors.grey[50],
//       // borderRadius: BorderRadius.circular(10),
//       // border: Border.all(color: AppColor.borderColor)
//     ),
//     child: Stack(
//       children: [
//         Column(
//           children: [
//             const SizedBox(height: 20),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.grey[50],
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: AppColor.borderColor)),
//               padding: const EdgeInsets.all(4),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomDropdown(
//                             selectedItem: cardData.productName.isNotEmpty
//                                 ? cardData.productName
//                                 : null,
//                             labelText: 'Product Name',
//                             items: const ['Product 1', 'Product 2'],
//                             hint: 'Select',
//                             isRequired: false,
//                             senValue: (value) {
//                               updateCardData(index, 'productName', value!);
//                             },
//                             filledColor: Colors.white),
//                       ),
//                       const SizedBox(height: 8),
//                       Expanded(
//                         child: CustomTextField(
//                             onChanged: (value) {
//                               updateCardData(index, 'productName', value!);
//                             },
//                             maxLines: 1,
//                             isReadOnly: false,
//                             keyBoardType: TextInputType.number,
//                             labelText: 'Quantity',
//                             hintText: 'Enter',
//                             isRequired: false,
//                             txtController: pincodeController,
//                             fillColor: Colors.white),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   CustomTextField(
//                       onChanged: (value) {
//                         updateCardData(index, 'productName', value!);
//                       },
//                       maxLines: 1,
//                       isReadOnly: false,
//                       keyBoardType: TextInputType.streetAddress,
//                       labelText: 'Remark',
//                       hintText: 'Enter',
//                       isRequired: false,
//                       txtController: addressController,
//                       fillColor: Colors.white),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           addCard();
//                         },
//                         icon: const Icon(Icons.add_circle_outline),
//                         color: Colors.green,
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           removeCard(index);
//                         },
//                         icon: const Icon(Icons.remove_circle_outline),
//                         color: Colors.red,
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Positioned(
//           top: 0.8,
//           child: Container(
//             alignment: Alignment.center,
//             width: 30,
//             height: 30,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               gradient: LinearGradient(
//                 colors: [
//                   AppColor.primaryBackgroundColor,
//                   AppColor.secondaryColor
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: Text(
//               (index + 1).toString(),
//               style: const TextStyle(color: Colors.white),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }

// void updateCardData(int index, String field, dynamic value) {
//   setState(() {
//     switch (field) {
//       case 'productName':
//         cardDataList[index].productName = value;
//         break;
//       case 'quantity':
//         cardDataList[index].quantity = int.tryParse(value) ?? 0;
//         break;
//       case 'remark':
//         cardDataList[index].remark = value;
//         break;
//     }
//   });
// }
}

class CardData {
  String productName;
  int quantity;
  String remark;

  CardData(
      {required this.productName,
      required this.quantity,
      required this.remark});

  // Optional: method to convert the object to JSON, useful for API calls
  Map<String, dynamic> toJson() => {
        'productName': productName,
        'quantity': quantity,
        'remark': remark,
      };
}
