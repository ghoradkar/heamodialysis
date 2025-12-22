class DietListModel {
  DietListModel({
      this.dietMasterId, 
      this.templateId, 
      this.specializationId, 
      this.templateName, 
      this.templateData, 
      this.fromDate, 
      this.toDate, 
      this.createdDateTime, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.deleted, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedDateTime, 
      this.unitId, 
      this.userId, 
      this.getListOfOPDDietDTO, 
      this.treatObj, 
      this.patientObj, 
      this.patientId, 
      this.treatmentId, 
      this.userName,});

  DietListModel.fromJson(dynamic json) {
    dietMasterId = json['dietMasterId'];
    templateId = json['templateId'];
    specializationId = json['specializationId'];
    templateName = json['templateName'];
    templateData = json['templateData'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    createdDateTime = json['createdDateTime'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedDateTime = json['deletedDateTime'];
    unitId = json['unitId'];
    userId = json['userId'];
    if (json['getListOfOPDDietDTO'] != null) {
      getListOfOPDDietDTO = [];
      json['getListOfOPDDietDTO'].forEach((v) {
        getListOfOPDDietDTO?.add(GetListOfOpdDietDto.fromJson(v));
      });
    }
    treatObj = json['treatObj'];
    patientObj = json['patientObj'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    userName = json['userName'];
  }
  int? dietMasterId;
  int? templateId;
  int? specializationId;
  String? templateName;
  dynamic templateData;
  String? fromDate;
  String? toDate;
  dynamic createdDateTime;
  dynamic updatedDateTime;
  dynamic deletedBy;
  String? deleted;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedDateTime;
  int? unitId;
  int? userId;
  List<GetListOfOpdDietDto>? getListOfOPDDietDTO;
  dynamic treatObj;
  dynamic patientObj;
  dynamic patientId;
  dynamic treatmentId;
  dynamic userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dietMasterId'] = dietMasterId;
    map['templateId'] = templateId;
    map['specializationId'] = specializationId;
    map['templateName'] = templateName;
    map['templateData'] = templateData;
    map['fromDate'] = fromDate;
    map['toDate'] = toDate;
    map['createdDateTime'] = createdDateTime;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['deleted'] = deleted;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedDateTime'] = deletedDateTime;
    map['unitId'] = unitId;
    map['userId'] = userId;
    if (getListOfOPDDietDTO != null) {
      map['getListOfOPDDietDTO'] = getListOfOPDDietDTO?.map((v) => v.toJson()).toList();
    }
    map['treatObj'] = treatObj;
    map['patientObj'] = patientObj;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['userName'] = userName;
    return map;
  }

}

class GetListOfOpdDietDto {
  GetListOfOpdDietDto({
      this.dietMasterId, 
      this.templateId, 
      this.specializationId, 
      this.templateName, 
      this.templateData, 
      this.fromDate, 
      this.toDate, 
      this.createdDateTime, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.deleted, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedDateTime, 
      this.unitId, 
      this.userId, 
      this.getListOfOPDDietDTO, 
      this.treatObj, 
      this.patientObj, 
      this.patientId, 
      this.treatmentId, 
      this.userName,});

  GetListOfOpdDietDto.fromJson(dynamic json) {
    dietMasterId = json['dietMasterId'];
    templateId = json['templateId'];
    specializationId = json['specializationId'];
    templateName = json['templateName'];
    templateData = json['templateData'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    createdDateTime = json['createdDateTime'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedDateTime = json['deletedDateTime'];
    unitId = json['unitId'];
    userId = json['userId'];
    getListOfOPDDietDTO = json['getListOfOPDDietDTO'];
    treatObj = json['treatObj'];
    patientObj = json['patientObj'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    userName = json['userName'];
  }
  int? dietMasterId;
  int? templateId;
  int? specializationId;
  String? templateName;
  dynamic templateData;
  String? fromDate;
  String? toDate;
  dynamic createdDateTime;
  dynamic updatedDateTime;
  dynamic deletedBy;
  String? deleted;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedDateTime;
  int? unitId;
  int? userId;
  dynamic getListOfOPDDietDTO;
  dynamic treatObj;
  dynamic patientObj;
  dynamic patientId;
  dynamic treatmentId;
  String? userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dietMasterId'] = dietMasterId;
    map['templateId'] = templateId;
    map['specializationId'] = specializationId;
    map['templateName'] = templateName;
    map['templateData'] = templateData;
    map['fromDate'] = fromDate;
    map['toDate'] = toDate;
    map['createdDateTime'] = createdDateTime;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['deleted'] = deleted;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedDateTime'] = deletedDateTime;
    map['unitId'] = unitId;
    map['userId'] = userId;
    map['getListOfOPDDietDTO'] = getListOfOPDDietDTO;
    map['treatObj'] = treatObj;
    map['patientObj'] = patientObj;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['userName'] = userName;
    return map;
  }

}