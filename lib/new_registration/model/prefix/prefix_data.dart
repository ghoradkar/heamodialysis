class PrefixData {
  PrefixData({
      this.unitId, 
      this.deleteStatus, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy, 
      this.createDate, 
      this.updatedDate, 
      this.deletedDate, 
      this.ptid, 
      this.title, 
      this.gender, 
      this.plist,});

  PrefixData.fromJson(dynamic json) {
    unitId = json['unitId'];
    deleteStatus = json['deleteStatus'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    createDate = json['createDate'];
    updatedDate = json['updatedDate'];
    deletedDate = json['deletedDate'];
    ptid = json['ptid'];
    title = json['title'];
    gender = json['gender'];
    plist = json['plist'];
  }
  int? unitId;
  String? deleteStatus;
  int? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createDate;
  String? updatedDate;
  dynamic deletedDate;
  int? ptid;
  String? title;
  String? gender;
  dynamic plist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitId'] = unitId;
    map['deleteStatus'] = deleteStatus;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedBy'] = deletedBy;
    map['createDate'] = createDate;
    map['updatedDate'] = updatedDate;
    map['deletedDate'] = deletedDate;
    map['ptid'] = ptid;
    map['title'] = title;
    map['gender'] = gender;
    map['plist'] = plist;
    return map;
  }

}