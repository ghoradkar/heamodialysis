class UploadedDocumentNephro {
  UploadedDocumentNephro({
      this.documentId, 
      this.doctorDeskFile, 
      this.remark, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deletedDate, 
      this.deletedBy, 
      this.unitId, 
      this.deleted, 
      this.treatmentDto, 
      this.patientRegistered, 
      this.lstDoctorDeskDocumentUploadDto, 
      this.userId,});

  UploadedDocumentNephro.fromJson(dynamic json) {
    documentId = json['documentId'];
    doctorDeskFile = json['doctorDeskFile'];
    remark = json['remark'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    treatmentDto = json['treatmentDto'];
    patientRegistered = json['patientRegistered'];
    lstDoctorDeskDocumentUploadDto = json['lstDoctorDeskDocumentUploadDto'];
    userId = json['userId'];
  }
  int? documentId;
  dynamic doctorDeskFile;
  String? remark;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  dynamic deletedDate;
  dynamic deletedBy;
  dynamic unitId;
  String? deleted;
  dynamic treatmentDto;
  dynamic patientRegistered;
  dynamic lstDoctorDeskDocumentUploadDto;
  dynamic userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['documentId'] = documentId;
    map['doctorDeskFile'] = doctorDeskFile;
    map['remark'] = remark;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deletedDate'] = deletedDate;
    map['deletedBy'] = deletedBy;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['treatmentDto'] = treatmentDto;
    map['patientRegistered'] = patientRegistered;
    map['lstDoctorDeskDocumentUploadDto'] = lstDoctorDeskDocumentUploadDto;
    map['userId'] = userId;
    return map;
  }

}