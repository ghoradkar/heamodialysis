import 'first_level_send_req_model.dart';

class QuestionModel {
  int? serviceId;
  String? srNumber;
  int? lookupLevelId;
  int? srnId;
  int? scrutinyLevelDet;
  int? srnMovId;
  int? scrutinyUser;
  int? userId;
  String? remark;
  String? level;
  String? srcutinyType;
  int? scrutinyLevelId;
  int? patientId;
  int? unitId;
  String? finalFlag;
  List<int>? desiginationList;
  List<int>? userIdLst;
  List<int>? lvlIds;
  List<String>? lvlList;
  List<TmCmScrutinyQuestionDetBean>? tmCmScrutinyQuestionDetBean;

  QuestionModel({
    this.serviceId,
    this.srNumber,
    this.lookupLevelId,
    this.srnId,
    this.scrutinyLevelDet,
    this.srnMovId,
    this.scrutinyUser,
    this.userId,
    this.remark,
    this.level,
    this.srcutinyType,
    this.scrutinyLevelId,
    this.patientId,
    this.unitId,
    this.finalFlag,
    this.desiginationList,
    this.userIdLst,
    this.lvlIds,
    this.lvlList,
    this.tmCmScrutinyQuestionDetBean,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      serviceId: json['serviceId'],
      srNumber: json['srNumber'],
      lookupLevelId: json['lookupLevelId'],
      srnId: json['srnId'],
      scrutinyLevelDet: json['scrutinyLevelDet'],
      srnMovId: json['srnMovId'],
      scrutinyUser: json['scrutinyUser'],
      userId: json['userId'],
      remark: json['remark'],
      level: json['level'],
      srcutinyType: json['srcutinyType'],
      scrutinyLevelId: json['scrutinyLevelId'],
      patientId: json['patientId'],
      unitId: json['unitId'],
      finalFlag: json['finalFlag'],
      desiginationList: List<int>.from(json['desiginationList'] ?? []),
      userIdLst: List<int>.from(json['userIdLst'] ?? []),
      lvlIds: List<int>.from(json['lvlIds'] ?? []),
      lvlList: List<String>.from(json['lvlList'] ?? []),
      tmCmScrutinyQuestionDetBean: (json['tmCmScrutinyQuestionDetBean'] as List<dynamic>?)
          ?.map((e) => TmCmScrutinyQuestionDetBean.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'srNumber': srNumber,
      'lookupLevelId': lookupLevelId,
      'srnId': srnId,
      'scrutinyLevelDet': scrutinyLevelDet,
      'srnMovId': srnMovId,
      'scrutinyUser': scrutinyUser,
      'userId': userId,
      'remark': remark,
      'level': level,
      'srcutinyType': srcutinyType,
      'scrutinyLevelId': scrutinyLevelId,
      'patientId': patientId,
      'unitId': unitId,
      'finalFlag': finalFlag,
      'desiginationList': desiginationList,
      'userIdLst': userIdLst,
      'lvlIds': lvlIds,
      'lvlList': lvlList,
      'tmCmScrutinyQuestionDetBean': tmCmScrutinyQuestionDetBean?.map((e) => e.toJson()).toList(),
    };
  }
}

class TmCmScrutinyQuestionDetBean {
  int? scrutinyQDetId;
  int? scrutinyQId;
  String? scrutinyQuestionEn;
  String? ansCode;
  String? lvlName;
  TmCmScrutinyBean tmCmScrutinyBean = TmCmScrutinyBean();

  TmCmScrutinyQuestionDetBean({
    this.scrutinyQDetId,
    this.scrutinyQId,
    this.scrutinyQuestionEn,
    this.ansCode,
    this.lvlName,
  });

  factory TmCmScrutinyQuestionDetBean.fromJson(Map<String, dynamic> json) {
    return TmCmScrutinyQuestionDetBean(
      scrutinyQDetId: json['scrutinyQDetId'],
      scrutinyQId: json['scrutinyQId'],
      scrutinyQuestionEn: json['scrutinyQuestionEn'],
      ansCode: json['ansCode'],
      lvlName: json['lvlName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scrutinyQDetId': scrutinyQDetId,
      'scrutinyQId': scrutinyQId,
      'scrutinyQuestionEn': scrutinyQuestionEn,
      'ansCode': ansCode,
      'lvlName': lvlName,
    };
  }
}
