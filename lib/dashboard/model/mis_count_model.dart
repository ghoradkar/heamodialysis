class MisCountModel {
  MisCountModel({
      this.unitName, 
      this.functionalUnit, 
      this.totalPatient, 
      this.mjpjayCount, 
      this.nonmjpjayCount, 
      this.positivePatient, 
      this.negativePatient, 
      this.testSendToLab, 
      this.instituteStartDate,});

  MisCountModel.fromJson(dynamic json) {
    unitName = json['unitName'];
    functionalUnit = json['functionalUnit'];
    totalPatient = json['totalPatient'];
    mjpjayCount = json['mjpjayCount'];
    nonmjpjayCount = json['nonmjpjayCount'];
    positivePatient = json['positivePatient'];
    negativePatient = json['negativePatient'];
    testSendToLab = json['testSendToLab'];
    instituteStartDate = json['instituteStartDate'];
  }
  dynamic unitName;
  int? functionalUnit;
  int? totalPatient;
  int? mjpjayCount;
  int? nonmjpjayCount;
  int? positivePatient;
  int? negativePatient;
  int? testSendToLab;
  dynamic instituteStartDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitName'] = unitName;
    map['functionalUnit'] = functionalUnit;
    map['totalPatient'] = totalPatient;
    map['mjpjayCount'] = mjpjayCount;
    map['nonmjpjayCount'] = nonmjpjayCount;
    map['positivePatient'] = positivePatient;
    map['negativePatient'] = negativePatient;
    map['testSendToLab'] = testSendToLab;
    map['instituteStartDate'] = instituteStartDate;
    return map;
  }

}