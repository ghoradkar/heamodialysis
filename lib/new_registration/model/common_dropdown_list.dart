class CommomDropdownList {
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
  List<LookupItem> occupationList;
  List<LookupItem> educationList;
  List<LookupItem> religionList;

  CommomDropdownList({
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
    required this.occupationList,
    required this.educationList,
    required this.religionList,
  });

  factory CommomDropdownList.fromJson(Map<String, dynamic> json) => CommomDropdownList(
    centerPatientId: json['centerPatientId'] ?? "-",
    age: json['age'] ?? 0,
    ageMonths: json['ageMonths'] ?? 0,
    ageDays: json['ageDays'] ?? 0,
    talukaId: json['talukaId'] ?? 0,
    townId: json['townId'] ?? 0,
    districtId: json['districtId'] ?? 0,
    divisionId: json['divisionId'] ?? 0,
    stateId: json['stateId'] ?? 0,
    countryId: json['countryId'] ?? 0,
    areaCode: json['areaCode'] ?? 0,
    unitId: json['unitId'] ?? 0,
    userId: json['userId'] ?? 0,
    deleted: json['deleted'] ?? "N",
    organDonarFlag: json['organDonarFlag'] ?? "N",
    imageName: json['imageName'] ?? "",
    aadharImageName: json['aadharImageName'] ?? "",
    blockFlag: json['blockFlag'] ?? "N",
    blockNarration1: json['blockNarration1'] ?? "-",
    blockNarration2: json['blockNarration2'] ?? "-",
    blockNarration3: json['blockNarration3'] ?? "-",
    blockUserName1: json['blockUserName1'] ?? "-",
    blockUserName2: json['blockUserName2'] ?? "-",
    blockUserName3: json['blockUserName3'] ?? "-",
    blockUserId1: json['blockUserId1'] ?? 0,
    blockUserId2: json['blockUserId2'] ?? 0,
    blockUserId3: json['blockUserId3'] ?? 0,
    relationId: json['relationId'] ?? 0,
    pertalukaId: json['pertalukaId'] ?? 0,
    pertownId: json['pertownId'] ?? 0,
    perdistrictId: json['perdistrictId'] ?? 0,
    perstateId: json['perstateId'] ?? 0,
    perDivisionId: json['perDivisionId'] ?? 0,
    percountryId: json['percountryId'] ?? 0,
    perareaCode: json['perareaCode'] ?? 0,
    oldPatientId: json['oldPatientId'] ?? "0",
    maritalStatusId: json['maritalStatusId'] ?? 0,
    nationalityId: json['nationalityId'] ?? 0,
    religionId: json['religionId'] ?? 0,
    languageId: json['languageId'] ?? 0,
    bloodGroupId: json['bloodGroupId'] ?? 0,
    identityProofId: json['identityProofId'] ?? 0,
    annualIncomeId: json['annualIncomeId'] ?? 0,
    occupation: json['occupation'] ?? "-",
    education: json['education'] ?? "-",
    ivfTreatFlag: json['ivfTreatFlag'] ?? "N",
    healthId: json['healthId'] ?? "0",
    healthIdNumber: json['healthIdNumber'] ?? "0",
    legacyUHIDNumber: json['legacyUHIDNumber'] ?? "0",
    departmentId: json['departmentId'] ?? 0,
    patientStatus: json['patientStatus'] ?? 0,
    treatmentId: json['treatmentId'] ?? 0,
    count: json['count'] ?? 0,
    occupationList: (json['occupationList'] as List)
        .map((e) => LookupItem.fromJson(e))
        .toList(),
    educationList: (json['educationList'] as List)
        .map((e) => LookupItem.fromJson(e))
        .toList(),
    religionList: (json['religionList'] as List)
        .map((e) => LookupItem.fromJson(e))
        .toList(),
  );
}

class LookupItem {
  final int? lookupDetId;
  final String? lookupDetValue;
  final String? lookupDetDescEn;
  final String? lookupDetParentName;

  LookupItem({
     this.lookupDetId,
     this.lookupDetValue,
     this.lookupDetDescEn,
     this.lookupDetParentName,
  });

  factory LookupItem.fromJson(Map<String, dynamic> json) => LookupItem(
    lookupDetId: json['lookupDetId'] ?? 0,
    lookupDetValue: json['lookupDetValue'] ?? "",
    lookupDetDescEn: json['lookupDetDescEn'] ?? "",
    lookupDetParentName: json['lookupDetParentName'] ?? "",
  );
}
