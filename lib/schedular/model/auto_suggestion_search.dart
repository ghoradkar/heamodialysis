class AutoSuggestionSearch {
  AutoSuggestionSearch({
      this.searchParam, 
      this.count, 
      this.patientId, 
      this.mobile, 
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
      this.blockUserId1, 
      this.blockUserId2, 
      this.blockUserId3, 
      this.relationId, 
      this.pertalukaId, 
      this.pertownId, 
      this.perdistrictId, 
      this.perstateId, 
      this.percountryId, 
      this.perareaCode, 
      this.maritalStatusId, 
      this.nationalityId, 
      this.religionId, 
      this.languageId, 
      this.bloodGroupId, 
      this.identityProofId, 
      this.annualIncomeId, 
      this.abhaNo, 
      this.patientApId, 
      this.treatmentId,});

  AutoSuggestionSearch.fromJson(dynamic json) {
    searchParam = json['searchParam'];
    count = json['count'];
    patientId = json['patientId'];
    mobile = json['mobile'];
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
    blockUserId1 = json['blockUserId1'];
    blockUserId2 = json['blockUserId2'];
    blockUserId3 = json['blockUserId3'];
    relationId = json['relationId'];
    pertalukaId = json['pertalukaId'];
    pertownId = json['pertownId'];
    perdistrictId = json['perdistrictId'];
    perstateId = json['perstateId'];
    percountryId = json['percountryId'];
    perareaCode = json['perareaCode'];
    maritalStatusId = json['maritalStatusId'];
    nationalityId = json['nationalityId'];
    religionId = json['religionId'];
    languageId = json['languageId'];
    bloodGroupId = json['bloodGroupId'];
    identityProofId = json['identityProofId'];
    annualIncomeId = json['annualIncomeId'];
    abhaNo = json['abhaNo'];
    patientApId = json['patientApId'];
    treatmentId = json['treatmentId'];
  }
  String? searchParam;
  int? count;
  int? patientId;
  String? mobile;
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
  int? blockUserId1;
  int? blockUserId2;
  int? blockUserId3;
  int? relationId;
  int? pertalukaId;
  int? pertownId;
  int? perdistrictId;
  int? perstateId;
  int? percountryId;
  int? perareaCode;
  int? maritalStatusId;
  int? nationalityId;
  int? religionId;
  int? languageId;
  int? bloodGroupId;
  int? identityProofId;
  int? annualIncomeId;
  String? abhaNo;
  int? patientApId;
  int? treatmentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['searchParam'] = searchParam;
    map['count'] = count;
    map['patientId'] = patientId;
    map['mobile'] = mobile;
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
    map['blockUserId1'] = blockUserId1;
    map['blockUserId2'] = blockUserId2;
    map['blockUserId3'] = blockUserId3;
    map['relationId'] = relationId;
    map['pertalukaId'] = pertalukaId;
    map['pertownId'] = pertownId;
    map['perdistrictId'] = perdistrictId;
    map['perstateId'] = perstateId;
    map['percountryId'] = percountryId;
    map['perareaCode'] = perareaCode;
    map['maritalStatusId'] = maritalStatusId;
    map['nationalityId'] = nationalityId;
    map['religionId'] = religionId;
    map['languageId'] = languageId;
    map['bloodGroupId'] = bloodGroupId;
    map['identityProofId'] = identityProofId;
    map['annualIncomeId'] = annualIncomeId;
    map['abhaNo'] = abhaNo;
    map['patientApId'] = patientApId;
    map['treatmentId'] = treatmentId;
    return map;
  }

}