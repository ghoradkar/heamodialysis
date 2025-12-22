class DischargePatientDetails {
  DischargePatientDetails({
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
      this.lookupDetIdPatientType, 
      this.mjpjyCardNo, 
      this.mjpjyApprovedNo, 
      this.abhaNo, 
      this.relativeMobileNo, 
      this.legacyUHIDNumber, 
      this.nephrologistName, 
      this.referenceName, 
      this.referenceDoctorName, 
      this.lookupDetIdRefByRef, 
      this.refByName, 
      this.lookupDetIdDialysisFrequencyInWeek, 
      this.nephrologistContactNo, 
      this.referredContactNumber, 
      this.mjpjayenrollmentNo, 
      this.previoushospitalName, 
      this.hospitalsessionDate, 
      this.divisionId, 
      this.perDivisionId, 
      this.firstTimeDialysisFlag, 
      this.sstartSessionDate, 
      this.patientQrCode, 
      this.abhaAddress, 
      this.mjpjaycaseNumber, 
      this.mjpjayclaimNumber, 
      this.mjpjayIPNumber, 
      this.filePath, 
      this.preAuthapdate, 
      this.lookupDetIdSchemeAdopt, 
      this.lastLookupDetIdSchemeAdopt, 
      this.deviceFrom, 
      this.listReg,});

  DischargePatientDetails.fromJson(dynamic json) {
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
    lookupDetIdPatientType = json['lookupDetIdPatientType'];
    mjpjyCardNo = json['mjpjyCardNo'];
    mjpjyApprovedNo = json['mjpjyApprovedNo'];
    abhaNo = json['abhaNo'];
    relativeMobileNo = json['relativeMobileNo'];
    legacyUHIDNumber = json['legacyUHIDNumber'];
    nephrologistName = json['nephrologistName'];
    referenceName = json['referenceName'];
    referenceDoctorName = json['referenceDoctorName'];
    lookupDetIdRefByRef = json['lookupDetIdRefByRef'];
    refByName = json['refByName'];
    lookupDetIdDialysisFrequencyInWeek = json['lookupDetIdDialysisFrequencyInWeek'];
    nephrologistContactNo = json['nephrologistContactNo'];
    referredContactNumber = json['referredContactNumber'];
    mjpjayenrollmentNo = json['mjpjayenrollmentNo'];
    previoushospitalName = json['previoushospitalName'];
    hospitalsessionDate = json['hospitalsessionDate'];
    divisionId = json['divisionId'];
    perDivisionId = json['perDivisionId'];
    firstTimeDialysisFlag = json['firstTimeDialysisFlag'];
    sstartSessionDate = json['sstartSessionDate'];
    patientQrCode = json['patientQrCode'];
    abhaAddress = json['abhaAddress'];
    mjpjaycaseNumber = json['mjpjaycaseNumber'];
    mjpjayclaimNumber = json['mjpjayclaimNumber'];
    mjpjayIPNumber = json['mjpjayIPNumber'];
    filePath = json['filePath'];
    preAuthapdate = json['preAuthapdate'];
    lookupDetIdSchemeAdopt = json['lookupDetIdSchemeAdopt'];
    lastLookupDetIdSchemeAdopt = json['lastLookupDetIdSchemeAdopt'];
    deviceFrom = json['deviceFrom'];
    if (json['listReg'] != null) {
      listReg = [];
      json['listReg'].forEach((v) {
        listReg?.add(ListReg.fromJson(v));
      });
    }
  }
  int? patientId;
  String? centerPatientId;
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
  int? stateId;
  int? countryId;
  int? areaCode;
  int? unitId;
  String? deleted;
  String? organDonarFlag;
  dynamic createdBy;
  dynamic createdDateTime;
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
  String? visa;
  int? relationId;
  String? relativeName;
  dynamic perAddress;
  int? pertalukaId;
  int? pertownId;
  int? perdistrictId;
  int? perstateId;
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
  String? identificationNumber;
  int? annualIncomeId;
  String? occupation;
  String? education;
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
  dynamic nephrologistName;
  dynamic referenceName;
  dynamic referenceDoctorName;
  dynamic lookupDetIdRefByRef;
  dynamic refByName;
  dynamic lookupDetIdDialysisFrequencyInWeek;
  dynamic nephrologistContactNo;
  dynamic referredContactNumber;
  dynamic mjpjayenrollmentNo;
  dynamic previoushospitalName;
  dynamic hospitalsessionDate;
  dynamic divisionId;
  dynamic perDivisionId;
  dynamic firstTimeDialysisFlag;
  dynamic sstartSessionDate;
  dynamic patientQrCode;
  dynamic abhaAddress;
  dynamic mjpjaycaseNumber;
  dynamic mjpjayclaimNumber;
  dynamic mjpjayIPNumber;
  dynamic filePath;
  dynamic preAuthapdate;
  dynamic lookupDetIdSchemeAdopt;
  dynamic lastLookupDetIdSchemeAdopt;
  dynamic deviceFrom;
  List<ListReg>? listReg;

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
    map['lookupDetIdPatientType'] = lookupDetIdPatientType;
    map['mjpjyCardNo'] = mjpjyCardNo;
    map['mjpjyApprovedNo'] = mjpjyApprovedNo;
    map['abhaNo'] = abhaNo;
    map['relativeMobileNo'] = relativeMobileNo;
    map['legacyUHIDNumber'] = legacyUHIDNumber;
    map['nephrologistName'] = nephrologistName;
    map['referenceName'] = referenceName;
    map['referenceDoctorName'] = referenceDoctorName;
    map['lookupDetIdRefByRef'] = lookupDetIdRefByRef;
    map['refByName'] = refByName;
    map['lookupDetIdDialysisFrequencyInWeek'] = lookupDetIdDialysisFrequencyInWeek;
    map['nephrologistContactNo'] = nephrologistContactNo;
    map['referredContactNumber'] = referredContactNumber;
    map['mjpjayenrollmentNo'] = mjpjayenrollmentNo;
    map['previoushospitalName'] = previoushospitalName;
    map['hospitalsessionDate'] = hospitalsessionDate;
    map['divisionId'] = divisionId;
    map['perDivisionId'] = perDivisionId;
    map['firstTimeDialysisFlag'] = firstTimeDialysisFlag;
    map['sstartSessionDate'] = sstartSessionDate;
    map['patientQrCode'] = patientQrCode;
    map['abhaAddress'] = abhaAddress;
    map['mjpjaycaseNumber'] = mjpjaycaseNumber;
    map['mjpjayclaimNumber'] = mjpjayclaimNumber;
    map['mjpjayIPNumber'] = mjpjayIPNumber;
    map['filePath'] = filePath;
    map['preAuthapdate'] = preAuthapdate;
    map['lookupDetIdSchemeAdopt'] = lookupDetIdSchemeAdopt;
    map['lastLookupDetIdSchemeAdopt'] = lastLookupDetIdSchemeAdopt;
    map['deviceFrom'] = deviceFrom;
    if (listReg != null) {
      map['listReg'] = listReg?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ListReg {
  ListReg({
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
      this.lookupDetIdPatientType, 
      this.mjpjyCardNo, 
      this.mjpjyApprovedNo, 
      this.abhaNo, 
      this.relativeMobileNo, 
      this.legacyUHIDNumber, 
      this.nephrologistName, 
      this.referenceName, 
      this.referenceDoctorName, 
      this.lookupDetIdRefByRef, 
      this.refByName, 
      this.lookupDetIdDialysisFrequencyInWeek, 
      this.nephrologistContactNo, 
      this.referredContactNumber, 
      this.mjpjayenrollmentNo, 
      this.previoushospitalName, 
      this.hospitalsessionDate, 
      this.divisionId, 
      this.perDivisionId, 
      this.firstTimeDialysisFlag, 
      this.sstartSessionDate, 
      this.patientQrCode, 
      this.abhaAddress, 
      this.mjpjaycaseNumber, 
      this.mjpjayclaimNumber, 
      this.mjpjayIPNumber, 
      this.filePath, 
      this.preAuthapdate, 
      this.lookupDetIdSchemeAdopt, 
      this.lastLookupDetIdSchemeAdopt, 
      this.deviceFrom, 
      this.listReg,});

  ListReg.fromJson(dynamic json) {
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
    lookupDetIdPatientType = json['lookupDetIdPatientType'];
    mjpjyCardNo = json['mjpjyCardNo'];
    mjpjyApprovedNo = json['mjpjyApprovedNo'];
    abhaNo = json['abhaNo'];
    relativeMobileNo = json['relativeMobileNo'];
    legacyUHIDNumber = json['legacyUHIDNumber'];
    nephrologistName = json['nephrologistName'];
    referenceName = json['referenceName'];
    referenceDoctorName = json['referenceDoctorName'];
    lookupDetIdRefByRef = json['lookupDetIdRefByRef'];
    refByName = json['refByName'];
    lookupDetIdDialysisFrequencyInWeek = json['lookupDetIdDialysisFrequencyInWeek'];
    nephrologistContactNo = json['nephrologistContactNo'];
    referredContactNumber = json['referredContactNumber'];
    mjpjayenrollmentNo = json['mjpjayenrollmentNo'];
    previoushospitalName = json['previoushospitalName'];
    hospitalsessionDate = json['hospitalsessionDate'];
    divisionId = json['divisionId'];
    perDivisionId = json['perDivisionId'];
    firstTimeDialysisFlag = json['firstTimeDialysisFlag'];
    sstartSessionDate = json['sstartSessionDate'];
    patientQrCode = json['patientQrCode'];
    abhaAddress = json['abhaAddress'];
    mjpjaycaseNumber = json['mjpjaycaseNumber'];
    mjpjayclaimNumber = json['mjpjayclaimNumber'];
    mjpjayIPNumber = json['mjpjayIPNumber'];
    filePath = json['filePath'];
    preAuthapdate = json['preAuthapdate'];
    lookupDetIdSchemeAdopt = json['lookupDetIdSchemeAdopt'];
    lastLookupDetIdSchemeAdopt = json['lastLookupDetIdSchemeAdopt'];
    deviceFrom = json['deviceFrom'];
    listReg = json['listReg'];
  }
  int? patientId;
  String? centerPatientId;
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
  String? updatedDateTime;
  dynamic deletedBy;
  dynamic deletedDateTime;
  String? mrnno;
  int? unitCount;
  dynamic transSMS;
  String? transEmail;
  dynamic pramoEmail;
  dynamic pramoSMS;
  String? external;
  String? emergency;
  dynamic adharcardNo;
  String? address;
  dynamic imageName;
  dynamic aadharImageName;
  String? blockFlag;
  String? blockNarration1;
  String? blockNarration2;
  String? blockNarration3;
  dynamic blockUserName1;
  dynamic blockUserName2;
  dynamic blockUserName3;
  int? blockUserId1;
  int? blockUserId2;
  int? blockUserId3;
  dynamic passport;
  dynamic visa;
  int? relationId;
  String? relativeName;
  String? perAddress;
  int? pertalukaId;
  int? pertownId;
  int? perdistrictId;
  int? perstateId;
  int? percountryId;
  int? perareaCode;
  dynamic oldPatientId;
  String? emailId;
  int? maritalStatusId;
  int? nationalityId;
  int? religionId;
  int? languageId;
  int? bloodGroupId;
  int? identityProofId;
  String? identificationNumber;
  int? annualIncomeId;
  dynamic occupation;
  dynamic education;
  dynamic ivfTreatFlag;
  dynamic healthId;
  dynamic healthIdNumber;
  double? pweight;
  double? pheight;
  dynamic bplFlag;
  int? lookupDetIdDialysisMode;
  int? lookupDetIdHaemodialysisProcedureType;
  int? lookupDetIdPatientType;
  dynamic mjpjyCardNo;
  dynamic mjpjyApprovedNo;
  String? abhaNo;
  String? relativeMobileNo;
  dynamic legacyUHIDNumber;
  String? nephrologistName;
  dynamic referenceName;
  dynamic referenceDoctorName;
  int? lookupDetIdRefByRef;
  String? refByName;
  int? lookupDetIdDialysisFrequencyInWeek;
  String? nephrologistContactNo;
  String? referredContactNumber;
  String? mjpjayenrollmentNo;
  String? previoushospitalName;
  dynamic hospitalsessionDate;
  int? divisionId;
  int? perDivisionId;
  dynamic firstTimeDialysisFlag;
  dynamic sstartSessionDate;
  dynamic patientQrCode;
  dynamic abhaAddress;
  dynamic mjpjaycaseNumber;
  dynamic mjpjayclaimNumber;
  dynamic mjpjayIPNumber;
  dynamic filePath;
  dynamic preAuthapdate;
  dynamic lookupDetIdSchemeAdopt;
  dynamic lastLookupDetIdSchemeAdopt;
  String? deviceFrom;
  dynamic listReg;

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
    map['lookupDetIdPatientType'] = lookupDetIdPatientType;
    map['mjpjyCardNo'] = mjpjyCardNo;
    map['mjpjyApprovedNo'] = mjpjyApprovedNo;
    map['abhaNo'] = abhaNo;
    map['relativeMobileNo'] = relativeMobileNo;
    map['legacyUHIDNumber'] = legacyUHIDNumber;
    map['nephrologistName'] = nephrologistName;
    map['referenceName'] = referenceName;
    map['referenceDoctorName'] = referenceDoctorName;
    map['lookupDetIdRefByRef'] = lookupDetIdRefByRef;
    map['refByName'] = refByName;
    map['lookupDetIdDialysisFrequencyInWeek'] = lookupDetIdDialysisFrequencyInWeek;
    map['nephrologistContactNo'] = nephrologistContactNo;
    map['referredContactNumber'] = referredContactNumber;
    map['mjpjayenrollmentNo'] = mjpjayenrollmentNo;
    map['previoushospitalName'] = previoushospitalName;
    map['hospitalsessionDate'] = hospitalsessionDate;
    map['divisionId'] = divisionId;
    map['perDivisionId'] = perDivisionId;
    map['firstTimeDialysisFlag'] = firstTimeDialysisFlag;
    map['sstartSessionDate'] = sstartSessionDate;
    map['patientQrCode'] = patientQrCode;
    map['abhaAddress'] = abhaAddress;
    map['mjpjaycaseNumber'] = mjpjaycaseNumber;
    map['mjpjayclaimNumber'] = mjpjayclaimNumber;
    map['mjpjayIPNumber'] = mjpjayIPNumber;
    map['filePath'] = filePath;
    map['preAuthapdate'] = preAuthapdate;
    map['lookupDetIdSchemeAdopt'] = lookupDetIdSchemeAdopt;
    map['lastLookupDetIdSchemeAdopt'] = lastLookupDetIdSchemeAdopt;
    map['deviceFrom'] = deviceFrom;
    map['listReg'] = listReg;
    return map;
  }

}