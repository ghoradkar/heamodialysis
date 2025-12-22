class InitialValueEditModel {
  InitialValueEditModel({
      this.roMachineIssueLogsId, 
      this.comments, 
      this.status, 
      this.createdDate, 
      this.createdBy, 
      this.updatedDate, 
      this.updatedBy, 
      this.macId, 
      this.ipAddress, 
      this.deviceFrom, 
      this.unitId, 
      this.roMachineMasterId, 
      this.lookupDetId, 
      this.srnId, 
      this.issueDate, 
      this.informationDate, 
      this.issueDescription, 
      this.informedTo, 
      this.informedBy, 
      this.callAttendedBy, 
      this.correctiveAction, 
      this.roLogSheetId, 
      this.lookupDetIdSfpPre, 
      this.lookupDetIdSfpPost, 
      this.sfpDifference, 
      this.lookupDetIdSandFilterBackwash, 
      this.lookupDetIdSandFilterRinse, 
      this.sandFilterDoneBy, 
      this.lookupDetIdBeforeRegenerationHardness, 
      this.beforeRegenerationHardnessValue, 
      this.lookupDetIdAfterRegenerationHardness, 
      this.afterRegenerationHardnessValue, 
      this.rawWaterTdsValue, 
      this.lookupDetIdRoWaterTds, 
      this.roWaterTdsValue, 
      this.preMembranePressure, 
      this.rejectPressure, 
      this.ppmPressureDifference, 
      this.premeateFlowLph, 
      this.lookupDetIdPostCarbonChlorine, 
      this.postCarbonChlorineValue, 
      this.lookupDetIdRoWaterConductivity, 
      this.roWaterConductivityValue, 
      this.rejectFlowLph, 
      this.rawWaterPump1, 
      this.rawWaterPump2, 
      this.highPressurePump1, 
      this.highPressurePump2, 
      this.transferPump1, 
      this.transferPump2, 
      this.uvLamp1, 
      this.uvLamp2, 
      this.ufMicronFilter, 
      this.dosingSystem, 
      this.lookupDetIdReturnLoopPressure, 
      this.returnLoopPressureValue, 
      this.checkedBy, 
      this.logSheetDate, 
      this.carbonFilterPressureId, 
      this.lookupDetIdCfpPre, 
      this.lookupDetIdCfpPost, 
      this.cfpDifference, 
      this.lookupDetIdCarbonFilterBackwash, 
      this.lookupDetIdCarbonFilterRinse, 
      this.carbonFilterDoneBy, 
      this.cfpComments, 
      this.softenerPressureId, 
      this.lookupDetIdSoftenerAvailable, 
      this.lookupDetIdSpPre, 
      this.lookupDetIdSpPost, 
      this.spDifference, 
      this.softenerRegenerationTime, 
      this.softenerRegenerationDoneBy, 
      this.spComments, 
      this.carbonString, 
      this.softString, 
      this.userId, 
      this.proLi, 
      this.machineNameList, 
      this.lookupDetIdRawWaterTds,});

  InitialValueEditModel.fromJson(dynamic json) {
    roMachineIssueLogsId = json['roMachineIssueLogsId'];
    comments = json['comments'];
    status = json['status'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    unitId = json['unitId'];
    roMachineMasterId = json['roMachineMasterId'];
    lookupDetId = json['lookupDetId'];
    srnId = json['srnId'];
    issueDate = json['issueDate'];
    informationDate = json['informationDate'];
    issueDescription = json['issueDescription'];
    informedTo = json['informedTo'];
    informedBy = json['informedBy'];
    callAttendedBy = json['callAttendedBy'];
    correctiveAction = json['correctiveAction'];
    roLogSheetId = json['roLogSheetId'];
    lookupDetIdSfpPre = json['lookupDetIdSfpPre'];
    lookupDetIdSfpPost = json['lookupDetIdSfpPost'];
    sfpDifference = json['sfpDifference'];
    lookupDetIdSandFilterBackwash = json['lookupDetIdSandFilterBackwash'];
    lookupDetIdSandFilterRinse = json['lookupDetIdSandFilterRinse'];
    sandFilterDoneBy = json['sandFilterDoneBy'];
    lookupDetIdBeforeRegenerationHardness = json['lookupDetIdBeforeRegenerationHardness'];
    beforeRegenerationHardnessValue = json['beforeRegenerationHardnessValue'];
    lookupDetIdAfterRegenerationHardness = json['lookupDetIdAfterRegenerationHardness'];
    afterRegenerationHardnessValue = json['afterRegenerationHardnessValue'];
    rawWaterTdsValue = json['rawWaterTdsValue'];
    lookupDetIdRoWaterTds = json['lookupDetIdRoWaterTds'];
    roWaterTdsValue = json['roWaterTdsValue'];
    preMembranePressure = json['preMembranePressure'];
    rejectPressure = json['rejectPressure'];
    ppmPressureDifference = json['ppmPressureDifference'];
    premeateFlowLph = json['premeateFlowLph'];
    lookupDetIdPostCarbonChlorine = json['lookupDetIdPostCarbonChlorine'];
    postCarbonChlorineValue = json['postCarbonChlorineValue'];
    lookupDetIdRoWaterConductivity = json['lookupDetIdRoWaterConductivity'];
    roWaterConductivityValue = json['roWaterConductivityValue'];
    rejectFlowLph = json['rejectFlowLph'];
    rawWaterPump1 = json['rawWaterPump1'];
    rawWaterPump2 = json['rawWaterPump2'];
    highPressurePump1 = json['highPressurePump1'];
    highPressurePump2 = json['highPressurePump2'];
    transferPump1 = json['transferPump1'];
    transferPump2 = json['transferPump2'];
    uvLamp1 = json['uvLamp1'];
    uvLamp2 = json['uvLamp2'];
    ufMicronFilter = json['ufMicronFilter'];
    dosingSystem = json['dosingSystem'];
    lookupDetIdReturnLoopPressure = json['lookupDetIdReturnLoopPressure'];
    returnLoopPressureValue = json['returnLoopPressureValue'];
    checkedBy = json['checkedBy'];
    logSheetDate = json['logSheetDate'];
    carbonFilterPressureId = json['carbonFilterPressureId'];
    lookupDetIdCfpPre = json['lookupDetIdCfpPre'];
    lookupDetIdCfpPost = json['lookupDetIdCfpPost'];
    cfpDifference = json['cfpDifference'];
    lookupDetIdCarbonFilterBackwash = json['lookupDetIdCarbonFilterBackwash'];
    lookupDetIdCarbonFilterRinse = json['lookupDetIdCarbonFilterRinse'];
    carbonFilterDoneBy = json['carbonFilterDoneBy'];
    cfpComments = json['cfpComments'];
    softenerPressureId = json['softenerPressureId'];
    lookupDetIdSoftenerAvailable = json['lookupDetIdSoftenerAvailable'];
    lookupDetIdSpPre = json['lookupDetIdSpPre'];
    lookupDetIdSpPost = json['lookupDetIdSpPost'];
    spDifference = json['spDifference'];
    softenerRegenerationTime = json['softenerRegenerationTime'];
    softenerRegenerationDoneBy = json['softenerRegenerationDoneBy'];
    spComments = json['spComments'];
    carbonString = json['carbonString'];
    softString = json['softString'];
    userId = json['userId'];
    proLi = json['proLi'];
    machineNameList = json['machineNameList'];
    lookupDetIdRawWaterTds = json['lookupDetIdRawWaterTds'];
  }
  int? roMachineIssueLogsId;
  String? comments;
  dynamic status;
  dynamic createdDate;
  dynamic createdBy;
  dynamic updatedDate;
  dynamic updatedBy;
  dynamic macId;
  dynamic ipAddress;
  dynamic deviceFrom;
  int? unitId;
  int? roMachineMasterId;
  dynamic lookupDetId;
  dynamic srnId;
  dynamic issueDate;
  dynamic informationDate;
  dynamic issueDescription;
  dynamic informedTo;
  dynamic informedBy;
  dynamic callAttendedBy;
  dynamic correctiveAction;
  int? roLogSheetId;
  int? lookupDetIdSfpPre;
  int? lookupDetIdSfpPost;
  int? sfpDifference;
  int? lookupDetIdSandFilterBackwash;
  int? lookupDetIdSandFilterRinse;
  String? sandFilterDoneBy;
  int? lookupDetIdBeforeRegenerationHardness;
  int? beforeRegenerationHardnessValue;
  int? lookupDetIdAfterRegenerationHardness;
  int? afterRegenerationHardnessValue;
  int? rawWaterTdsValue;
  int? lookupDetIdRoWaterTds;
  int? roWaterTdsValue;
  double? preMembranePressure;
  double? rejectPressure;
  double? ppmPressureDifference;
  int? premeateFlowLph;
  int? lookupDetIdPostCarbonChlorine;
  double? postCarbonChlorineValue;
  int? lookupDetIdRoWaterConductivity;
  int? roWaterConductivityValue;
  int? rejectFlowLph;
  String? rawWaterPump1;
  String? rawWaterPump2;
  String? highPressurePump1;
  dynamic highPressurePump2;
  String? transferPump1;
  String? transferPump2;
  String? uvLamp1;
  String? uvLamp2;
  String? ufMicronFilter;
  String? dosingSystem;
  int? lookupDetIdReturnLoopPressure;
  int? returnLoopPressureValue;
  String? checkedBy;
  String? logSheetDate;
  dynamic carbonFilterPressureId;
  dynamic lookupDetIdCfpPre;
  dynamic lookupDetIdCfpPost;
  dynamic cfpDifference;
  dynamic lookupDetIdCarbonFilterBackwash;
  dynamic lookupDetIdCarbonFilterRinse;
  dynamic carbonFilterDoneBy;
  dynamic cfpComments;
  dynamic softenerPressureId;
  dynamic lookupDetIdSoftenerAvailable;
  dynamic lookupDetIdSpPre;
  dynamic lookupDetIdSpPost;
  dynamic spDifference;
  dynamic softenerRegenerationTime;
  dynamic softenerRegenerationDoneBy;
  dynamic spComments;
  String? carbonString;
  String? softString;
  dynamic userId;
  dynamic proLi;
  dynamic machineNameList;
  int? lookupDetIdRawWaterTds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roMachineIssueLogsId'] = roMachineIssueLogsId;
    map['comments'] = comments;
    map['status'] = status;
    map['createdDate'] = createdDate;
    map['createdBy'] = createdBy;
    map['updatedDate'] = updatedDate;
    map['updatedBy'] = updatedBy;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    map['unitId'] = unitId;
    map['roMachineMasterId'] = roMachineMasterId;
    map['lookupDetId'] = lookupDetId;
    map['srnId'] = srnId;
    map['issueDate'] = issueDate;
    map['informationDate'] = informationDate;
    map['issueDescription'] = issueDescription;
    map['informedTo'] = informedTo;
    map['informedBy'] = informedBy;
    map['callAttendedBy'] = callAttendedBy;
    map['correctiveAction'] = correctiveAction;
    map['roLogSheetId'] = roLogSheetId;
    map['lookupDetIdSfpPre'] = lookupDetIdSfpPre;
    map['lookupDetIdSfpPost'] = lookupDetIdSfpPost;
    map['sfpDifference'] = sfpDifference;
    map['lookupDetIdSandFilterBackwash'] = lookupDetIdSandFilterBackwash;
    map['lookupDetIdSandFilterRinse'] = lookupDetIdSandFilterRinse;
    map['sandFilterDoneBy'] = sandFilterDoneBy;
    map['lookupDetIdBeforeRegenerationHardness'] = lookupDetIdBeforeRegenerationHardness;
    map['beforeRegenerationHardnessValue'] = beforeRegenerationHardnessValue;
    map['lookupDetIdAfterRegenerationHardness'] = lookupDetIdAfterRegenerationHardness;
    map['afterRegenerationHardnessValue'] = afterRegenerationHardnessValue;
    map['rawWaterTdsValue'] = rawWaterTdsValue;
    map['lookupDetIdRoWaterTds'] = lookupDetIdRoWaterTds;
    map['roWaterTdsValue'] = roWaterTdsValue;
    map['preMembranePressure'] = preMembranePressure;
    map['rejectPressure'] = rejectPressure;
    map['ppmPressureDifference'] = ppmPressureDifference;
    map['premeateFlowLph'] = premeateFlowLph;
    map['lookupDetIdPostCarbonChlorine'] = lookupDetIdPostCarbonChlorine;
    map['postCarbonChlorineValue'] = postCarbonChlorineValue;
    map['lookupDetIdRoWaterConductivity'] = lookupDetIdRoWaterConductivity;
    map['roWaterConductivityValue'] = roWaterConductivityValue;
    map['rejectFlowLph'] = rejectFlowLph;
    map['rawWaterPump1'] = rawWaterPump1;
    map['rawWaterPump2'] = rawWaterPump2;
    map['highPressurePump1'] = highPressurePump1;
    map['highPressurePump2'] = highPressurePump2;
    map['transferPump1'] = transferPump1;
    map['transferPump2'] = transferPump2;
    map['uvLamp1'] = uvLamp1;
    map['uvLamp2'] = uvLamp2;
    map['ufMicronFilter'] = ufMicronFilter;
    map['dosingSystem'] = dosingSystem;
    map['lookupDetIdReturnLoopPressure'] = lookupDetIdReturnLoopPressure;
    map['returnLoopPressureValue'] = returnLoopPressureValue;
    map['checkedBy'] = checkedBy;
    map['logSheetDate'] = logSheetDate;
    map['carbonFilterPressureId'] = carbonFilterPressureId;
    map['lookupDetIdCfpPre'] = lookupDetIdCfpPre;
    map['lookupDetIdCfpPost'] = lookupDetIdCfpPost;
    map['cfpDifference'] = cfpDifference;
    map['lookupDetIdCarbonFilterBackwash'] = lookupDetIdCarbonFilterBackwash;
    map['lookupDetIdCarbonFilterRinse'] = lookupDetIdCarbonFilterRinse;
    map['carbonFilterDoneBy'] = carbonFilterDoneBy;
    map['cfpComments'] = cfpComments;
    map['softenerPressureId'] = softenerPressureId;
    map['lookupDetIdSoftenerAvailable'] = lookupDetIdSoftenerAvailable;
    map['lookupDetIdSpPre'] = lookupDetIdSpPre;
    map['lookupDetIdSpPost'] = lookupDetIdSpPost;
    map['spDifference'] = spDifference;
    map['softenerRegenerationTime'] = softenerRegenerationTime;
    map['softenerRegenerationDoneBy'] = softenerRegenerationDoneBy;
    map['spComments'] = spComments;
    map['carbonString'] = carbonString;
    map['softString'] = softString;
    map['userId'] = userId;
    map['proLi'] = proLi;
    map['machineNameList'] = machineNameList;
    map['lookupDetIdRawWaterTds'] = lookupDetIdRawWaterTds;
    return map;
  }

}