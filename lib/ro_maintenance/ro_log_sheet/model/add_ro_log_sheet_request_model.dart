class AddRoLogSheetRequestModel {

  AddRoLogSheetRequestModel({
      this.roLogSheetId, 
      this.roMachineMasterId,
      this.lookupDetIdSfpPre, 
      this.lookupDetIdSfpPost, 
      this.sfpDifference, 
      this.lookupDetIdSandFilterBackwash, 
      this.lookupDetIdSandFilterRinse, 
      this.logSheetDate, 
      this.sandFilterDoneBy, 
      this.lookupDetIdBeforeRegenerationHardness, 
      this.beforeRegenerationHardnessValue, 
      this.lookupDetIdAfterRegenerationHardness, 
      this.afterRegenerationHardnessValue, 
      this.lookupDetIdRawWaterTds, 
      this.rawWaterTdsValue, 
      this.lookupDetIdRoWaterTds, 
      this.roWaterTdsValue, 
      this.preMembranePressure, 
      this.rejectPressure, 
      this.ppmPressureDifference, 
      this.premeateFlowLph, 
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
      this.comments, 
      this.lookupDetIdCfpPre, 
      this.lookupDetDesCfpPre,
      this.lookupDetDesCfpPost,
      this.lookupDetIdCfpPost,
      this.cfpDifference, 
      this.lookupDetIdCarbonFilterBackwash, 
      this.lookupDetIdCarbonFilterBackwashDes,
      this.lookupDetIdCarbonFilterRinse,
      this.lookupDetIdCarbonFilterRinseDes,
      this.carbonFilterDoneBy,
      this.carbonFilterDoneByDes,
      this.lookupDetIdSpPre,
      this.lookupDetDescrSpPre,
      this.lookupDetIdSpPost,
      this.lookupDetDescrSpPost,
      this.spDifference,
      this.softenerRegenerationTime, 
      this.softenerRegenerationDoneBy, 
      this.softenerRegenerationDoneByDescrip,
      this.lookupDetIdPostCarbonChlorine,
      this.postCarbonChlorineValue, 
      this.lookupDetIdRoWaterConductivity, 
      this.roWaterConductivityValue, 
      this.rejectFlowLph, 
      this.lookupDetIdSoftenerAvailable,
      this.lookupDetIdSoftenerAvailableDes,
      this.cfpComments,
      this.spComments, 
      this.softenerPressureId, 
      this.carbonFilterPressureId, 
      this.rawWaterPump1, 
      this.createdBy, 
      this.unitId, 
      this.srnId,});

  AddRoLogSheetRequestModel.fromJson(dynamic json) {
    roLogSheetId = json['roLogSheetId'];
    roMachineMasterId = json['roMachineMasterId'];
    lookupDetIdSfpPre = json['lookupDetIdSfpPre'];
    lookupDetIdSfpPost = json['lookupDetIdSfpPost'];
    sfpDifference = json['sfpDifference'];
    lookupDetIdSandFilterBackwash = json['lookupDetIdSandFilterBackwash'];
    lookupDetIdSandFilterRinse = json['lookupDetIdSandFilterRinse'];
    logSheetDate = json['logSheetDate'];
    sandFilterDoneBy = json['sandFilterDoneBy'];
    lookupDetIdBeforeRegenerationHardness = json['lookupDetIdBeforeRegenerationHardness'];
    beforeRegenerationHardnessValue = json['beforeRegenerationHardnessValue'];
    lookupDetIdAfterRegenerationHardness = json['lookupDetIdAfterRegenerationHardness'];
    afterRegenerationHardnessValue = json['afterRegenerationHardnessValue'];
    lookupDetIdRawWaterTds = json['lookupDetIdRawWaterTds'];
    rawWaterTdsValue = json['rawWaterTdsValue'];
    lookupDetIdRoWaterTds = json['lookupDetIdRoWaterTds'];
    roWaterTdsValue = json['roWaterTdsValue'];
    preMembranePressure = json['preMembranePressure'];
    rejectPressure = json['rejectPressure'];
    ppmPressureDifference = json['ppmPressureDifference'];
    premeateFlowLph = json['premeateFlowLph'];
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
    comments = json['comments'];
    lookupDetIdCfpPre = json['lookupDetIdCfpPre'];
    lookupDetIdCfpPost = json['lookupDetIdCfpPost'];
    cfpDifference = json['cfpDifference'];
    lookupDetIdCarbonFilterBackwash = json['lookupDetIdCarbonFilterBackwash'];
    lookupDetIdCarbonFilterRinse = json['lookupDetIdCarbonFilterRinse'];
    carbonFilterDoneBy = json['carbonFilterDoneBy'];
    lookupDetIdSpPre = json['lookupDetIdSpPre'];
    lookupDetIdSpPost = json['lookupDetIdSpPost'];
    spDifference = json['spDifference'];
    softenerRegenerationTime = json['softenerRegenerationTime'];
    softenerRegenerationDoneBy = json['softenerRegenerationDoneBy'];
    lookupDetIdPostCarbonChlorine = json['lookupDetIdPostCarbonChlorine'];
    postCarbonChlorineValue = json['postCarbonChlorineValue'];
    lookupDetIdRoWaterConductivity = json['lookupDetIdRoWaterConductivity'];
    roWaterConductivityValue = json['roWaterConductivityValue'];
    rejectFlowLph = json['rejectFlowLph'];
    lookupDetIdSoftenerAvailable = json['lookupDetIdSoftenerAvailable'];
    cfpComments = json['cfpComments'];
    spComments = json['spComments'];
    softenerPressureId = json['softenerPressureId'];
    carbonFilterPressureId = json['carbonFilterPressureId'];
    rawWaterPump1 = json['rawWaterPump1'];
    createdBy = json['createdBy'];
    unitId = json['unitId'];
    srnId = json['srnId'];
  }
  int? roLogSheetId;
  int? roMachineMasterId;
  String? lookupDetIdSfpPre;
  String? lookupDetIdSfpPost;
  int? sfpDifference;
  int? lookupDetIdSandFilterBackwash;
  int? lookupDetIdSandFilterRinse;
  String? logSheetDate;
  int? sandFilterDoneBy;
  int? lookupDetIdBeforeRegenerationHardness;
  int? beforeRegenerationHardnessValue;
  int? lookupDetIdAfterRegenerationHardness;
  int? afterRegenerationHardnessValue;
  int? lookupDetIdRawWaterTds;
  int? rawWaterTdsValue;
  int? lookupDetIdRoWaterTds;
  int? roWaterTdsValue;
  int? preMembranePressure;
  int? rejectPressure;
  int? ppmPressureDifference;
  int? premeateFlowLph;
  int? rawWaterPump2;
  int? highPressurePump1;
  int? highPressurePump2;
  int? transferPump1;
  int? transferPump2;
  int? uvLamp1;
  int? uvLamp2;
  int? ufMicronFilter;
  int? dosingSystem;
  int? lookupDetIdReturnLoopPressure;
  int? returnLoopPressureValue;
  int? checkedBy;
  String? comments;
  String? lookupDetIdCfpPre;
  String? lookupDetIdCfpPost;
  String? lookupDetDesCfpPre;
  String? lookupDetDesCfpPost;
  String? cfpDifference;
  String? lookupDetIdCarbonFilterBackwash;
  String? lookupDetIdCarbonFilterBackwashDes;
  String? lookupDetIdCarbonFilterRinse;
  String? lookupDetIdCarbonFilterRinseDes;
  String? carbonFilterDoneBy;
  String? carbonFilterDoneByDes;
  String? lookupDetIdSpPre;
  String? lookupDetDescrSpPre;
  String? lookupDetIdSpPost;
  String? lookupDetDescrSpPost;
  String? spDifference;
  String? softenerRegenerationTime;
  String? softenerRegenerationDoneBy;
  String? softenerRegenerationDoneByDescrip;
  int? lookupDetIdPostCarbonChlorine;
  int? postCarbonChlorineValue;
  int? lookupDetIdRoWaterConductivity;
  int? roWaterConductivityValue;
  int? rejectFlowLph;
  int? lookupDetIdSoftenerAvailable;
  String? lookupDetIdSoftenerAvailableDes;
  String? cfpComments;
  String? spComments;
  String? softenerPressureId;
  String? carbonFilterPressureId;
  int? rawWaterPump1;
  int? createdBy;
  int? unitId;
  int? srnId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roLogSheetId'] = roLogSheetId;
    map['roMachineMasterId'] = roMachineMasterId;
    map['lookupDetIdSfpPre'] = lookupDetIdSfpPre;
    map['lookupDetIdSfpPost'] = lookupDetIdSfpPost;
    map['sfpDifference'] = sfpDifference;
    map['lookupDetIdSandFilterBackwash'] = lookupDetIdSandFilterBackwash;
    map['lookupDetIdSandFilterRinse'] = lookupDetIdSandFilterRinse;
    map['logSheetDate'] = logSheetDate;
    map['sandFilterDoneBy'] = sandFilterDoneBy;
    map['lookupDetIdBeforeRegenerationHardness'] = lookupDetIdBeforeRegenerationHardness;
    map['beforeRegenerationHardnessValue'] = beforeRegenerationHardnessValue;
    map['lookupDetIdAfterRegenerationHardness'] = lookupDetIdAfterRegenerationHardness;
    map['afterRegenerationHardnessValue'] = afterRegenerationHardnessValue;
    map['lookupDetIdRawWaterTds'] = lookupDetIdRawWaterTds;
    map['rawWaterTdsValue'] = rawWaterTdsValue;
    map['lookupDetIdRoWaterTds'] = lookupDetIdRoWaterTds;
    map['roWaterTdsValue'] = roWaterTdsValue;
    map['preMembranePressure'] = preMembranePressure;
    map['rejectPressure'] = rejectPressure;
    map['ppmPressureDifference'] = ppmPressureDifference;
    map['premeateFlowLph'] = premeateFlowLph;
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
    map['comments'] = comments;
    map['lookupDetIdCfpPre'] = lookupDetIdCfpPre;
    map['lookupDetIdCfpPost'] = lookupDetIdCfpPost;
    map['cfpDifference'] = cfpDifference;
    map['lookupDetIdCarbonFilterBackwash'] = lookupDetIdCarbonFilterBackwash;
    map['lookupDetIdCarbonFilterRinse'] = lookupDetIdCarbonFilterRinse;
    map['carbonFilterDoneBy'] = carbonFilterDoneBy;
    map['lookupDetIdSpPre'] = lookupDetIdSpPre;
    map['lookupDetIdSpPost'] = lookupDetIdSpPost;
    map['spDifference'] = spDifference;
    map['softenerRegenerationTime'] = softenerRegenerationTime;
    map['softenerRegenerationDoneBy'] = softenerRegenerationDoneBy;
    map['lookupDetIdPostCarbonChlorine'] = lookupDetIdPostCarbonChlorine;
    map['postCarbonChlorineValue'] = postCarbonChlorineValue;
    map['lookupDetIdRoWaterConductivity'] = lookupDetIdRoWaterConductivity;
    map['roWaterConductivityValue'] = roWaterConductivityValue;
    map['rejectFlowLph'] = rejectFlowLph;
    map['lookupDetIdSoftenerAvailable'] = lookupDetIdSoftenerAvailable;
    map['cfpComments'] = cfpComments;
    map['spComments'] = spComments;
    map['softenerPressureId'] = softenerPressureId;
    map['carbonFilterPressureId'] = carbonFilterPressureId;
    map['rawWaterPump1'] = rawWaterPump1;
    map['createdBy'] = createdBy;
    map['unitId'] = unitId;
    map['srnId'] = srnId;
    return map;
  }

}