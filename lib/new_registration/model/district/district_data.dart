class DistrictData {
  DistrictData({
      this.districtID, 
      this.stateID, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deletedBy, 
      this.unitId, 
      this.districtName, 
      this.status, 
      this.divID, 
      this.stateName, 
      this.divisionName,});

  DistrictData.fromJson(dynamic json) {
    districtID = json['district_ID'];
    stateID = json['state_ID'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    districtName = json['districtName'];
    status = json['status'];
    divID = json['divID'];
    stateName = json['stateName'];
    divisionName = json['divisionName'];
  }
  int? districtID;
  int? stateID;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  dynamic deletedBy;
  dynamic unitId;
  String? districtName;
  String? status;
  dynamic divID;
  dynamic stateName;
  dynamic divisionName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['district_ID'] = districtID;
    map['state_ID'] = stateID;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deletedBy'] = deletedBy;
    map['unitId'] = unitId;
    map['districtName'] = districtName;
    map['status'] = status;
    map['divID'] = divID;
    map['stateName'] = stateName;
    map['divisionName'] = divisionName;
    return map;
  }

}