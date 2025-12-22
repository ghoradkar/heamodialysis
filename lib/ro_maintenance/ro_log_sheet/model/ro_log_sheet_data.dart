import 'ro_sheet_machine_master.dart';
import 'unit_sheet_master_dto.dart';

class RoLogSheetData {
  RoLogSheetData({
      this.roLogSheetId, 
      this.lookupDetIdSoftenerAvailable,
      this.roMachineMaster,
      this.unitMasterDto, 
      this.lookupDetIdSfpPre, 
      this.lookupDetIdSfpPost, 
      this.status, 
      this.sfpDifference, 
      this.lookupDetIdSandFilterBackwash, 
      this.lookupDetIdSandFilterRinse, 
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
      this.comments, 
      this.logSheetDate, 
      this.createdBy, 
      this.createdDate, 
      this.updatedBy, 
      this.srnId, 
      this.scrutinyUserId, 
      this.scrutinyLevelDetId, 
      this.lookupDetIdMovementStatus, 
      this.updatedDate, 
      this.macId, 
      this.ipAddress, 
      this.deviceFrom, 
      this.proLi, 
      this.count, 
      this.machineNameList, 
      this.carbCount, 
      this.softCount,});

  RoLogSheetData.fromJson(dynamic json) {
    roLogSheetId = json['roLogSheetId'];
    lookupDetIdSoftenerAvailable = json['lookupDetIdSoftenerAvailable'];
    roMachineMaster = json['roMachineMaster'] != null ? RoSheetMachineMaster.fromJson(json['roMachineMaster']) : null;
    unitMasterDto = json['unitMasterDto'] != null ? UnitSheetMasterDto.fromJson(json['unitMasterDto']) : null;
    lookupDetIdSfpPre = json['lookupDetIdSfpPre'];
    lookupDetIdSfpPost = json['lookupDetIdSfpPost'];
    status = json['status'];
    sfpDifference = json['sfpDifference'];
    lookupDetIdSandFilterBackwash = json['lookupDetIdSandFilterBackwash'];
    lookupDetIdSandFilterRinse = json['lookupDetIdSandFilterRinse'];
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
    comments = json['comments'];
    logSheetDate = json['logSheetDate'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    srnId = json['srnId'];
    scrutinyUserId = json['scrutinyUserId'];
    scrutinyLevelDetId = json['scrutinyLevelDetId'];
    lookupDetIdMovementStatus = json['lookupDetIdMovementStatus'];
    updatedDate = json['updatedDate'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    proLi = json['proLi'];
    count = json['count'];
    machineNameList = json['machineNameList'];
    carbCount = json['carbCount'];
    softCount = json['softCount'];
  }
  int? roLogSheetId;
  int? lookupDetIdSoftenerAvailable;
  RoSheetMachineMaster? roMachineMaster;
  UnitSheetMasterDto? unitMasterDto;
  int? lookupDetIdSfpPre;
  int? lookupDetIdSfpPost;
  int? status;
  int? sfpDifference;
  int? lookupDetIdSandFilterBackwash;
  int? lookupDetIdSandFilterRinse;
  String? sandFilterDoneBy;
  int? lookupDetIdBeforeRegenerationHardness;
  int? beforeRegenerationHardnessValue;
  int? lookupDetIdAfterRegenerationHardness;
  int? afterRegenerationHardnessValue;
  int? lookupDetIdRawWaterTds;
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
  String? comments;
  String? logSheetDate;
  int? createdBy;
  String? createdDate;
  dynamic updatedBy;
  int? srnId;
  dynamic scrutinyUserId;
  dynamic scrutinyLevelDetId;
  dynamic lookupDetIdMovementStatus;
  dynamic updatedDate;
  dynamic macId;
  dynamic ipAddress;
  dynamic deviceFrom;
  dynamic proLi;
  dynamic count;
  dynamic machineNameList;
  int? carbCount;
  int? softCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roLogSheetId'] = roLogSheetId;
    map['lookupDetIdSoftenerAvailable'] = lookupDetIdSoftenerAvailable;
    if (roMachineMaster != null) {
      map['roMachineMaster'] = roMachineMaster?.toJson();
    }
    if (unitMasterDto != null) {
      map['unitMasterDto'] = unitMasterDto?.toJson();
    }
    map['lookupDetIdSfpPre'] = lookupDetIdSfpPre;
    map['lookupDetIdSfpPost'] = lookupDetIdSfpPost;
    map['status'] = status;
    map['sfpDifference'] = sfpDifference;
    map['lookupDetIdSandFilterBackwash'] = lookupDetIdSandFilterBackwash;
    map['lookupDetIdSandFilterRinse'] = lookupDetIdSandFilterRinse;
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
    map['comments'] = comments;
    map['logSheetDate'] = logSheetDate;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['srnId'] = srnId;
    map['scrutinyUserId'] = scrutinyUserId;
    map['scrutinyLevelDetId'] = scrutinyLevelDetId;
    map['lookupDetIdMovementStatus'] = lookupDetIdMovementStatus;
    map['updatedDate'] = updatedDate;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    map['proLi'] = proLi;
    map['count'] = count;
    map['machineNameList'] = machineNameList;
    map['carbCount'] = carbCount;
    map['softCount'] = softCount;
    return map;
  }

}