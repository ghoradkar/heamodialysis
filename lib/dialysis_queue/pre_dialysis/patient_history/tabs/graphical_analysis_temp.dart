import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/cover_sheet_nephro.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/line_chart.dart';


class GraphicalAnalysisTemp extends StatefulWidget {
  final List<TemperatureTrendAnalysisList>? temp;

  const GraphicalAnalysisTemp({super.key, this.temp});

  @override
  State<GraphicalAnalysisTemp> createState() => _GraphicalAnalysisTempState();
}

class _GraphicalAnalysisTempState extends State<GraphicalAnalysisTemp> {
  @override
  Widget build(BuildContext context) {
    // Extract data from widget.weight and convert them
    List<DateTime> dates = [];
    List<double> preDialysisVal = [];
    List<double> postDialysisVal = [];

    if (widget.temp != null) {
      for (var data in widget.temp!) {
        // Parse the dates and weights
        if (data.preDialysisStartDate != null && data.postDialysisStopDate != null) {
          dates.add(DateTime.parse(data.preDialysisStartDate!));
          dates.add(DateTime.parse(data.postDialysisStopDate!));
        }
        if (data.preTemperature != null) preDialysisVal.add(double.parse(data.preTemperature!));
        if (data.postTemperature != null) postDialysisVal.add(double.parse(data.postTemperature!));
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.borderColor)),
            child: Column(
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
                        text: 'Temperature Trend Analysis',
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

                // Plotting the graph with the dynamic data
                SizedBox(
                  height: 300,
                  child: LineChartWidget(
                    dates: dates.isEmpty
                        ? [DateTime(2024, 8, 1), DateTime(2024, 8, 2)] // Default fallback dates
                        : dates,
                    preDialysisValue: preDialysisVal.isEmpty
                        ? [70, 72] // Default fallback weights
                        : preDialysisVal,
                    postDialysisValue: postDialysisVal.isEmpty
                        ? [68, 70] // Default fallback weights
                        : postDialysisVal, analysis: 'Temperature',
                  ),
                ),
              ],
            ),
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


