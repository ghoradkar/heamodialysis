class SaveRequestModel {
  int? postDialysisInfusionId;
  int? postDialysisId;
  double? weight;
  int? bloodPressureH;
  int? bloodPressureL;
  int? lookupDetIdInfusion;
  int? patientId;
  int? treatmentId;
  int? unitId;
  int? pulse;
  double? temperature;
  double? finalUfv;
  int? venousPressure;
  int? bloodFlowQb;
  int? dialyticFlowQd;
  int? rrfUrineVolumeMlDay;
  int? herapinIu;
  int? respiratoryRate;
  String? remarks;
  int? dialysisStopDate;
  String? dialysisStopTime;
  int? status;
  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
  String? macId;
  String? ipAddress;
  String? deviceFrom;
  String? quantity;
  String? postRemark;
  double? weightDifference;
  String? causeDuration;
  String? temperatureUnit;
  String? caseNarration;
  int? physicalConsumableDetId;
  int? itemId;
  int? consumedQuantity;
  int? usedQuantity;
  int? variableQuantity;
  String? consumableModeFlag;
  String? remark;
  String? remarkFlag;
  String? dialysisStartDatetime;
  String? batchNo;
  String? expiryDate;
  String? orderNo;
  double? percentageFiberBundle;
  int? actualFiberBundle;
  String? disRemark;
  int? dilCeck;
  String? finalKTV;
  int? oxyLevel;
  int? diaDurationRemark;
  double? ufv;
  int? epoAdministered;
  int? epoBrandName;
  int? epoDose;
  int? epoFrequency;
  int? epoRoute;
  String? epoAdminDays; // "903,904,905..."
  int? epoStartDate;
  String? epoIndication;
  int? lastHgbHb;
  int? ironSucrose;
  int? ironPreparation;
  int? ironDose;
  int? ironFrequency;
  int? ironRoute;
  String? ironAdminDays; // "919,920,921..."
  int? ironStartDate;
  int? ironProtocolUsed;
  int? ferritinLevel;
  int? tsat;
  int? bloodTrans;
  int? captureVolume;
  String? bloodTransDate;
  String? postDialysisInfusion;
  String? dialysisDuration;
  double? cbv;

  SaveRequestModel({
    this.postDialysisInfusionId,
    this.postDialysisId,
    this.weight,
    this.bloodPressureH,
    this.bloodPressureL,
    this.lookupDetIdInfusion,
    this.patientId,
    this.treatmentId,
    this.unitId,
    this.pulse,
    this.temperature,
    this.finalUfv,
    this.venousPressure,
    this.bloodFlowQb,
    this.dialyticFlowQd,
    this.rrfUrineVolumeMlDay,
    this.herapinIu,
    this.respiratoryRate,
    this.remarks,
    this.dialysisStopDate,
    this.dialysisStopTime,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.macId,
    this.ipAddress,
    this.deviceFrom,
    this.quantity,
    this.postRemark,
    this.weightDifference,
    this.causeDuration,
    this.temperatureUnit,
    this.caseNarration,
    this.physicalConsumableDetId,
    this.itemId,
    this.consumedQuantity,
    this.usedQuantity,
    this.variableQuantity,
    this.consumableModeFlag,
    this.remark,
    this.remarkFlag,
    this.dialysisStartDatetime,
    this.batchNo,
    this.expiryDate,
    this.orderNo,
    this.percentageFiberBundle,
    this.actualFiberBundle,
    this.disRemark,
    this.dilCeck,
    this.finalKTV,
    this.oxyLevel,
    this.diaDurationRemark,
    this.ufv,
    this.epoAdministered,
    this.epoBrandName,
    this.epoDose,
    this.epoFrequency,
    this.epoRoute,
    this.epoAdminDays,
    this.epoStartDate,
    this.epoIndication,
    this.lastHgbHb,
    this.ironSucrose,
    this.ironPreparation,
    this.ironDose,
    this.ironFrequency,
    this.ironRoute,
    this.ironAdminDays,
    this.ironStartDate,
    this.ironProtocolUsed,
    this.ferritinLevel,
    this.tsat,
    this.bloodTrans,
    this.captureVolume,
    this.bloodTransDate,
    this.postDialysisInfusion,
    this.dialysisDuration,
    this.cbv,
  });

  factory SaveRequestModel.fromJson(Map<String, dynamic> json) {
    return SaveRequestModel(
      postDialysisInfusionId: json['postDialysisInfusionId'],
      postDialysisId: json['postDialysisId'],
      weight: json['weight'],
      bloodPressureH: json['bloodPressureH'],
      bloodPressureL: json['bloodPressureL'],
      lookupDetIdInfusion: json['lookupDetIdInfusion'],
      patientId: json['patientId'],
      treatmentId: json['treatmentId'],
      unitId: json['unitId'],
      pulse: json['pulse'],
      temperature: json['temperature'],
      finalUfv: json['finalUfv'],
      venousPressure: json['venousPressure'],
      bloodFlowQb: json['bloodFlowQb'],
      dialyticFlowQd: json['dialyticFlowQd'],
      rrfUrineVolumeMlDay: json['rrfUrineVolumeMlDay'],
      herapinIu: json['herapinIu'],
      respiratoryRate: json['respiratoryRate'],
      remarks: json['remarks'],
      dialysisStopDate: json['dialysisStopDate'],
      dialysisStopTime: json['dialysis_stopTime'],
      status: json['status'],
      createdBy: json['createdBy'],
      createdDate: json['createdDate'],
      updatedBy: json['updatedBy'],
      updatedDate: json['updatedDate'],
      macId: json['macId'],
      ipAddress: json['ipAddress'],
      deviceFrom: json['deviceFrom'],
      quantity: json['quantity'],
      postRemark: json['postRemark'],
      weightDifference: (json['weightDifference'] as num?)?.toDouble(),
      causeDuration: json['causeDuration'],
      temperatureUnit: json['temperatureUnit'],
      caseNarration: json['caseNarration'],
      physicalConsumableDetId: json['physicalConsumableDetId'],
      itemId: json['itemId'],
      consumedQuantity: json['consumedQuantity'],
      usedQuantity: json['usedQuantity'],
      variableQuantity: json['variableQuantity'],
      consumableModeFlag: json['consumableModeFlag'],
      remark: json['remark'],
      remarkFlag: json['remarkFlag'],
      dialysisStartDatetime: json['dialysisStartDatetime'],
      batchNo: json['batchNo'],
      expiryDate: json['expiryDate'],
      orderNo: json['orderNo'],
      percentageFiberBundle: (json['percentageFiberBundle'] as num?)?.toDouble(),
      actualFiberBundle: json['actualFiberBundle'],
      disRemark: json['disRemark'],
      dilCeck: json['dilCeck'],
      finalKTV: json['finalKTV'],
      oxyLevel: json['oxyLevel'],
      diaDurationRemark: json['diaDurationRemark'],
      ufv: (json['ufv'] as num?)?.toDouble(),
      epoAdministered: json['epoAdministered'],
      epoBrandName: json['epoBrandName'],
      epoDose: json['epoDose'],
      epoFrequency: json['epoFrequency'],
      epoRoute: json['epoRoute'],
      epoAdminDays: json['epoAdminDays'],
      epoStartDate: json['epoStartDate'],
      epoIndication: json['epoIndication'],
      lastHgbHb: json['lastHgbHb'],
      ironSucrose: json['ironSucrose'],
      ironPreparation: json['ironPreparation'],
      ironDose: json['ironDose'],
      ironFrequency: json['ironFrequency'],
      ironRoute: json['ironRoute'],
      ironAdminDays: json['ironAdminDays'],
      ironStartDate: json['ironStartDate'],
      ironProtocolUsed: json['ironProtocolUsed'],
      ferritinLevel: json['ferritinLevel'],
      tsat: json['tsat'],
      bloodTrans: json['bloodTrans'],
      captureVolume: json['captureVolume'],
      bloodTransDate: json['bloodTransDate'],
      postDialysisInfusion: json['postDialysisInfusion'],
      dialysisDuration: json['dialysisDuration'],
      cbv: (json['cbv'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['postDialysisInfusionId'] = postDialysisInfusionId;
    map['postDialysisId'] = postDialysisId;
    map['weight'] = weight;
    map['bloodPressureH'] = bloodPressureH;
    map['bloodPressureL'] = bloodPressureL;
    map['lookupDetIdInfusion'] = lookupDetIdInfusion;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['unitId'] = unitId;
    map['pulse'] = pulse;
    map['temperature'] = temperature;
    map['finalUfv'] = finalUfv;
    map['venousPressure'] = venousPressure;
    map['bloodFlowQb'] = bloodFlowQb;
    map['dialyticFlowQd'] = dialyticFlowQd;
    map['rrfUrineVolumeMlDay'] = rrfUrineVolumeMlDay;
    map['herapinIu'] = herapinIu;
    map['respiratoryRate'] = respiratoryRate;
    map['remarks'] = remarks;
    map['dialysisStopDate'] = dialysisStopDate;
    map['dialysis_stopTime'] = dialysisStopTime;
    map['status'] = status;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    map['quantity'] = quantity;
    map['postRemark'] = postRemark;
    map['weightDifference'] = weightDifference;
    map['causeDuration'] = causeDuration;
    map['temperatureUnit'] = temperatureUnit;
    map['caseNarration'] = caseNarration;
    map['physicalConsumableDetId'] = physicalConsumableDetId;
    map['itemId'] = itemId;
    map['consumedQuantity'] = consumedQuantity;
    map['usedQuantity'] = usedQuantity;
    map['variableQuantity'] = variableQuantity;
    map['consumableModeFlag'] = consumableModeFlag;
    map['remark'] = remark;
    map['remarkFlag'] = remarkFlag;
    map['dialysisStartDatetime'] = dialysisStartDatetime;
    map['batchNo'] = batchNo;
    map['expiryDate'] = expiryDate;
    map['orderNo'] = orderNo;
    map['percentageFiberBundle'] = percentageFiberBundle;
    map['actualFiberBundle'] = actualFiberBundle;
    map['disRemark'] = disRemark;
    map['dilCeck'] = dilCeck;
    map['finalKTV'] = finalKTV;
    map['oxyLevel'] = oxyLevel;
    map['diaDurationRemark'] = diaDurationRemark;
    map['ufv'] = ufv;
    map['epoAdministered'] = epoAdministered;
    map['epoBrandName'] = epoBrandName;
    map['epoDose'] = epoDose;
    map['epoFrequency'] = epoFrequency;
    map['epoRoute'] = epoRoute;
    map['epoAdminDays'] = epoAdminDays;
    map['epoStartDate'] = epoStartDate;
    map['epoIndication'] = epoIndication;
    map['lastHgbHb'] = lastHgbHb;
    map['ironSucrose'] = ironSucrose;
    map['ironPreparation'] = ironPreparation;
    map['ironDose'] = ironDose;
    map['ironFrequency'] = ironFrequency;
    map['ironRoute'] = ironRoute;
    map['ironAdminDays'] = ironAdminDays;
    map['ironStartDate'] = ironStartDate;
    map['ironProtocolUsed'] = ironProtocolUsed;
    map['ferritinLevel'] = ferritinLevel;
    map['tsat'] = tsat;
    map['bloodTrans'] = bloodTrans;
    map['captureVolume'] = captureVolume;
    map['bloodTransDate'] = bloodTransDate;
    map['postDialysisInfusion'] = postDialysisInfusion;
    map['dialysisDuration'] = dialysisDuration;
    map['cbv'] = cbv;
    return map;
  }
}


// class SaveRequestModel {
//
//   int? postDialysisId;
//   int? postDialysisInfusionId;
//   dynamic weight;
//   int? bloodPressureH;
//   int? bloodPressureL;
//   int? lookupDetIdInfusion;
//   int? patientId;
//   int? treatmentId;
//   int? unitId;
//   num? pulse;
//   dynamic temperature;
//   dynamic finalUfv;
//   int? venousPressure;
//   int? respiratoryRate;
//   int? dialyticFlowQd;
//   int? createdBy;
//   num? herapinIu;
//   String? caseNarration;
//   String? dialysisStopTime;
//   int? rrfUrineVolumeMlDay;
//   int? dialysisDuration;
//   String? postRemark;
//   int? weightDifference;
//   int? bloodFlowQb;
//   int? actualFiberBundle;
//   double? percentageFiberBundle;
//   int? dilCeck;
//   int? disRemark;
//   int? finalKTV;
//   int? oxyLevel;
//   int? diaDurationRemark;
//   int? ufv;
//   int? postDialysisInfusion;
//   String? remarks;
//   String? dialysisStopDate;
//   int? status;
//   String? createdDate;
//   int? updatedBy;
//   String? updatedDate;
//   int? macId;
//   int? ipAddress;
//   String? deviceFrom;
//   String? quantity;
//   String? causeDuration;
//   String? temperatureUnit;
//   int? physicalConsumableDetId;
//   int? itemId;
//   int? consumedQuantity;
//   int? usedQuantity;
//   int? variableQuantity;
//   String? consumableModeFlag;
//   String? remark;
//   String? remarkFlag;
//   String? dialysisStartDatetime;
//   String? batchNo;
//   String? expiryDate;
//   String? orderNo;
//
//   SaveRequestModel({
//       this.postDialysisInfusionId,
//       this.postDialysisId,
//       this.weight,
//       this.bloodPressureH,
//       this.bloodPressureL,
//       this.lookupDetIdInfusion,
//       this.patientId,
//       this.treatmentId,
//       this.unitId,
//       this.pulse,
//       this.temperature,
//       this.finalUfv,
//       this.venousPressure,
//       this.respiratoryRate,
//       this.dialyticFlowQd,
//       this.createdBy,
//       this.herapinIu,
//       this.caseNarration,
//       this.dialysisStopTime,
//       this.rrfUrineVolumeMlDay,
//       this.dialysisDuration,
//       this.postRemark,
//       this.weightDifference,
//       this.bloodFlowQb,
//       this.actualFiberBundle,
//       this.percentageFiberBundle,
//       this.dilCeck,
//       this.disRemark,
//       this.finalKTV,
//       this.oxyLevel,
//       this.diaDurationRemark,
//       this.ufv,
//       this.postDialysisInfusion,
//       this.remarks,
//       this.dialysisStopDate,
//       this.status,
//       this.createdDate,
//       this.updatedBy,
//       this.updatedDate,
//       this.macId,
//       this.ipAddress,
//       this.deviceFrom,
//       this.quantity,
//       this.causeDuration,
//       this.temperatureUnit,
//       this.physicalConsumableDetId,
//       this.itemId,
//       this.consumedQuantity,
//       this.usedQuantity,
//       this.variableQuantity,
//       this.consumableModeFlag,
//       this.remark,
//       this.remarkFlag,
//       this.dialysisStartDatetime,
//       this.batchNo,
//       this.expiryDate,
//       this.orderNo,
//
//   });
//
//   SaveRequestModel.fromJson(dynamic json) {
//     postDialysisInfusionId = json['postDialysisInfusionId'];
//     postDialysisId = json['postDialysisId'];
//     weight = json['weight'];
//     bloodPressureH = json['bloodPressureH'];
//     bloodPressureL = json['bloodPressureL'];
//     lookupDetIdInfusion = json['lookupDetIdInfusion'];
//     patientId = json['patientId'];
//     treatmentId = json['treatmentId'];
//     unitId = json['unitId'];
//     pulse = json['pulse'];
//     temperature = json['temperature'];
//     finalUfv = json['finalUfv'];
//     venousPressure = json['venousPressure'];
//     respiratoryRate = json['respiratoryRate'];
//     dialyticFlowQd = json['dialyticFlowQd'];
//     createdBy = json['createdBy'];
//     herapinIu = json['herapinIu'];
//     caseNarration = json['caseNarration'];
//     dialysisStopTime = json['dialysis_stopTime'];
//     rrfUrineVolumeMlDay = json['rrfUrineVolumeMlDay'];
//     dialysisDuration = json['dialysisDuration'];
//     postRemark = json['postRemark'];
//     weightDifference = json['weightDifference'];
//     bloodFlowQb = json['bloodFlowQb'];
//     actualFiberBundle = json['actualFiberBundle'];
//     percentageFiberBundle = json['percentageFiberBundle'];
//     dilCeck = json['dilCeck'];
//     disRemark = json['disRemark'];
//     finalKTV = json['finalKTV'];
//     oxyLevel = json['oxyLevel'];
//     diaDurationRemark = json['diaDurationRemark'];
//     ufv = json['ufv'];
//     postDialysisInfusion = json['postDialysisInfusion'];
//     remarks = json['remarks'];
//     dialysisStopDate = json['dialysisStopDate'];
//     status = json['status'];
//     createdDate = json['createdDate'];
//     updatedBy = json['updatedBy'];
//     updatedDate = json['updatedDate'];
//     macId = json['macId'];
//     ipAddress = json['ipAddress'];
//     deviceFrom = json['deviceFrom'];
//     quantity = json['quantity'];
//     causeDuration = json['causeDuration'];
//     temperatureUnit = json['temperatureUnit'];
//     physicalConsumableDetId = json['physicalConsumableDetId'];
//     itemId = json['itemId'];
//     consumedQuantity = json['consumedQuantity'];
//     usedQuantity = json['usedQuantity'];
//     variableQuantity = json['variableQuantity'];
//     consumableModeFlag = json['consumableModeFlag'];
//     remark = json['remark'];
//     remarkFlag = json['remarkFlag'];
//     dialysisStartDatetime = json['dialysisStartDatetime'];
//     batchNo = json['batchNo'];
//     expiryDate = json['expiryDate'];
//     orderNo = json['orderNo'];
//   }
//
//
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['postDialysisInfusionId'] = postDialysisInfusionId;
//     map['postDialysisId'] = postDialysisId;
//     map['weight'] = weight;
//     map['bloodPressureH'] = bloodPressureH;
//     map['bloodPressureL'] = bloodPressureL;
//     map['lookupDetIdInfusion'] = lookupDetIdInfusion;
//     map['patientId'] = patientId;
//     map['treatmentId'] = treatmentId;
//     map['unitId'] = unitId;
//     map['pulse'] = pulse;
//     map['temperature'] = temperature;
//     map['finalUfv'] = finalUfv;
//     map['venousPressure'] = venousPressure;
//     map['respiratoryRate'] = respiratoryRate;
//     map['dialyticFlowQd'] = dialyticFlowQd;
//     map['createdBy'] = createdBy;
//     map['herapinIu'] = herapinIu;
//     map['caseNarration'] = caseNarration;
//     map['dialysis_stopTime'] = dialysisStopTime;
//     map['rrfUrineVolumeMlDay'] = rrfUrineVolumeMlDay;
//     map['dialysisDuration'] = dialysisDuration;
//     map['postRemark'] = postRemark;
//     map['weightDifference'] = weightDifference;
//     map['bloodFlowQb'] = bloodFlowQb;
//     map['actualFiberBundle'] = actualFiberBundle;
//     map['percentageFiberBundle'] = percentageFiberBundle;
//     map['dilCeck'] = dilCeck;
//     map['disRemark'] = disRemark;
//     map['finalKTV'] = finalKTV;
//     map['oxyLevel'] = oxyLevel;
//     map['diaDurationRemark'] = diaDurationRemark;
//     map['ufv'] = ufv;
//     map['postDialysisInfusion'] = postDialysisInfusion;
//     map['remarks'] = remarks;
//     map['dialysisStopDate'] = dialysisStopDate;
//     map['createdDate'] = createdDate;
//     map['status'] = status;
//     map['updatedBy'] = updatedBy;
//     map['updatedDate'] = updatedDate;
//     map['macId'] = macId;
//     map['ipAddress'] = ipAddress;
//     map['deviceFrom'] = deviceFrom;
//     map['causeDuration'] = causeDuration;
//     map['temperatureUnit'] = temperatureUnit;
//     map['physicalConsumableDetId'] = physicalConsumableDetId;
//     map['itemId'] = itemId;
//     map['consumedQuantity'] = consumedQuantity;
//     map['usedQuantity'] = usedQuantity;
//     map['usedQuantity'] = usedQuantity;
//     map['consumableModeFlag'] = consumableModeFlag;
//     map['remark'] = remark;
//     map['remarkFlag'] = remarkFlag;
//     map['dialysisStartDatetime'] = dialysisStartDatetime;
//     map['batchNo'] = batchNo;
//     map['expiryDate'] = expiryDate;
//     map['orderNo'] = orderNo;
//     map['variableQuantity'] = variableQuantity;
//     map['quantity'] = quantity;
//     return map;
//   }
//
// }