class EditReqModel {
  EditReqModel({
      this.patientId, 
      this.treatmentId, 
      this.lookupDetIdDialysisType, 
      this.lookupDetHierId1AccessType, 
      this.lookupDetHierId2AccessSite, 
      this.lookupDetIdDialysarType, 
      this.lookupDetIdSpecialDialysis, 
      this.weight, 
      this.bloodPressureH, 
      this.bloodPressureL, 
      this.pulse, 
      this.temperature, 
      this.dialyzerDiscardedFlag, 
      this.heightCm, 
      this.heightInch, 
      this.respiratoryRate, 
      this.dialysisStartDate, 
      this.dialysisStartTime, 
      this.status, 
      this.createdBy, 
      this.preHdCondition, 
      this.dryWeight, 
      this.interDialyticWeightGain, 
      this.discardreamrk, 
      this.temperatureUnit,
      this.dialyserFlag,
      this.dialyserBarcodeSerialNo, 
      this.dialyserResueNo, 
      this.dialyserRemarks, 
      this.tubeFlag, 
      this.tubeBarcodeSerialNo, 
      this.tubeResueNo, 
      this.tubeRemarks, 
      this.oxyLevel,
      this.naRemarks,
      this.unitId,
      this.fiberBundle,
  });

  EditReqModel.fromJson(dynamic json) {
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    lookupDetIdDialysisType = json['lookupDetIdDialysisType'];
    lookupDetHierId1AccessType = json['lookupDetHierId1AccessType'];
    lookupDetHierId2AccessSite = json['lookupDetHierId2AccessSite'];
    lookupDetIdDialysarType = json['lookupDetIdDialysarType'];
    lookupDetIdSpecialDialysis = json['lookupDetIdSpecialDialysis'];
    weight = json['weight'];
    bloodPressureH = json['bloodPressureH'];
    bloodPressureL = json['bloodPressureL'];
    pulse = json['pulse'];
    temperature = json['temperature'];
    dialyzerDiscardedFlag = json['dialyzerDiscardedFlag'];
    heightCm = json['heightCm'];
    heightInch = json['heightInch'];
    respiratoryRate = json['respiratoryRate'];
    dialysisStartDate = json['dialysisStartDate'];
    dialysisStartTime = json['dialysisStartTime'];
    status = json['status'];
    createdBy = json['createdBy'];
    preHdCondition = json['preHdCondition'];
    dryWeight = json['dryWeight'];
    interDialyticWeightGain = json['interDialyticWeightGain'];
    discardreamrk = json['discardreamrk'];
    temperatureUnit = json['temperatureUnit'];
    dialyserFlag = json['dialyserFlag'];
    dialyserBarcodeSerialNo = json['dialyserBarcodeSerialNo'];
    dialyserResueNo = json['dialyserResueNo'];
    dialyserRemarks = json['dialyserRemarks'];
    tubeFlag = json['tubeFlag'];
    tubeBarcodeSerialNo = json['tubeBarcodeSerialNo'];
    tubeResueNo = json['tubeResueNo'];
    tubeRemarks = json['tubeRemarks'];
    oxyLevel = json['oxyLevel'];
    naRemarks = json['naRemarks'];
    unitId = json['unitId'];
    fiberBundle = json['fiberBundle'];
  }
  String? patientId;
  String? treatmentId;
  int? lookupDetIdDialysisType;
  int? lookupDetHierId1AccessType;
  int? lookupDetHierId2AccessSite;
  int? lookupDetIdDialysarType;
  int? lookupDetIdSpecialDialysis;
  String? weight;
  String? bloodPressureH;
  String? bloodPressureL;
  int? pulse;
  String? temperature;
  String? dialyzerDiscardedFlag;
  int? heightCm;
  int? heightInch;
  int? respiratoryRate;
  String? dialysisStartDate;
  String? dialysisStartTime;
  int? status;
  String? createdBy;
  String? preHdCondition;
  String? dryWeight;
  String? interDialyticWeightGain;
  int? discardreamrk;
  String? temperatureUnit;
  String? dialyserFlag;
  String? dialyserBarcodeSerialNo;
  String? dialyserResueNo;
  String? dialyserRemarks;
  String? tubeFlag;
  String? tubeBarcodeSerialNo;
  int? tubeResueNo;
  String? tubeRemarks;
  int? oxyLevel;
  String? naRemarks;
  int? unitId;
  int? fiberBundle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['lookupDetIdDialysisType'] = lookupDetIdDialysisType;
    map['lookupDetHierId1AccessType'] = lookupDetHierId1AccessType;
    map['lookupDetHierId2AccessSite'] = lookupDetHierId2AccessSite;
    map['lookupDetIdDialysarType'] = lookupDetIdDialysarType;
    map['lookupDetIdSpecialDialysis'] = lookupDetIdSpecialDialysis;
    map['weight'] = weight;
    map['bloodPressureH'] = bloodPressureH;
    map['bloodPressureL'] = bloodPressureL;
    map['pulse'] = pulse;
    map['temperature'] = temperature;
    map['dialyzerDiscardedFlag'] = dialyzerDiscardedFlag;
    map['heightCm'] = heightCm;
    map['heightInch'] = heightInch;
    map['respiratoryRate'] = respiratoryRate;
    map['dialysisStartDate'] = dialysisStartDate;
    map['dialysisStartTime'] = dialysisStartTime;
    map['status'] = status;
    map['createdBy'] = createdBy;
    map['preHdCondition'] = preHdCondition;
    map['dryWeight'] = dryWeight;
    map['interDialyticWeightGain'] = interDialyticWeightGain;
    map['discardreamrk'] = discardreamrk;
    map['temperatureUnit'] = temperatureUnit;
    map['dialyserFlag'] = dialyserFlag;
    map['dialyserBarcodeSerialNo'] = dialyserBarcodeSerialNo;
    map['dialyserResueNo'] = dialyserResueNo;
    map['dialyserRemarks'] = dialyserRemarks;
    map['tubeFlag'] = tubeFlag;
    map['tubeBarcodeSerialNo'] = tubeBarcodeSerialNo;
    map['tubeResueNo'] = tubeResueNo;
    map['tubeRemarks'] = tubeRemarks;
    map['oxyLevel'] = oxyLevel;
    map['naRemarks'] = naRemarks;
    map['unitId'] = unitId;
    map['fiberBundle'] = fiberBundle;
    return map;
  }

}