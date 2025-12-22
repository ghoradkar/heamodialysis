class ClinicalConditionProvisionaList {
  ClinicalConditionProvisionaList({
      this.id, 
      this.treatObj, 
      this.patientObj, 
      this.date, 
      this.diagndesc, 
      this.diagoName, 
      this.icd10Code, 
      this.diagnoType, 
      this.comment, 
      this.createdDateTime, 
      this.updatedDateTime, 
      this.userId, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy, 
      this.deleted, 
      this.deletedDate, 
      this.unitId, 
      this.dignosisBy, 
      this.patientId, 
      this.treatmentId,});

  ClinicalConditionProvisionaList.fromJson(dynamic json) {
    id = json['id'];
    treatObj = json['treatObj'] != null ? TreatObj.fromJson(json['treatObj']) : null;
    patientObj = json['patientObj'] != null ? PatientObj.fromJson(json['patientObj']) : null;
    date = json['date'];
    diagndesc = json['diagndesc'];
    diagoName = json['diagoName'];
    icd10Code = json['icd10_code'];
    diagnoType = json['diagnoType'];
    comment = json['comment'];
    createdDateTime = json['createdDateTime'];
    updatedDateTime = json['updatedDateTime'];
    userId = json['userId'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deleted_by'];
    deleted = json['deleted'];
    deletedDate = json['deletedDate'];
    unitId = json['unitId'];
    dignosisBy = json['dignosisBy'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
  }
  int? id;
  TreatObj? treatObj;
  PatientObj? patientObj;
  String? date;
  String? diagndesc;
  String? diagoName;
  String? icd10Code;
  String? diagnoType;
  String? comment;
  String? createdDateTime;
  String? updatedDateTime;
  int? userId;
  int? createdBy;
  int? updatedBy;
  int? deletedBy;
  String? deleted;
  dynamic deletedDate;
  int? unitId;
  String? dignosisBy;
  dynamic patientId;
  dynamic treatmentId;
  bool isSelected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (treatObj != null) {
      map['treatObj'] = treatObj?.toJson();
    }
    if (patientObj != null) {
      map['patientObj'] = patientObj?.toJson();
    }
    map['date'] = date;
    map['diagndesc'] = diagndesc;
    map['diagoName'] = diagoName;
    map['icd10_code'] = icd10Code;
    map['diagnoType'] = diagnoType;
    map['comment'] = comment;
    map['createdDateTime'] = createdDateTime;
    map['updatedDateTime'] = updatedDateTime;
    map['userId'] = userId;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deleted_by'] = deletedBy;
    map['deleted'] = deleted;
    map['deletedDate'] = deletedDate;
    map['unitId'] = unitId;
    map['dignosisBy'] = dignosisBy;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    return map;
  }

}

class PatientObj {
  PatientObj({
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
      this.nephrologistContactNo, 
      this.userId, 
      this.abhaAddress, 
      this.patientApId, 
      this.patientName, 
      this.listReg, 
      this.patientList, 
      this.maxTreatmentId, 
      this.organDonationRegistrationDto, 
      this.listTreatment, 
      this.listBill, 
      this.listBillDetails, 
      // this.listPayRes,
      this.listMlcDetails, 
      this.listMultipleSponsor, 
      this.userList, 
      this.admitedDays, 
      this.docName, 
      this.sourceTypeId, 
      this.sponsorName, 
      this.queryType, 
      this.objTreatment, 
      this.patientID, 
      this.treatmentId, 
      this.title, 
      this.bloodGroup, 
      this.sex, 
      this.weight, 
      this.height, 
      this.officeNumber, 
      this.wtType, 
      this.bedNo, 
      this.objtreatmentbeds, 
      this.age1, 
      this.patientidivf, 
      this.patientNameivf, 
      this.patientidivffemale, 
      this.patientNameivffemale, 
      this.tflg, 
      this.departmentId, 
      this.patientWeight, 
      this.mjpjayenrollmentNo, 
      this.indentificationNumber, 
      this.referredContactNumber, 
      this.lookupDetIdDialysisFrequencyInWeek, 
      this.referenceByName, 
      this.previoushospitalName, 
      this.hospitalsessionDate, 
      this.divisionId, 
      this.perDivisionId, 
      this.deviceFrom, 
      this.firstTimeDialysisFlag, 
      this.sstartSessionDate,});

  PatientObj.fromJson(dynamic json) {
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
    nephrologistContactNo = json['nephrologistContactNo'];
    userId = json['userId'];
    abhaAddress = json['abhaAddress'];
    patientApId = json['patientApId'];
    patientName = json['patientName'];
    listReg = json['listReg'];
    patientList = json['patientList'];
    maxTreatmentId = json['maxTreatmentId'];
    organDonationRegistrationDto = json['organDonationRegistrationDto'];
    if (json['listTreatment'] != null) {
      listTreatment = [];
      json['listTreatment'].forEach((v) {
        listTreatment?.add(ListTreatment.fromJson(v));
      });
    }
    if (json['listBill'] != null) {
      listBill = [];
      json['listBill'].forEach((v) {
        listBill?.add(ListBill.fromJson(v));
      });
    }
    listBillDetails = json['listBillDetails'];
    // if (json['listPayRes'] != null) {
    //   listPayRes = [];
    //   json['listPayRes'].forEach((v) {
    //     listPayRes?.add(Dynamic.fromJson(v));
    //   });
    // }
    // if (json['listMlcDetails'] != null) {
    //   listMlcDetails = [];
    //   json['listMlcDetails'].forEach((v) {
    //     listMlcDetails?.add(Dynamic.fromJson(v));
    //   });
    // }
    // if (json['listMultipleSponsor'] != null) {
    //   listMultipleSponsor = [];
    //   json['listMultipleSponsor'].forEach((v) {
    //     listMultipleSponsor?.add(Dynamic.fromJson(v));
    //   });
    // }
    userList = json['userList'];
    admitedDays = json['admitedDays'];
    docName = json['docName'];
    sourceTypeId = json['sourceTypeId'];
    sponsorName = json['sponsorName'];
    queryType = json['queryType'];
    objTreatment = json['objTreatment'] != null ? ObjTreatment.fromJson(json['objTreatment']) : null;
    patientID = json['patient_ID'];
    treatmentId = json['treatment_id'];
    title = json['title'];
    bloodGroup = json['bloodGroup'];
    sex = json['sex'];
    weight = json['weight'];
    height = json['height'];
    officeNumber = json['officeNumber'];
    wtType = json['wtType'];
    bedNo = json['bedNo'];
    objtreatmentbeds = json['objtreatmentbeds'];
    age1 = json['age1'];
    patientidivf = json['patientidivf'];
    patientNameivf = json['patientNameivf'];
    patientidivffemale = json['patientidivffemale'];
    patientNameivffemale = json['patientNameivffemale'];
    tflg = json['tflg'];
    departmentId = json['department_id'];
    patientWeight = json['patient_weight'];
    mjpjayenrollmentNo = json['mjpjayenrollmentNo'];
    indentificationNumber = json['indentificationNumber'];
    referredContactNumber = json['referredContactNumber'];
    lookupDetIdDialysisFrequencyInWeek = json['lookupDetIdDialysisFrequencyInWeek'];
    referenceByName = json['referenceByName'];
    previoushospitalName = json['previoushospitalName'];
    hospitalsessionDate = json['hospitalsessionDate'];
    divisionId = json['divisionId'];
    perDivisionId = json['perDivisionId'];
    deviceFrom = json['deviceFrom'];
    firstTimeDialysisFlag = json['firstTimeDialysisFlag'];
    sstartSessionDate = json['sstartSessionDate'];
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
  dynamic updatedDateTime;
  dynamic deletedBy;
  dynamic deletedDateTime;
  String? mrnno;
  int? unitCount;
  dynamic transSMS;
  dynamic transEmail;
  dynamic pramoEmail;
  dynamic pramoSMS;
  dynamic external;
  dynamic emergency;
  dynamic adharcardNo;
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
  dynamic bplFlag;
  int? lookupDetIdDialysisMode;
  int? lookupDetIdHaemodialysisProcedureType;
  int? lookupDetIdPatientType;
  dynamic mjpjyCardNo;
  dynamic mjpjyApprovedNo;
  String? abhaNo;
  String? relativeMobileNo;
  String? legacyUHIDNumber;
  String? nephrologistName;
  dynamic referenceName;
  String? referenceDoctorName;
  int? lookupDetIdRefByRef;
  String? refByName;
  String? nephrologistContactNo;
  dynamic userId;
  String? abhaAddress;
  int? patientApId;
  dynamic patientName;
  dynamic listReg;
  dynamic patientList;
  dynamic maxTreatmentId;
  dynamic organDonationRegistrationDto;
  List<ListTreatment>? listTreatment;
  List<ListBill>? listBill;
  dynamic listBillDetails;
  // List<dynamic>? listPayRes;
  List<dynamic>? listMlcDetails;
  List<dynamic>? listMultipleSponsor;
  dynamic userList;
  int? admitedDays;
  dynamic docName;
  int? sourceTypeId;
  dynamic sponsorName;
  dynamic queryType;
  ObjTreatment? objTreatment;
  int? patientID;
  int? treatmentId;
  dynamic title;
  dynamic bloodGroup;
  dynamic sex;
  dynamic weight;
  dynamic height;
  dynamic officeNumber;
  dynamic wtType;
  dynamic bedNo;
  dynamic objtreatmentbeds;
  dynamic age1;
  int? patientidivf;
  dynamic patientNameivf;
  int? patientidivffemale;
  dynamic patientNameivffemale;
  dynamic tflg;
  int? departmentId;
  double? patientWeight;
  String? mjpjayenrollmentNo;
  dynamic indentificationNumber;
  String? referredContactNumber;
  int? lookupDetIdDialysisFrequencyInWeek;
  dynamic referenceByName;
  String? previoushospitalName;
  dynamic hospitalsessionDate;
  int? divisionId;
  int? perDivisionId;
  String? deviceFrom;
  String? firstTimeDialysisFlag;
  dynamic sstartSessionDate;

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
    map['nephrologistContactNo'] = nephrologistContactNo;
    map['userId'] = userId;
    map['abhaAddress'] = abhaAddress;
    map['patientApId'] = patientApId;
    map['patientName'] = patientName;
    map['listReg'] = listReg;
    map['patientList'] = patientList;
    map['maxTreatmentId'] = maxTreatmentId;
    map['organDonationRegistrationDto'] = organDonationRegistrationDto;
    if (listTreatment != null) {
      map['listTreatment'] = listTreatment?.map((v) => v.toJson()).toList();
    }
    if (listBill != null) {
      map['listBill'] = listBill?.map((v) => v.toJson()).toList();
    }
    map['listBillDetails'] = listBillDetails;
    // if (listPayRes != null) {
    //   map['listPayRes'] = listPayRes?.map((v) => v.toJson()).toList();
    // }
    if (listMlcDetails != null) {
      map['listMlcDetails'] = listMlcDetails?.map((v) => v.toJson()).toList();
    }
    if (listMultipleSponsor != null) {
      map['listMultipleSponsor'] = listMultipleSponsor?.map((v) => v.toJson()).toList();
    }
    map['userList'] = userList;
    map['admitedDays'] = admitedDays;
    map['docName'] = docName;
    map['sourceTypeId'] = sourceTypeId;
    map['sponsorName'] = sponsorName;
    map['queryType'] = queryType;
    if (objTreatment != null) {
      map['objTreatment'] = objTreatment?.toJson();
    }
    map['patient_ID'] = patientID;
    map['treatment_id'] = treatmentId;
    map['title'] = title;
    map['bloodGroup'] = bloodGroup;
    map['sex'] = sex;
    map['weight'] = weight;
    map['height'] = height;
    map['officeNumber'] = officeNumber;
    map['wtType'] = wtType;
    map['bedNo'] = bedNo;
    map['objtreatmentbeds'] = objtreatmentbeds;
    map['age1'] = age1;
    map['patientidivf'] = patientidivf;
    map['patientNameivf'] = patientNameivf;
    map['patientidivffemale'] = patientidivffemale;
    map['patientNameivffemale'] = patientNameivffemale;
    map['tflg'] = tflg;
    map['department_id'] = departmentId;
    map['patient_weight'] = patientWeight;
    map['mjpjayenrollmentNo'] = mjpjayenrollmentNo;
    map['indentificationNumber'] = indentificationNumber;
    map['referredContactNumber'] = referredContactNumber;
    map['lookupDetIdDialysisFrequencyInWeek'] = lookupDetIdDialysisFrequencyInWeek;
    map['referenceByName'] = referenceByName;
    map['previoushospitalName'] = previoushospitalName;
    map['hospitalsessionDate'] = hospitalsessionDate;
    map['divisionId'] = divisionId;
    map['perDivisionId'] = perDivisionId;
    map['deviceFrom'] = deviceFrom;
    map['firstTimeDialysisFlag'] = firstTimeDialysisFlag;
    map['sstartSessionDate'] = sstartSessionDate;
    return map;
  }

}

class ObjTreatment {
  ObjTreatment({
      this.chkRefDoc, 
      this.claimTime, 
      this.tiVal,
      this.mcflag, 
      this.pi, 
      this.dt, 
      this.tf, 
      this.wt, 
      this.rb, 
      this.rt, 
      this.sy, 
      this.treStart, 
      this.treEnd, 
      this.lit, 
      this.int, 
      this.out, 
      this.opd, 
      this.echo, 
      this.note, 
      this.tmt, 
      this.opddt, 
      this.opDate, 
      this.sn, 
      this.nv, 
      this.sdic, 
      this.empId, 
      this.bedridden, 
      this.sero, 
      this.department, 
      this.selRefBy, 
      this.txtRefBy, 
      this.otrfdoc, 
      this.txtRefByNM, 
      this.trCount, 
      this.idRadiology, 
      this.ctd, 
      this.tppay, 
      this.paynm, 
      this.relage, 
      this.relsex, 
      this.relrelation, 
      this.relAdd, 
      this.relmob, 
      this.cmpny, 
      this.insuCmpny, 
      this.memoNo, 
      this.rmenoDt, 
      this.cashPolNo, 
      this.cnnNo, 
      this.convertToIpd, 
      this.ipdAdDt, 
      this.ipdBillCat, 
      this.billCategoryName, 
      this.billCategoryDiscount, 
      this.erFlag, 
      this.docterId, 
      this.hospitalId, 
      this.companyname, 
      this.companyid, 
      this.refundReceiptList, 
      this.reasonOfVisitId,});

  ObjTreatment.fromJson(dynamic json) {
    chkRefDoc = json['chkRefDoc'];
    claimTime = json['claim_time'];
    tiVal = json['ti'];
    mcflag = json['mcflag'];
    pi = json['pi'];
    dt = json['dt'];
    tf = json['tf'];
    wt = json['wt'];
    rb = json['rb'];
    rt = json['rt'];
    sy = json['sy'];
    treStart = json['treStart'];
    treEnd = json['treEnd'];
    lit = json['lit'];
    int = json['int'];
    out = json['out'];
    opd = json['opd'];
    echo = json['echo'];
    note = json['note'];
    tmt = json['tmt'];
    opddt = json['opddt'];
    opDate = json['opDate'];
    sn = json['sn'];
    nv = json['nv'];
    sdic = json['sdic'];
    empId = json['empId'];
    bedridden = json['bedridden'];
    sero = json['sero'];
    department = json['department'];
    selRefBy = json['selRefBy'];
    txtRefBy = json['txtRefBy'];
    otrfdoc = json['otrfdoc'];
    txtRefByNM = json['txtRefByNM'];
    trCount = json['trCount'];
    idRadiology = json['IdRadiology'];
    ctd = json['ctd'];
    tppay = json['tppay'];
    paynm = json['paynm'];
    relage = json['relage'];
    relsex = json['relsex'];
    relrelation = json['relrelation'];
    relAdd = json['relAdd'];
    relmob = json['relmob'];
    cmpny = json['cmpny'];
    insuCmpny = json['insuCmpny'];
    memoNo = json['memoNo'];
    rmenoDt = json['rmenoDt'];
    cashPolNo = json['cashPolNo'];
    cnnNo = json['cnnNo'];
    convertToIpd = json['convertToIpd'];
    ipdAdDt = json['ipdAdDt'];
    ipdBillCat = json['ipdBillCat'];
    billCategoryName = json['billCategory_Name'];
    billCategoryDiscount = json['billCategory_Discount'];
    erFlag = json['erFlag'];
    docterId = json['docter_id'];
    hospitalId = json['hospital_id'];
    companyname = json['companyname'];
    companyid = json['companyid'];
    refundReceiptList = json['refundReceiptList'];
    reasonOfVisitId = json['reasonOfVisit_id'];
  }
  bool? chkRefDoc;
  dynamic claimTime;
  dynamic tiVal;
  dynamic mcflag;
  dynamic pi;
  dynamic dt;
  dynamic tf;
  dynamic wt;
  dynamic rb;
  dynamic rt;
  dynamic sy;
  dynamic treStart;
  dynamic treEnd;
  dynamic lit;
  dynamic int;
  dynamic out;
  dynamic opd;
  dynamic echo;
  dynamic note;
  dynamic tmt;
  dynamic opddt;
  dynamic opDate;
  dynamic sn;
  dynamic nv;
  dynamic sdic;
  dynamic empId;
  dynamic bedridden;
  dynamic sero;
  dynamic department;
  dynamic selRefBy;
  dynamic txtRefBy;
  dynamic otrfdoc;
  dynamic txtRefByNM;
  dynamic trCount;
  dynamic idRadiology;
  dynamic ctd;
  dynamic tppay;
  dynamic paynm;
  dynamic relage;
  dynamic relsex;
  dynamic relrelation;
  dynamic relAdd;
  dynamic relmob;
  dynamic cmpny;
  dynamic insuCmpny;
  dynamic memoNo;
  dynamic rmenoDt;
  dynamic cashPolNo;
  dynamic cnnNo;
  dynamic convertToIpd;
  dynamic ipdAdDt;
  dynamic ipdBillCat;
  dynamic billCategoryName;
  double? billCategoryDiscount;
  dynamic erFlag;
  dynamic docterId;
  dynamic hospitalId;
  dynamic companyname;
  dynamic companyid;
  dynamic refundReceiptList;
  dynamic reasonOfVisitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chkRefDoc'] = chkRefDoc;
    map['claim_time'] = claimTime;
    map['ti'] = tiVal;
    map['mcflag'] = mcflag;
    map['pi'] = pi;
    map['dt'] = dt;
    map['tf'] = tf;
    map['wt'] = wt;
    map['rb'] = rb;
    map['rt'] = rt;
    map['sy'] = sy;
    map['treStart'] = treStart;
    map['treEnd'] = treEnd;
    map['lit'] = lit;
    map['int'] = int;
    map['out'] = out;
    map['opd'] = opd;
    map['echo'] = echo;
    map['note'] = note;
    map['tmt'] = tmt;
    map['opddt'] = opddt;
    map['opDate'] = opDate;
    map['sn'] = sn;
    map['nv'] = nv;
    map['sdic'] = sdic;
    map['empId'] = empId;
    map['bedridden'] = bedridden;
    map['sero'] = sero;
    map['department'] = department;
    map['selRefBy'] = selRefBy;
    map['txtRefBy'] = txtRefBy;
    map['otrfdoc'] = otrfdoc;
    map['txtRefByNM'] = txtRefByNM;
    map['trCount'] = trCount;
    map['IdRadiology'] = idRadiology;
    map['ctd'] = ctd;
    map['tppay'] = tppay;
    map['paynm'] = paynm;
    map['relage'] = relage;
    map['relsex'] = relsex;
    map['relrelation'] = relrelation;
    map['relAdd'] = relAdd;
    map['relmob'] = relmob;
    map['cmpny'] = cmpny;
    map['insuCmpny'] = insuCmpny;
    map['memoNo'] = memoNo;
    map['rmenoDt'] = rmenoDt;
    map['cashPolNo'] = cashPolNo;
    map['cnnNo'] = cnnNo;
    map['convertToIpd'] = convertToIpd;
    map['ipdAdDt'] = ipdAdDt;
    map['ipdBillCat'] = ipdBillCat;
    map['billCategory_Name'] = billCategoryName;
    map['billCategory_Discount'] = billCategoryDiscount;
    map['erFlag'] = erFlag;
    map['docter_id'] = docterId;
    map['hospital_id'] = hospitalId;
    map['companyname'] = companyname;
    map['companyid'] = companyid;
    map['refundReceiptList'] = refundReceiptList;
    map['reasonOfVisit_id'] = reasonOfVisitId;
    return map;
  }

}

