class SaveBarcodeModel {
  int? investigationQueueId;
  int? patientId;
  int? treatmentId;
  String? testName;
  String? patName;
  int? age;
  String? gender;
  String? mobile;
  String? expectedSampleDispatchDate;
  String? expectedSampleDispatchTime;
  String? actualSampleDispatchDate;
  String? actualSampleDispatchTime;
  String? status;
  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
  String? macId;
  String? ipAddress;
  String? deviceFrom;
  String? remarks;
  String? packageName;
  int? testId;
  String? barcodeNo;
  String? sampleCollectedBytechDate;
  String? testStatus;
  int? packageId;
  String? sampleCollectedBytechTime;
  String? distCode;
  String? fTypeIni;
  String? cptCode;

  SaveBarcodeModel({
    this.investigationQueueId,
    this.patientId,
    this.treatmentId,
    this.testName,
    this.patName,
    this.age,
    this.gender,
    this.mobile,
    this.expectedSampleDispatchDate,
    this.expectedSampleDispatchTime,
    this.actualSampleDispatchDate,
    this.actualSampleDispatchTime,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.macId,
    this.ipAddress,
    this.deviceFrom,
    this.remarks,
    this.packageName,
    this.testId,
    this.barcodeNo,
    this.sampleCollectedBytechDate,
    this.testStatus,
    this.packageId,
    this.sampleCollectedBytechTime,
    this.distCode,
    this.fTypeIni,
    this.cptCode,
  });

  factory SaveBarcodeModel.fromJson(Map<String, dynamic> json) {
    return SaveBarcodeModel(
      investigationQueueId: json['investigationQueueId'],
      patientId: json['patientId'],
      treatmentId: json['treatmentId'],
      testName: json['testName'],
      patName: json['patName'],
      age: json['age'],
      gender: json['gender'],
      mobile: json['mobile'],
      expectedSampleDispatchDate: json['expectedSampleDispatchDate'],
      expectedSampleDispatchTime: json['expectedSampleDispatchTime'],
      actualSampleDispatchDate: json['actualSampleDispatchDate'],
      actualSampleDispatchTime: json['actualSampleDispatchTime'],
      status: json['status'],
      createdBy: json['createdBy'],
      createdDate: json['createdDate'],
      updatedBy: json['updatedBy'],
      updatedDate: json['updatedDate'],
      macId: json['macId'],
      ipAddress: json['ipAddress'],
      deviceFrom: json['deviceFrom'],
      remarks: json['remarks'],
      packageName: json['packageName'],
      testId: json['testId'],
      barcodeNo: json['barcodeNo'],
      sampleCollectedBytechDate: json['sampleCollectedBytechDate'],
      testStatus: json['testStatus'],
      packageId: json['packageId'],
      sampleCollectedBytechTime: json['sampleCollectedBytechTime'],
      distCode: json['distCode'],
      fTypeIni: json['fTypeIni'],
      cptCode: json['cptCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'investigationQueueId': investigationQueueId,
      'patientId': patientId,
      'treatmentId': treatmentId,
      'testName': testName,
      'patName': patName,
      'age': age,
      'gender': gender,
      'mobile': mobile,
      'expectedSampleDispatchDate': expectedSampleDispatchDate,
      'expectedSampleDispatchTime': expectedSampleDispatchTime,
      'actualSampleDispatchDate': actualSampleDispatchDate,
      'actualSampleDispatchTime': actualSampleDispatchTime,
      'status': status,
      'createdBy': createdBy,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
      'updatedDate': updatedDate,
      'macId': macId,
      'ipAddress': ipAddress,
      'deviceFrom': deviceFrom,
      'remarks': remarks,
      'packageName': packageName,
      'testId': testId,
      'barcodeNo': barcodeNo,
      'sampleCollectedBytechDate': sampleCollectedBytechDate,
      'testStatus': testStatus,
      'packageId': packageId,
      'sampleCollectedBytechTime': sampleCollectedBytechTime,
      'distCode': distCode,
      'fTypeIni': fTypeIni,
      'cptCode': cptCode,
    };
  }
}
