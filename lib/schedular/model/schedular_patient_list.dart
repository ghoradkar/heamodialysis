

class SchedularPatientList {
  SchedularPatientList({
      this.code, 
      this.status, 
      this.data,});

  SchedularPatientList.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SchedularData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<SchedularData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SchedularData {
  SchedularData({
    this.searchParam,
    this.count,
    this.patientId,
    this.centerPatientId,
    this.prefix,
    this.fName,
    this.mName,
    this.lName,
    this.mobile,
    this.gender,
    this.dob,
    this.age,
    this.ageMonths,
    this.ageDays,
    this.talukaId,
    this.townId,
    this.districtId,
    this.stateId,
    this.countryId,
    this.areaCode,
    this.unitId,
    this.deleted,
    this.organDonarFlag,
    this.createdBy,
    this.createdDateTime,
    this.blockedDateTime,
    this.updatedBy,
    this.updatedDateTime,
    this.deletedBy,
    this.deletedDateTime,
    this.mrnno,
    this.unitCount,
    this.transSMS,
    this.transEmail,
    this.pramoEmail,
    this.pramoSMS,
    this.external,
    this.emergency,
    this.adharcardNo,
    this.address,
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
    this.passport,
    this.visa,
    this.relationId,
    this.relativeName,
    this.perAddress,
    this.pertalukaId,
    this.pertownId,
    this.perdistrictId,
    this.perstateId,
    this.percountryId,
    this.perareaCode,
    this.oldPatientId,
    this.emailId,
    this.maritalStatusId,
    this.nationalityId,
    this.religionId,
    this.languageId,
    this.bloodGroupId,
    this.identityProofId,
    this.identificationNumber,
    this.annualIncomeId,
    this.occupation,
    this.education,
    this.ivfTreatFlag,
    this.healthId,
    this.healthIdNumber,
    this.pweight,
    this.pheight,
    this.bplFlag,
    this.lookupDetIdDialysisMode,
    this.lookupDetIdHaemodialysisProcedureType,
    this.haemodialysisProcedureTypeEn,
    this.lookupDetIdPatientType,
    this.patientTypeEn,
    this.mjpjyCardNo,
    this.mjpjyApprovedNo,
    this.abhaNo,
    this.relativeMobileNo,
    this.patientApId,
    this.treatmentId,
    this.maxTreatmentId,
    this.legacyUHIDNumber,
    this.bedAllocationDate,
    this.slotTime,
    this.slotId,
    this.bedAloDate,
    this.slotBFlag,
    this.patBedAllocationId,});

  SchedularData.fromJson(dynamic json) {
    searchParam = json['searchParam'];
    count = json['count'];
    patientId = json['patientId'];
    centerPatientId = json['centerPatientId'];
    prefix = json['prefix'];
    fName = json['fName'];
    mName = json['mName'];
    lName = json['lName'];
    mobile = json['mobile'];
    gender = json['gender'];
    dob = json['dob'];
    age = json['age'];
    ageMonths = json['ageMonths'];
    ageDays = json['ageDays'];
    talukaId = json['talukaId'];
    townId = json['townId'];
    districtId = json['districtId'];
    stateId = json['stateId'];
    countryId = json['countryId'];
    areaCode = json['areaCode'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    organDonarFlag = json['organDonarFlag'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
    blockedDateTime = json['blockedDateTime'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    deletedDateTime = json['deletedDateTime'];
    mrnno = json['mrnno'];
    unitCount = json['unitCount'];
    transSMS = json['transSMS'];
    transEmail = json['transEmail'];
    pramoEmail = json['pramoEmail'];
    pramoSMS = json['pramoSMS'];
    external = json['external'];
    emergency = json['emergency'];
    adharcardNo = json['adharcardNo'];
    address = json['address'];
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
    passport = json['passport'];
    visa = json['visa'];
    relationId = json['relationId'];
    relativeName = json['relativeName'];
    perAddress = json['perAddress'];
    pertalukaId = json['pertalukaId'];
    pertownId = json['pertownId'];
    perdistrictId = json['perdistrictId'];
    perstateId = json['perstateId'];
    percountryId = json['percountryId'];
    perareaCode = json['perareaCode'];
    oldPatientId = json['oldPatientId'];
    emailId = json['emailId'];
    maritalStatusId = json['maritalStatusId'];
    nationalityId = json['nationalityId'];
    religionId = json['religionId'];
    languageId = json['languageId'];
    bloodGroupId = json['bloodGroupId'];
    identityProofId = json['identityProofId'];
    identificationNumber = json['identificationNumber'];
    annualIncomeId = json['annualIncomeId'];
    occupation = json['occupation'];
    education = json['education'];
    ivfTreatFlag = json['ivfTreatFlag'];
    healthId = json['healthId'];
    healthIdNumber = json['healthIdNumber'];
    pweight = json['pweight'];
    pheight = json['pheight'];
    bplFlag = json['bplFlag'];
    lookupDetIdDialysisMode = json['lookupDetIdDialysisMode'];
    lookupDetIdHaemodialysisProcedureType = json['lookupDetIdHaemodialysisProcedureType'];
    haemodialysisProcedureTypeEn = json['haemodialysisProcedureTypeEn'];
    lookupDetIdPatientType = json['lookupDetIdPatientType'];
    patientTypeEn = json['patientTypeEn'];
    mjpjyCardNo = json['mjpjyCardNo'];
    mjpjyApprovedNo = json['mjpjyApprovedNo'];
    abhaNo = json['abhaNo'];
    relativeMobileNo = json['relativeMobileNo'];
    patientApId = json['patientApId'];
    treatmentId = json['treatmentId'];
    maxTreatmentId = json['maxTreatmentId'];
    legacyUHIDNumber = json['legacyUHIDNumber'];
    bedAllocationDate = json['bedAllocationDate'];
    slotTime = json['slotTime'];
    slotId = json['slotId'];
    bedAloDate = json['bedAloDate'];
    slotBFlag = json['slotBFlag'];
    patBedAllocationId = json['patBedAllocationId'];
  }
  dynamic searchParam;
  int? count;
  int? patientId;
  dynamic centerPatientId;
  dynamic prefix;
  String? fName;
  dynamic mName;
  dynamic lName;
  String? mobile;
  String? gender;
  dynamic dob;
  int? age;
  int? ageMonths;
  int? ageDays;
  int? talukaId;
  int? townId;
  int? districtId;
  int? stateId;
  int? countryId;
  int? areaCode;
  int? unitId;
  dynamic deleted;
  dynamic organDonarFlag;
  dynamic createdBy;
  dynamic createdDateTime;
  dynamic blockedDateTime;
  dynamic updatedBy;
  dynamic updatedDateTime;
  dynamic deletedBy;
  dynamic deletedDateTime;
  dynamic mrnno;
  dynamic unitCount;
  dynamic transSMS;
  dynamic transEmail;
  dynamic pramoEmail;
  dynamic pramoSMS;
  dynamic external;
  dynamic emergency;
  dynamic adharcardNo;
  dynamic address;
  dynamic imageName;
  dynamic aadharImageName;
  dynamic blockFlag;
  dynamic blockNarration1;
  dynamic blockNarration2;
  dynamic blockNarration3;
  dynamic blockUserName1;
  dynamic blockUserName2;
  dynamic blockUserName3;
  int? blockUserId1;
  int? blockUserId2;
  int? blockUserId3;
  dynamic passport;
  dynamic visa;
  int? relationId;
  dynamic relativeName;
  dynamic perAddress;
  int? pertalukaId;
  int? pertownId;
  int? perdistrictId;
  int? perstateId;
  int? percountryId;
  int? perareaCode;
  dynamic oldPatientId;
  dynamic emailId;
  int? maritalStatusId;
  int? nationalityId;
  int? religionId;
  int? languageId;
  int? bloodGroupId;
  int? identityProofId;
  dynamic identificationNumber;
  int? annualIncomeId;
  dynamic occupation;
  dynamic education;
  dynamic ivfTreatFlag;
  String? healthId;
  dynamic healthIdNumber;
  dynamic pweight;
  dynamic pheight;
  dynamic bplFlag;
  dynamic lookupDetIdDialysisMode;
  dynamic lookupDetIdHaemodialysisProcedureType;
  String? haemodialysisProcedureTypeEn;
  dynamic lookupDetIdPatientType;
  String? patientTypeEn;
  dynamic mjpjyCardNo;
  dynamic mjpjyApprovedNo;
  dynamic abhaNo;
  dynamic relativeMobileNo;
  int? patientApId;
  int? treatmentId;
  dynamic maxTreatmentId;
  dynamic legacyUHIDNumber;
  String? bedAllocationDate;
  String? slotTime;
  int? slotId;
  String? bedAloDate;
  String? slotBFlag;
  int? patBedAllocationId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['searchParam'] = searchParam;
    map['count'] = count;
    map['patientId'] = patientId;
    map['centerPatientId'] = centerPatientId;
    map['prefix'] = prefix;
    map['fName'] = fName;
    map['mName'] = mName;
    map['lName'] = lName;
    map['mobile'] = mobile;
    map['gender'] = gender;
    map['dob'] = dob;
    map['age'] = age;
    map['ageMonths'] = ageMonths;
    map['ageDays'] = ageDays;
    map['talukaId'] = talukaId;
    map['townId'] = townId;
    map['districtId'] = districtId;
    map['stateId'] = stateId;
    map['countryId'] = countryId;
    map['areaCode'] = areaCode;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['organDonarFlag'] = organDonarFlag;
    map['createdBy'] = createdBy;
    map['createdDateTime'] = createdDateTime;
    map['blockedDateTime'] = blockedDateTime;
    map['updatedBy'] = updatedBy;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['deletedDateTime'] = deletedDateTime;
    map['mrnno'] = mrnno;
    map['unitCount'] = unitCount;
    map['transSMS'] = transSMS;
    map['transEmail'] = transEmail;
    map['pramoEmail'] = pramoEmail;
    map['pramoSMS'] = pramoSMS;
    map['external'] = external;
    map['emergency'] = emergency;
    map['adharcardNo'] = adharcardNo;
    map['address'] = address;
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
    map['passport'] = passport;
    map['visa'] = visa;
    map['relationId'] = relationId;
    map['relativeName'] = relativeName;
    map['perAddress'] = perAddress;
    map['pertalukaId'] = pertalukaId;
    map['pertownId'] = pertownId;
    map['perdistrictId'] = perdistrictId;
    map['perstateId'] = perstateId;
    map['percountryId'] = percountryId;
    map['perareaCode'] = perareaCode;
    map['oldPatientId'] = oldPatientId;
    map['emailId'] = emailId;
    map['maritalStatusId'] = maritalStatusId;
    map['nationalityId'] = nationalityId;
    map['religionId'] = religionId;
    map['languageId'] = languageId;
    map['bloodGroupId'] = bloodGroupId;
    map['identityProofId'] = identityProofId;
    map['identificationNumber'] = identificationNumber;
    map['annualIncomeId'] = annualIncomeId;
    map['occupation'] = occupation;
    map['education'] = education;
    map['ivfTreatFlag'] = ivfTreatFlag;
    map['healthId'] = healthId;
    map['healthIdNumber'] = healthIdNumber;
    map['pweight'] = pweight;
    map['pheight'] = pheight;
    map['bplFlag'] = bplFlag;
    map['lookupDetIdDialysisMode'] = lookupDetIdDialysisMode;
    map['lookupDetIdHaemodialysisProcedureType'] = lookupDetIdHaemodialysisProcedureType;
    map['haemodialysisProcedureTypeEn'] = haemodialysisProcedureTypeEn;
    map['lookupDetIdPatientType'] = lookupDetIdPatientType;
    map['patientTypeEn'] = patientTypeEn;
    map['mjpjyCardNo'] = mjpjyCardNo;
    map['mjpjyApprovedNo'] = mjpjyApprovedNo;
    map['abhaNo'] = abhaNo;
    map['relativeMobileNo'] = relativeMobileNo;
    map['patientApId'] = patientApId;
    map['treatmentId'] = treatmentId;
    map['maxTreatmentId'] = maxTreatmentId;
    map['legacyUHIDNumber'] = legacyUHIDNumber;
    map['bedAllocationDate'] = bedAllocationDate;
    map['slotTime'] = slotTime;
    map['slotId'] = slotId;
    map['bedAloDate'] = bedAloDate;
    map['slotBFlag'] = slotBFlag;
    map['patBedAllocationId'] = patBedAllocationId;
    return map;
  }

}