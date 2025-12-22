class HemoglobinTrackingModel {
  final int? districtId;
  final String? districtName;
  final int? talukaId;
  final int? srNo;
  final int? stateId;
  final String? divisionName;
  final String? talukaName;
  final int? unitId;
  final int? divisionId;
  final String? instituteName;

  HemoglobinTrackingModel({
    this.districtId,
    this.districtName,
    this.talukaId,
    this.srNo,
    this.stateId,
    this.divisionName,
    this.talukaName,
    this.unitId,
    this.divisionId,
    this.instituteName,
  });

  factory HemoglobinTrackingModel.fromJson(Map<String, dynamic> json) {
    return HemoglobinTrackingModel(
      districtId: json['districtId'],
      districtName: json['districtName'],
      talukaId: json['talukaId'],
      srNo: json['srNo'],
      stateId: json['stateId'],
      divisionName: json['divisionName'],
      talukaName: json['talukaName'],
      unitId: json['unitId'],
      divisionId: json['divisionId'],
      instituteName: json['instituteName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'districtId': districtId,
      'districtName': districtName,
      'talukaId': talukaId,
      'srNo': srNo,
      'stateId': stateId,
      'divisionName': divisionName,
      'talukaName': talukaName,
      'unitId': unitId,
      'divisionId': divisionId,
      'instituteName': instituteName,
    };
  }

  static List<HemoglobinTrackingModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => HemoglobinTrackingModel.fromJson(e)).toList();
  }
}
