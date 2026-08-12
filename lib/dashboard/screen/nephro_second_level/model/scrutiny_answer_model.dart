class ScrutinyAnswerModel {
  ScrutinyAnswerModel({
      this.status, 
      this.message, 
      this.dateTime, 
      this.details,});

  ScrutinyAnswerModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    dateTime = json['dateTime'];
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  String? status;
  String? message;
  dynamic dateTime;
  Details? details;

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

class Details {
  Details({
      this.srnMoveId, 
      this.tmCmScrutinyLevelDetBean, 
      this.ttServiceRequestBean, 
      this.patientId, 
      this.beneficiaryId, 
      this.serviceId, 
      this.unitId, 
      this.assignedDate, 
      this.sendDate, 
      this.approveRejectFlag, 
      this.approveRejectRemark, 
      this.lookupDetIdMovementStatus, 
      this.createdBy, 
      this.createdDate, 
      this.updatedBy, 
      this.updatedDate, 
      this.userId, 
      this.nextLevelUserId, 
      this.rejectionReasonRefId, 
      this.srnId, 
      this.lookUpDetId, 
      this.levrlIds,
      this.userLstId, 
      this.scrutinyLevelId, 
      this.scrutinyLevelDetId, 
      this.rejectRefId, 
      this.finalFlag, 
      this.lvlLstId, 
      this.srnIdLong, 
      this.expectedCompletionDays, 
      this.srnMovValId, 
      this.srnMovId, 
      this.ulbId, 
      this.scrutinyQDetId, 
      this.scrutinyAnswer, 
      this.scrutinyAnsAttached, 
      this.scrutinyRemarks, 
      this.metaTitle, 
      this.isfinalFlag, 
      this.reqApprovalAmt, 
      this.scrutinyLVL, 
      this.listTtServiceRequestMovementBean, 
      this.serviceRequestMovementValueBean,});

  Details.fromJson(dynamic json) {
    srnMoveId = json['srnMoveId'];
    tmCmScrutinyLevelDetBean = json['tmCmScrutinyLevelDetBean'];
    ttServiceRequestBean = json['ttServiceRequestBean'];
    patientId = json['patientId'];
    beneficiaryId = json['beneficiaryId'];
    serviceId = json['serviceId'];
    unitId = json['unitId'];
    assignedDate = json['assignedDate'];
    sendDate = json['sendDate'];
    approveRejectFlag = json['approveRejectFlag'];
    approveRejectRemark = json['approveRejectRemark'];
    lookupDetIdMovementStatus = json['lookupDetIdMovementStatus'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    userId = json['userId'];
    nextLevelUserId = json['nextLevelUserId'];
    rejectionReasonRefId = json['rejectionReasonRefId'];
    srnId = json['srnId'];
    lookUpDetId = json['lookUpDetId'];
    levrlIds = json['levrlIds'];

    userLstId = json['userLstId'];
    scrutinyLevelId = json['scrutinyLevelId'];
    scrutinyLevelDetId = json['scrutinyLevelDetId'];
    rejectRefId = json['rejectRefId'];
    finalFlag = json['finalFlag'];
    lvlLstId = json['lvlLstId'];
    srnIdLong = json['srnIdLong'];
    expectedCompletionDays = json['expectedCompletionDays'];
    srnMovValId = json['srnMovValId'];
    srnMovId = json['srnMovId'];
    ulbId = json['ulbId'];
    scrutinyQDetId = json['scrutinyQDetId'];
    scrutinyAnswer = json['scrutinyAnswer'];
    scrutinyAnsAttached = json['scrutinyAnsAttached'];
    scrutinyRemarks = json['scrutinyRemarks'];
    metaTitle = json['metaTitle'];
    isfinalFlag = json['isfinalFlag'];
    reqApprovalAmt = json['reqApprovalAmt'];
    scrutinyLVL = json['scrutinyLVL'];
    if (json['listTtServiceRequestMovementBean'] != null) {
      listTtServiceRequestMovementBean = [];
      json['listTtServiceRequestMovementBean'].forEach((v) {
        listTtServiceRequestMovementBean?.add(ListTtServiceRequestMovementBean.fromJson(v));
      });
    }

  }
  int? srnMoveId;
  dynamic tmCmScrutinyLevelDetBean;
  dynamic ttServiceRequestBean;
  dynamic patientId;
  dynamic beneficiaryId;
  dynamic serviceId;
  int? unitId;
  dynamic assignedDate;
  dynamic sendDate;
  dynamic approveRejectFlag;
  dynamic approveRejectRemark;
  dynamic lookupDetIdMovementStatus;
  dynamic createdBy;
  dynamic createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic userId;
  dynamic nextLevelUserId;
  dynamic rejectionReasonRefId;
  dynamic srnId;
  int? lookUpDetId;
  int? levrlIds;
  dynamic userLstId;
  dynamic scrutinyLevelId;
  int? scrutinyLevelDetId;
  dynamic rejectRefId;
  dynamic finalFlag;
  dynamic lvlLstId;
  dynamic srnIdLong;
  dynamic expectedCompletionDays;
  int? srnMovValId;
  int? srnMovId;
  int? ulbId;
  int? scrutinyQDetId;
  dynamic scrutinyAnswer;
  dynamic scrutinyAnsAttached;
  dynamic scrutinyRemarks;
  dynamic metaTitle;
  dynamic isfinalFlag;
  dynamic reqApprovalAmt;
  dynamic scrutinyLVL;
  List<ListTtServiceRequestMovementBean>? listTtServiceRequestMovementBean;
  List<dynamic>? serviceRequestMovementValueBean;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['srnMoveId'] = srnMoveId;
    map['tmCmScrutinyLevelDetBean'] = tmCmScrutinyLevelDetBean;
    map['ttServiceRequestBean'] = ttServiceRequestBean;
    map['patientId'] = patientId;
    map['beneficiaryId'] = beneficiaryId;
    map['serviceId'] = serviceId;
    map['unitId'] = unitId;
    map['assignedDate'] = assignedDate;
    map['sendDate'] = sendDate;
    map['approveRejectFlag'] = approveRejectFlag;
    map['approveRejectRemark'] = approveRejectRemark;
    map['lookupDetIdMovementStatus'] = lookupDetIdMovementStatus;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['userId'] = userId;
    map['nextLevelUserId'] = nextLevelUserId;
    map['rejectionReasonRefId'] = rejectionReasonRefId;
    map['srnId'] = srnId;
    map['lookUpDetId'] = lookUpDetId;
    map['levrlIds'] = levrlIds;

    map['userLstId'] = userLstId;
    map['scrutinyLevelId'] = scrutinyLevelId;
    map['scrutinyLevelDetId'] = scrutinyLevelDetId;
    map['rejectRefId'] = rejectRefId;
    map['finalFlag'] = finalFlag;
    map['lvlLstId'] = lvlLstId;
    map['srnIdLong'] = srnIdLong;
    map['expectedCompletionDays'] = expectedCompletionDays;
    map['srnMovValId'] = srnMovValId;
    map['srnMovId'] = srnMovId;
    map['ulbId'] = ulbId;
    map['scrutinyQDetId'] = scrutinyQDetId;
    map['scrutinyAnswer'] = scrutinyAnswer;
    map['scrutinyAnsAttached'] = scrutinyAnsAttached;
    map['scrutinyRemarks'] = scrutinyRemarks;
    map['metaTitle'] = metaTitle;
    map['isfinalFlag'] = isfinalFlag;
    map['reqApprovalAmt'] = reqApprovalAmt;
    map['scrutinyLVL'] = scrutinyLVL;
    if (listTtServiceRequestMovementBean != null) {
      map['listTtServiceRequestMovementBean'] = listTtServiceRequestMovementBean?.map((v) => v.toJson()).toList();
    }
    if (serviceRequestMovementValueBean != null) {
      map['serviceRequestMovementValueBean'] = serviceRequestMovementValueBean?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ListTtServiceRequestMovementBean {
  ListTtServiceRequestMovementBean({
      this.srnMoveId, 
      this.tmCmScrutinyLevelDetBean, 
      this.ttServiceRequestBean, 
      this.patientId, 
      this.beneficiaryId, 
      this.serviceId, 
      this.unitId, 
      this.assignedDate, 
      this.sendDate, 
      this.approveRejectFlag, 
      this.approveRejectRemark, 
      this.lookupDetIdMovementStatus, 
      this.createdBy, 
      this.createdDate, 
      this.updatedBy, 
      this.updatedDate, 
      this.userId, 
      this.nextLevelUserId, 
      this.rejectionReasonRefId, 
      this.srnId, 
      this.lookUpDetId, 
      this.levrlIds, 
      this.serviceRequestMovementValue, 
      this.userLstId, 
      this.scrutinyLevelId, 
      this.scrutinyLevelDetId, 
      this.rejectRefId, 
      this.finalFlag, 
      this.lvlLstId, 
      this.srnIdLong, 
      this.expectedCompletionDays, 
      this.srnMovValId, 
      this.srnMovId, 
      this.ulbId, 
      this.scrutinyQDetId, 
      this.scrutinyAnswer, 
      this.scrutinyAnsAttached, 
      this.scrutinyRemarks, 
      this.metaTitle, 
      this.isfinalFlag, 
      this.reqApprovalAmt, 
      this.scrutinyLVL, 
      this.listTtServiceRequestMovementBean, 
      this.serviceRequestMovementValueBean,});

  ListTtServiceRequestMovementBean.fromJson(dynamic json) {
    srnMoveId = json['srnMoveId'];
    tmCmScrutinyLevelDetBean = json['tmCmScrutinyLevelDetBean'];
    ttServiceRequestBean = json['ttServiceRequestBean'];
    patientId = json['patientId'];
    beneficiaryId = json['beneficiaryId'];
    serviceId = json['serviceId'];
    unitId = json['unitId'];
    assignedDate = json['assignedDate'];
    sendDate = json['sendDate'];
    approveRejectFlag = json['approveRejectFlag'];
    approveRejectRemark = json['approveRejectRemark'];
    lookupDetIdMovementStatus = json['lookupDetIdMovementStatus'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    userId = json['userId'];
    nextLevelUserId = json['nextLevelUserId'];
    rejectionReasonRefId = json['rejectionReasonRefId'];
    srnId = json['srnId'];
    lookUpDetId = json['lookUpDetId'];
    levrlIds = json['levrlIds'];
    userLstId = json['userLstId'];
    scrutinyLevelId = json['scrutinyLevelId'];
    scrutinyLevelDetId = json['scrutinyLevelDetId'];
    rejectRefId = json['rejectRefId'];
    finalFlag = json['finalFlag'];
    lvlLstId = json['lvlLstId'];
    srnIdLong = json['srnIdLong'];
    expectedCompletionDays = json['expectedCompletionDays'];
    srnMovValId = json['srnMovValId'];
    srnMovId = json['srnMovId'];
    ulbId = json['ulbId'];
    scrutinyQDetId = json['scrutinyQDetId'];
    scrutinyAnswer = json['scrutinyAnswer'];
    scrutinyAnsAttached = json['scrutinyAnsAttached'];
    scrutinyRemarks = json['scrutinyRemarks'];
    metaTitle = json['metaTitle'];
    isfinalFlag = json['isfinalFlag'];
    reqApprovalAmt = json['reqApprovalAmt'];
    scrutinyLVL = json['scrutinyLVL'];
    listTtServiceRequestMovementBean = json['listTtServiceRequestMovementBean'];

  }
  int? srnMoveId;
  dynamic tmCmScrutinyLevelDetBean;
  dynamic ttServiceRequestBean;
  dynamic patientId;
  dynamic beneficiaryId;
  dynamic serviceId;
  int? unitId;
  dynamic assignedDate;
  dynamic sendDate;
  dynamic approveRejectFlag;
  dynamic approveRejectRemark;
  dynamic lookupDetIdMovementStatus;
  dynamic createdBy;
  dynamic createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic userId;
  dynamic nextLevelUserId;
  dynamic rejectionReasonRefId;
  int? srnId;
  int? lookUpDetId;
  int? levrlIds;
  List<dynamic>? serviceRequestMovementValue;
  dynamic userLstId;
  dynamic scrutinyLevelId;
  int? scrutinyLevelDetId;
  dynamic rejectRefId;
  dynamic finalFlag;
  dynamic lvlLstId;
  dynamic srnIdLong;
  dynamic expectedCompletionDays;
  int? srnMovValId;
  int? srnMovId;
  int? ulbId;
  int? scrutinyQDetId;
  String? scrutinyAnswer;
  dynamic scrutinyAnsAttached;
  String? scrutinyRemarks;
  dynamic metaTitle;
  dynamic isfinalFlag;
  dynamic reqApprovalAmt;
  String? scrutinyLVL;
  dynamic listTtServiceRequestMovementBean;
  List<dynamic>? serviceRequestMovementValueBean;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['srnMoveId'] = srnMoveId;
    map['tmCmScrutinyLevelDetBean'] = tmCmScrutinyLevelDetBean;
    map['ttServiceRequestBean'] = ttServiceRequestBean;
    map['patientId'] = patientId;
    map['beneficiaryId'] = beneficiaryId;
    map['serviceId'] = serviceId;
    map['unitId'] = unitId;
    map['assignedDate'] = assignedDate;
    map['sendDate'] = sendDate;
    map['approveRejectFlag'] = approveRejectFlag;
    map['approveRejectRemark'] = approveRejectRemark;
    map['lookupDetIdMovementStatus'] = lookupDetIdMovementStatus;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['userId'] = userId;
    map['nextLevelUserId'] = nextLevelUserId;
    map['rejectionReasonRefId'] = rejectionReasonRefId;
    map['srnId'] = srnId;
    map['lookUpDetId'] = lookUpDetId;
    map['levrlIds'] = levrlIds;
    if (serviceRequestMovementValue != null) {
      map['serviceRequestMovementValue'] = serviceRequestMovementValue?.map((v) => v.toJson()).toList();
    }
    map['userLstId'] = userLstId;
    map['scrutinyLevelId'] = scrutinyLevelId;
    map['scrutinyLevelDetId'] = scrutinyLevelDetId;
    map['rejectRefId'] = rejectRefId;
    map['finalFlag'] = finalFlag;
    map['lvlLstId'] = lvlLstId;
    map['srnIdLong'] = srnIdLong;
    map['expectedCompletionDays'] = expectedCompletionDays;
    map['srnMovValId'] = srnMovValId;
    map['srnMovId'] = srnMovId;
    map['ulbId'] = ulbId;
    map['scrutinyQDetId'] = scrutinyQDetId;
    map['scrutinyAnswer'] = scrutinyAnswer;
    map['scrutinyAnsAttached'] = scrutinyAnsAttached;
    map['scrutinyRemarks'] = scrutinyRemarks;
    map['metaTitle'] = metaTitle;
    map['isfinalFlag'] = isfinalFlag;
    map['reqApprovalAmt'] = reqApprovalAmt;
    map['scrutinyLVL'] = scrutinyLVL;
    map['listTtServiceRequestMovementBean'] = listTtServiceRequestMovementBean;
    if (serviceRequestMovementValueBean != null) {
      map['serviceRequestMovementValueBean'] = serviceRequestMovementValueBean?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}