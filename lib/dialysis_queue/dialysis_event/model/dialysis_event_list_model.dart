class DialysisEventListModel {
  DialysisEventListModel({
      this.patientId, 
      this.centerPatientId, 
      this.fName, 
      this.mobile, 
      this.gender, 
      this.age, 
      this.ageMonths, 
      this.ageDays, 
      this.talukaId, 
      this.townId, 
      this.districtId, 
      this.divisionId, 
      this.stateId, 
      this.countryId, 
      this.areaCode, 
      this.unitId, 
      this.userId, 
      this.deleted, 
      this.organDonarFlag, 
      this.imageName, 
      this.aadharImageName, 
      this.blockFlag, 
      this.blockNarration1, 
      this.blockNarration2, 
      this.blockNarration3, 
      this.blockUserName1, 
      this.blockUserName2, 
      this.blockUserName3, 
      this.blockUserId1, 
      this.blockUserId2, 
      this.blockUserId3, 
      this.relationId, 
      this.pertalukaId, 
      this.pertownId, 
      this.perdistrictId, 
      this.perstateId, 
      this.perDivisionId, 
      this.percountryId, 
      this.perareaCode, 
      this.oldPatientId, 
      this.maritalStatusId, 
      this.nationalityId, 
      this.religionId, 
      this.languageId, 
      this.bloodGroupId, 
      this.identityProofId, 
      this.annualIncomeId, 
      this.occupation, 
      this.education, 
      this.ivfTreatFlag, 
      this.healthId, 
      this.healthIdNumber, 
      this.legacyUHIDNumber, 
      this.departmentId, 
      this.patientStatus, 
      this.treatmentId, 
      this.dialysisSupportType, 
      this.procedureType, 
      this.count, 
      this.dialysisDate,});

  DialysisEventListModel.fromJson(dynamic json) {
    patientId = json['patientId'];
    centerPatientId = json['centerPatientId'];
    fName = json['fName'];
    mobile = json['mobile'];
    gender = json['gender'];
    age = json['age'];
    ageMonths = json['ageMonths'];
    ageDays = json['ageDays'];
    talukaId = json['talukaId'];
    townId = json['townId'];
    districtId = json['districtId'];
    divisionId = json['divisionId'];
    stateId = json['stateId'];
    countryId = json['countryId'];
    areaCode = json['areaCode'];
    unitId = json['unitId'];
    userId = json['userId'];
    deleted = json['deleted'];
    organDonarFlag = json['organDonarFlag'];
    imageName = json['imageName'];
    aadharImageName = json['aadharImageName'];
    blockFlag = json['blockFlag'];
    blockNarration1 = json['blockNarration1'];
    blockNarration2 = json['blockNarration2'];
    blockNarration3 = json['blockNarration3'];
    blockUserName1 = json['blockUserName1'];
    blockUserName2 = json['blockUserName2'];
    blockUserName3 = json['blockUserName3'];
    blockUserId1 = json['blockUserId1'];
    blockUserId2 = json['blockUserId2'];
    blockUserId3 = json['blockUserId3'];
    relationId = json['relationId'];
    pertalukaId = json['pertalukaId'];
    pertownId = json['pertownId'];
    perdistrictId = json['perdistrictId'];
    perstateId = json['perstateId'];
    perDivisionId = json['perDivisionId'];
    percountryId = json['percountryId'];
    perareaCode = json['perareaCode'];
    oldPatientId = json['oldPatientId'];
    maritalStatusId = json['maritalStatusId'];
    nationalityId = json['nationalityId'];
    religionId = json['religionId'];
    languageId = json['languageId'];
    bloodGroupId = json['bloodGroupId'];
    identityProofId = json['identityProofId'];
    annualIncomeId = json['annualIncomeId'];
    occupation = json['occupation'];
    education = json['education'];
    ivfTreatFlag = json['ivfTreatFlag'];
    healthId = json['healthId'];
    healthIdNumber = json['healthIdNumber'];
    legacyUHIDNumber = json['legacyUHIDNumber'];
    departmentId = json['departmentId'];
    patientStatus = json['patientStatus'];
    treatmentId = json['treatmentId'];
    dialysisSupportType = json['dialysisSupportType'];
    procedureType = json['procedureType'];
    count = json['count'];
    dialysisDate = json['dialysisDate'];
  }
  int? patientId;
  String? centerPatientId;
  String? fName;
  String? mobile;
  String? gender;
  int? age;
  int? ageMonths;
  int? ageDays;
  int? talukaId;
  int? townId;
  int? districtId;
  int? divisionId;
  int? stateId;
  int? countryId;
  int? areaCode;
  int? unitId;
  int? userId;
  String? deleted;
  String? organDonarFlag;
  String? imageName;
  String? aadharImageName;
  String? blockFlag;
  String? blockNarration1;
  String? blockNarration2;
  String? blockNarration3;
  String? blockUserName1;
  String? blockUserName2;
  String? blockUserName3;
  int? blockUserId1;
  int? blockUserId2;
  int? blockUserId3;
  int? relationId;
  int? pertalukaId;
  int? pertownId;
  int? perdistrictId;
  int? perstateId;
  int? perDivisionId;
  int? percountryId;
  int? perareaCode;
  String? oldPatientId;
  int? maritalStatusId;
  int? nationalityId;
  int? religionId;
  int? languageId;
  int? bloodGroupId;
  int? identityProofId;
  int? annualIncomeId;
  String? occupation;
  String? education;
  String? ivfTreatFlag;
  String? healthId;
  String? healthIdNumber;
  String? legacyUHIDNumber;
  int? departmentId;
  int? patientStatus;
  int? treatmentId;
  String? dialysisSupportType;
  String? procedureType;
  int? count;
  String? dialysisDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['centerPatientId'] = centerPatientId;
    map['fName'] = fName;
    map['mobile'] = mobile;
    map['gender'] = gender;
    map['age'] = age;
    map['ageMonths'] = ageMonths;
    map['ageDays'] = ageDays;
    map['talukaId'] = talukaId;
    map['townId'] = townId;
    map['districtId'] = districtId;
    map['divisionId'] = divisionId;
    map['stateId'] = stateId;
    map['countryId'] = countryId;
    map['areaCode'] = areaCode;
    map['unitId'] = unitId;
    map['userId'] = userId;
    map['deleted'] = deleted;
    map['organDonarFlag'] = organDonarFlag;
    map['imageName'] = imageName;
    map['aadharImageName'] = aadharImageName;
    map['blockFlag'] = blockFlag;
    map['blockNarration1'] = blockNarration1;
    map['blockNarration2'] = blockNarration2;
    map['blockNarration3'] = blockNarration3;
    map['blockUserName1'] = blockUserName1;
    map['blockUserName2'] = blockUserName2;
    map['blockUserName3'] = blockUserName3;
    map['blockUserId1'] = blockUserId1;
    map['blockUserId2'] = blockUserId2;
    map['blockUserId3'] = blockUserId3;
    map['relationId'] = relationId;
    map['pertalukaId'] = pertalukaId;
    map['pertownId'] = pertownId;
    map['perdistrictId'] = perdistrictId;
    map['perstateId'] = perstateId;
    map['perDivisionId'] = perDivisionId;
    map['percountryId'] = percountryId;
    map['perareaCode'] = perareaCode;
    map['oldPatientId'] = oldPatientId;
    map['maritalStatusId'] = maritalStatusId;
    map['nationalityId'] = nationalityId;
    map['religionId'] = religionId;
    map['languageId'] = languageId;
    map['bloodGroupId'] = bloodGroupId;
    map['identityProofId'] = identityProofId;
    map['annualIncomeId'] = annualIncomeId;
    map['occupation'] = occupation;
    map['education'] = education;
    map['ivfTreatFlag'] = ivfTreatFlag;
    map['healthId'] = healthId;
    map['healthIdNumber'] = healthIdNumber;
    map['legacyUHIDNumber'] = legacyUHIDNumber;
    map['departmentId'] = departmentId;
    map['patientStatus'] = patientStatus;
    map['treatmentId'] = treatmentId;
    map['dialysisSupportType'] = dialysisSupportType;
    map['procedureType'] = procedureType;
    map['count'] = count;
    map['dialysisDate'] = dialysisDate;
    return map;
  }

}