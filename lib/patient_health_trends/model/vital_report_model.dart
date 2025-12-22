
class VitalReportModel {
  final Map<String, Map<String, dynamic>> data;
  final List<String> dates;

  VitalReportModel({required this.data, required this.dates});

  factory VitalReportModel.fromJson(Map<String, dynamic> json) {
    final rawData = <String, Map<String, dynamic>>{};
    if (json['data'] is Map) {
      (json['data'] as Map<String, dynamic>).forEach((metric, val) {
        if (val is Map) {
          rawData[metric] = Map<String, dynamic>.from(val);
        } else {
          rawData[metric] = {};
        }
      });
    }
    final rawDates = <String>[];
    if (json['dates'] is List) {
      rawDates.addAll(List<String>.from(json['dates']));
    }
    return VitalReportModel(data: rawData, dates: rawDates);
  }
}
