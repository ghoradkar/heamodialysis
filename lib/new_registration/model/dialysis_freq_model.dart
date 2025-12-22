class DialysisFreqModel {
  DialysisFreqModel({
      this.centerPatientId, 
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
      this.count, 
      this.maritalStatusList, 
      this.idProofList, 
      this.relationList, 
      this.dialysisModeList, 
      this.haemodialysisProcedureTypeList, 
      this.ptientTypeList, 
      this.referredByList, 
      this.townList, 
      this.stateList, 
      this.devisionList, 
      this.districtList, 
      this.documentChecklistList, 
      this.dialysisFrequency,});

  DialysisFreqModel.fromJson(dynamic json) {
    centerPatientId = json['centerPatientId'];
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
    count = json['count'];
    if (json['maritalStatusList'] != null) {
      maritalStatusList = [];
      json['maritalStatusList'].forEach((v) {
        maritalStatusList?.add(MaritalStatusList.fromJson(v));
      });
    }
    if (json['idProofList'] != null) {
      idProofList = [];
      json['idProofList'].forEach((v) {
        idProofList?.add(IdProofList.fromJson(v));
      });
    }
    if (json['relationList'] != null) {
      relationList = [];
      json['relationList'].forEach((v) {
        relationList?.add(RelationList.fromJson(v));
      });
    }
    if (json['dialysisModeList'] != null) {
      dialysisModeList = [];
      json['dialysisModeList'].forEach((v) {
        dialysisModeList?.add(DialysisModeList.fromJson(v));
      });
    }
    if (json['haemodialysisProcedureTypeList'] != null) {
      haemodialysisProcedureTypeList = [];
      json['haemodialysisProcedureTypeList'].forEach((v) {
        haemodialysisProcedureTypeList?.add(HaemodialysisProcedureTypeList.fromJson(v));
      });
    }
    if (json['ptientTypeList'] != null) {
      ptientTypeList = [];
      json['ptientTypeList'].forEach((v) {
        ptientTypeList?.add(PtientTypeList.fromJson(v));
      });
    }
    if (json['referredByList'] != null) {
      referredByList = [];
      json['referredByList'].forEach((v) {
        referredByList?.add(ReferredByList.fromJson(v));
      });
    }
    if (json['townList'] != null) {
      townList = [];
      json['townList'].forEach((v) {
        townList?.add(TownList.fromJson(v));
      });
    }
    if (json['stateList'] != null) {
      stateList = [];
      json['stateList'].forEach((v) {
        stateList?.add(StateList.fromJson(v));
      });
    }
    if (json['devisionList'] != null) {
      devisionList = [];
      json['devisionList'].forEach((v) {
        devisionList?.add(DevisionList.fromJson(v));
      });
    }
    if (json['districtList'] != null) {
      districtList = [];
      json['districtList'].forEach((v) {
        districtList?.add(DistrictList.fromJson(v));
      });
    }
    if (json['documentChecklistList'] != null) {
      documentChecklistList = [];
      json['documentChecklistList'].forEach((v) {
        documentChecklistList?.add(DocumentChecklistList.fromJson(v));
      });
    }
    if (json['dialysisFrequency'] != null) {
      dialysisFrequency = [];
      json['dialysisFrequency'].forEach((v) {
        dialysisFrequency?.add(DialysisFrequency.fromJson(v));
      });
    }
  }
  String? centerPatientId;
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
  int? count;
  List<MaritalStatusList>? maritalStatusList;
  List<IdProofList>? idProofList;
  List<RelationList>? relationList;
  List<DialysisModeList>? dialysisModeList;
  List<HaemodialysisProcedureTypeList>? haemodialysisProcedureTypeList;
  List<PtientTypeList>? ptientTypeList;
  List<ReferredByList>? referredByList;
  List<TownList>? townList;
  List<StateList>? stateList;
  List<DevisionList>? devisionList;
  List<DistrictList>? districtList;
  List<DocumentChecklistList>? documentChecklistList;
  List<DialysisFrequency>? dialysisFrequency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['centerPatientId'] = centerPatientId;
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
    map['count'] = count;
    if (maritalStatusList != null) {
      map['maritalStatusList'] = maritalStatusList?.map((v) => v.toJson()).toList();
    }
    if (idProofList != null) {
      map['idProofList'] = idProofList?.map((v) => v.toJson()).toList();
    }
    if (relationList != null) {
      map['relationList'] = relationList?.map((v) => v.toJson()).toList();
    }
    if (dialysisModeList != null) {
      map['dialysisModeList'] = dialysisModeList?.map((v) => v.toJson()).toList();
    }
    if (haemodialysisProcedureTypeList != null) {
      map['haemodialysisProcedureTypeList'] = haemodialysisProcedureTypeList?.map((v) => v.toJson()).toList();
    }
    if (ptientTypeList != null) {
      map['ptientTypeList'] = ptientTypeList?.map((v) => v.toJson()).toList();
    }
    if (referredByList != null) {
      map['referredByList'] = referredByList?.map((v) => v.toJson()).toList();
    }
    if (townList != null) {
      map['townList'] = townList?.map((v) => v.toJson()).toList();
    }
    if (stateList != null) {
      map['stateList'] = stateList?.map((v) => v.toJson()).toList();
    }
    if (devisionList != null) {
      map['devisionList'] = devisionList?.map((v) => v.toJson()).toList();
    }
    if (districtList != null) {
      map['districtList'] = districtList?.map((v) => v.toJson()).toList();
    }
    if (documentChecklistList != null) {
      map['documentChecklistList'] = documentChecklistList?.map((v) => v.toJson()).toList();
    }
    if (dialysisFrequency != null) {
      map['dialysisFrequency'] = dialysisFrequency?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class DialysisFrequency {
  DialysisFrequency({
      this.lookupId, 
      this.lookupDescEn, 
      this.lookupValue,});

  DialysisFrequency.fromJson(dynamic json) {
    lookupId = json['lookupId'];
    lookupDescEn = json['lookupDescEn'];
    lookupValue = json['lookupValue'];
  }
  int? lookupId;
  String? lookupDescEn;
  String? lookupValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupId'] = lookupId;
    map['lookupDescEn'] = lookupDescEn;
    map['lookupValue'] = lookupValue;
    return map;
  }

}

class DocumentChecklistList {
  DocumentChecklistList({
      this.docId, 
      this.docDescdetEn, 
      this.requiredFlag,});

  DocumentChecklistList.fromJson(dynamic json) {
    docId = json['docId'];
    docDescdetEn = json['docDescdetEn'];
    requiredFlag = json['requiredFlag'];
  }
  int? docId;
  String? docDescdetEn;
  String? requiredFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['docId'] = docId;
    map['docDescdetEn'] = docDescdetEn;
    map['requiredFlag'] = requiredFlag;
    return map;
  }

}

