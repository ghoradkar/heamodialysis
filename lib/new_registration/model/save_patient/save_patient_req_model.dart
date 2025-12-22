class SavePatientReqModel {
  SavePatientReqModel({
      this.patientRelativeContactnoId,
      this.centerPatientId,
      this.hospitalsessionDate,
      this.sstartSessionDate,
      this.patientId,
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
      this.divisionId, 
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
      this.perDivisionId, 
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
      this.annualIncomeId, 
      this.occupation, 
      this.education, 
      this.economicStatus,
      this.religion,
      this.ivfTreatFlag,
      this.healthId, 
      this.healthIdNumber, 
      this.pweight, 
      this.pheight, 
      this.bplFlag, 
      this.lookupDetIdDialysisMode, 
      this.lookupDetIdHaemodialysisProcedureType, 
      this.lookupDetIdPatientType, 
      this.mjpjyCardNo, 
      this.mjpjyApprovedNo, 
      this.abhaNo, 
      this.relativeMobileNo, 
      this.legacyUHIDNumber, 
      this.departmentId, 
      this.nephrologistName, 
      this.referenceName, 
      this.referenceDoctorName, 
      this.patientStatus, 
      this.identificationNumber, 
      this.treatmentId, 
      this.dialysisSupportType, 
      this.procedureType, 
      this.count, 
      this.dialysisDate, 
      this.referredBy, 
      this.mJPJAYEnrollmentNo, 
      this.indentificationNumber, 
      this.referedContactNumber, 
      this.dialysisFrequencyInWeek, 
      this.nephrologistContactNo, 
      this.lookupDetIdRefByRef, 
      this.refByName, 
      this.mjpjayenrollmentNo, 
      this.referredContactNumber, 
      this.lookupDetIdDialysisFrequencyInWeek, 
      this.nephrologistContactNumber, 
      this.referenceByName,
      this.lookUpDetRelationId,
      this.previoushospitalName,
      this.firstTimeDialysisFlag,
      this.serviceCode,
      this.monthlyIncome,


  });

  SavePatientReqModel.fromJson(dynamic json) {
    patientRelativeContactnoId = json['patientRelativeContactnoId'];
    centerPatientId = json['centerPatientId'];
    hospitalsessionDate = json['hospitalsessionDate'];
    sstartSessionDate = json['sstartSessionDate'];
    patientId = json['patientId'];
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
    divisionId = json['divisionId'];
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
    perDivisionId = json['perDivisionId'];
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
    annualIncomeId = json['annualIncomeId'];
    occupation = json['occupation'];
    education = json['education'];
    economicStatus = json['economicStatus'];
    religion = json['religion'];
    ivfTreatFlag = json['ivfTreatFlag'];
    healthId = json['healthId'];
    healthIdNumber = json['healthIdNumber'];
    pweight = json['pweight'];
    pheight = json['pheight'];
    bplFlag = json['bplFlag'];
    lookupDetIdDialysisMode = json['lookupDetIdDialysisMode'];
    lookupDetIdHaemodialysisProcedureType = json['lookupDetIdHaemodialysisProcedureType'];
    lookupDetIdPatientType = json['lookupDetIdPatientType'];
    mjpjyCardNo = json['mjpjyCardNo'];
    mjpjyApprovedNo = json['mjpjyApprovedNo'];
    abhaNo = json['abhaNo'];
    relativeMobileNo = json['relativeMobileNo'];
    legacyUHIDNumber = json['legacyUHIDNumber'];
    departmentId = json['departmentId'];
    nephrologistName = json['nephrologistName'];
    referenceName = json['referenceName'];
    referenceDoctorName = json['referenceDoctorName'];
    patientStatus = json['patientStatus'];
    identificationNumber = json['identificationNumber'];
    treatmentId = json['treatmentId'];
    dialysisSupportType = json['dialysisSupportType'];
    procedureType = json['procedureType'];
    count = json['count'];
    dialysisDate = json['dialysisDate'];
    referredBy = json['referredBy'];
    mJPJAYEnrollmentNo = json['mJPJAYEnrollmentNo'];
    indentificationNumber = json['indentificationNumber'];
    referedContactNumber = json['referedContactNumber'];
    dialysisFrequencyInWeek = json['dialysisFrequencyInWeek'];
    nephrologistContactNo = json['nephrologistContactNo'];
    lookupDetIdRefByRef = json['lookupDetIdRefByRef'];
    refByName = json['refByName'];
    mjpjayenrollmentNo = json['mjpjayenrollmentNo'];
    referredContactNumber = json['referredContactNumber'];
    lookupDetIdDialysisFrequencyInWeek = json['lookupDetIdDialysisFrequencyInWeek'];
    nephrologistContactNumber = json['nephrologistContactNumber'];
    referenceByName = json['referenceByName'];
    lookUpDetRelationId = json['lookUpDetRelationId'];
    sstartSessionDate = json['sstartSessionDate'];
    previoushospitalName = json['previoushospitalName'];
    firstTimeDialysisFlag = json['firstTimeDialysisFlag'];
    sstartSessionDate = json['sstartSessionDate'];
    serviceCode = json['serviceCode'];
    monthlyIncome = json['monthlyIncome'];
  }
  int? patientRelativeContactnoId;
  String? centerPatientId;
  dynamic hospitalsessionDate;
  dynamic sstartSessionDate;
  String? patientId;
  String? prefix;
  String? fName;
  String? mName;
  String? lName;
  String? mobile;
  String? gender;
  String? dob;
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
  String? deleted;
  String? organDonarFlag;
  int? createdBy;
  String? createdDateTime;
  dynamic blockedDateTime;
  dynamic updatedBy;
  dynamic updatedDateTime;
  dynamic deletedBy;
  dynamic deletedDateTime;
  String? mrnno;
  int? unitCount;
  String? transSMS;
  String? transEmail;
  String? pramoEmail;
  String? pramoSMS;
  String? external;
  String? emergency;
  String? adharcardNo;
  String? address;
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
  String? passport;
  dynamic visa;
  int? relationId;
  String? relativeName;
  String? perAddress;
  int? pertalukaId;
  int? pertownId;
  int? perdistrictId;
  int? perstateId;
  int? perDivisionId;
  int? percountryId;
  int? perareaCode;
  String? oldPatientId;
  String? emailId;
  int? maritalStatusId;
  int? nationalityId;
  int? religionId;
  int? languageId;
  int? bloodGroupId;
  int? identityProofId;
  int? annualIncomeId;
  String? occupation;
  String? education;
  String? economicStatus;
  String? religion;
  String? ivfTreatFlag;
  String? healthId;
  String? healthIdNumber;
  double? pweight;
  double? pheight;
  String? bplFlag;
  int? lookupDetIdDialysisMode;
  int? lookupDetIdHaemodialysisProcedureType;
  int? lookupDetIdPatientType;
  String? mjpjyCardNo;
  String? mjpjyApprovedNo;
  String? abhaNo;
  String? relativeMobileNo;
  String? legacyUHIDNumber;
  int? departmentId;
  String? nephrologistName;
  String? referenceName;
  String? referenceDoctorName;
  int? patientStatus;
  String? identificationNumber;
  int? treatmentId;
  String? dialysisSupportType;
  String? procedureType;
  int? count;
  String? dialysisDate;
  String? referredBy;
  String? mJPJAYEnrollmentNo;
  String? indentificationNumber;
  String? referedContactNumber;
  int? dialysisFrequencyInWeek;
  String? nephrologistContactNo;
  int? lookupDetIdRefByRef;
  String? refByName;
  String? mjpjayenrollmentNo;
  String? referredContactNumber;
  int? lookupDetIdDialysisFrequencyInWeek;
  String? nephrologistContactNumber;
  String? referenceByName;
  int? lookUpDetRelationId;
  String? previoushospitalName;
  String? firstTimeDialysisFlag;
  String? serviceCode;
  int? monthlyIncome;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientRelativeContactnoId'] = patientRelativeContactnoId;
    map['centerPatientId'] = centerPatientId;
    map['hospitalsessionDate'] = hospitalsessionDate;
    map['sstartSessionDate'] = sstartSessionDate;
    map['patientId'] = patientId;
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
    map['divisionId'] = divisionId;
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
    map['perDivisionId'] = perDivisionId;
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
    map['annualIncomeId'] = annualIncomeId;
    map['occupation'] = occupation;
    map['education'] = education;
    map['economicStatus'] = economicStatus;
    map['religion'] = religion;
    map['ivfTreatFlag'] = ivfTreatFlag;
    map['healthId'] = healthId;
    map['healthIdNumber'] = healthIdNumber;
    map['pweight'] = pweight;
    map['pheight'] = pheight;
    map['bplFlag'] = bplFlag;
    map['lookupDetIdDialysisMode'] = lookupDetIdDialysisMode;
    map['lookupDetIdHaemodialysisProcedureType'] = lookupDetIdHaemodialysisProcedureType;
    map['lookupDetIdPatientType'] = lookupDetIdPatientType;
    map['mjpjyCardNo'] = mjpjyCardNo;
    map['mjpjyApprovedNo'] = mjpjyApprovedNo;
    map['abhaNo'] = abhaNo;
    map['relativeMobileNo'] = relativeMobileNo;
    map['legacyUHIDNumber'] = legacyUHIDNumber;
    map['departmentId'] = departmentId;
    map['nephrologistName'] = nephrologistName;
    map['referenceName'] = referenceName;
    map['referenceDoctorName'] = referenceDoctorName;
    map['patientStatus'] = patientStatus;
    map['identificationNumber'] = identificationNumber;
    map['treatmentId'] = treatmentId;
    map['dialysisSupportType'] = dialysisSupportType;
    map['procedureType'] = procedureType;
    map['count'] = count;
    map['dialysisDate'] = dialysisDate;
    map['referredBy'] = referredBy;
    map['mJPJAYEnrollmentNo'] = mJPJAYEnrollmentNo;
    map['indentificationNumber'] = indentificationNumber;
    map['referedContactNumber'] = referedContactNumber;
    map['dialysisFrequencyInWeek'] = dialysisFrequencyInWeek;
    map['nephrologistContactNo'] = nephrologistContactNo;
    map['lookupDetIdRefByRef'] = lookupDetIdRefByRef;
    map['refByName'] = refByName;
    map['mjpjayenrollmentNo'] = mjpjayenrollmentNo;
    map['referredContactNumber'] = referredContactNumber;
    map['lookupDetIdDialysisFrequencyInWeek'] = lookupDetIdDialysisFrequencyInWeek;
    map['nephrologistContactNumber'] = nephrologistContactNumber;
    map['referenceByName'] = referenceByName;
    map['lookUpDetRelationId'] = lookUpDetRelationId;
    map['sstartSessionDate'] = sstartSessionDate;
    map['previoushospitalName'] = previoushospitalName;
    map['firstTimeDialysisFlag'] = firstTimeDialysisFlag;
    map['serviceCode'] = serviceCode;
    map['monthlyIncome'] = monthlyIncome;
    return map;
  }

}