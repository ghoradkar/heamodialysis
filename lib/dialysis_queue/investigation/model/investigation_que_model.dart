class InvestigationQueModel {
  int? investigationQueueId;
  int? patientId;
  int? treatmentId;
  String? patName;
  String? testName;
  int? age;
  String? gender;
  String? mobile;
  String? packageName;
  String? barcodeNo;

  /// NEW (may be absent in some responses)
  String? sampleCollectedBytechDate;
  String? sampleCollectedBytechTime;

  String? testStatus;
  int? packageId;

  InvestigationQueModel({
    this.investigationQueueId,
    this.patientId,
    this.treatmentId,
    this.patName,
    this.testName,
    this.age,
    this.gender,
    this.mobile,
    this.packageName,
    this.barcodeNo,
    this.sampleCollectedBytechDate,
    this.sampleCollectedBytechTime,
    this.testStatus,
    this.packageId,
  });

  factory InvestigationQueModel.fromJson(Map<String, dynamic> json) {
    return InvestigationQueModel(
      investigationQueueId: _asInt(json['investigationQueueId']),
      patientId: _asInt(json['patientId']),
      treatmentId: _asInt(json['treatmentId']),
      patName: json['patName']?.toString(),
      testName: json['testName']?.toString(),
      age: _asInt(json['age']),
      gender: json['gender']?.toString(),
      mobile: json['mobile']?.toString(),
      packageName: json['packageName']?.toString(),
      barcodeNo: json['barcodeNo']?.toString(),
      sampleCollectedBytechDate: json['sampleCollectedBytechDate']?.toString(),
      sampleCollectedBytechTime: json['sampleCollectedBytechTime']?.toString(),
      testStatus: json['testStatus']?.toString(),
      packageId: _asInt(json['packageId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'investigationQueueId': investigationQueueId,
      'patientId': patientId,
      'treatmentId': treatmentId,
      'patName': patName,
      'testName': testName,
      'age': age,
      'gender': gender,
      'mobile': mobile,
      'packageName': packageName,
      'barcodeNo': barcodeNo,
      'sampleCollectedBytechDate': sampleCollectedBytechDate,
      'sampleCollectedBytechTime': sampleCollectedBytechTime,
      'testStatus': testStatus,
      'packageId': packageId,
    };
  }

  static int? _asInt(dynamic v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v);
    return null;
  }
}