class DistrictList {
  DistrictList({
      this.districtID, 
      this.stateID, 
      this.districtName, 
      this.status,});

  DistrictList.fromJson(dynamic json) {
    districtID = json['district_ID'];
    stateID = json['state_ID'];
    districtName = json['districtName'];
    status = json['status'];
  }
  int? districtID;
  int? stateID;
  String? districtName;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['district_ID'] = districtID;
    map['state_ID'] = stateID;
    map['districtName'] = districtName;
    map['status'] = status;
    return map;
  }

}

class DevisionList {
  DevisionList({
      this.divId, 
      this.divName,});

  DevisionList.fromJson(dynamic json) {
    divId = json['divId'];
    divName = json['divName'];
  }
  int? divId;
  String? divName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['divId'] = divId;
    map['divName'] = divName;
    return map;
  }

}

class StateList {
  StateList({
      this.stateID, 
      this.stateName, 
      this.status,});

  StateList.fromJson(dynamic json) {
    stateID = json['state_ID'];
    stateName = json['stateName'];
    status = json['status'];
  }
  int? stateID;
  String? stateName;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state_ID'] = stateID;
    map['stateName'] = stateName;
    map['status'] = status;
    return map;
  }

}

class TownList {
  TownList({
      this.cityID, 
      this.status, 
      this.talukaID, 
      this.districtID, 
      this.stateID, 
      this.cityName,});

