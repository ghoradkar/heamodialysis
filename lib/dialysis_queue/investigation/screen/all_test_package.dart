import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/test_details_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class AllTestPackage extends StatefulWidget {
  final List<TestDetailsModel>? testList;

  const AllTestPackage({super.key, this.testList});

  @override
  State<AllTestPackage> createState() => _AllTestPackageState();
}

class _AllTestPackageState extends State<AllTestPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: context.l10n.dqAllTest,
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
      body: ListView.builder(
          itemCount: widget.testList?.length,
          itemBuilder: (context, index) {
            return dialysisHistoryCard(index,widget.testList?[index]);
          }),
    );
  }

  Widget dialysisHistoryCard(int index,TestDetailsModel? testData) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        // borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: AppColor.borderColor)
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
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CustomText(
                            text: "${context.l10n.dqTestName} :",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            // text: cardData.dialyserBarcodeSerialNo ?? '',
                            text: testData?.packageName ??'',
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
                            text: "${context.l10n.dqTestId} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            // text: formatDateFromTimestamp(cardData.dialysisStartDate) ?? "",
                            text: testData?.testName.toString() ?? "",
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
                            text: "${context.l10n.dqTestName} : ",
                            fontSize: 14,
                            fontFam: "Lato",
                            fontWeight: FontWeight.w500,
                            textColor: Colors.black,
                            textAlign: TextAlign.start),
                        CustomText(
                            // text: formatDateFromTimestamp(cardData.dialysisStartDate) ?? "",
                            text: testData?.testName ?? "",
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
}
