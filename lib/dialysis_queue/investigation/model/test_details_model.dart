class TestDetailsModel {
  int? labInvestigationPackageId;
  dynamic unitId;
  String? packageName;
  dynamic lookupFreqTest;
  dynamic fromdate;
  dynamic toDate;
  dynamic status;
  dynamic createdBy;
  dynamic createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  int? subServId;
  dynamic frequencyTestDesc;
  int? labInvestigationPackageDetId;
  String? testName;
  int? serivceId;

  // 🔹 Newly added fields from JSON
  int? investigationQueueId;
  int? patientId;
  int? treatmentId;
  String? patName;
  dynamic age;
  String? gender;
  String? mobile;
  String? expectedSampleDispatchDate;
  String? expectedSampleDispatchTime;
  String? actualSampleDispatchDate;
  String? actualSampleDispatchTime;
  String? remarks;
  int? testId;
  String? barcodeNo;
  String? sampleCollectedBytechDate;
  String? sampleCollectedBytechTime;
  String? testStatus;
  int? packageId;
  String? distCode;
  String? fTypeIni;
  String? cptCode;
  String? macId;
  String? ipAddress;
  String? deviceFrom;

  TestDetailsModel({
    this.labInvestigationPackageId,
    this.unitId,
    this.packageName,
    this.lookupFreqTest,
    this.fromdate,
    this.toDate,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.subServId,
    this.frequencyTestDesc,
    this.labInvestigationPackageDetId,
    this.testName,
    this.serivceId,
    this.investigationQueueId,
    this.patientId,
    this.treatmentId,
    this.patName,
    this.age,
    this.gender,
    this.mobile,
    this.expectedSampleDispatchDate,
    this.expectedSampleDispatchTime,
    this.actualSampleDispatchDate,
    this.actualSampleDispatchTime,
    this.remarks,
    this.testId,
    this.barcodeNo,
    this.sampleCollectedBytechDate,
    this.sampleCollectedBytechTime,
    this.testStatus,
    this.packageId,
    this.distCode,
    this.fTypeIni,
    this.cptCode,
    this.macId,
    this.ipAddress,
    this.deviceFrom,
  });

  TestDetailsModel.fromJson(Map<String, dynamic> json) {
    labInvestigationPackageId = json['labInvestigationPackageId'];
    unitId = json['unitId'];
    packageName = json['packageName'];
    lookupFreqTest = json['lookupFreqTest'];
    fromdate = json['fromdate'];
    toDate = json['toDate'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    subServId = json['subServId'];
    frequencyTestDesc = json['frequencyTestDesc'];
    labInvestigationPackageDetId = json['labInvestigationPackageDetId'];
    testName = json['testName'];
    serivceId = json['serivceId'];

    investigationQueueId = json['investigationQueueId'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    patName = json['patName'];
    age = json['age'];
    gender = json['gender'];
    mobile = json['mobile'];
    expectedSampleDispatchDate = json['expectedSampleDispatchDate'];
    expectedSampleDispatchTime = json['expectedSampleDispatchTime'];
    actualSampleDispatchDate = json['actualSampleDispatchDate'];
    actualSampleDispatchTime = json['actualSampleDispatchTime'];
    remarks = json['remarks'];
    testId = json['testId'];
    barcodeNo = json['barcodeNo'];
    sampleCollectedBytechDate = json['sampleCollectedBytechDate'];
    sampleCollectedBytechTime = json['sampleCollectedBytechTime'];
    testStatus = json['testStatus'];
    packageId = json['packageId'];
    distCode = json['distCode'];
    fTypeIni = json['fTypeIni'];
    cptCode = json['cptCode'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['labInvestigationPackageId'] = labInvestigationPackageId;
    map['unitId'] = unitId;
    map['packageName'] = packageName;
    map['lookupFreqTest'] = lookupFreqTest;
    map['fromdate'] = fromdate;
    map['toDate'] = toDate;
    map['status'] = status;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['subServId'] = subServId;
    map['frequencyTestDesc'] = frequencyTestDesc;
    map['labInvestigationPackageDetId'] = labInvestigationPackageDetId;
    map['testName'] = testName;
    map['serivceId'] = serivceId;

    map['investigationQueueId'] = investigationQueueId;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['patName'] = patName;
    map['age'] = age;
    map['gender'] = gender;
    map['mobile'] = mobile;
    map['expectedSampleDispatchDate'] = expectedSampleDispatchDate;
    map['expectedSampleDispatchTime'] = expectedSampleDispatchTime;
    map['actualSampleDispatchDate'] = actualSampleDispatchDate;
    map['actualSampleDispatchTime'] = actualSampleDispatchTime;
    map['remarks'] = remarks;
    map['testId'] = testId;
    map['barcodeNo'] = barcodeNo;
    map['sampleCollectedBytechDate'] = sampleCollectedBytechDate;
    map['sampleCollectedBytechTime'] = sampleCollectedBytechTime;
    map['testStatus'] = testStatus;
    map['packageId'] = packageId;
    map['distCode'] = distCode;
    map['fTypeIni'] = fTypeIni;
    map['cptCode'] = cptCode;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    return map;
  }
}