  TownList.fromJson(dynamic json) {
    cityID = json['city_ID'];
    status = json['status'];
    talukaID = json['taluka_ID'];
    districtID = json['district_ID'];
    stateID = json['state_ID'];
    cityName = json['cityName'];
  }
  int? cityID;
  String? status;
  int? talukaID;
  int? districtID;
  int? stateID;
  String? cityName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city_ID'] = cityID;
    map['status'] = status;
    map['taluka_ID'] = talukaID;
    map['district_ID'] = districtID;
    map['state_ID'] = stateID;
    map['cityName'] = cityName;
    return map;
  }

}

class ReferredByList {
  ReferredByList({
      this.lookupId, 
      this.lookupDescEn, 
      this.lookupValue,});

  ReferredByList.fromJson(dynamic json) {
    lookupId = json['lookupId'];
    lookupDescEn = json['lookupDescEn'];
    lookupValue = json['lookupValue'];
  }
  int? lookupId;
  String? lookupDescEn;
  String? lookupValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupId'] = lookupId;
    map['lookupDescEn'] = lookupDescEn;
    map['lookupValue'] = lookupValue;
    return map;
  }

}

class PtientTypeList {
  PtientTypeList({
      this.lookupId, 
      this.lookupDescEn, 
      this.lookupValue,});

  PtientTypeList.fromJson(dynamic json) {
    lookupId = json['lookupId'];
    lookupDescEn = json['lookupDescEn'];
    lookupValue = json['lookupValue'];
  }
  int? lookupId;
  String? lookupDescEn;
  String? lookupValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupId'] = lookupId;
    map['lookupDescEn'] = lookupDescEn;
    map['lookupValue'] = lookupValue;
    return map;
  }

}

class HaemodialysisProcedureTypeList {
  HaemodialysisProcedureTypeList({
      this.lookupId, 
      this.lookupDescEn, 
      this.lookupValue,});

  HaemodialysisProcedureTypeList.fromJson(dynamic json) {
    lookupId = json['lookupId'];
    lookupDescEn = json['lookupDescEn'];
    lookupValue = json['lookupValue'];
  }
  int? lookupId;
  String? lookupDescEn;
  String? lookupValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupId'] = lookupId;
    map['lookupDescEn'] = lookupDescEn;
    map['lookupValue'] = lookupValue;
    return map;
  }

}

class DialysisModeList {
  DialysisModeList({
      this.lookupId, 
      this.lookupDescEn, 
      this.lookupValue,});

  DialysisModeList.fromJson(dynamic json) {
    lookupId = json['lookupId'];
    lookupDescEn = json['lookupDescEn'];
    lookupValue = json['lookupValue'];
  }
  int? lookupId;
  String? lookupDescEn;
  String? lookupValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupId'] = lookupId;
    map['lookupDescEn'] = lookupDescEn;
    map['lookupValue'] = lookupValue;
    return map;
  }

}

class RelationList {
  RelationList({
      this.lookupId, 
      this.lookupDescEn, 
      this.lookupValue,});

  RelationList.fromJson(dynamic json) {
    lookupId = json['lookupId'];
    lookupDescEn = json['lookupDescEn'];
    lookupValue = json['lookupValue'];
  }
  int? lookupId;
  String? lookupDescEn;
  String? lookupValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupId'] = lookupId;
    map['lookupDescEn'] = lookupDescEn;
    map['lookupValue'] = lookupValue;
    return map;
  }

}

class IdProofList {
  IdProofList({
      this.lookupId, 
      this.lookupDescEn, 
      this.lookupValue,});

  IdProofList.fromJson(dynamic json) {
    lookupId = json['lookupId'];
    lookupDescEn = json['lookupDescEn'];
    lookupValue = json['lookupValue'];
  }
  int? lookupId;
  String? lookupDescEn;
  String? lookupValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupId'] = lookupId;
    map['lookupDescEn'] = lookupDescEn;
    map['lookupValue'] = lookupValue;
    return map;
  }

}

class MaritalStatusList {
  MaritalStatusList({
      this.lookupId, 
      this.lookupDescEn, 
      this.lookupValue,});

  MaritalStatusList.fromJson(dynamic json) {
    lookupId = json['lookupId'];
    lookupDescEn = json['lookupDescEn'];
    lookupValue = json['lookupValue'];
  }
  int? lookupId;
  String? lookupDescEn;
  String? lookupValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupId'] = lookupId;
    map['lookupDescEn'] = lookupDescEn;
    map['lookupValue'] = lookupValue;
    return map;
  }

}