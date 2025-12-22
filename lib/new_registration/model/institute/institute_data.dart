class InstituteDataModel {
  InstituteDataModel({
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
      this.divisionName, 
      this.divisionId, 
      this.talukaName, 
      this.talukaId, 
      this.longitude, 
      this.latitude, 
      this.unitAddress, 
      this.zipCode, 
      this.unitEmail, 
      this.contactNo, 
      this.filePath, 
      this.idHospital,});

  InstituteDataModel.fromJson(dynamic json) {
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
    divisionName = json['divisionName'];
    divisionId = json['divisionId'];
    talukaName = json['talukaName'];
    talukaId = json['talukaId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    unitAddress = json['unitAddress'];
    zipCode = json['zipCode'];
    unitEmail = json['unitEmail'];
    contactNo = json['contactNo'];
    filePath = json['filePath'];
    idHospital = json['idHospital'];
  }
  int? unitId;
  String? unitName;
  dynamic unitCode;
  dynamic stateId;
  dynamic stateName;
  dynamic districtId;
  dynamic districtName;
  dynamic typeId;
  dynamic typeName;
  dynamic hospitalId;
  dynamic hospitalName;
  dynamic yearId;
  dynamic year;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? deleted;
  dynamic createdDate;
  dynamic updatedDate;
  dynamic deletedDate;
  String? activeFlag;
  dynamic divisionName;
  dynamic divisionId;
  dynamic talukaName;
  dynamic talukaId;
  dynamic longitude;
  dynamic latitude;
  dynamic unitAddress;
  dynamic zipCode;
  dynamic unitEmail;
  dynamic contactNo;
  dynamic filePath;
  dynamic idHospital;

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
    map['divisionName'] = divisionName;
    map['divisionId'] = divisionId;
    map['talukaName'] = talukaName;
    map['talukaId'] = talukaId;
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['unitAddress'] = unitAddress;
    map['zipCode'] = zipCode;
    map['unitEmail'] = unitEmail;
    map['contactNo'] = contactNo;
    map['filePath'] = filePath;
    map['idHospital'] = idHospital;
    return map;
  }

}