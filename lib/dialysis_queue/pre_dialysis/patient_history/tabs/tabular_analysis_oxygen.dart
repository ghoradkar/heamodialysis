import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/cover_sheet_nephro.dart';
import 'package:heamodialysis/widgets/custom_table.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class TabularAnalysisOxygen extends StatefulWidget {
  final List<OxygenLevelTrendAnalysisList>? oxygen;

  const TabularAnalysisOxygen({super.key, this.oxygen});

  @override
  State<TabularAnalysisOxygen> createState() => _TabularAnalysisOxygenState();
}

class _TabularAnalysisOxygenState extends State<TabularAnalysisOxygen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
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
                      text: context.l10n.clinTemperature,
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
              RoundedCornerTable(
                l1: widget.oxygen != null && widget.oxygen!.isNotEmpty
                    ? widget.oxygen!
                        .asMap()
                        .keys
                        .map((index) => (index + 1).toString())
                        .toList()
                    : [],
                l2: widget.oxygen
                        ?.map((e) => e.preDialysisStartDate)
                        .toList() ??
                    [],
                l3: widget.oxygen
                        ?.map((e) => e.postDialysisStopDate)
                        .toList() ??
                    [],
                l4: widget.oxygen?.map((e) => e.preDialysisOxygen).toList() ??
                    [],
                tableHeader: const [
                  "Sr. No",
                  "Pre \nDate",
                  "Post \nDate",
                  "Pre Temperature",
                  "Post Temperature"
                ],
                lastColumnWidgets: widget.oxygen
                        ?.map((diet) => CustomText(
                              text: diet.preDialysisOxygen ?? 'N/A',
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
