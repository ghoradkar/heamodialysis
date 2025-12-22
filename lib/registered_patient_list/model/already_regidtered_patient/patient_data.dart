

import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/list_bill.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/list_treatment.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/obj_treatment.dart';

class PatientData {
  PatientData({
      this.patientId, 
      this.centerPatientId, 
      this.prefix, 
      this.fName, 
      this.mName, 
      this.searchParam,
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
      this.legacyUHIDNumber, 
      this.nephrologistName, 
      this.referenceName, 
      this.referenceDoctorName, 
      this.lookupDetIdRefByRef, 
      this.refByName, 
      this.nephrologistContactNo, 
      this.patientApId, 
      this.patientName, 
      this.listReg, 
      this.patientList, 
      this.maxTreatmentId, 
      this.organDonationRegistrationDto, 
      this.listTreatment, 
      this.listBill, 
      this.listBillDetails,
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
      this.referenceByName,});

  PatientData.fromJson(dynamic json) {
    patientId = json['patientId'];
    centerPatientId = json['centerPatientId'];
    prefix = json['prefix'];
    fName = json['fName'];
    mName = json['mName'];
    searchParam = json['searchParam'];
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
    legacyUHIDNumber = json['legacyUHIDNumber'];
    nephrologistName = json['nephrologistName'];
    referenceName = json['referenceName'];
    referenceDoctorName = json['referenceDoctorName'];
    lookupDetIdRefByRef = json['lookupDetIdRefByRef'];
    refByName = json['refByName'];
    nephrologistContactNo = json['nephrologistContactNo'];
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

    userList = json['userList'];
    admitedDays = json['admitedDays'];
    docName = json['docName'];
    sourceTypeId = json['sourceTypeId'];
    sponsorName = json['sponsorName'];
    queryType = json['queryType'];
    objTreatment = json['objTreatment'] != null ? ObjTreatment.fromJson(json['objTreatment']) : null;
    patientID = json['patient_ID'];
    treatmentId = json['treatmentId'];
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
  }
  int? patientId;
  String? centerPatientId;
  String? prefix;
  String? fName;
  String? mName;
  String? searchParam;
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
  int? createdDateTime;
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
  dynamic pweight;
  dynamic pheight;
  dynamic bplFlag;
  dynamic lookupDetIdDialysisMode;
  dynamic lookupDetIdHaemodialysisProcedureType;
  dynamic haemodialysisProcedureTypeEn;
  dynamic lookupDetIdPatientType;
  String? patientTypeEn;
  dynamic mjpjyCardNo;
  dynamic mjpjyApprovedNo;
  dynamic abhaNo;
  dynamic relativeMobileNo;
  String? legacyUHIDNumber;
  dynamic nephrologistName;
  dynamic referenceName;
  dynamic referenceDoctorName;
  dynamic lookupDetIdRefByRef;
  dynamic refByName;
  dynamic nephrologistContactNo;
  int? patientApId;
  dynamic patientName;
  dynamic listReg;
  dynamic patientList;
  dynamic maxTreatmentId;
  dynamic organDonationRegistrationDto;
  List<ListTreatment>? listTreatment;
  List<ListBill>? listBill;
  dynamic listBillDetails;
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
  dynamic mjpjayenrollmentNo;
  dynamic indentificationNumber;
  dynamic referredContactNumber;
  dynamic lookupDetIdDialysisFrequencyInWeek;
  dynamic referenceByName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['centerPatientId'] = centerPatientId;
    map['prefix'] = prefix;
    map['fName'] = fName;
    map['mName'] = mName;
    map['searchParam'] = searchParam;
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
    map['legacyUHIDNumber'] = legacyUHIDNumber;
    map['nephrologistName'] = nephrologistName;
    map['referenceName'] = referenceName;
    map['referenceDoctorName'] = referenceDoctorName;
    map['lookupDetIdRefByRef'] = lookupDetIdRefByRef;
    map['refByName'] = refByName;
    map['nephrologistContactNo'] = nephrologistContactNo;
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
    map['treatmentId'] = treatmentId;
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
    return map;
  }

}