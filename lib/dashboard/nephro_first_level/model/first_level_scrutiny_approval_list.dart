

class FirstLevelScrutinyApprovalList {
  FirstLevelScrutinyApprovalList({
      this.status, 
      this.message, 
      this.dateTime, 
      this.details,});

  FirstLevelScrutinyApprovalList.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    dateTime = json['dateTime'];
    details = json['details'] != null ? FirstLevelDetails.fromJson(json['details']) : null;
  }
  String? status;
  String? message;
  dynamic dateTime;
  FirstLevelDetails? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['dateTime'] = dateTime;
    if (details != null) {
      map['details'] = details?.toJson();
    }
    return map;
  }

}


class FirstLevelDetails {
  FirstLevelDetails({
    this.srnId,
    this.serviceCode,
    this.complaintMasterId,
    this.patientId,
    this.treatmentId,
    this.unitId,
    this.appNumber,
    this.appDate,
    this.appName,
    this.status,
    this.serviceName,
    this.srnMoveId,
    this.scrutinyLevelDetId,
    this.distId,
    this.scrutinyQDetId,
    this.scrutinyAnswer,
    this.scrutinyRemark,
    this.approveRejectFlag,
    this.approveRejectRemark,
    this.serviceId,
    this.scrutinyLevel,
    this.tmCmScrutinyBean,
    this.unitName,
    this.distName,
    this.srNumber,
    this.userId,
    this.invoiceId,});

  FirstLevelDetails.fromJson(dynamic json) {
    srnId = json['srnId'];
    serviceCode = json['serviceCode'];
    complaintMasterId = json['complaintMasterId'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    unitId = json['unitId'];
    appNumber = json['appNumber'];
    appDate = json['appDate'];
    appName = json['appName'];
    status = json['status'];
    serviceName = json['serviceName'];
    srnMoveId = json['srnMoveId'];
    scrutinyLevelDetId = json['scrutinyLevelDetId'];
    distId = json['distId'];
    scrutinyQDetId = json['scrutinyQDetId'];
    scrutinyAnswer = json['scrutinyAnswer'];
    scrutinyRemark = json['scrutinyRemark'];
    approveRejectFlag = json['approveRejectFlag'];
    approveRejectRemark = json['approveRejectRemark'];
    serviceId = json['serviceId'];
    scrutinyLevel = json['scrutinyLevel'];
    if (json['tmCmScrutinyBean'] != null) {
      tmCmScrutinyBean = [];
      json['tmCmScrutinyBean'].forEach((v) {
        tmCmScrutinyBean?.add(FirstLevelTmCmScrutinyBean.fromJson(v));
      });
    }
    unitName = json['unitName'];
    distName = json['distName'];
    srNumber = json['srNumber'];
    userId = json['userId'];
    invoiceId = json['invoiceId'];
  }
  int? srnId;
  dynamic serviceCode;
  dynamic complaintMasterId;
  dynamic patientId;
  dynamic treatmentId;
  dynamic unitId;
  dynamic appNumber;
  dynamic appDate;
  dynamic appName;
  dynamic status;
  dynamic serviceName;
  dynamic srnMoveId;
  dynamic scrutinyLevelDetId;
  dynamic distId;
  dynamic scrutinyQDetId;
  dynamic scrutinyAnswer;
  dynamic scrutinyRemark;
  dynamic approveRejectFlag;
  dynamic approveRejectRemark;
  dynamic serviceId;
  dynamic scrutinyLevel;
  List<FirstLevelTmCmScrutinyBean>? tmCmScrutinyBean;
  dynamic unitName;
  dynamic distName;
  dynamic srNumber;
  dynamic userId;
  dynamic invoiceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['srnId'] = srnId;
    map['serviceCode'] = serviceCode;
    map['complaintMasterId'] = complaintMasterId;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['unitId'] = unitId;
    map['appNumber'] = appNumber;
    map['appDate'] = appDate;
    map['appName'] = appName;
    map['status'] = status;
    map['serviceName'] = serviceName;
    map['srnMoveId'] = srnMoveId;
    map['scrutinyLevelDetId'] = scrutinyLevelDetId;
    map['distId'] = distId;
    map['scrutinyQDetId'] = scrutinyQDetId;
    map['scrutinyAnswer'] = scrutinyAnswer;
    map['scrutinyRemark'] = scrutinyRemark;
    map['approveRejectFlag'] = approveRejectFlag;
    map['approveRejectRemark'] = approveRejectRemark;
    map['serviceId'] = serviceId;
    map['scrutinyLevel'] = scrutinyLevel;
    if (tmCmScrutinyBean != null) {
      map['tmCmScrutinyBean'] = tmCmScrutinyBean?.map((v) => v.toJson()).toList();
    }
    map['unitName'] = unitName;
    map['distName'] = distName;
    map['srNumber'] = srNumber;
    map['userId'] = userId;
    map['invoiceId'] = invoiceId;
    return map;
  }

}

