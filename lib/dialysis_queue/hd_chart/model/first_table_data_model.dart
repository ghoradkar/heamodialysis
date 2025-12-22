class FirstTableDataModel {
  int? patientHdChartId;
  int? unitId;
  int? patientId;
  int? treatmentId;

  String? patientNameOnDialyserCheck;
  String? patientNameOnTubingCheck;
  String? machineRinseDone;
  String? machineSelfTestDone;

  // Server sends these as strings in your sample
  String? bolusDose;
  String? infusionDose;
  String? ktV;
  String? injectionEpoIron;
  String? airDetectorLineClamp;
  String? alarmLimitSet;
  String? heparinPumpOn;
  String? concentrate;

  double? dialysateFlow;
  double? dialysateTemp;
  double? conductivity;

  int? status;
  int? createdBy;
  DateTime? createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  String? macId;
  String? ipAddress;
  String? deviceFrom;

  FirstTableDataModel({
    this.patientHdChartId,
    this.unitId,
    this.patientId,
    this.treatmentId,
    this.patientNameOnDialyserCheck,
    this.patientNameOnTubingCheck,
    this.machineRinseDone,
    this.machineSelfTestDone,
    this.bolusDose,
    this.infusionDose,
    this.ktV,
    this.injectionEpoIron,
    this.airDetectorLineClamp,
    this.alarmLimitSet,
    this.heparinPumpOn,
    this.concentrate,
    this.dialysateFlow,
    this.dialysateTemp,
    this.conductivity,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.macId,
    this.ipAddress,
    this.deviceFrom,
  });

  factory FirstTableDataModel.fromJson(Map<String, dynamic> json) => FirstTableDataModel(
    patientHdChartId: _toInt(json['patientHdChartId']),
    unitId: _toInt(json['unitId']),
    patientId: _toInt(json['patientId']),
    treatmentId: _toInt(json['treatmentId']),
    patientNameOnDialyserCheck: _toStr(json['patientNameOnDialyserCheck']),
    patientNameOnTubingCheck: _toStr(json['patientNameOnTubingCheck']),
    machineRinseDone: _toStr(json['machineRinseDone']),
    machineSelfTestDone: _toStr(json['machineSelfTestDone']),
    bolusDose: _toStr(json['bolusDose']),
    infusionDose: _toStr(json['infusionDose']),
    ktV: _toStr(json['ktV']),
    injectionEpoIron: _toStr(json['injectionEpoIron']),
    airDetectorLineClamp: _toStr(json['airDetectorLineClamp']),
    alarmLimitSet: _toStr(json['alarmLimitSet']),
    heparinPumpOn: _toStr(json['heparinPumpOn']),
    concentrate: _toStr(json['concentrate']),
    dialysateFlow: _toDouble(json['dialysateFlow']),
    dialysateTemp: _toDouble(json['dialysateTemp']),
    conductivity: _toDouble(json['conductivity']),
    status: _toInt(json['status']),
    createdBy: _toInt(json['createdBy']),
    createdDate: _toDate(json['createdDate']),
    updatedBy: _toInt(json['updatedBy']),
    updatedDate: _toDate(json['updatedDate']),
    macId: _toStr(json['macId']),
    ipAddress: _toStr(json['ipAddress']),
    deviceFrom: _toStr(json['deviceFrom']),
  );

  Map<String, dynamic> toJson() => {
    'patientHdChartId': patientHdChartId,
    'unitId': unitId,
    'patientId': patientId,
    'treatmentId': treatmentId,
    'patientNameOnDialyserCheck': patientNameOnDialyserCheck,
    'patientNameOnTubingCheck': patientNameOnTubingCheck,
    'machineRinseDone': machineRinseDone,
    'machineSelfTestDone': machineSelfTestDone,
    'bolusDose': bolusDose,
    'infusionDose': infusionDose,
    'ktV': ktV,
    'injectionEpoIron': injectionEpoIron,
    'airDetectorLineClamp': airDetectorLineClamp,
    'alarmLimitSet': alarmLimitSet,
    'heparinPumpOn': heparinPumpOn,
    'concentrate': concentrate,
    'dialysateFlow': dialysateFlow,
    'dialysateTemp': dialysateTemp,
    'conductivity': conductivity,
    'status': status,
    'createdBy': createdBy,
    'createdDate': createdDate?.toIso8601String(),
    'updatedBy': updatedBy,
    'updatedDate': updatedDate?.toIso8601String(),
    'macId': macId,
    'ipAddress': ipAddress,
    'deviceFrom': deviceFrom,
  };

  // ---- helpers ----
  static int? _toInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }
  static double? _toDouble(dynamic v) {
    if (v == null) return null;
    if (v is double) return v;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }
  static String? _toStr(dynamic v) => v?.toString();
  static DateTime? _toDate(dynamic v) {
    if (v == null || (v is String && v.isEmpty)) return null;
    try { return DateTime.parse(v.toString()); } catch (_) { return null; }
  }
}
