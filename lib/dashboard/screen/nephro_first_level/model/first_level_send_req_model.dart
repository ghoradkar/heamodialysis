class FirstLevelSendReqModel {
  FirstLevelSendReqModel({
      this.patientId, 
      this.srnId, 
      this.userId, 
      this.treatmentId, 
      this.serviceCode, 
      this.complaintMasterId, 
      this.unitId, 
      this.distId, 
      this.approveRejectFlag, 
      this.approveRejectRemark, 
      this.tmCmScrutinyBean,});

  FirstLevelSendReqModel.fromJson(dynamic json) {
    patientId = json['patientId'];
    srnId = json['srnId'];
    userId = json['userId'];
    treatmentId = json['treatmentId'];
    serviceCode = json['serviceCode'];
    complaintMasterId = json['complaintMasterId'];
    unitId = json['unitId'];
    distId = json['distId'];
    approveRejectFlag = json['approveRejectFlag'];
    approveRejectRemark = json['approveRejectRemark'];
    if (json['tmCmScrutinyBean'] != null) {
      tmCmScrutinyBean = [];
      json['tmCmScrutinyBean'].forEach((v) {
        tmCmScrutinyBean?.add(TmCmScrutinyBean.fromJson(v));
      });
    }
  }
  String? patientId;
  String? srnId;
  String? userId;
  String? treatmentId;
  String? serviceCode;
  String? complaintMasterId;
  String? unitId;
  String? distId;
  String? approveRejectFlag;
  String? approveRejectRemark;
  List<TmCmScrutinyBean>? tmCmScrutinyBean;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['srnId'] = srnId;
    map['userId'] = userId;
    map['treatmentId'] = treatmentId;
    map['serviceCode'] = serviceCode;
    map['complaintMasterId'] = complaintMasterId;
    map['unitId'] = unitId;
    map['distId'] = distId;
    map['approveRejectFlag'] = approveRejectFlag;
    map['approveRejectRemark'] = approveRejectRemark;
    if (tmCmScrutinyBean != null) {
      map['tmCmScrutinyBean'] = tmCmScrutinyBean?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TmCmScrutinyBean {
  TmCmScrutinyBean({
      this.unitId, 
      this.scrutinyQDetId, 
      this.scrutinyAnswer = "YES",
      this.scrutinyRemark,});

  TmCmScrutinyBean.fromJson(dynamic json) {
    unitId = json['unitId'];
    scrutinyQDetId = json['scrutinyQDetId'];
    scrutinyAnswer = json['scrutinyAnswer'];
    scrutinyRemark = json['scrutinyRemark'];
  }
  String? unitId;
  String? scrutinyQDetId;
  String? scrutinyAnswer;
  String? scrutinyRemark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitId'] = unitId;
    map['scrutinyQDetId'] = scrutinyQDetId;
    map['scrutinyAnswer'] = scrutinyAnswer;
    map['scrutinyRemark'] = scrutinyRemark;
    return map;
  }

}