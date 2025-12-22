class TotalDialysisPatientModel {
  TotalDialysisPatientModel({
      this.patientId, 
      this.fName, 
      this.lName, 
      this.mobileNo, 
      this.abhNo, 
      this.unitName, 
      this.schemeName, 
      this.treatmentId,
      this.procedreType,});

  TotalDialysisPatientModel.fromJson(dynamic json) {
    patientId = json['patientId'];
    fName = json['fName'];
    lName = json['lName'];
    mobileNo = json['mobileNo'];
    abhNo = json['abhNo'];
    unitName = json['unitName'];
    schemeName = json['schemeName'];
    treatmentId = json['treatmentId'];
    procedreType = json['procedreType'];
  }
  int? patientId;
  String? fName;
  String? lName;
  String? mobileNo;
  String? abhNo;
  String? unitName;
  String? schemeName;
  int? treatmentId;
  String? procedreType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['fName'] = fName;
    map['lName'] = lName;
    map['mobileNo'] = mobileNo;
    map['abhNo'] = abhNo;
    map['unitName'] = unitName;
    map['schemeName'] = schemeName;
    map['treatmentId'] = treatmentId;
    map['procedreType'] = procedreType;
    return map;
  }

}