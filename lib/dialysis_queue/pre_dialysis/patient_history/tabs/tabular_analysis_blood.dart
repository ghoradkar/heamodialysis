import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/cover_sheet_nephro.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/expandable_card.dart';
import 'package:heamodialysis/widgets/custom_table.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../../../nephro_desk_patient_list/controller/nephro_controller.dart';

class TabularAnalysisBlood extends StatefulWidget {
  final List<BloodPressureTrendAnalysisList>? blooad;


  const TabularAnalysisBlood({super.key, this.blooad});

  @override
  State<TabularAnalysisBlood> createState() => _TabularAnalysisBloodState();
}

class _TabularAnalysisBloodState extends State<TabularAnalysisBlood> {
  bool isExpanded = false;
  final NephroController nephroController = Get.find<NephroController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Trend Analysis',
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
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [


        ExpandableCardDetails(
        patientData: nephroController.patientDet?.first,
        isExpand: (value) {
          isExpanded = value;
          setState(() {});
        },
        isExpanded: isExpanded,
        currentStat: nephroController.currentStat,
      ).paddingSymmetric(vertical: 10.h),
                const Row(
                  children: [
                    CustomText(
                        text: 'Test Name :',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.w500,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                    CustomText(
                        text: 'Blood Pressure',
                        fontSize: 14,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.start),
                  ],
                ).paddingSymmetric(vertical: 2),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 150,
                  child: RoundedCornerTable(
                    l1: widget.blooad != null && widget.blooad!.isNotEmpty
                        ? widget.blooad!
                            .asMap()
                            .keys
                            .map((index) => (index + 1).toString())
                            .toList()
                        : [],
                    l2: widget.blooad
                            ?.map((e) => e.preDialysisStartDate)
                            .toList() ??
                        [],
                    l3: widget.blooad
                            ?.map((e) => e.postDialysisStopDate)
                            .toList() ??
                        [],
                    l4: widget.blooad?.map((e) => e.prebloodPressureHL).toList() ?? [],
                    tableHeader: const [
                      "Sr. \nNo\n",
                      "Pre \nDate\n",
                      "Post \nDate\n",
                      "Pre \nBlood Pressure",
                      "Post \nBlood Pressure"
                    ],
                    lastColumnWidgets: widget.blooad
                            ?.map((diet) => CustomText(
                                  text: diet.postbloodpressureLH ?? 'N/A',
                                  fontSize: 14,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start,
                                ))
                            .toList() ??
                        [],
                    onButtonPressed: handleButtonPress,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  handleButtonPress(int index) {
    // Perform action based on the index
    if (index == 0) {
      debugPrint('Button pressed at index: $index');
    } else if (index == 1) {
      debugPrint('Button pressed at index: $index');
    }
  }
}
