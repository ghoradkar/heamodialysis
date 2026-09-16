import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/pre_dialysis/edit_history/history_data.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/model/pre_dialysis/pre_dialysis_data.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/patient_card_details.dart';
import 'package:intl/intl.dart';

class PatientHistoryScreen extends StatefulWidget {
  final PreDialysisData preDialysisData;
  final List<HistoryData>? historyList;

  const PatientHistoryScreen(
      {super.key, required this.preDialysisData, this.historyList});

  @override
  State<PatientHistoryScreen> createState() => _PatientHistoryScreenState();
}

class _PatientHistoryScreenState extends State<PatientHistoryScreen> {
  bool isExpanded = false;
  bool hasInternet = true;

  // List<String> cardDataList = ["85686856",'2024-01-11','1','Test Remark'];

  // TextEditingController pincodeController = TextEditingController();
  // TextEditingController addressController = TextEditingController();

  // void addCard() {
  //   setState(() {
  //     cardDataList.add(CardData(productName: '', quantity: 0, remark: ''));
  //   });
  // }
  //
  // void removeCard(int index) {
  //   if (cardDataList.length > 1) {
  //     setState(() {
  //       cardDataList.removeAt(index);
  //     });
  //   }
  // }
  final NewRegistrationController newRegistrationController =
      Get.put(NewRegistrationController());

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
    newRegistrationController.refreshUi();
    if (hasInternet) {
      await newRegistrationController
          .viewPatientData(widget.preDialysisData.patientId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: context.l10n.dqHistory,
          fontSize: 18.0,
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
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          GetBuilder<NewRegistrationController>(builder: (controller) {
            return PatientCardDetails(
              isExpand: (value) {
                isExpanded = value;
                setState(() {});
              },
              isExpanded: isExpanded,
              isFromAddPredialysis: true,
              refBy: widget.preDialysisData.refByName ?? "",
              schemaAdopted: '',
              patientDetails: newRegistrationController.viewPatientModel,
            ).paddingSymmetric(vertical: 10);
          }),
          Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.darkBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: ExpansionTile(
                    maintainState: true,
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                    title: Row(children: [
                      Image.asset("assets/pulse-line.png"),
                      const SizedBox(width: 12),
                      Text(
                        context.l10n.dqDialysisHistory,
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontFamily: 'Lato'),
                      ),
                    ]),
                    children: widget.historyList!.asMap().entries.map((entry) {
                      int index = entry.key;
                      HistoryData cardData = entry.value;
                      return dialysisHistoryCard(index, cardData);
                    }).toList(),
                  ))),
          const SizedBox(
            height: 10,
          ),
          Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.darkBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: ExpansionTile(
                    maintainState: true,
                    collapsedIconColor: Colors.white,
                    iconColor: Colors.white,
                    title: Row(children: [
                      Image.asset("assets/pulse-line.png"),
                      const SizedBox(width: 12),
                      Text(
                        context.l10n.dqTubeHistory,
                        style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontFamily: 'Lato'),
                      ),
                    ]),
                    children: widget.historyList!.asMap().entries.map((entry) {
                      int index = entry.key;
                      HistoryData cardData = entry.value;
                      return tubeHistoryCard(index, cardData);
                    }).toList(),
                  ))),
        ],
      ).paddingSymmetric(horizontal: 4)),
    );
  }

  Widget dialysisHistoryCard(int index, HistoryData cardData) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.borderColor)),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CustomText(
                            text: "${context.l10n.clinDialyzerBarcode} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: cardData.dialyserBarcodeSerialNo ?? '',
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: "${context.l10n.clinDialyzerBarcode} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: formatDateFromIso(cardData.createdDate) ?? "",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: "${context.l10n.dqCounter} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: cardData.dialyserResueNo.toString(),
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: "${context.l10n.clinDialyzerRemark} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: cardData.dialyserRemarks ?? "",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: "${context.l10n.clinDiscardedRemarks} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: cardData.discardreamrk ?? "",
                            fontSize: 14,
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
              width: 24,
              height: 24,
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

  Widget tubeHistoryCard(int index, HistoryData cardData) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.borderColor)),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CustomText(
                            text: "${context.l10n.clinBloodTubingBarcode} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: cardData.tubeBarcodeSerialNo ?? "",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: "${context.l10n.clinBloodTubingBarcode} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: formatDateFromIso(cardData.createdDate) ?? "",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: "${context.l10n.dqCounter} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: cardData.dialyserResueNo.toString(),
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                            text: "${context.l10n.clinDiscardedRemarks} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            text: cardData.tubeRemarks ?? "",
                            fontSize: 14,
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
              width: 24,
              height: 24,
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

  String? formatDateFromIso(String? isoString) {
    if (isoString != null && isoString.isNotEmpty) {
      try {
        DateTime dateTime = DateTime.parse(isoString);
        return DateFormat('yyyy-MM-dd').format(dateTime);
      } catch (e) {
        debugPrint("Invalid ISO date: $isoString");
        return null;
      }
    }
    return null;
  }

// String? formatDateFromTimestamp(String? timestamp) {
//   if (timestamp != null && timestamp.isNotEmpty) {
//     try {
//       int parsedTimestamp = int.parse(timestamp);
//       DateTime dateTime =
//           DateTime.fromMillisecondsSinceEpoch(parsedTimestamp);
//
//       // Define the desired format
//       DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//
//       // Format the DateTime object to a string
//       return dateFormat.format(dateTime);
//     } catch (e) {
//       print("Invalid timestamp: $timestamp");
//       return null;
//     }
//   }
//   return null;
// }
}
