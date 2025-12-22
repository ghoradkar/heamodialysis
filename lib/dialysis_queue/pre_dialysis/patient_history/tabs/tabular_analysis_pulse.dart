import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/cover_sheet_nephro.dart';
import 'package:heamodialysis/widgets/custom_table.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class TabularAnalysisPulse extends StatefulWidget {
  final List<PulseTrendAnalysisList>? pulse;

  const TabularAnalysisPulse({super.key, this.pulse});

  @override
  State<TabularAnalysisPulse> createState() => _TabularAnalysisPulseState();
}

class _TabularAnalysisPulseState extends State<TabularAnalysisPulse> {
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
                      text: 'Temperature',
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
                  l1: widget.pulse != null && widget.pulse!.isNotEmpty
                      ? widget.pulse!
                          .asMap()
                          .keys
                          .map((index) => (index + 1).toString())
                          .toList()
                      : [],
                  l2: widget.pulse
                          ?.map((e) => e.preDialysisStartDate)
                          .toList() ??
                      [],
                  l3: widget.pulse
                          ?.map((e) => e.postDialysisStopDate)
                          .toList() ??
                      [],
                  l4: widget.pulse?.map((e) => e.prePulse).toList() ?? [],
                  tableHeader: const [
                    "Sr. No",
                    "Pre \nDate",
                    "Post \nDate",
                    "Pre Temperature",
                    "Post Temperature"
                  ],
                  lastColumnWidgets: widget.pulse
                          ?.map((diet) => CustomText(
                                text: diet.postPulse ?? 'N/A',
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
