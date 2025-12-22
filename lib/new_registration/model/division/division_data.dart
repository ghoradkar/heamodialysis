class DivisionData {
  DivisionData({
      this.divId, 
      this.divName, 
      this.stateId, 
      this.unitId, 
      this.status, 
      this.createdBy, 
      this.createdDate, 
      this.deletedBy, 
      this.updatedBy, 
      this.updatedDate, 
      this.stateName,});

  DivisionData.fromJson(dynamic json) {
    divId = json['divId'];
    divName = json['divName'];
    stateId = json['stateId'];
    unitId = json['unitId'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    deletedBy = json['deletedBy'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    stateName = json['stateName'];
  }
  int? divId;
  String? divName;
  dynamic stateId;
  dynamic unitId;
  dynamic status;
  dynamic createdBy;
  dynamic createdDate;
  dynamic deletedBy;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic stateName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['divId'] = divId;
    map['divName'] = divName;
    map['stateId'] = stateId;
    map['unitId'] = unitId;
    map['status'] = status;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['deletedBy'] = deletedBy;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['stateName'] = stateName;
    return map;
  }

}