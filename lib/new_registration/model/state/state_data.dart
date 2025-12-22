class StateData {
  StateData({
      this.stateID, 
      this.stateName, 
      this.status, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deletedBy, 
      this.unitId,});

  StateData.fromJson(dynamic json) {
    stateID = json['state_ID'];
    stateName = json['stateName'];
    status = json['status'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
  }
  int? stateID;
  String? stateName;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  dynamic deletedBy;
  dynamic unitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state_ID'] = stateID;
    map['stateName'] = stateName;
    map['status'] = status;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deletedBy'] = deletedBy;
    map['unitId'] = unitId;
    return map;
  }

}