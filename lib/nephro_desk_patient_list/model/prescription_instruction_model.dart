class PrescriptionInstructionModel {
  PrescriptionInstructionModel({
      this.id, 
      this.englishInstruction, 
      this.hindiInstruction, 
      this.marathiInstruction, 
      this.unicode, 
      this.referTo, 
      this.createdDateTime, 
      this.createdBy, 
      this.unitId, 
      this.updatedBy, 
      this.deletedBy, 
      this.deleted, 
      this.unicodeHindi, 
      this.listPrescriptionInstructionDto,});

  PrescriptionInstructionModel.fromJson(dynamic json) {
    id = json['id'];
    englishInstruction = json['englishInstruction'];
    hindiInstruction = json['hindiInstruction'];
    marathiInstruction = json['marathiInstruction'];
    unicode = json['unicode'];
    referTo = json['referTo'];
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    unitId = json['unitId'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deleted_by'];
    deleted = json['deleted'];
    unicodeHindi = json['unicodeHindi'];
    if (json['listPrescriptionInstructionDto'] != null) {
      listPrescriptionInstructionDto = [];
      json['listPrescriptionInstructionDto'].forEach((v) {
        listPrescriptionInstructionDto?.add(ListPrescriptionInstructionDto.fromJson(v));
      });
    }
  }
  int? id;
  dynamic englishInstruction;
  dynamic hindiInstruction;
  dynamic marathiInstruction;
  dynamic unicode;
  dynamic referTo;
  dynamic createdDateTime;
  dynamic createdBy;
  int? unitId;
  int? updatedBy;
  int? deletedBy;
  String? deleted;
  dynamic unicodeHindi;
  List<ListPrescriptionInstructionDto>? listPrescriptionInstructionDto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['englishInstruction'] = englishInstruction;
    map['hindiInstruction'] = hindiInstruction;
    map['marathiInstruction'] = marathiInstruction;
    map['unicode'] = unicode;
    map['referTo'] = referTo;
    map['createdDateTime'] = createdDateTime;
    map['createdBy'] = createdBy;
    map['unitId'] = unitId;
    map['updatedBy'] = updatedBy;
    map['deleted_by'] = deletedBy;
    map['deleted'] = deleted;
    map['unicodeHindi'] = unicodeHindi;
    if (listPrescriptionInstructionDto != null) {
      map['listPrescriptionInstructionDto'] = listPrescriptionInstructionDto?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ListPrescriptionInstructionDto {
  ListPrescriptionInstructionDto({
      this.id, 
      this.englishInstruction, 
      this.hindiInstruction, 
      this.marathiInstruction, 
      this.unicode, 
      this.referTo, 
      this.createdDateTime, 
      this.createdBy, 
      this.unitId, 
      this.updatedBy, 
      this.deletedBy, 
      this.deleted, 
      this.unicodeHindi, 
      this.listPrescriptionInstructionDto,});

  ListPrescriptionInstructionDto.fromJson(dynamic json) {
    id = json['id'];
    englishInstruction = json['englishInstruction'];
    hindiInstruction = json['hindiInstruction'];
    marathiInstruction = json['marathiInstruction'];
    unicode = json['unicode'];
    referTo = json['referTo'];
    createdDateTime = json['createdDateTime'];
    createdBy = json['createdBy'];
    unitId = json['unitId'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deleted_by'];
    deleted = json['deleted'];
    unicodeHindi = json['unicodeHindi'];
    listPrescriptionInstructionDto = json['listPrescriptionInstructionDto'];
  }
  int? id;
  String? englishInstruction;
  String? hindiInstruction;
  String? marathiInstruction;
  String? unicode;
  String? referTo;
  String? createdDateTime;
  int? createdBy;
  int? unitId;
  int? updatedBy;
  int? deletedBy;
  String? deleted;
  String? unicodeHindi;
  dynamic listPrescriptionInstructionDto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['englishInstruction'] = englishInstruction;
    map['hindiInstruction'] = hindiInstruction;
    map['marathiInstruction'] = marathiInstruction;
    map['unicode'] = unicode;
    map['referTo'] = referTo;
    map['createdDateTime'] = createdDateTime;
    map['createdBy'] = createdBy;
    map['unitId'] = unitId;
    map['updatedBy'] = updatedBy;
    map['deleted_by'] = deletedBy;
    map['deleted'] = deleted;
    map['unicodeHindi'] = unicodeHindi;
    map['listPrescriptionInstructionDto'] = listPrescriptionInstructionDto;
    return map;
  }

}