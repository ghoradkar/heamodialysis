class HistoryData {
  HistoryData({
      this.preDialysisId, 
      this.unitId, 
      this.patientId, 
      this.treatmentId, 
      this.lookupDetIdDialysisType, 
      this.lookupDetHierId1AccessType, 
      this.lookupDetHierId2AccessSite, 
      this.lookupDetIdDialysarType, 
      this.lookupDetIdSpecialDialysis, 
      this.dialyzerDiscardedFlag, 
      this.weight, 
      this.bloodPressureH, 
      this.bloodPressureL, 
      this.pulse, 
      this.temperature, 
      this.heightCm, 
      this.heightInch, 
      this.dialysisStartDate, 
      this.dialysisStartTime, 
      this.respiratoryRate, 
      this.status, 
      this.createdBy, 
      this.createdDate, 
      this.updatedBy, 
      this.updatedDate, 
      this.macId, 
      this.ipAddress, 
      this.deviceFrom, 
      this.preHdCondition, 
      this.dryWeight, 
      this.interDialyticWeightGain, 
      this.discardreamrk, 
      this.getttPreDialysis, 
      this.dialyserFlag, 
      this.dialyserBarcodeSerialNo, 
      this.dialyserResueNo, 
      this.dialyserRemarks, 
      this.tubeFlag, 
      this.tubeBarcodeSerialNo, 
      this.tubeResueNo, 
      this.tubeRemarks,});

  HistoryData.fromJson(dynamic json) {
    preDialysisId = json['preDialysisId'];
    unitId = json['unitId'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    lookupDetIdDialysisType = json['lookupDetIdDialysisType'];
    lookupDetHierId1AccessType = json['lookupDetHierId1AccessType'];
    lookupDetHierId2AccessSite = json['lookupDetHierId2AccessSite'];
    lookupDetIdDialysarType = json['lookupDetIdDialysarType'];
    lookupDetIdSpecialDialysis = json['lookupDetIdSpecialDialysis'];
    dialyzerDiscardedFlag = json['dialyzerDiscardedFlag'];
    weight = json['weight'];
    bloodPressureH = json['bloodPressureH'];
    bloodPressureL = json['bloodPressureL'];
    pulse = json['pulse'];
    temperature = json['temperature'];
    heightCm = json['heightCm'];
    heightInch = json['heightInch'];
    dialysisStartDate = json['dialysisStartDate'];
    dialysisStartTime = json['dialysisStartTime'];
    respiratoryRate = json['respiratoryRate'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    preHdCondition = json['preHdCondition'];
    dryWeight = json['dryWeight'];
    interDialyticWeightGain = json['interDialyticWeightGain'];
    discardreamrk = json['discardreamrk'];
    getttPreDialysis = json['getttPreDialysis'];
    dialyserFlag = json['dialyserFlag'];
    dialyserBarcodeSerialNo = json['dialyserBarcodeSerialNo'];
    dialyserResueNo = json['dialyserResueNo'];
    dialyserRemarks = json['dialyserRemarks'];
    tubeFlag = json['tubeFlag'];
    tubeBarcodeSerialNo = json['tubeBarcodeSerialNo'];
    tubeResueNo = json['tubeResueNo'];
    tubeRemarks = json['tubeRemarks'];
  }
  int? preDialysisId;
  int? unitId;
  int? patientId;
  int? treatmentId;
  int? lookupDetIdDialysisType;
  int? lookupDetHierId1AccessType;
  int? lookupDetHierId2AccessSite;
  int? lookupDetIdDialysarType;
  int? lookupDetIdSpecialDialysis;
  String? dialyzerDiscardedFlag;
  double? weight;
  int? bloodPressureH;
  int? bloodPressureL;
  int? pulse;
  double? temperature;
  double? heightCm;
  double? heightInch;
  String? dialysisStartDate;
  String? dialysisStartTime;
  int? respiratoryRate;
  int? status;
  int? createdBy;
  String? createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic macId;
  dynamic ipAddress;
  dynamic deviceFrom;
  String? preHdCondition;
  double? dryWeight;
  String? interDialyticWeightGain;
  String? discardreamrk;
  dynamic getttPreDialysis;
  String? dialyserFlag;
  String? dialyserBarcodeSerialNo;
  int? dialyserResueNo;
  String? dialyserRemarks;
  String? tubeFlag;
  String? tubeBarcodeSerialNo;
  int? tubeResueNo;
  String? tubeRemarks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['preDialysisId'] = preDialysisId;
    map['unitId'] = unitId;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['lookupDetIdDialysisType'] = lookupDetIdDialysisType;
    map['lookupDetHierId1AccessType'] = lookupDetHierId1AccessType;
    map['lookupDetHierId2AccessSite'] = lookupDetHierId2AccessSite;
    map['lookupDetIdDialysarType'] = lookupDetIdDialysarType;
    map['lookupDetIdSpecialDialysis'] = lookupDetIdSpecialDialysis;
    map['dialyzerDiscardedFlag'] = dialyzerDiscardedFlag;
    map['weight'] = weight;
    map['bloodPressureH'] = bloodPressureH;
    map['bloodPressureL'] = bloodPressureL;
    map['pulse'] = pulse;
    map['temperature'] = temperature;
    map['heightCm'] = heightCm;
    map['heightInch'] = heightInch;
    map['dialysisStartDate'] = dialysisStartDate;
    map['dialysisStartTime'] = dialysisStartTime;
    map['respiratoryRate'] = respiratoryRate;
    map['status'] = status;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    map['preHdCondition'] = preHdCondition;
    map['dryWeight'] = dryWeight;
    map['interDialyticWeightGain'] = interDialyticWeightGain;
    map['discardreamrk'] = discardreamrk;
    map['getttPreDialysis'] = getttPreDialysis;
    map['dialyserFlag'] = dialyserFlag;
    map['dialyserBarcodeSerialNo'] = dialyserBarcodeSerialNo;
    map['dialyserResueNo'] = dialyserResueNo;
    map['dialyserRemarks'] = dialyserRemarks;
    map['tubeFlag'] = tubeFlag;
    map['tubeBarcodeSerialNo'] = tubeBarcodeSerialNo;
    map['tubeResueNo'] = tubeResueNo;
    map['tubeRemarks'] = tubeRemarks;
    return map;
  }

}