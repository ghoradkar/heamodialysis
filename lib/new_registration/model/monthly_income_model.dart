class PatientDetailsResponse {
  String centerPatientId;
  int age;
  int ageMonths;
  int ageDays;
  int talukaId;
  int townId;
  int districtId;
  int divisionId;
  int stateId;
  int countryId;
  int areaCode;
  int unitId;
  int userId;
  String deleted;
  String organDonarFlag;
  String imageName;
  String aadharImageName;
  String blockFlag;
  String blockNarration1;
  String blockNarration2;
  String blockNarration3;
  String blockUserName1;
  String blockUserName2;
  String blockUserName3;
  int blockUserId1;
  int blockUserId2;
  int blockUserId3;
  int relationId;
  int pertalukaId;
  int pertownId;
  int perdistrictId;
  int perstateId;
  int perDivisionId;
  int percountryId;
  int perareaCode;
  String oldPatientId;
  int maritalStatusId;
  int nationalityId;
  int religionId;
  int languageId;
  int bloodGroupId;
  int identityProofId;
  int annualIncomeId;
  String occupation;
  String education;
  String ivfTreatFlag;
  String healthId;
  String healthIdNumber;
  String legacyUHIDNumber;
  int departmentId;
  int patientStatus;
  int treatmentId;
  int count;

  List<MonthlyIncome> monthlyIncomeList;

  PatientDetailsResponse({
    required this.centerPatientId,
    required this.age,
    required this.ageMonths,
    required this.ageDays,
    required this.talukaId,
    required this.townId,
    required this.districtId,
    required this.divisionId,
    required this.stateId,
    required this.countryId,
    required this.areaCode,
    required this.unitId,
    required this.userId,
    required this.deleted,
    required this.organDonarFlag,
    required this.imageName,
    required this.aadharImageName,
    required this.blockFlag,
    required this.blockNarration1,
    required this.blockNarration2,
    required this.blockNarration3,
    required this.blockUserName1,
    required this.blockUserName2,
    required this.blockUserName3,
    required this.blockUserId1,
    required this.blockUserId2,
    required this.blockUserId3,
    required this.relationId,
    required this.pertalukaId,
    required this.pertownId,
    required this.perdistrictId,
    required this.perstateId,
    required this.perDivisionId,
    required this.percountryId,
    required this.perareaCode,
    required this.oldPatientId,
    required this.maritalStatusId,
    required this.nationalityId,
    required this.religionId,
    required this.languageId,
    required this.bloodGroupId,
    required this.identityProofId,
    required this.annualIncomeId,
    required this.occupation,
    required this.education,
    required this.ivfTreatFlag,
    required this.healthId,
    required this.healthIdNumber,
    required this.legacyUHIDNumber,
    required this.departmentId,
    required this.patientStatus,
    required this.treatmentId,
    required this.count,
    required this.monthlyIncomeList,
  });

  factory PatientDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PatientDetailsResponse(
      centerPatientId: json['centerPatientId'],
      age: json['age'],
      ageMonths: json['ageMonths'],
      ageDays: json['ageDays'],
      talukaId: json['talukaId'],
      townId: json['townId'],
      districtId: json['districtId'],
      divisionId: json['divisionId'],
      stateId: json['stateId'],
      countryId: json['countryId'],
      areaCode: json['areaCode'],
      unitId: json['unitId'],
      userId: json['userId'],
      deleted: json['deleted'],
      organDonarFlag: json['organDonarFlag'],
      imageName: json['imageName'],
      aadharImageName: json['aadharImageName'],
      blockFlag: json['blockFlag'],
      blockNarration1: json['blockNarration1'],
      blockNarration2: json['blockNarration2'],
      blockNarration3: json['blockNarration3'],
      blockUserName1: json['blockUserName1'],
      blockUserName2: json['blockUserName2'],
      blockUserName3: json['blockUserName3'],
      blockUserId1: json['blockUserId1'],
      blockUserId2: json['blockUserId2'],
      blockUserId3: json['blockUserId3'],
      relationId: json['relationId'],
      pertalukaId: json['pertalukaId'],
      pertownId: json['pertownId'],
      perdistrictId: json['perdistrictId'],
      perstateId: json['perstateId'],
      perDivisionId: json['perDivisionId'],
      percountryId: json['percountryId'],
      perareaCode: json['perareaCode'],
      oldPatientId: json['oldPatientId'],
      maritalStatusId: json['maritalStatusId'],
      nationalityId: json['nationalityId'],
      religionId: json['religionId'],
      languageId: json['languageId'],
      bloodGroupId: json['bloodGroupId'],
      identityProofId: json['identityProofId'],
      annualIncomeId: json['annualIncomeId'],
      occupation: json['occupation'],
      education: json['education'],
      ivfTreatFlag: json['ivfTreatFlag'],
      healthId: json['healthId'],
      healthIdNumber: json['healthIdNumber'],
      legacyUHIDNumber: json['legacyUHIDNumber'],
      departmentId: json['departmentId'],
      patientStatus: json['patientStatus'],
      treatmentId: json['treatmentId'],
      count: json['count'],
      monthlyIncomeList: (json['monthlyIncomeList'] as List)
          .map((e) => MonthlyIncome.fromJson(e))
          .toList(),
    );
  }
}

class MonthlyIncome {
  String? lookupDetParentName;
  int? lookupId;
  String? lookupDescEn;
  String? lookupValue;

  MonthlyIncome({
    this.lookupDetParentName,
    this.lookupId,
    this.lookupDescEn,
    this.lookupValue,
  });

  factory MonthlyIncome.fromJson(Map<String, dynamic> json) {
    return MonthlyIncome(
      lookupDetParentName: json['lookupDetParentName'] ?? '',
      lookupId: json['lookupId'] ?? 0,
      lookupDescEn: json['lookupDescEn'] ?? '',
      lookupValue: json['lookupValue'] ?? '',
    );
  }
}