class FirstLevelTmCmScrutinyBean {
  FirstLevelTmCmScrutinyBean({
    this.srnId,
    this.serviceCode,
    this.complaintMasterId,
    this.patientId,
    this.treatmentId,
    this.unitId,
    this.appNumber,
    this.appDate,
    this.appName,
    this.status,
    this.serviceName,
    this.srnMoveId,
    this.scrutinyLevelDetId,
    this.distId,
    this.scrutinyQDetId,
    this.scrutinyAnswer,
    this.scrutinyRemark,
    this.approveRejectFlag,
    this.approveRejectRemark,
    this.serviceId,
    this.scrutinyLevel,
    this.tmCmScrutinyBean,
    this.unitName,
    this.distName,
    this.srNumber,
    this.userId,
    this.invoiceId,});

  FirstLevelTmCmScrutinyBean.fromJson(dynamic json) {
    srnId = json['srnId'];
    serviceCode = json['serviceCode'];
    complaintMasterId = json['complaintMasterId'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    unitId = json['unitId'];
    appNumber = json['appNumber'];
    appDate = json['appDate'];
    appName = json['appName'];
    status = json['status'];
    serviceName = json['serviceName'];
    srnMoveId = json['srnMoveId'];
    scrutinyLevelDetId = json['scrutinyLevelDetId'];
    distId = json['distId'];
    scrutinyQDetId = json['scrutinyQDetId'];
    scrutinyAnswer = json['scrutinyAnswer'];
    scrutinyRemark = json['scrutinyRemark'];
    approveRejectFlag = json['approveRejectFlag'];
    approveRejectRemark = json['approveRejectRemark'];
    serviceId = json['serviceId'];
    scrutinyLevel = json['scrutinyLevel'];
    tmCmScrutinyBean = json['tmCmScrutinyBean'];
    unitName = json['unitName'];
    distName = json['distName'];
    srNumber = json['srNumber'];
    userId = json['userId'];
    invoiceId = json['invoiceId'];
  }
  int? srnId;
  String? serviceCode;
  dynamic complaintMasterId;
  int? patientId;
  dynamic treatmentId;
  int? unitId;
  String? appNumber;
  String? appDate;
  String? appName;
  String? status;
  String? serviceName;
  int? srnMoveId;
  int? scrutinyLevelDetId;
  dynamic distId;
  dynamic scrutinyQDetId;
  dynamic scrutinyAnswer;
  dynamic scrutinyRemark;
  dynamic approveRejectFlag;
  dynamic approveRejectRemark;
  dynamic serviceId;
  String? scrutinyLevel;
  dynamic tmCmScrutinyBean;
  String? unitName;
  dynamic distName;
  dynamic srNumber;
  dynamic userId;
  dynamic invoiceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['srnId'] = srnId;
    map['serviceCode'] = serviceCode;
    map['complaintMasterId'] = complaintMasterId;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['unitId'] = unitId;
    map['appNumber'] = appNumber;
    map['appDate'] = appDate;
    map['appName'] = appName;
    map['status'] = status;
    map['serviceName'] = serviceName;
    map['srnMoveId'] = srnMoveId;
    map['scrutinyLevelDetId'] = scrutinyLevelDetId;
    map['distId'] = distId;
    map['scrutinyQDetId'] = scrutinyQDetId;
    map['scrutinyAnswer'] = scrutinyAnswer;
    map['scrutinyRemark'] = scrutinyRemark;
    map['approveRejectFlag'] = approveRejectFlag;
    map['approveRejectRemark'] = approveRejectRemark;
    map['serviceId'] = serviceId;
    map['scrutinyLevel'] = scrutinyLevel;
    map['tmCmScrutinyBean'] = tmCmScrutinyBean;
    map['unitName'] = unitName;
    map['distName'] = distName;
    map['srNumber'] = srNumber;
    map['userId'] = userId;
    map['invoiceId'] = invoiceId;
    return map;
  }

}