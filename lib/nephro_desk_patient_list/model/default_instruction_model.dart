class DefaultInstructionModel {
  DefaultInstructionModel({
      this.reportInstructionID, 
      this.reportInstruction, 
      this.reportInstructionHindi, 
      this.reportInstructionMarathi, 
      this.reportInstructionOther1, 
      this.reportInstructionOther2, 
      this.reportInstructionOther3, 
      this.mandatoryInstFlag, 
      this.createdDateTime, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.deleted, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedDateTime, 
      this.unitId, 
      this.userId, 
      this.unicodeMarati, 
      this.unicodeHindi, 
      this.getListOfOPDInstructionDTO, 
      this.mandatoryCheckedFlag,});

  DefaultInstructionModel.fromJson(dynamic json) {
    reportInstructionID = json['reportInstructionID'];
    reportInstruction = json['reportInstruction'];
    reportInstructionHindi = json['reportInstructionHindi'];
    reportInstructionMarathi = json['reportInstructionMarathi'];
    reportInstructionOther1 = json['reportInstructionOther1'];
    reportInstructionOther2 = json['reportInstructionOther2'];
    reportInstructionOther3 = json['reportInstructionOther3'];
    mandatoryInstFlag = json['mandatoryInstFlag'];
    createdDateTime = json['createdDateTime'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedDateTime = json['deletedDateTime'];
    unitId = json['unitId'];
    userId = json['userId'];
    unicodeMarati = json['unicodeMarati'];
    unicodeHindi = json['unicodeHindi'];
    if (json['getListOfOPDInstructionDTO'] != null) {
      getListOfOPDInstructionDTO = [];
      json['getListOfOPDInstructionDTO'].forEach((v) {
        getListOfOPDInstructionDTO?.add(GetListOfOpdInstructionDto.fromJson(v));
      });
    }
    mandatoryCheckedFlag = json['mandatoryCheckedFlag'];
  }
  int? reportInstructionID;
  dynamic reportInstruction;
  dynamic reportInstructionHindi;
  dynamic reportInstructionMarathi;
  dynamic reportInstructionOther1;
  dynamic reportInstructionOther2;
  dynamic reportInstructionOther3;
  String? mandatoryInstFlag;
  dynamic createdDateTime;
  dynamic updatedDateTime;
  dynamic deletedBy;
  String? deleted;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedDateTime;
  int? unitId;
  int? userId;
  dynamic unicodeMarati;
  dynamic unicodeHindi;
  List<GetListOfOpdInstructionDto>? getListOfOPDInstructionDTO;
  dynamic mandatoryCheckedFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reportInstructionID'] = reportInstructionID;
    map['reportInstruction'] = reportInstruction;
    map['reportInstructionHindi'] = reportInstructionHindi;
    map['reportInstructionMarathi'] = reportInstructionMarathi;
    map['reportInstructionOther1'] = reportInstructionOther1;
    map['reportInstructionOther2'] = reportInstructionOther2;
    map['reportInstructionOther3'] = reportInstructionOther3;
    map['mandatoryInstFlag'] = mandatoryInstFlag;
    map['createdDateTime'] = createdDateTime;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['deleted'] = deleted;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedDateTime'] = deletedDateTime;
    map['unitId'] = unitId;
    map['userId'] = userId;
    map['unicodeMarati'] = unicodeMarati;
    map['unicodeHindi'] = unicodeHindi;
    if (getListOfOPDInstructionDTO != null) {
      map['getListOfOPDInstructionDTO'] = getListOfOPDInstructionDTO?.map((v) => v.toJson()).toList();
    }
    map['mandatoryCheckedFlag'] = mandatoryCheckedFlag;
    return map;
  }

}

class GetListOfOpdInstructionDto {
  GetListOfOpdInstructionDto({
      this.reportInstructionID, 
      this.reportInstruction, 
      this.reportInstructionHindi, 
      this.reportInstructionMarathi, 
      this.reportInstructionOther1, 
      this.reportInstructionOther2, 
      this.reportInstructionOther3, 
      this.mandatoryInstFlag, 
      this.createdDateTime, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.deleted, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedDateTime, 
      this.unitId, 
      this.userId, 
      this.unicodeMarati, 
      this.unicodeHindi, 
      this.getListOfOPDInstructionDTO, 
      this.mandatoryCheckedFlag,});

  GetListOfOpdInstructionDto.fromJson(dynamic json) {
    reportInstructionID = json['reportInstructionID'];
    reportInstruction = json['reportInstruction'];
    reportInstructionHindi = json['reportInstructionHindi'];
    reportInstructionMarathi = json['reportInstructionMarathi'];
    reportInstructionOther1 = json['reportInstructionOther1'];
    reportInstructionOther2 = json['reportInstructionOther2'];
    reportInstructionOther3 = json['reportInstructionOther3'];
    mandatoryInstFlag = json['mandatoryInstFlag'];
    createdDateTime = json['createdDateTime'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedDateTime = json['deletedDateTime'];
    unitId = json['unitId'];
    userId = json['userId'];
    unicodeMarati = json['unicodeMarati'];
    unicodeHindi = json['unicodeHindi'];
    getListOfOPDInstructionDTO = json['getListOfOPDInstructionDTO'];
    mandatoryCheckedFlag = json['mandatoryCheckedFlag'];
  }
  int? reportInstructionID;
  String? reportInstruction;
  String? reportInstructionHindi;
  String? reportInstructionMarathi;
  String? reportInstructionOther1;
  String? reportInstructionOther2;
  String? reportInstructionOther3;
  String? mandatoryInstFlag;
  String? createdDateTime;
  String? updatedDateTime;
  dynamic deletedBy;
  String? deleted;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedDateTime;
  int? unitId;
  int? userId;
  String? unicodeMarati;
  String? unicodeHindi;
  dynamic getListOfOPDInstructionDTO;
  dynamic mandatoryCheckedFlag;
  bool isSelected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reportInstructionID'] = reportInstructionID;
    map['reportInstruction'] = reportInstruction;
    map['reportInstructionHindi'] = reportInstructionHindi;
    map['reportInstructionMarathi'] = reportInstructionMarathi;
    map['reportInstructionOther1'] = reportInstructionOther1;
    map['reportInstructionOther2'] = reportInstructionOther2;
    map['reportInstructionOther3'] = reportInstructionOther3;
    map['mandatoryInstFlag'] = mandatoryInstFlag;
    map['createdDateTime'] = createdDateTime;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['deleted'] = deleted;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedDateTime'] = deletedDateTime;
    map['unitId'] = unitId;
    map['userId'] = userId;
    map['unicodeMarati'] = unicodeMarati;
    map['unicodeHindi'] = unicodeHindi;
    map['getListOfOPDInstructionDTO'] = getListOfOPDInstructionDTO;
    map['mandatoryCheckedFlag'] = mandatoryCheckedFlag;
    return map;
  }

}