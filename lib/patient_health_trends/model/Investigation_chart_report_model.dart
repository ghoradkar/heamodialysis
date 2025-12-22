class InvestigationChartReportModel {
  // Map of parameter name -> Map of date -> value
  // Example: {"Serum Blood Urea": {"2025-05-03": "84.8", "2025-05-07": "15.5"}}
  final Map<String, Map<String, String>> data;

  // List of all unique dates in chronological order
  final List<String> dates;

  InvestigationChartReportModel({
    required this.data,
    required this.dates,
  });

  factory InvestigationChartReportModel.fromJson(List<dynamic> jsonList) {
    Map<String, Map<String, String>> groupedData = {};
    Set<String> allDates = {};

    // Group data by parameter
    for (var item in jsonList) {
      String parameter = item['parameter'] ?? 'Unknown';
      String date = item['post_treatment_date'] ?? '';
      String result = item['result'] ?? '';

      if (date.isEmpty) continue;

      allDates.add(date);

      if (!groupedData.containsKey(parameter)) {
        groupedData[parameter] = {};
      }

      groupedData[parameter]![date] = result;
    }

    // Sort dates chronologically
    List<String> sortedDates = allDates.toList();
    sortedDates.sort((a, b) {
      try {
        DateTime dateA = DateTime.parse(a);
        DateTime dateB = DateTime.parse(b);
        return dateA.compareTo(dateB);
      } catch (e) {
        return a.compareTo(b);
      }
    });

    return InvestigationChartReportModel(
      data: groupedData,
      dates: sortedDates,
    );
  }
}