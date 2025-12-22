import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/cover_sheet_nephro.dart';
import 'package:heamodialysis/widgets/custom_table.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class TabularAnalysisWeight extends StatefulWidget {
  final List<WeightTrendAnalysisList>? weight;

  const TabularAnalysisWeight({super.key, this.weight});

  @override
  State<TabularAnalysisWeight> createState() => _TabularAnalysisWeightState();
}

class _TabularAnalysisWeightState extends State<TabularAnalysisWeight> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
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
                      text: 'Weight',
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
                  l1: widget.weight != null && widget.weight!.isNotEmpty
                      ? widget.weight!
                          .asMap()
                          .keys
                          .map((index) => (index + 1).toString())
                          .toList()
                      : [],
                  l2: widget.weight
                          ?.map((e) => e.preDialysisStartDate)
                          .toList() ??
                      [],
                  l3: widget.weight
                          ?.map((e) => e.postDialysisStopDate)
                          .toList() ??
                      [],
                  l4: widget.weight?.map((e) => e.preWeight).toList() ?? [],
                  tableHeader: const [
                    "Sr.\nNo",
                    "Pre \nDate",
                    "Post \nDate",
                    "Pre\nWeight",
                    "Post\nWeight"
                  ],
                  lastColumnWidgets: widget.weight
                          ?.map((diet) => CustomText(
                                text: diet.postWeight ?? 'N/A',
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
