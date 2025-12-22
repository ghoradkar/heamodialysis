class CapturedPhotoData {
  CapturedPhotoData({
      this.id, 
      this.patientId, 
      this.documentName, 
      this.filePath, 
      this.deleted, 
      this.createdBy, 
      this.createdDateTime, 
      this.updatedBy, 
      this.updatedDateTime, 
      this.unitId,});

  CapturedPhotoData.fromJson(dynamic json) {
    id = json['id'];
    patientId = json['patientId'];
    documentName = json['documentName'];
    filePath = json['filePath'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    unitId = json['unitId'];
  }
  int? id;
  dynamic patientId;
  dynamic documentName;
  String? filePath;
  dynamic deleted;
  dynamic createdBy;
  dynamic createdDateTime;
  dynamic updatedBy;
  dynamic updatedDateTime;
  dynamic unitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['patientId'] = patientId;
    map['documentName'] = documentName;
    map['filePath'] = filePath;
    map['deleted'] = deleted;
    map['createdBy'] = createdBy;
    map['createdDateTime'] = createdDateTime;
    map['updatedBy'] = updatedBy;
    map['updatedDateTime'] = updatedDateTime;
    map['unitId'] = unitId;
    return map;
  }

}