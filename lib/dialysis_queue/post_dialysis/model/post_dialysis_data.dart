class PostDialysisData {
  PostDialysisData({
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
      this.divisionId, 
      this.stateId, 
      this.countryId, 
      this.areaCode, 
      this.unitId, 
      this.userId, 
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
      this.bloodGroup, 
      this.identityProofId, 
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
      this.treatmentId, 
      this.dialysisSupportType, 
      this.procedureType, 
      this.count, 
      this.dialysisDate, 
      this.referredBy, 
      this.identificationNumber, 
      this.referedContactNumber, 
      this.dialysisFrequencyInWeek, 
      this.nephrologistContactNo, 
      this.lookupDetIdRefByRef, 
      this.refByName, 
      this.mjpjayenrollmentNo, 
      this.referredContactNumber, 
      this.lookupDetIdDialysisFrequencyInWeek, 
      this.referenceByName, 
      this.indentificationNumber, 
      this.hsessionDate, 
      this.previoushospitalName, 
      this.unitname, 
      this.startSessionDate, 
      this.firstTimeDialysisFlag, 
      this.dischargeDate, 
      this.townList, 
      this.stateList, 
      this.devisionList, 
      this.districtList, 
      this.talukaList, 
      this.maritalStatusList, 
      this.idProofList, 
      this.relationList, 
      this.dialysisModeList, 
      this.haemodialysisProcedureTypeList, 
      this.ptientTypeList, 
      this.patientStatusList, 
      this.referredByList, 
      this.documentChecklistList, 
      this.dobDate, 
      this.patientTreatmentBean, 
      this.patientBillMasterBean, 
      this.imgFile, 
      this.historFile, 
      this.files, 
      this.documentChecklistId, 
      this.patientImage, 
      this.previousHospitalDocument, 
      this.mjpjayPatDoc, 
      this.basicData, 
      this.hhhTest, 
      this.bloodTest, 
      this.vassAccess, 
      this.highRiskC, 
      this.lookUpDetRelationId, 
      this.parentPatientId, 
      this.relationMappingId, 
      this.abhaAddress,});

  PostDialysisData.fromJson(dynamic json) {
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
    divisionId = json['divisionId'];
    stateId = json['stateId'];
    countryId = json['countryId'];
    areaCode = json['areaCode'];
    unitId = json['unitId'];
    userId = json['userId'];
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
    bloodGroup = json['bloodGroup'];
    identityProofId = json['identityProofId'];
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
    treatmentId = json['treatmentId'];
    dialysisSupportType = json['dialysisSupportType'];
    procedureType = json['procedureType'];
    count = json['count'];
    dialysisDate = json['dialysisDate'];
    referredBy = json['referredBy'];
    identificationNumber = json['identificationNumber'];
    referedContactNumber = json['referedContactNumber'];
    dialysisFrequencyInWeek = json['dialysisFrequencyInWeek'];
    nephrologistContactNo = json['nephrologistContactNo'];
    lookupDetIdRefByRef = json['lookupDetIdRefByRef'];
    refByName = json['refByName'];
    mjpjayenrollmentNo = json['mjpjayenrollmentNo'];
    referredContactNumber = json['referredContactNumber'];
    lookupDetIdDialysisFrequencyInWeek = json['lookupDetIdDialysisFrequencyInWeek'];
    referenceByName = json['referenceByName'];
    indentificationNumber = json['indentificationNumber'];
    hsessionDate = json['hsessionDate'];
    previoushospitalName = json['previoushospitalName'];
    unitname = json['unitname'];
    startSessionDate = json['startSessionDate'];
    firstTimeDialysisFlag = json['firstTimeDialysisFlag'];
    dischargeDate = json['dischargeDate'];
    townList = json['townList'];
    stateList = json['stateList'];
    devisionList = json['devisionList'];
    districtList = json['districtList'];
    talukaList = json['talukaList'];
    maritalStatusList = json['maritalStatusList'];
    idProofList = json['idProofList'];
    relationList = json['relationList'];
    dialysisModeList = json['dialysisModeList'];
    haemodialysisProcedureTypeList = json['haemodialysisProcedureTypeList'];
    ptientTypeList = json['ptientTypeList'];
    patientStatusList = json['patientStatusList'];
    referredByList = json['referredByList'];
    documentChecklistList = json['documentChecklistList'];
    dobDate = json['dobDate'];
    patientTreatmentBean = json['patientTreatmentBean'];
    patientBillMasterBean = json['patientBillMasterBean'];
    imgFile = json['imgFile'];
    historFile = json['historFile'];
    files = json['files'];
    documentChecklistId = json['documentChecklistId'];
    patientImage = json['patientImage'];
    previousHospitalDocument = json['previousHospitalDocument'];
    mjpjayPatDoc = json['mjpjayPatDoc'];
    basicData = json['basicData'];
    hhhTest = json['hhhTest'];
    bloodTest = json['bloodTest'];
    vassAccess = json['vassAccess'];
    highRiskC = json['highRiskC'];
    lookUpDetRelationId = json['lookUpDetRelationId'];
    parentPatientId = json['parentPatientId'];
    relationMappingId = json['relationMappingId'];
    abhaAddress = json['abhaAddress'];
  }
  int? patientId;
  String? centerPatientId;
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
  int? divisionId;
  int? stateId;
  int? countryId;
  int? areaCode;
  int? unitId;
  int? userId;
  String? deleted;
  String? organDonarFlag;
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
  dynamic passport;
  dynamic visa;
  int? relationId;
  dynamic relativeName;
  dynamic perAddress;
  int? pertalukaId;
  int? pertownId;
  int? perdistrictId;
  int? perstateId;
  int? perDivisionId;
  int? percountryId;
  int? perareaCode;
  String? oldPatientId;
  dynamic emailId;
  int? maritalStatusId;
  int? nationalityId;
  int? religionId;
  int? languageId;
  int? bloodGroupId;
  dynamic bloodGroup;
  int? identityProofId;
  int? annualIncomeId;
  String? occupation;
  String? education;
  String? ivfTreatFlag;
  String? healthId;
  String? healthIdNumber;
  dynamic pweight;
  dynamic pheight;
  dynamic bplFlag;
  dynamic lookupDetIdDialysisMode;
  dynamic lookupDetIdHaemodialysisProcedureType;
  dynamic lookupDetIdPatientType;
  dynamic mjpjyCardNo;
  dynamic mjpjyApprovedNo;
  dynamic abhaNo;
  dynamic relativeMobileNo;
  String? legacyUHIDNumber;
  int? departmentId;
  dynamic nephrologistName;
  dynamic referenceName;
  dynamic referenceDoctorName;
  int? patientStatus;
  int? treatmentId;
  String? dialysisSupportType;
  String? procedureType;
  int? count;
  String? dialysisDate;
  dynamic referredBy;
  dynamic identificationNumber;
  dynamic referedContactNumber;
  dynamic dialysisFrequencyInWeek;
  dynamic nephrologistContactNo;
  dynamic lookupDetIdRefByRef;
  dynamic refByName;
  dynamic mjpjayenrollmentNo;
  dynamic referredContactNumber;
  dynamic lookupDetIdDialysisFrequencyInWeek;
  dynamic referenceByName;
  dynamic indentificationNumber;
  dynamic hsessionDate;
  dynamic previoushospitalName;
  dynamic unitname;
  dynamic startSessionDate;
  dynamic firstTimeDialysisFlag;
  dynamic dischargeDate;
  dynamic townList;
  dynamic stateList;
  dynamic devisionList;
  dynamic districtList;
  dynamic talukaList;
  dynamic maritalStatusList;
  dynamic idProofList;
  dynamic relationList;
  dynamic dialysisModeList;
  dynamic haemodialysisProcedureTypeList;
  dynamic ptientTypeList;
  dynamic patientStatusList;
  dynamic referredByList;
  dynamic documentChecklistList;
  dynamic dobDate;
  dynamic patientTreatmentBean;
  dynamic patientBillMasterBean;
  dynamic imgFile;
  dynamic historFile;
  dynamic files;
  dynamic documentChecklistId;
  dynamic patientImage;
  dynamic previousHospitalDocument;
  dynamic mjpjayPatDoc;
  dynamic basicData;
  dynamic hhhTest;
  dynamic bloodTest;
  dynamic vassAccess;
  dynamic highRiskC;
  int? lookUpDetRelationId;
  int? parentPatientId;
  int? relationMappingId;
  dynamic abhaAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['divisionId'] = divisionId;
    map['stateId'] = stateId;
    map['countryId'] = countryId;
    map['areaCode'] = areaCode;
    map['unitId'] = unitId;
    map['userId'] = userId;
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
    map['bloodGroup'] = bloodGroup;
    map['identityProofId'] = identityProofId;
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
    map['treatmentId'] = treatmentId;
    map['dialysisSupportType'] = dialysisSupportType;
    map['procedureType'] = procedureType;
    map['count'] = count;
    map['dialysisDate'] = dialysisDate;
    map['referredBy'] = referredBy;
    map['identificationNumber'] = identificationNumber;
    map['referedContactNumber'] = referedContactNumber;
    map['dialysisFrequencyInWeek'] = dialysisFrequencyInWeek;
    map['nephrologistContactNo'] = nephrologistContactNo;
    map['lookupDetIdRefByRef'] = lookupDetIdRefByRef;
    map['refByName'] = refByName;
    map['mjpjayenrollmentNo'] = mjpjayenrollmentNo;
    map['referredContactNumber'] = referredContactNumber;
    map['lookupDetIdDialysisFrequencyInWeek'] = lookupDetIdDialysisFrequencyInWeek;
    map['referenceByName'] = referenceByName;
    map['indentificationNumber'] = indentificationNumber;
    map['hsessionDate'] = hsessionDate;
    map['previoushospitalName'] = previoushospitalName;
    map['unitname'] = unitname;
    map['startSessionDate'] = startSessionDate;
    map['firstTimeDialysisFlag'] = firstTimeDialysisFlag;
    map['dischargeDate'] = dischargeDate;
    map['townList'] = townList;
    map['stateList'] = stateList;
    map['devisionList'] = devisionList;
    map['districtList'] = districtList;
    map['talukaList'] = talukaList;
    map['maritalStatusList'] = maritalStatusList;
    map['idProofList'] = idProofList;
    map['relationList'] = relationList;
    map['dialysisModeList'] = dialysisModeList;
    map['haemodialysisProcedureTypeList'] = haemodialysisProcedureTypeList;
    map['ptientTypeList'] = ptientTypeList;
    map['patientStatusList'] = patientStatusList;
    map['referredByList'] = referredByList;
    map['documentChecklistList'] = documentChecklistList;
    map['dobDate'] = dobDate;
    map['patientTreatmentBean'] = patientTreatmentBean;
    map['patientBillMasterBean'] = patientBillMasterBean;
    map['imgFile'] = imgFile;
    map['historFile'] = historFile;
    map['files'] = files;
    map['documentChecklistId'] = documentChecklistId;
    map['patientImage'] = patientImage;
    map['previousHospitalDocument'] = previousHospitalDocument;
    map['mjpjayPatDoc'] = mjpjayPatDoc;
    map['basicData'] = basicData;
    map['hhhTest'] = hhhTest;
    map['bloodTest'] = bloodTest;
    map['vassAccess'] = vassAccess;
    map['highRiskC'] = highRiskC;
    map['lookUpDetRelationId'] = lookUpDetRelationId;
    map['parentPatientId'] = parentPatientId;
    map['relationMappingId'] = relationMappingId;
    map['abhaAddress'] = abhaAddress;
    return map;
  }

}