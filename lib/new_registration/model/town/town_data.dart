class TownData {
  TownData({
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deletedBy, 
      this.unitId, 
      this.status, 
      this.talukaID, 
      this.districtID, 
      this.stateID, 
      this.divisionId, 
      this.stateName, 
      this.divisionName, 
      this.districtName, 
      this.talukaName, 
      this.cityId, 
      this.cityName, 
      this.cityList,});

  TownData.fromJson(dynamic json) {
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    status = json['status'];
    talukaID = json['taluka_ID'];
    districtID = json['district_ID'];
    stateID = json['state_ID'];
    divisionId = json['divisionId'];
    stateName = json['stateName'];
    divisionName = json['divisionName'];
    districtName = json['districtName'];
    talukaName = json['talukaName'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    cityList = json['cityList'];
  }
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  dynamic deletedBy;
  dynamic unitId;
  String? status;
  int? talukaID;
  int? districtID;
  int? stateID;
  dynamic divisionId;
  dynamic stateName;
  dynamic divisionName;
  dynamic districtName;
  dynamic talukaName;
  int? cityId;
  String? cityName;
  dynamic cityList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deletedBy'] = deletedBy;
    map['unitId'] = unitId;
    map['status'] = status;
    map['taluka_ID'] = talukaID;
    map['district_ID'] = districtID;
    map['state_ID'] = stateID;
    map['divisionId'] = divisionId;
    map['stateName'] = stateName;
    map['divisionName'] = divisionName;
    map['districtName'] = districtName;
    map['talukaName'] = talukaName;
    map['city_id'] = cityId;
    map['city_name'] = cityName;
    map['cityList'] = cityList;
    return map;
  }

}