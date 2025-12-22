class SchedularPreDialysisHistory {
  SchedularPreDialysisHistory({
    this.dialyzerDiscardedFlag,
    this.weight,
    this.bloodPressureH,
    this.bloodPressureL,
    this.pulse,
    this.temperature,
    this.heightCm,
    this.heightInch,
    this.respiratoryRate,
    this.preHdCondition,
    this.dryWeight,
    this.interDialyticWeightGain,
    this.dialysisType,
    this.accessType,
    this.accessSite,
    this.dialyserType,
    this.specialDialysis,
    this.preDialysisStart,
    this.preDialysisId,
    this.discardreamrk,
    this.dialyserFlag,
    this.dialyserBarcodeSerialNo,
    this.dialyserResueNo,
    this.dialyserRemarks,
    this.tubeFlag,
    this.tubeBarcodeSerialNo,
    this.tubeResueNo,
    this.tubeRemarks,
    this.oxyLevel,
  });

  SchedularPreDialysisHistory.fromJson(dynamic json) {
    dialyzerDiscardedFlag = json['dialyzerDiscardedFlag'];
    weight = json['weight'];
    bloodPressureH = json['bloodPressureH'];
    bloodPressureL = json['bloodPressureL'];
    pulse = json['pulse'];
    temperature = json['temperature'];
    heightCm = json['heightCm'];
    heightInch = json['heightInch'];
    respiratoryRate = json['respiratoryRate'];
    preHdCondition = json['preHdCondition'];
    dryWeight = json['dryWeight'];
    interDialyticWeightGain = json['interDialyticWeightGain'] is String
        ? double.tryParse(json['interDialyticWeightGain'])
        : json['interDialyticWeightGain'];
    dialysisType = json['dialysisType'];
    accessType = json['accessType'];
    accessSite = json['accessSite'];
    dialyserType = json['dialyserType'];
    specialDialysis = json['specialDialysis'];
    preDialysisStart = json['preDialysisStart'];
    preDialysisId = json['preDialysisId'];
    discardreamrk = json['discardreamrk'];
    dialyserFlag = json['dialyserFlag'];
    dialyserBarcodeSerialNo = json['dialyserBarcodeSerialNo'];
    dialyserResueNo = json['dialyserResueNo'];
    dialyserRemarks = json['dialyserRemarks'];
    tubeFlag = json['tubeFlag'];
    tubeBarcodeSerialNo = json['tubeBarcodeSerialNo'];
    tubeResueNo = json['tubeResueNo'];
    tubeRemarks = json['tubeRemarks'];
    oxyLevel = json['oxyLevel'];
  }

  String? dialyzerDiscardedFlag;
  double? weight;
  int? bloodPressureH;
  int? bloodPressureL;
  int? pulse;
  double? temperature;
  int? oxyLevel;
  double? heightCm;
  double? heightInch;
  int? respiratoryRate;
  String? preHdCondition;
  double? dryWeight;
  double? interDialyticWeightGain;
  String? dialysisType;
  String? accessType;
  String? accessSite;
  String? dialyserType;
  String? specialDialysis;
  String? preDialysisStart;
  int? preDialysisId;
  String? discardreamrk;
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
    map['dialyzerDiscardedFlag'] = dialyzerDiscardedFlag;
    map['weight'] = weight;
    map['bloodPressureH'] = bloodPressureH;
    map['bloodPressureL'] = bloodPressureL;
    map['pulse'] = pulse;
    map['temperature'] = temperature;
    map['heightCm'] = heightCm;
    map['heightInch'] = heightInch;
    map['respiratoryRate'] = respiratoryRate;
    map['preHdCondition'] = preHdCondition;
    map['dryWeight'] = dryWeight;
    map['interDialyticWeightGain'] = interDialyticWeightGain;
    map['dialysisType'] = dialysisType;
    map['accessType'] = accessType;
    map['accessSite'] = accessSite;
    map['dialyserType'] = dialyserType;
    map['specialDialysis'] = specialDialysis;
    map['preDialysisStart'] = preDialysisStart;
    map['preDialysisId'] = preDialysisId;
    map['discardreamrk'] = discardreamrk;
    map['dialyserFlag'] = dialyserFlag;
    map['dialyserBarcodeSerialNo'] = dialyserBarcodeSerialNo;
    map['dialyserResueNo'] = dialyserResueNo;
    map['dialyserRemarks'] = dialyserRemarks;
    map['tubeFlag'] = tubeFlag;
    map['tubeBarcodeSerialNo'] = tubeBarcodeSerialNo;
    map['tubeResueNo'] = tubeResueNo;
    map['tubeRemarks'] = tubeRemarks;
    map['oxyLevel'] = oxyLevel;
    return map;
  }
}
