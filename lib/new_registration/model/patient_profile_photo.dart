

class PatientProfilePhoto {
  PatientProfilePhoto({
      this.code, 
      this.status, 
      this.data,});

  PatientProfilePhoto.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProfilePhotoData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<ProfilePhotoData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



class ProfilePhotoData {
  ProfilePhotoData({
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

  ProfilePhotoData.fromJson(dynamic json) {
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