class GetInstructionsModel {
  GetInstructionsModel({
      this.idindividualtreatmentinstruction, 
      this.treatmentId, 
      this.status, 
      this.reportInstructionIDFK, 
      this.mandatoryInstFlag, 
      this.lstList, 
      this.reportInstruction,});

  GetInstructionsModel.fromJson(dynamic json) {
    idindividualtreatmentinstruction = json['idindividualtreatmentinstruction'];
    treatmentId = json['treatmentId'];
    status = json['status'];
    reportInstructionIDFK = json['reportInstruction_ID_FK'];
    mandatoryInstFlag = json['mandatoryInstFlag'];
    if (json['lstList'] != null) {
      lstList = [];
      json['lstList'].forEach((v) {
        lstList?.add(LstList.fromJson(v));
      });
    }
    reportInstruction = json['reportInstruction'];
  }
  int? idindividualtreatmentinstruction;
  dynamic treatmentId;
  String? status;
  dynamic reportInstructionIDFK;
  String? mandatoryInstFlag;
  List<LstList>? lstList;
  dynamic reportInstruction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idindividualtreatmentinstruction'] = idindividualtreatmentinstruction;
    map['treatmentId'] = treatmentId;
    map['status'] = status;
    map['reportInstruction_ID_FK'] = reportInstructionIDFK;
    map['mandatoryInstFlag'] = mandatoryInstFlag;
    if (lstList != null) {
      map['lstList'] = lstList?.map((v) => v.toJson()).toList();
    }
    map['reportInstruction'] = reportInstruction;
    return map;
  }

}

class LstList {
  LstList({
      this.idindividualtreatmentinstruction, 
      this.treatmentId, 
      this.status, 
      this.reportInstructionIDFK, 
      this.mandatoryInstFlag, 
      this.lstList, 
      this.reportInstruction,});

  LstList.fromJson(dynamic json) {
    idindividualtreatmentinstruction = json['idindividualtreatmentinstruction'];
    treatmentId = json['treatmentId'];
    status = json['status'];
    reportInstructionIDFK = json['reportInstruction_ID_FK'];
    mandatoryInstFlag = json['mandatoryInstFlag'];
    lstList = json['lstList'];
    reportInstruction = json['reportInstruction'];
  }
  int? idindividualtreatmentinstruction;
  int? treatmentId;
  String? status;
  int? reportInstructionIDFK;
  String? mandatoryInstFlag;
  dynamic lstList;
  String? reportInstruction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idindividualtreatmentinstruction'] = idindividualtreatmentinstruction;
    map['treatmentId'] = treatmentId;
    map['status'] = status;
    map['reportInstruction_ID_FK'] = reportInstructionIDFK;
    map['mandatoryInstFlag'] = mandatoryInstFlag;
    map['lstList'] = lstList;
    map['reportInstruction'] = reportInstruction;
    return map;
  }

}