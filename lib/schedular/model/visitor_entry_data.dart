class VisitorEntryData {
  String? abhaNo;
  List<String>? previousScheme;
  List<dynamic>? pendingData;
  int? sessionCount;
  List<dynamic>? packageMasterData;

  VisitorEntryData({
    this.abhaNo,
    this.previousScheme,
    this.pendingData,
    this.sessionCount,
    this.packageMasterData,
  });

  factory VisitorEntryData.fromJson(Map<String, dynamic> json) {
    return VisitorEntryData(
      abhaNo: json['abhaNo'],
      previousScheme: (json['previousScheme'] as List?)
          ?.where((e) => e != null)
          .map((e) => e.toString())
          .toList() ?? [],
      pendingData: json['pendingData'] != null
          ? List<dynamic>.from(json['pendingData'])
          : [],
      sessionCount: json['sessionCount'],
      packageMasterData: json['packageMasterData'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abhaNo': abhaNo,
      'previousScheme': previousScheme,
      'pendingData': pendingData,
      'sessionCount': sessionCount,
      'packageMasterData': packageMasterData,
    };
  }
}
