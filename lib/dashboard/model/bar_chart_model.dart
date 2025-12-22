class BarChartModel {
  BarChartModel({
    this.patientId,
    this.fName,
    this.lName,
    this.mobileNo,
    this.abhNo,
    this.schemeId,
    this.unitName,
    this.viralLoadStatus,
    this.schemeName,
    this.unitId,
    this.dischargeCount,
    this.abhaRegCount,
  });

  BarChartModel.fromJson(dynamic json) {
    patientId = json['patientId'];
    fName = json['fName'];
    lName = json['lName'];
    mobileNo = json['mobileNo'];
    abhNo = json['abhNo'];
    schemeId = json['schemeId'];
    unitName = json['unitName'];
    viralLoadStatus = json['viralLoadStatus'];
    schemeName = json['schemeName'];
    unitId = json['unitId'];
    dischargeCount = json['dischargeCount'];
    abhaRegCount = json['abhaRegCount'];
  }

  dynamic patientId;
  dynamic fName;
  dynamic lName;
  dynamic mobileNo;
  dynamic abhNo;
  dynamic schemeId;
  String? unitName;
  String? viralLoadStatus;
  String? schemeName;
  int? unitId;
  int? dischargeCount;
  dynamic abhaRegCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['fName'] = fName;
    map['lName'] = lName;
    map['mobileNo'] = mobileNo;
    map['abhNo'] = abhNo;
    map['schemeId'] = schemeId;
    map['unitName'] = unitName;
    map['viralLoadStatus'] = viralLoadStatus;
    map['schemeName'] = schemeName;
    map['unitId'] = unitId;
    map['dischargeCount'] = dischargeCount;
    map['abhaRegCount'] = abhaRegCount;
    return map;
  }
}
