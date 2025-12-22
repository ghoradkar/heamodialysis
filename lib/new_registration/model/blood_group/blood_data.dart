class BloodData {
  BloodData({
      this.bloodGroupId, 
      this.bloodGrouptName, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deletedDate, 
      this.deletedBy, 
      this.unitId, 
      this.status, 
      this.ipAddress, 
      this.lstBloodGroupMaster,});

  BloodData.fromJson(dynamic json) {
    bloodGroupId = json['bloodGroupId'];
    bloodGrouptName = json['bloodGrouptName'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    status = json['status'];
    ipAddress = json['ipAddress'];
    lstBloodGroupMaster = json['lstBloodGroupMaster'];
  }
  int? bloodGroupId;
  String? bloodGrouptName;
  int? createdBy;
  int? updatedBy;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  dynamic deletedBy;
  int? unitId;
  String? status;
  String? ipAddress;
  dynamic lstBloodGroupMaster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bloodGroupId'] = bloodGroupId;
    map['bloodGrouptName'] = bloodGrouptName;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deletedDate'] = deletedDate;
    map['deletedBy'] = deletedBy;
    map['unitId'] = unitId;
    map['status'] = status;
    map['ipAddress'] = ipAddress;
    map['lstBloodGroupMaster'] = lstBloodGroupMaster;
    return map;
  }

}