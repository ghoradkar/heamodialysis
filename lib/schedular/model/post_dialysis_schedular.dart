class PostDialysisSchedular {
  PostDialysisSchedular(
      {this.postDialysisInfusionId,
      this.postDialysisId,
      this.weight,
      this.bloodPressureH,
      this.bloodPressureL,
      this.patientId,
      this.treatmentId,
      this.pulse,
      this.temperature,
      this.percentageFiberBundle,
      this.finalUfv,
      this.venousPressure,
      this.actualFiberBundle,
      this.bloodFlowQb,
      this.dialyticFlowQd,
      this.rrfUrineVolumeMlDay,
      this.herapinIu,
      this.respiratoryRate,
      this.dialysisStopTime,
      this.status,
      this.updatedBy,
      this.weightDifference,
      this.caseNarration,
      this.dialysisStartDatetime,
      // this.postDialysisInfusion,
      this.dialysisDuration,
      this.oxyLevel});

  PostDialysisSchedular.fromJson(dynamic json) {
    postDialysisInfusionId = json['postDialysisInfusionId'];
    postDialysisId = json['postDialysisId'];
    weight = json['weight'];
    bloodPressureH = json['bloodPressureH'];
    bloodPressureL = json['bloodPressureL'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    pulse = json['pulse'];
    temperature = json['temperature'];
    percentageFiberBundle = json['percentageFiberBundle'];
    finalUfv = json['finalUfv'];
    venousPressure = json['venousPressure'];
    bloodFlowQb = json['bloodFlowQb'];
    dialyticFlowQd = json['dialyticFlowQd'];
    rrfUrineVolumeMlDay = json['rrfUrineVolumeMlDay'];
    herapinIu = json['herapinIu'];
    respiratoryRate = json['respiratoryRate'];
    dialysisStopTime = json['dialysis_stopTime'];
    status = json['status'];
    updatedBy = json['updatedBy'];
    weightDifference = json['weightDifference'];
    caseNarration = json['caseNarration'];
    dialysisStartDatetime = json['dialysisStartDatetime'];
    actualFiberBundle = json['actualFiberBundle'];
    // if (json['postDialysisInfusion'] != null) {
    //   postDialysisInfusion = [];
    //   json['postDialysisInfusion'].forEach((v) {
    //     postDialysisInfusion?.add(Dynamic.fromJson(v));
    //   });
    // }
    dialysisDuration = json['dialysisDuration'];
    oxyLevel = json['oxyLevel'];
  }

  int? postDialysisInfusionId;
  int? postDialysisId;
  double? weight;
  int? bloodPressureH;
  int? bloodPressureL;
  int? patientId;
  int? treatmentId;
  int? pulse;
  double? temperature;
  double? percentageFiberBundle;
  double? finalUfv;
  int? venousPressure;
  int? actualFiberBundle;
  int? bloodFlowQb;
  int? dialyticFlowQd;
  int? rrfUrineVolumeMlDay;
  int? herapinIu;
  int? respiratoryRate;
  String? dialysisStopTime;
  int? status;
  int? updatedBy;
  double? weightDifference;
  String? caseNarration;
  String? dialysisStartDatetime;

  // List<dynamic>? postDialysisInfusion;
  String? dialysisDuration;
  int ? oxyLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['postDialysisInfusionId'] = postDialysisInfusionId;
    map['postDialysisId'] = postDialysisId;
    map['weight'] = weight;
    map['bloodPressureH'] = bloodPressureH;
    map['bloodPressureL'] = bloodPressureL;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['pulse'] = pulse;
    map['temperature'] = temperature;
    map['finalUfv'] = finalUfv;
    map['venousPressure'] = venousPressure;
    map['actualFiberBundle'] = actualFiberBundle;
    map['percentageFiberBundle'] = percentageFiberBundle;
    map['bloodFlowQb'] = bloodFlowQb;
    map['dialyticFlowQd'] = dialyticFlowQd;
    map['rrfUrineVolumeMlDay'] = rrfUrineVolumeMlDay;
    map['herapinIu'] = herapinIu;
    map['respiratoryRate'] = respiratoryRate;
    map['dialysis_stopTime'] = dialysisStopTime;
    map['status'] = status;
    map['updatedBy'] = updatedBy;
    map['weightDifference'] = weightDifference;
    map['caseNarration'] = caseNarration;
    map['dialysisStartDatetime'] = dialysisStartDatetime;
    map['oxyLevel'] = oxyLevel;
    // if (postDialysisInfusion != null) {
    //   map['postDialysisInfusion'] = postDialysisInfusion?.map((v) => v.toJson()).toList();
    // }
    map['dialysisDuration'] = dialysisDuration;
    return map;
  }
}