class ListBill {
  ListBill({
      this.billId, 
      this.treatmentId, 
      this.patienttId, 
      this.departmentId, 
      this.count, 
      this.sourceTypeId, 
      this.unitId, 
      this.deleted, 
      this.createdBy, 
      this.createdDateTime,
      this.invoiceCreatedDateTime, 
      this.invCreatedBy, 
      this.updatedBy, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.invoiceFlag, 
      this.invoiceCount, 
      this.billType, 
      this.billTypeName, 
      this.deletedDateTime, 
      this.sponsorCatId, 
      this.patientCatId, 
      this.sponsorId, 
      this.totalBill, 
      this.totalPaid, 
      this.totalRemain, 
      this.totalRefund, 
      this.discount, 
      this.totalConcn, 
      this.billSettledFlag, 
      this.listBill, 
      this.listPayRes, 
      this.listMultipleSponsor,});

  ListBill.fromJson(dynamic json) {
    billId = json['billId'];
    treatmentId = json['treatmentId'];
    patienttId = json['patienttId'];
    departmentId = json['departmentId'];
    count = json['count'];
    sourceTypeId = json['sourceTypeId'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
    invoiceCreatedDateTime = json['invoiceCreatedDateTime'];
    invCreatedBy = json['invCreatedBy'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    invoiceFlag = json['invoiceFlag'];
    invoiceCount = json['invoiceCount'];
    billType = json['billType'];
    billTypeName = json['billTypeName'];
    deletedDateTime = json['deletedDateTime'];
    sponsorCatId = json['sponsorCatId'];
    patientCatId = json['patientCatId'];
    sponsorId = json['sponsorId'];
    totalBill = json['totalBill'];
    totalPaid = json['totalPaid'];
    totalRemain = json['totalRemain'];
    totalRefund = json['totalRefund'];
    discount = json['discount'];
    totalConcn = json['totalConcn'];
    billSettledFlag = json['billSettledFlag'];
    listBill = json['listBill'];
    // if (json['listPayRes'] != null) {
    //   listPayRes = [];
    //   json['listPayRes'].forEach((v) {
    //     listPayRes?.add(Dynamic.fromJson(v));
    //   });
    // }
    // if (json['listMultipleSponsor'] != null) {
    //   listMultipleSponsor = [];
    //   json['listMultipleSponsor'].forEach((v) {
    //     listMultipleSponsor?.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  int? billId;
  dynamic treatmentId;
  dynamic patienttId;
  int? departmentId;
  int? count;
  int? sourceTypeId;
  int? unitId;
  String? deleted;
  int? createdBy;
  String? createdDateTime;
  dynamic invoiceCreatedDateTime;
  int? invCreatedBy;
  int? updatedBy;
  dynamic updatedDateTime;
  int? deletedBy;
  String? invoiceFlag;
  int? invoiceCount;
  int? billType;
  String? billTypeName;
  dynamic deletedDateTime;
  int? sponsorCatId;
  int? patientCatId;
  int? sponsorId;
  double? totalBill;
  double? totalPaid;
  double? totalRemain;
  double? totalRefund;
  double? discount;
  double? totalConcn;
  String? billSettledFlag;
  dynamic listBill;
  List<dynamic>? listPayRes;
  List<dynamic>? listMultipleSponsor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['billId'] = billId;
    map['treatmentId'] = treatmentId;
    map['patienttId'] = patienttId;
    map['departmentId'] = departmentId;
    map['count'] = count;
    map['sourceTypeId'] = sourceTypeId;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['createdBy'] = createdBy;
    map['createdDateTime'] = createdDateTime;
    map['invoiceCreatedDateTime'] = invoiceCreatedDateTime;
    map['invCreatedBy'] = invCreatedBy;
    map['updatedBy'] = updatedBy;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['invoiceFlag'] = invoiceFlag;
    map['invoiceCount'] = invoiceCount;
    map['billType'] = billType;
    map['billTypeName'] = billTypeName;
    map['deletedDateTime'] = deletedDateTime;
    map['sponsorCatId'] = sponsorCatId;
    map['patientCatId'] = patientCatId;
    map['sponsorId'] = sponsorId;
    map['totalBill'] = totalBill;
    map['totalPaid'] = totalPaid;
    map['totalRemain'] = totalRemain;
    map['totalRefund'] = totalRefund;
    map['discount'] = discount;
    map['totalConcn'] = totalConcn;
    map['billSettledFlag'] = billSettledFlag;
    map['listBill'] = listBill;
    if (listPayRes != null) {
      map['listPayRes'] = listPayRes?.map((v) => v.toJson()).toList();
    }
    if (listMultipleSponsor != null) {
      map['listMultipleSponsor'] = listMultipleSponsor?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ListTreatment {
  ListTreatment({
      this.treatmentId, 
      this.patientId, 
      this.departmentId, 
      this.doctorIdList, 
      this.centerPatientId, 
      this.token, 
      this.tFlag, 
      this.unitId, 
      this.deleted, 
      this.refDocId, 
      this.refDocName, 
      this.caseType, 
      this.weight, 
      this.height, 
      this.mheight, 
      this.fheight, 
      this.notes, 
      this.empid, 
      this.count, 
      this.trcount, 
      this.opdipdno, 
      this.tpaid, 
      this.cancelNarration, 
      this.admCancelFlag, 
      this.ivfPayFlag, 
      this.narration, 
      this.ivfTreatID, 
      this.tokenno, 
      this.reqGenFormId, 
      this.referredBy, 
      this.referredSource, 
      this.referredSourceSlave, 
      this.referredSourceDocId, 
      this.refDate, 
      this.sponsorId, 
      this.sactionOrdNo, 
      this.sanctionAmt, 
      this.neisNo, 
      this.visitNo, 
      this.ipdOrOpd, 
      this.treatPermited, 
      this.diseToBeTreat, 
      this.validUpToDate, 
      this.admissionCanDateTime, 
      this.admissionCanceledBy, 
      this.admissionDateTime, 
      this.reasonofvisit, 
      this.ivfTreatFlag, 
      this.patientName, 
      this.mobile, 
      this.userName, 
      this.cancelDate, 
      this.cancelTime, 
      this.phyDateTime, 
      this.phyDisFlag, 
      this.outtime, 
      this.casualityFlag, 
      this.organDonarFlag, 
      this.specialityId, 
      this.emrHighrisk, 
      this.createdBy, 
      this.createdDateTime, 
      this.updatedBy, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.deletedDateTime, 
      this.emergencyFlag, 
      this.businessType, 
      this.customerType, 
      this.customerId, 
      this.collectionDate, 
      this.collectionTime, 
      this.registeredAt, 
      this.appointmentId, 
      this.mjpjaycaseNumber, 
      this.mjpjayclaimNumber, 
      this.mjpjayIPNumber, 
      this.preAuthapdate, 
      this.filePath, 
      this.visitDate, 
      this.visitTime, 
      this.listTreatment, 
      this.listBill, 
      this.invoiceCount, 
      this.listPayRes, 
      this.listMultipleSponsor, 
      this.lookupDetIdSchemeAdopt, 
      this.pathologyMachineMasterId, 
      this.lookupDetIdStage, 
      this.dischargeDate, 
      this.mjpjayenrollmentNo, 
      this.treatendDate, 
      this.bmi, 
      this.bsa, 
      this.hcim, 
      this.targetheight,});

  ListTreatment.fromJson(dynamic json) {
    treatmentId = json['treatmentId'];
    patientId = json['patientId'];
    departmentId = json['departmentId'];
    doctorIdList = json['doctorIdList'];
    centerPatientId = json['centerPatientId'];
    token = json['token'];
    tFlag = json['tFlag'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    refDocId = json['refDocId'];
    refDocName = json['refDocName'];
    caseType = json['caseType'];
    weight = json['weight'];
    height = json['height'];
    mheight = json['mheight'];
    fheight = json['fheight'];
    notes = json['notes'];
    empid = json['empid'];
    count = json['count'];
    trcount = json['trcount'];
    opdipdno = json['opdipdno'];
    tpaid = json['tpaid'];
    cancelNarration = json['cancelNarration'];
    admCancelFlag = json['admCancelFlag'];
    ivfPayFlag = json['ivfPayFlag'];
    narration = json['narration'];
    ivfTreatID = json['ivfTreatID'];
    tokenno = json['tokenno'];
    reqGenFormId = json['reqGenFormId'];
    referredBy = json['referredBy'];
    referredSource = json['referredSource'];
    referredSourceSlave = json['referredSourceSlave'];
    referredSourceDocId = json['referredSourceDocId'];
    refDate = json['refDate'];
    sponsorId = json['sponsorId'];
    sactionOrdNo = json['sactionOrdNo'];
    sanctionAmt = json['sanctionAmt'];
    neisNo = json['neisNo'];
    visitNo = json['visitNo'];
    ipdOrOpd = json['ipdOrOpd'];
    treatPermited = json['treatPermited'];
    diseToBeTreat = json['diseToBeTreat'];
    validUpToDate = json['validUpToDate'];
    admissionCanDateTime = json['admissionCanDateTime'];
    admissionCanceledBy = json['admissionCanceledBy'];
    admissionDateTime = json['admissionDateTime'];
    reasonofvisit = json['reasonofvisit'];
    ivfTreatFlag = json['ivfTreatFlag'];
    patientName = json['patientName'];
    mobile = json['mobile'];
    userName = json['userName'];
    cancelDate = json['cancelDate'];
    cancelTime = json['cancelTime'];
    phyDateTime = json['phyDateTime'];
    phyDisFlag = json['phyDisFlag'];
    outtime = json['outtime'];
    casualityFlag = json['casualityFlag'];
    organDonarFlag = json['organDonarFlag'];
    specialityId = json['specialityId'];
    emrHighrisk = json['emrHighrisk'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    deletedDateTime = json['deletedDateTime'];
    emergencyFlag = json['emergencyFlag'];
    businessType = json['businessType'];
    customerType = json['customerType'];
    customerId = json['customerId'];
    collectionDate = json['collectionDate'];
    collectionTime = json['collectionTime'];
    registeredAt = json['registeredAt'];
    appointmentId = json['appointmentId'];
    mjpjaycaseNumber = json['mjpjaycaseNumber'];
    mjpjayclaimNumber = json['mjpjayclaimNumber'];
    mjpjayIPNumber = json['mjpjayIPNumber'];
    preAuthapdate = json['preAuthapdate'];
    filePath = json['filePath'];
    visitDate = json['visitDate'];
    visitTime = json['visitTime'];
    listTreatment = json['listTreatment'];
    if (json['listBill'] != null) {
      listBill = [];
      json['listBill'].forEach((v) {
        listBill?.add(ListBill.fromJson(v));
      });
    }
    invoiceCount = json['invoiceCount'];

    lookupDetIdSchemeAdopt = json['lookupDetIdSchemeAdopt'];
    pathologyMachineMasterId = json['pathologyMachineMasterId'];
    lookupDetIdStage = json['lookupDetIdStage'];
    dischargeDate = json['dischargeDate'];
    mjpjayenrollmentNo = json['mjpjayenrollmentNo'];
    treatendDate = json['treatendDate'];
    bmi = json['BMI'];
    bsa = json['BSA'];
    hcim = json['HCIM'];
    targetheight = json['TARGET_HEIGHT'];
  }
  int? treatmentId;
  int? patientId;
  int? departmentId;
  int? doctorIdList;
  String? centerPatientId;
  int? token;
  String? tFlag;
  int? unitId;
  String? deleted;
  int? refDocId;
  String? refDocName;
  int? caseType;
  double? weight;
  double? height;
  double? mheight;
  double? fheight;
  String? notes;
  String? empid;
  int? count;
  String? trcount;
  String? opdipdno;
  String? tpaid;
  String? cancelNarration;
  String? admCancelFlag;
  String? ivfPayFlag;
  String? narration;
  dynamic ivfTreatID;
  String? tokenno;
  int? reqGenFormId;
  String? referredBy;
  int? referredSource;
  String? referredSourceSlave;
  int? referredSourceDocId;
  dynamic refDate;
  int? sponsorId;
  String? sactionOrdNo;
  double? sanctionAmt;
  String? neisNo;
  String? visitNo;
  String? ipdOrOpd;
  String? treatPermited;
  String? diseToBeTreat;
  dynamic validUpToDate;
  dynamic admissionCanDateTime;
  int? admissionCanceledBy;
  String? admissionDateTime;
  int? reasonofvisit;
  String? ivfTreatFlag;
  String? patientName;
  String? mobile;
  String? userName;
  dynamic cancelDate;
  dynamic cancelTime;
  dynamic phyDateTime;
  String? phyDisFlag;
  String? outtime;
  String? casualityFlag;
  String? organDonarFlag;
  String? specialityId;
  int? emrHighrisk;
  int? createdBy;
  String? createdDateTime;
  int? updatedBy;
  String? updatedDateTime;
  int? deletedBy;
  dynamic deletedDateTime;
  String? emergencyFlag;
  int? businessType;
  int? customerType;
  int? customerId;
  String? collectionDate;
  String? collectionTime;
  String? registeredAt;
  int? appointmentId;
  String? mjpjaycaseNumber;
  String? mjpjayclaimNumber;
  String? mjpjayIPNumber;
  String? preAuthapdate;
  dynamic filePath;
  String? visitDate;
  String? visitTime;
  dynamic listTreatment;
  List<ListBill>? listBill;
  dynamic invoiceCount;
  List<dynamic>? listPayRes;
  List<dynamic>? listMultipleSponsor;
  int? lookupDetIdSchemeAdopt;
  int? pathologyMachineMasterId;
  int? lookupDetIdStage;
  dynamic dischargeDate;
  dynamic mjpjayenrollmentNo;
  dynamic treatendDate;
  double? bmi;
  double? bsa;
  double? hcim;
  double? targetheight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['treatmentId'] = treatmentId;
    map['patientId'] = patientId;
    map['departmentId'] = departmentId;
    map['doctorIdList'] = doctorIdList;
    map['centerPatientId'] = centerPatientId;
    map['token'] = token;
    map['tFlag'] = tFlag;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['refDocId'] = refDocId;
    map['refDocName'] = refDocName;
    map['caseType'] = caseType;
    map['weight'] = weight;
    map['height'] = height;
    map['mheight'] = mheight;
    map['fheight'] = fheight;
    map['notes'] = notes;
    map['empid'] = empid;
    map['count'] = count;
    map['trcount'] = trcount;
    map['opdipdno'] = opdipdno;
    map['tpaid'] = tpaid;
    map['cancelNarration'] = cancelNarration;
    map['admCancelFlag'] = admCancelFlag;
    map['ivfPayFlag'] = ivfPayFlag;
    map['narration'] = narration;
    map['ivfTreatID'] = ivfTreatID;
    map['tokenno'] = tokenno;
    map['reqGenFormId'] = reqGenFormId;
    map['referredBy'] = referredBy;
    map['referredSource'] = referredSource;
    map['referredSourceSlave'] = referredSourceSlave;
    map['referredSourceDocId'] = referredSourceDocId;
    map['refDate'] = refDate;
    map['sponsorId'] = sponsorId;
    map['sactionOrdNo'] = sactionOrdNo;
    map['sanctionAmt'] = sanctionAmt;
    map['neisNo'] = neisNo;
    map['visitNo'] = visitNo;
    map['ipdOrOpd'] = ipdOrOpd;
    map['treatPermited'] = treatPermited;
    map['diseToBeTreat'] = diseToBeTreat;
    map['validUpToDate'] = validUpToDate;
    map['admissionCanDateTime'] = admissionCanDateTime;
    map['admissionCanceledBy'] = admissionCanceledBy;
    map['admissionDateTime'] = admissionDateTime;
    map['reasonofvisit'] = reasonofvisit;
    map['ivfTreatFlag'] = ivfTreatFlag;
    map['patientName'] = patientName;
    map['mobile'] = mobile;
    map['userName'] = userName;
    map['cancelDate'] = cancelDate;
    map['cancelTime'] = cancelTime;
    map['phyDateTime'] = phyDateTime;
    map['phyDisFlag'] = phyDisFlag;
    map['outtime'] = outtime;
    map['casualityFlag'] = casualityFlag;
    map['organDonarFlag'] = organDonarFlag;
    map['specialityId'] = specialityId;
    map['emrHighrisk'] = emrHighrisk;
    map['createdBy'] = createdBy;
    map['createdDateTime'] = createdDateTime;
    map['updatedBy'] = updatedBy;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['deletedDateTime'] = deletedDateTime;
    map['emergencyFlag'] = emergencyFlag;
    map['businessType'] = businessType;
    map['customerType'] = customerType;
    map['customerId'] = customerId;
    map['collectionDate'] = collectionDate;
    map['collectionTime'] = collectionTime;
    map['registeredAt'] = registeredAt;
    map['appointmentId'] = appointmentId;
    map['mjpjaycaseNumber'] = mjpjaycaseNumber;
    map['mjpjayclaimNumber'] = mjpjayclaimNumber;
    map['mjpjayIPNumber'] = mjpjayIPNumber;
    map['preAuthapdate'] = preAuthapdate;
    map['filePath'] = filePath;
    map['visitDate'] = visitDate;
    map['visitTime'] = visitTime;
    map['listTreatment'] = listTreatment;
    if (listBill != null) {
      map['listBill'] = listBill?.map((v) => v.toJson()).toList();
    }
    map['invoiceCount'] = invoiceCount;
    if (listPayRes != null) {
      map['listPayRes'] = listPayRes?.map((v) => v.toJson()).toList();
    }
    if (listMultipleSponsor != null) {
      map['listMultipleSponsor'] = listMultipleSponsor?.map((v) => v.toJson()).toList();
    }
    map['lookupDetIdSchemeAdopt'] = lookupDetIdSchemeAdopt;
    map['pathologyMachineMasterId'] = pathologyMachineMasterId;
    map['lookupDetIdStage'] = lookupDetIdStage;
    map['dischargeDate'] = dischargeDate;
    map['mjpjayenrollmentNo'] = mjpjayenrollmentNo;
    map['treatendDate'] = treatendDate;
    map['BMI'] = bmi;
    map['BSA'] = bsa;
    map['HCIM'] = hcim;
    map['TARGET_HEIGHT'] = targetheight;
    return map;
  }

}

class ListBills {
  ListBills({
      this.billId, 
      this.treatmentId, 
      this.patienttId, 
      this.departmentId, 
      this.count, 
      this.sourceTypeId, 
      this.unitId, 
      this.deleted, 
      this.createdBy, 
      this.createdDateTime, 
      this.invoiceCreatedDateTime, 
      this.invCreatedBy, 
      this.updatedBy, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.invoiceFlag, 
      this.invoiceCount, 
      this.billType, 
      this.billTypeName, 
      this.deletedDateTime, 
      this.sponsorCatId, 
      this.patientCatId, 
      this.sponsorId, 
      this.totalBill, 
      this.totalPaid, 
      this.totalRemain, 
      this.totalRefund, 
      this.discount, 
      this.totalConcn, 
      this.billSettledFlag, 
      this.listBill, 
      this.listPayRes, 
      this.listMultipleSponsor,});

  ListBills.fromJson(dynamic json) {
    billId = json['billId'];
    treatmentId = json['treatmentId'];
    patienttId = json['patienttId'];
    departmentId = json['departmentId'];
    count = json['count'];
    sourceTypeId = json['sourceTypeId'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
    invoiceCreatedDateTime = json['invoiceCreatedDateTime'];
    invCreatedBy = json['invCreatedBy'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    invoiceFlag = json['invoiceFlag'];
    invoiceCount = json['invoiceCount'];
    billType = json['billType'];
    billTypeName = json['billTypeName'];
    deletedDateTime = json['deletedDateTime'];
    sponsorCatId = json['sponsorCatId'];
    patientCatId = json['patientCatId'];
    sponsorId = json['sponsorId'];
    totalBill = json['totalBill'];
    totalPaid = json['totalPaid'];
    totalRemain = json['totalRemain'];
    totalRefund = json['totalRefund'];
    discount = json['discount'];
    totalConcn = json['totalConcn'];
    billSettledFlag = json['billSettledFlag'];
    listBill = json['listBill'];

  }
  int? billId;
  dynamic treatmentId;
  dynamic patienttId;
  int? departmentId;
  int? count;
  int? sourceTypeId;
  int? unitId;
  String? deleted;
  int? createdBy;
  String? createdDateTime;
  dynamic invoiceCreatedDateTime;
  int? invCreatedBy;
  int? updatedBy;
  dynamic updatedDateTime;
  int? deletedBy;
  String? invoiceFlag;
  int? invoiceCount;
  int? billType;
  String? billTypeName;
  dynamic deletedDateTime;
  int? sponsorCatId;
  int? patientCatId;
  int? sponsorId;
  double? totalBill;
  double? totalPaid;
  double? totalRemain;
  double? totalRefund;
  double? discount;
  double? totalConcn;
  String? billSettledFlag;
  dynamic listBill;
  List<dynamic>? listPayRes;
  List<dynamic>? listMultipleSponsor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['billId'] = billId;
    map['treatmentId'] = treatmentId;
    map['patienttId'] = patienttId;
    map['departmentId'] = departmentId;
    map['count'] = count;
    map['sourceTypeId'] = sourceTypeId;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['createdBy'] = createdBy;
    map['createdDateTime'] = createdDateTime;
    map['invoiceCreatedDateTime'] = invoiceCreatedDateTime;
    map['invCreatedBy'] = invCreatedBy;
    map['updatedBy'] = updatedBy;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['invoiceFlag'] = invoiceFlag;
    map['invoiceCount'] = invoiceCount;
    map['billType'] = billType;
    map['billTypeName'] = billTypeName;
    map['deletedDateTime'] = deletedDateTime;
    map['sponsorCatId'] = sponsorCatId;
    map['patientCatId'] = patientCatId;
    map['sponsorId'] = sponsorId;
    map['totalBill'] = totalBill;
    map['totalPaid'] = totalPaid;
    map['totalRemain'] = totalRemain;
    map['totalRefund'] = totalRefund;
    map['discount'] = discount;
    map['totalConcn'] = totalConcn;
    map['billSettledFlag'] = billSettledFlag;
    map['listBill'] = listBill;
    if (listPayRes != null) {
      map['listPayRes'] = listPayRes?.map((v) => v.toJson()).toList();
    }
    if (listMultipleSponsor != null) {
      map['listMultipleSponsor'] = listMultipleSponsor?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TreatObj {
  TreatObj({
      this.treatmentId, 
      this.patientId, 
      this.departmentId, 
      this.doctorIdList, 
      this.centerPatientId, 
      this.token, 
      this.tFlag, 
      this.unitId, 
      this.deleted, 
      this.refDocId, 
      this.refDocName, 
      this.caseType, 
      this.weight, 
      this.height, 
      this.mheight, 
      this.fheight, 
      this.notes, 
      this.empid, 
      this.count, 
      this.trcount, 
      this.opdipdno, 
      this.tpaid, 
      this.cancelNarration, 
      this.admCancelFlag, 
      this.ivfPayFlag, 
      this.narration, 
      this.ivfTreatID, 
      this.tokenno, 
      this.reqGenFormId, 
      this.referredBy, 
      this.referredSource, 
      this.referredSourceSlave, 
      this.referredSourceDocId, 
      this.refDate, 
      this.sponsorId, 
      this.sactionOrdNo, 
      this.sanctionAmt, 
      this.neisNo, 
      this.visitNo, 
      this.ipdOrOpd, 
      this.treatPermited, 
      this.diseToBeTreat, 
      this.validUpToDate, 
      this.admissionCanDateTime, 
      this.admissionCanceledBy, 
      this.admissionDateTime, 
      this.reasonofvisit, 
      this.ivfTreatFlag, 
      this.patientName, 
      this.mobile, 
      this.userName, 
      this.cancelDate, 
      this.cancelTime, 
      this.phyDateTime, 
      this.phyDisFlag, 
      this.outtime, 
      this.casualityFlag, 
      this.organDonarFlag, 
      this.specialityId, 
      this.emrHighrisk, 
      this.createdBy, 
      this.createdDateTime, 
      this.updatedBy, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.deletedDateTime, 
      this.emergencyFlag, 
      this.businessType, 
      this.customerType, 
      this.customerId, 
      this.collectionDate, 
      this.collectionTime, 
      this.registeredAt, 
      this.appointmentId, 
      this.mjpjaycaseNumber, 
      this.mjpjayclaimNumber, 
      this.mjpjayIPNumber, 
      this.preAuthapdate, 
      this.filePath, 
      this.visitDate, 
      this.visitTime, 
      this.listTreatment, 
      this.listBill, 
      this.invoiceCount, 
      this.listPayRes, 
      this.listMultipleSponsor, 
      this.lookupDetIdSchemeAdopt, 
      this.pathologyMachineMasterId, 
      this.lookupDetIdStage, 
      this.dischargeDate, 
      this.mjpjayenrollmentNo, 
      this.treatendDate, 
      this.bmi, 
      this.bsa, 
      this.hcim, 
      this.targetheight,});

  TreatObj.fromJson(dynamic json) {
    treatmentId = json['treatmentId'];
    patientId = json['patientId'];
    departmentId = json['departmentId'];
    doctorIdList = json['doctorIdList'];
    centerPatientId = json['centerPatientId'];
    token = json['token'];
    tFlag = json['tFlag'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    refDocId = json['refDocId'];
    refDocName = json['refDocName'];
    caseType = json['caseType'];
    weight = json['weight'];
    height = json['height'];
    mheight = json['mheight'];
    fheight = json['fheight'];
    notes = json['notes'];
    empid = json['empid'];
    count = json['count'];
    trcount = json['trcount'];
    opdipdno = json['opdipdno'];
    tpaid = json['tpaid'];
    cancelNarration = json['cancelNarration'];
    admCancelFlag = json['admCancelFlag'];
    ivfPayFlag = json['ivfPayFlag'];
    narration = json['narration'];
    ivfTreatID = json['ivfTreatID'];
    tokenno = json['tokenno'];
    reqGenFormId = json['reqGenFormId'];
    referredBy = json['referredBy'];
    referredSource = json['referredSource'];
    referredSourceSlave = json['referredSourceSlave'];
    referredSourceDocId = json['referredSourceDocId'];
    refDate = json['refDate'];
    sponsorId = json['sponsorId'];
    sactionOrdNo = json['sactionOrdNo'];
    sanctionAmt = json['sanctionAmt'];
    neisNo = json['neisNo'];
    visitNo = json['visitNo'];
    ipdOrOpd = json['ipdOrOpd'];
    treatPermited = json['treatPermited'];
    diseToBeTreat = json['diseToBeTreat'];
    validUpToDate = json['validUpToDate'];
    admissionCanDateTime = json['admissionCanDateTime'];
    admissionCanceledBy = json['admissionCanceledBy'];
    admissionDateTime = json['admissionDateTime'];
    reasonofvisit = json['reasonofvisit'];
    ivfTreatFlag = json['ivfTreatFlag'];
    patientName = json['patientName'];
    mobile = json['mobile'];
    userName = json['userName'];
    cancelDate = json['cancelDate'];
    cancelTime = json['cancelTime'];
    phyDateTime = json['phyDateTime'];
    phyDisFlag = json['phyDisFlag'];
    outtime = json['outtime'];
    casualityFlag = json['casualityFlag'];
    organDonarFlag = json['organDonarFlag'];
    specialityId = json['specialityId'];
    emrHighrisk = json['emrHighrisk'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    deletedDateTime = json['deletedDateTime'];
    emergencyFlag = json['emergencyFlag'];
    businessType = json['businessType'];
    customerType = json['customerType'];
    customerId = json['customerId'];
    collectionDate = json['collectionDate'];
    collectionTime = json['collectionTime'];
    registeredAt = json['registeredAt'];
    appointmentId = json['appointmentId'];
    mjpjaycaseNumber = json['mjpjaycaseNumber'];
    mjpjayclaimNumber = json['mjpjayclaimNumber'];
    mjpjayIPNumber = json['mjpjayIPNumber'];
    preAuthapdate = json['preAuthapdate'];
    filePath = json['filePath'];
    visitDate = json['visitDate'];
    visitTime = json['visitTime'];
    listTreatment = json['listTreatment'];
    if (json['listBill'] != null) {
      listBill = [];
      json['listBill'].forEach((v) {
        listBill?.add(ListBill.fromJson(v));
      });
    }
    invoiceCount = json['invoiceCount'];

    lookupDetIdSchemeAdopt = json['lookupDetIdSchemeAdopt'];
    pathologyMachineMasterId = json['pathologyMachineMasterId'];
    lookupDetIdStage = json['lookupDetIdStage'];
    dischargeDate = json['dischargeDate'];
    mjpjayenrollmentNo = json['mjpjayenrollmentNo'];
    treatendDate = json['treatendDate'];
    bmi = json['BMI'];
    bsa = json['BSA'];
    hcim = json['HCIM'];
    targetheight = json['TARGET_HEIGHT'];
  }
  int? treatmentId;
  int? patientId;
  int? departmentId;
  int? doctorIdList;
  String? centerPatientId;
  int? token;
  String? tFlag;
  int? unitId;
  String? deleted;
  int? refDocId;
  String? refDocName;
  int? caseType;
  double? weight;
  double? height;
  double? mheight;
  double? fheight;
  String? notes;
  String? empid;
  int? count;
  String? trcount;
  String? opdipdno;
  String? tpaid;
  String? cancelNarration;
  String? admCancelFlag;
  String? ivfPayFlag;
  String? narration;
  dynamic ivfTreatID;
  String? tokenno;
  int? reqGenFormId;
  String? referredBy;
  int? referredSource;
  String? referredSourceSlave;
  int? referredSourceDocId;
  dynamic refDate;
  int? sponsorId;
  String? sactionOrdNo;
  double? sanctionAmt;
  String? neisNo;
  String? visitNo;
  String? ipdOrOpd;
  String? treatPermited;
  String? diseToBeTreat;
  dynamic validUpToDate;
  dynamic admissionCanDateTime;
  int? admissionCanceledBy;
  String? admissionDateTime;
  int? reasonofvisit;
  String? ivfTreatFlag;
  String? patientName;
  String? mobile;
  String? userName;
  dynamic cancelDate;
  dynamic cancelTime;
  dynamic phyDateTime;
  String? phyDisFlag;
  String? outtime;
  String? casualityFlag;
  String? organDonarFlag;
  String? specialityId;
  int? emrHighrisk;
  int? createdBy;
  String? createdDateTime;
  int? updatedBy;
  String? updatedDateTime;
  int? deletedBy;
  dynamic deletedDateTime;
  String? emergencyFlag;
  int? businessType;
  int? customerType;
  int? customerId;
  String? collectionDate;
  String? collectionTime;
  String? registeredAt;
  int? appointmentId;
  String? mjpjaycaseNumber;
  String? mjpjayclaimNumber;
  String? mjpjayIPNumber;
  String? preAuthapdate;
  dynamic filePath;
  String? visitDate;
  String? visitTime;
  dynamic listTreatment;
  List<ListBill>? listBill;
  dynamic invoiceCount;
  List<dynamic>? listPayRes;
  List<dynamic>? listMultipleSponsor;
  int? lookupDetIdSchemeAdopt;
  int? pathologyMachineMasterId;
  int? lookupDetIdStage;
  dynamic dischargeDate;
  dynamic mjpjayenrollmentNo;
  dynamic treatendDate;
  double? bmi;
  double? bsa;
  double? hcim;
  double? targetheight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['treatmentId'] = treatmentId;
    map['patientId'] = patientId;
    map['departmentId'] = departmentId;
    map['doctorIdList'] = doctorIdList;
    map['centerPatientId'] = centerPatientId;
    map['token'] = token;
    map['tFlag'] = tFlag;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['refDocId'] = refDocId;
    map['refDocName'] = refDocName;
    map['caseType'] = caseType;
    map['weight'] = weight;
    map['height'] = height;
    map['mheight'] = mheight;
    map['fheight'] = fheight;
    map['notes'] = notes;
    map['empid'] = empid;
    map['count'] = count;
    map['trcount'] = trcount;
    map['opdipdno'] = opdipdno;
    map['tpaid'] = tpaid;
    map['cancelNarration'] = cancelNarration;
    map['admCancelFlag'] = admCancelFlag;
    map['ivfPayFlag'] = ivfPayFlag;
    map['narration'] = narration;
    map['ivfTreatID'] = ivfTreatID;
    map['tokenno'] = tokenno;
    map['reqGenFormId'] = reqGenFormId;
    map['referredBy'] = referredBy;
    map['referredSource'] = referredSource;
    map['referredSourceSlave'] = referredSourceSlave;
    map['referredSourceDocId'] = referredSourceDocId;
    map['refDate'] = refDate;
    map['sponsorId'] = sponsorId;
    map['sactionOrdNo'] = sactionOrdNo;
    map['sanctionAmt'] = sanctionAmt;
    map['neisNo'] = neisNo;
    map['visitNo'] = visitNo;
    map['ipdOrOpd'] = ipdOrOpd;
    map['treatPermited'] = treatPermited;
    map['diseToBeTreat'] = diseToBeTreat;
    map['validUpToDate'] = validUpToDate;
    map['admissionCanDateTime'] = admissionCanDateTime;
    map['admissionCanceledBy'] = admissionCanceledBy;
    map['admissionDateTime'] = admissionDateTime;
    map['reasonofvisit'] = reasonofvisit;
    map['ivfTreatFlag'] = ivfTreatFlag;
    map['patientName'] = patientName;
    map['mobile'] = mobile;
    map['userName'] = userName;
    map['cancelDate'] = cancelDate;
    map['cancelTime'] = cancelTime;
    map['phyDateTime'] = phyDateTime;
    map['phyDisFlag'] = phyDisFlag;
    map['outtime'] = outtime;
    map['casualityFlag'] = casualityFlag;
    map['organDonarFlag'] = organDonarFlag;
    map['specialityId'] = specialityId;
    map['emrHighrisk'] = emrHighrisk;
    map['createdBy'] = createdBy;
    map['createdDateTime'] = createdDateTime;
    map['updatedBy'] = updatedBy;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['deletedDateTime'] = deletedDateTime;
    map['emergencyFlag'] = emergencyFlag;
    map['businessType'] = businessType;
    map['customerType'] = customerType;
    map['customerId'] = customerId;
    map['collectionDate'] = collectionDate;
    map['collectionTime'] = collectionTime;
    map['registeredAt'] = registeredAt;
    map['appointmentId'] = appointmentId;
    map['mjpjaycaseNumber'] = mjpjaycaseNumber;
    map['mjpjayclaimNumber'] = mjpjayclaimNumber;
    map['mjpjayIPNumber'] = mjpjayIPNumber;
    map['preAuthapdate'] = preAuthapdate;
    map['filePath'] = filePath;
    map['visitDate'] = visitDate;
    map['visitTime'] = visitTime;
    map['listTreatment'] = listTreatment;
    if (listBill != null) {
      map['listBill'] = listBill?.map((v) => v.toJson()).toList();
    }
    map['invoiceCount'] = invoiceCount;
    if (listPayRes != null) {
      map['listPayRes'] = listPayRes?.map((v) => v.toJson()).toList();
    }
    if (listMultipleSponsor != null) {
      map['listMultipleSponsor'] = listMultipleSponsor?.map((v) => v.toJson()).toList();
    }
    map['lookupDetIdSchemeAdopt'] = lookupDetIdSchemeAdopt;
    map['pathologyMachineMasterId'] = pathologyMachineMasterId;
    map['lookupDetIdStage'] = lookupDetIdStage;
    map['dischargeDate'] = dischargeDate;
    map['mjpjayenrollmentNo'] = mjpjayenrollmentNo;
    map['treatendDate'] = treatendDate;
    map['BMI'] = bmi;
    map['BSA'] = bsa;
    map['HCIM'] = hcim;
    map['TARGET_HEIGHT'] = targetheight;
    return map;
  }

}

class ListBillss {
  ListBillss({
      this.billId, 
      this.treatmentId, 
      this.patienttId, 
      this.departmentId, 
      this.count, 
      this.sourceTypeId, 
      this.unitId, 
      this.deleted, 
      this.createdBy, 
      this.createdDateTime, 
      this.invoiceCreatedDateTime, 
      this.invCreatedBy, 
      this.updatedBy, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.invoiceFlag, 
      this.invoiceCount, 
      this.billType, 
      this.billTypeName, 
      this.deletedDateTime, 
      this.sponsorCatId, 
      this.patientCatId, 
      this.sponsorId, 
      this.totalBill, 
      this.totalPaid, 
      this.totalRemain, 
      this.totalRefund, 
      this.discount, 
      this.totalConcn, 
      this.billSettledFlag, 
      this.listBill, 
      this.listPayRes, 
      this.listMultipleSponsor,});

  ListBillss.fromJson(dynamic json) {
    billId = json['billId'];
    treatmentId = json['treatmentId'];
    patienttId = json['patienttId'];
    departmentId = json['departmentId'];
    count = json['count'];
    sourceTypeId = json['sourceTypeId'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
    invoiceCreatedDateTime = json['invoiceCreatedDateTime'];
    invCreatedBy = json['invCreatedBy'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    invoiceFlag = json['invoiceFlag'];
    invoiceCount = json['invoiceCount'];
    billType = json['billType'];
    billTypeName = json['billTypeName'];
    deletedDateTime = json['deletedDateTime'];
    sponsorCatId = json['sponsorCatId'];
    patientCatId = json['patientCatId'];
    sponsorId = json['sponsorId'];
    totalBill = json['totalBill'];
    totalPaid = json['totalPaid'];
    totalRemain = json['totalRemain'];
    totalRefund = json['totalRefund'];
    discount = json['discount'];
    totalConcn = json['totalConcn'];
    billSettledFlag = json['billSettledFlag'];
    listBill = json['listBill'];

  }
  int? billId;
  dynamic treatmentId;
  dynamic patienttId;
  int? departmentId;
  int? count;
  int? sourceTypeId;
  int? unitId;
  String? deleted;
  int? createdBy;
  String? createdDateTime;
  dynamic invoiceCreatedDateTime;
  int? invCreatedBy;
  int? updatedBy;
  dynamic updatedDateTime;
  int? deletedBy;
  String? invoiceFlag;
  int? invoiceCount;
  int? billType;
  String? billTypeName;
  dynamic deletedDateTime;
  int? sponsorCatId;
  int? patientCatId;
  int? sponsorId;
  double? totalBill;
  double? totalPaid;
  double? totalRemain;
  double? totalRefund;
  double? discount;
  double? totalConcn;
  String? billSettledFlag;
  dynamic listBill;
  List<dynamic>? listPayRes;
  List<dynamic>? listMultipleSponsor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['billId'] = billId;
    map['treatmentId'] = treatmentId;
    map['patienttId'] = patienttId;
    map['departmentId'] = departmentId;
    map['count'] = count;
    map['sourceTypeId'] = sourceTypeId;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['createdBy'] = createdBy;
    map['createdDateTime'] = createdDateTime;
    map['invoiceCreatedDateTime'] = invoiceCreatedDateTime;
    map['invCreatedBy'] = invCreatedBy;
    map['updatedBy'] = updatedBy;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['invoiceFlag'] = invoiceFlag;
    map['invoiceCount'] = invoiceCount;
    map['billType'] = billType;
    map['billTypeName'] = billTypeName;
    map['deletedDateTime'] = deletedDateTime;
    map['sponsorCatId'] = sponsorCatId;
    map['patientCatId'] = patientCatId;
    map['sponsorId'] = sponsorId;
    map['totalBill'] = totalBill;
    map['totalPaid'] = totalPaid;
    map['totalRemain'] = totalRemain;
    map['totalRefund'] = totalRefund;
    map['discount'] = discount;
    map['totalConcn'] = totalConcn;
    map['billSettledFlag'] = billSettledFlag;
    map['listBill'] = listBill;
    if (listPayRes != null) {
      map['listPayRes'] = listPayRes?.map((v) => v.toJson()).toList();
    }
    if (listMultipleSponsor != null) {
      map['listMultipleSponsor'] = listMultipleSponsor?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}