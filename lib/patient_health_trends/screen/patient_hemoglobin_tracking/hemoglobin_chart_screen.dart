import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/patient_health_trends/model/vital_report_model.dart';
import 'package:heamodialysis/patient_health_trends/controller/patient_heath_trends_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class HemoglobinChartScreen extends StatefulWidget {
  final String? metricName;
  final VitalReportModel? dates;
  final List<double?> series;

  const HemoglobinChartScreen({
    super.key,
    this.metricName,
    this.dates,
    required this.series,
  });

  @override
  State<HemoglobinChartScreen> createState() => _VitalChartScreenState();
}

class _VitalChartScreenState extends State<HemoglobinChartScreen> {
  final PatientController patientController = Get.put(PatientController());

  bool hasInternet = true;
  var userData;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.metricName ?? '',
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
          child: Image.asset('assets/arrow-left.png'),
        ),
      ),
      body: GetBuilder<PatientController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Trend Chart
            _buildTrendChart(controller),

            CustomText(
              text: context.l10n.phtValuesByDate,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
              textAlign: TextAlign.start,
            ).paddingSymmetric(vertical: 4),

            // Values List
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller
                        .vitalReportModel?.data[widget.metricName]?.length ??
                    0,
                itemBuilder: (context, index) {
                  final entries = controller
                      .vitalReportModel!.data[widget.metricName]!.entries
                      .toList();
                  String? date = entries[index].key;
                  String? value = entries[index].value;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.borderColor.withValues(alpha: 0.4),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: date,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          textColor: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        CustomText(
                          text: value ?? 'No data',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          textColor: Colors.black,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ).paddingSymmetric(vertical: 6);
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 14);
      }),
    );
  }

  Widget _buildTrendChart(PatientController controller) {
    final metricData = controller.vitalReportModel?.data[widget.metricName];

    if (metricData == null || metricData.isEmpty) {
      return Container(
        height: 300,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.borderColor),
        ),
        child: Center(
          child: CustomText(
            text: context.l10n.phtNoChartData,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            textColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    List<DateTime> dates = [];
    List<double> values = [];

    // Extract dates and values, filtering out nulls and empty strings
    metricData.forEach((dateStr, value) {
      // Skip if value is null or empty string
      if (value == null || value.toString().trim().isEmpty) {
        return;
      }

      try {
        // Parse date from dd-MM-yyyy format
        final parts = dateStr.split('-');
        if (parts.length == 3) {
          final date = DateTime(
            int.parse(parts[2]), // year
            int.parse(parts[1]), // month
            int.parse(parts[0]), // day
          );

          // Try to parse the value
          final parsedValue = double.tryParse(value.toString());
          if (parsedValue != null) {
            dates.add(date);
            values.add(parsedValue);
          }
        }
      } catch (e) {
        // Skip invalid entries
        debugPrint('Error parsing date/value: $e');
      }
    });

    // Check if we have any valid data after filtering
    if (dates.isEmpty || values.isEmpty) {
      return Container(
        height: 300,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.borderColor),
        ),
        child: Center(
          child: CustomText(
            text: context.l10n.phtNoValidDataPoints,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            textColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Sort by date (chronological order)
    final combined = List.generate(
      dates.length,
      (i) => {'date': dates[i], 'value': values[i]},
    );
    combined.sort(
        (a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));

    dates = combined.map((e) => e['date'] as DateTime).toList();
    values = combined.map((e) => e['value'] as double).toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.borderColor),
            ),
            child: SizedBox(
              height: 500,
              child: VitalLineChartWidget(
                dates: dates,
                preDialysisValue: values,
                postDialysisValue: const [],
                analysis: widget.metricName ?? 'Value',
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class VitalLineChartWidget extends StatelessWidget {
  final List<DateTime> dates;
  final List<double> preDialysisValue;
  final List<double> postDialysisValue;
  final String analysis;

  const VitalLineChartWidget({
    super.key,
    required this.dates,
    required this.preDialysisValue,
    required this.postDialysisValue,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    if (preDialysisValue.isEmpty && postDialysisValue.isEmpty) {
      return Center(child: Text('No data available'));
    }

    List<double> allValues = [];
    if (preDialysisValue.isNotEmpty) allValues.addAll(preDialysisValue);
    if (postDialysisValue.isNotEmpty) allValues.addAll(postDialysisValue);

    double minY = 0;
    double maxY = 100;

    if (allValues.isNotEmpty) {
      double dataMin = allValues.reduce((a, b) => a < b ? a : b);
      double dataMax = allValues.reduce((a, b) => a > b ? a : b);

      double range = dataMax - dataMin;
      double padding = range > 0 ? range * 0.1 : 10;

      minY = (dataMin - padding).floorToDouble();
      maxY = (dataMax + padding).ceilToDouble();

      if (maxY - minY < 10) {
        double mid = (minY + maxY) / 2;
        minY = mid - 5;
        maxY = mid + 5;
      }
    }

    int maxLength = preDialysisValue.length;
    double yInterval = ((maxY - minY) / 5).ceilToDouble();
    if (yInterval < 1) yInterval = 1;

    return Column(
      children: [
        // Axis Labels Header

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 8, bottom: 8),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: yInterval,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withValues(alpha: 0.3),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withValues(alpha: 0.3),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    axisNameWidget: Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    axisNameSize: 20,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: maxLength > 10 ? 2 : 1,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      "Unit",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    axisNameSize: 16,
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: yInterval,
                      reservedSize: 45,
                      getTitlesWidget: leftTitleWidgets,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                minX: 0,
                maxX: maxLength > 1 ? (maxLength - 1).toDouble() : 1,
                minY: minY,
                maxY: maxY,
                clipData: const FlClipData.all(),
                lineBarsData: [
                  if (preDialysisValue.isNotEmpty)
                    LineChartBarData(
                      spots: List.generate(
                        preDialysisValue.length,
                        (index) =>
                            FlSpot(index.toDouble(), preDialysisValue[index]),
                      ),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                  if (postDialysisValue.isNotEmpty)
                    LineChartBarData(
                      spots: List.generate(
                        postDialysisValue.length,
                        (index) =>
                            FlSpot(index.toDouble(), postDialysisValue[index]),
                      ),
                      isCurved: true,
                      color: AppColor.red,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index < 0 || index >= dates.length) return Container();
    final DateFormat formatter = DateFormat('dd/MM');
    final String formattedDate = formatter.format(dates[index]);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: Transform.rotate(
        angle: -0.5,
        child: Text(
          formattedDate,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: Text(
        value.toStringAsFixed(0),
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
    );
  }
}
