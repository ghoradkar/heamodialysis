class Data {
  Data({
      this.talukaID, 
      this.districtID, 
      this.divID, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deletedBy, 
      this.unitId, 
      this.talukaName, 
      this.status, 
      this.stateID, 
      this.districtName, 
      this.stateName, 
      this.cityName, 
      this.divisionName, 
      this.cityId,});

  Data.fromJson(dynamic json) {
    talukaID = json['taluka_ID'];
    districtID = json['district_ID'];
    divID = json['div_ID'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    talukaName = json['talukaName'];
    status = json['status'];
    stateID = json['state_ID'];
    districtName = json['districtName'];
    stateName = json['stateName'];
    cityName = json['cityName'];
    divisionName = json['divisionName'];
    cityId = json['city_id'];
  }
  int? talukaID;
  int? districtID;
  int? divID;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  dynamic deletedBy;
  dynamic unitId;
  dynamic talukaName;
  String? status;
  int? stateID;
  dynamic districtName;
  dynamic stateName;
  dynamic cityName;
  dynamic divisionName;
  int? cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['taluka_ID'] = talukaID;
    map['district_ID'] = districtID;
    map['div_ID'] = divID;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deletedBy'] = deletedBy;
    map['unitId'] = unitId;
    map['talukaName'] = talukaName;
    map['status'] = status;
    map['state_ID'] = stateID;
    map['districtName'] = districtName;
    map['stateName'] = stateName;
    map['cityName'] = cityName;
    map['divisionName'] = divisionName;
    map['city_id'] = cityId;
    return map;
  }

}