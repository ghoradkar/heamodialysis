class UnitMasterDto {
  UnitMasterDto({
      this.unitId, 
      this.unitName, 
      this.unitCode, 
      this.stateId, 
      this.stateName, 
      this.districtId, 
      this.districtName, 
      this.typeId, 
      this.typeName, 
      this.hospitalId, 
      this.hospitalName, 
      this.yearId, 
      this.year, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy, 
      this.deleted, 
      this.createdDate, 
      this.updatedDate, 
      this.deletedDate, 
      this.activeFlag, 
      this.lstUnit, 
      this.lstDepts, 
      this.listService, 
      this.divisionName, 
      this.divisionId, 
      this.talukaName, 
      this.talukaId, 
      this.longitude, 
      this.latitude, 
      this.unitAddress,});

  UnitMasterDto.fromJson(dynamic json) {
    unitId = json['unitId'];
    unitName = json['unitName'];
    unitCode = json['unitCode'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    typeId = json['typeId'];
    typeName = json['typeName'];
    hospitalId = json['hospitalId'];
    hospitalName = json['hospitalName'];
    yearId = json['yearId'];
    year = json['year'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    deleted = json['deleted'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedDate = json['deletedDate'];
    activeFlag = json['activeFlag'];
    lstUnit = json['lstUnit'];
    lstDepts = json['lstDepts'];
    listService = json['listService'];
    divisionName = json['divisionName'];
    divisionId = json['divisionId'];
    talukaName = json['talukaName'];
    talukaId = json['talukaId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    unitAddress = json['unitAddress'];
  }
  int? unitId;
  String? unitName;
  String? unitCode;
  int? stateId;
  String? stateName;
  int? districtId;
  String? districtName;
  int? typeId;
  String? typeName;
  dynamic hospitalId;
  dynamic hospitalName;
  dynamic yearId;
  dynamic year;
  int? createdBy;
  int? updatedBy;
  dynamic deletedBy;
  String? deleted;
  String? createdDate;
  String? updatedDate;
  dynamic deletedDate;
  String? activeFlag;
  dynamic lstUnit;
  dynamic lstDepts;
  dynamic listService;
  dynamic divisionName;
  dynamic divisionId;
  dynamic talukaName;
  dynamic talukaId;
  double? longitude;
  double? latitude;
  String? unitAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitId'] = unitId;
    map['unitName'] = unitName;
    map['unitCode'] = unitCode;
    map['stateId'] = stateId;
    map['stateName'] = stateName;
    map['districtId'] = districtId;
    map['districtName'] = districtName;
    map['typeId'] = typeId;
    map['typeName'] = typeName;
    map['hospitalId'] = hospitalId;
    map['hospitalName'] = hospitalName;
    map['yearId'] = yearId;
    map['year'] = year;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedBy'] = deletedBy;
    map['deleted'] = deleted;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deletedDate'] = deletedDate;
    map['activeFlag'] = activeFlag;
    map['lstUnit'] = lstUnit;
    map['lstDepts'] = lstDepts;
    map['listService'] = listService;
    map['divisionName'] = divisionName;
    map['divisionId'] = divisionId;
    map['talukaName'] = talukaName;
    map['talukaId'] = talukaId;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['unitAddress'] = unitAddress;
    return map;
  }

}