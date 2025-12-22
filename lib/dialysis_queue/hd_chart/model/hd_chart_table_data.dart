import 'dart:convert';

class HdChartTableData {
   int? patientId;
   int? treatmentId;
   DateTime? dialysisStartDate;
   DateTime? dialysisStopDate;
   String? duration;
   String? dialysarType; // note: key is "dialysarType" in JSON
   int? dialyserReuseNo;
   int? tubeReuseNo;
   int? heparin;
    double? preDialysisWeight;
   String? intraDialyticWeight; // "NA" or a number; keep as String
   double? ufTarget;
   int? prePulse;
   int? respiratoryRate;
   int? preBloodPressureH;
   int? preBloodPressureL;
   String? preBloodPressre; // key spelled as given
   String? posBloodPressre; // key spelled as given
   double? preDialysisTemperature;
   String? hdStartedBy;
   double? postDialysisWeight;
   double? weightDifference;
   int? postBloodPressureH;
   int? postBloodPressureL;
   double? postDialysisTemperature;
   int? postPulse;
   String? hdCompletedBy;
   String? dialysisStartTime; // "HH:mm:ss"
   String? dialysisStopTime;  // "HH:mm:ss"
   String? machineName;
   String? event;
   String? event1;
   DateTime? eventDate;
   String? eventDescription;
   String? actionTaken;
   List<dynamic>? listOfData;
   String? tubeBarcodeSerialNo;
   String? vascularAccessType;
   double? dryWeight;

  HdChartTableData({
    this.patientId,
    this.treatmentId,
    this.dialysisStartDate,
    this.dialysisStopDate,
    this.duration,
    this.dialysarType,
    this.dialyserReuseNo,
    this.tubeReuseNo,
    this.heparin,
    this.preDialysisWeight,
    this.intraDialyticWeight,
    this.ufTarget,
    this.prePulse,
    this.respiratoryRate,
    this.preBloodPressureH,
    this.preBloodPressureL,
    this.preBloodPressre,
    this.posBloodPressre,
    this.preDialysisTemperature,
    this.hdStartedBy,
    this.postDialysisWeight,
    this.weightDifference,
    this.postBloodPressureH,
    this.postBloodPressureL,
    this.postDialysisTemperature,
    this.postPulse,
    this.hdCompletedBy,
    this.dialysisStartTime,
    this.dialysisStopTime,
    this.machineName,
    this.event,
    this.event1,
    this.eventDate,
    this.eventDescription,
    this.actionTaken,
    this.listOfData,
    this.tubeBarcodeSerialNo,
    this.vascularAccessType,
    this.dryWeight,
  });

  factory HdChartTableData.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v;
      if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
      return null;
    }

    int? toInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String && v.trim().isNotEmpty) return int.tryParse(v.trim());
      return null;
    }

    double? toDouble(dynamic v) {
      if (v == null) return null;
      if (v is double) return v;
      if (v is num) return v.toDouble();
      if (v is String && v.trim().isNotEmpty) return double.tryParse(v.trim());
      return null;
    }

    String? toString(dynamic v) => v?.toString();

    return HdChartTableData(
      patientId: toInt(json['patientId']),
      treatmentId: toInt(json['treatmentId']),
      dialysisStartDate: parseDate(json['dialysisStartDate']),
      dialysisStopDate: parseDate(json['dialysisStopDate']),
      duration: toString(json['duration']),
      dialysarType: toString(json['dialysarType']),
      dialyserReuseNo: toInt(json['dialyserReuseNo']),
      tubeReuseNo: toInt(json['tubeReuseNo']),
      heparin: toInt(json['heparin']),
      preDialysisWeight: toDouble(json['preDialysisWeight']),
      intraDialyticWeight: toString(json['intraDialyticWeight']),
      ufTarget: toDouble(json['ufTarget']),
      prePulse: toInt(json['prePulse']),
      respiratoryRate: toInt(json['respiratoryRate']),
      preBloodPressureH: toInt(json['preBloodPressureH']),
      preBloodPressureL: toInt(json['preBloodPressureL']),
      preBloodPressre: toString(json['preBloodPressre']),
      posBloodPressre: toString(json['posBloodPressre']),
      preDialysisTemperature: toDouble(json['preDialysisTemperature']),
      hdStartedBy: toString(json['hdStartedBy']),
      postDialysisWeight: toDouble(json['postDialysisWeight']),
      weightDifference: toDouble(json['weightDifference']),
      postBloodPressureH: toInt(json['postBloodPressureH']),
      postBloodPressureL: toInt(json['postBloodPressureL']),
      postDialysisTemperature: toDouble(json['postDialysisTemperature']),
      postPulse: toInt(json['postPulse']),
      hdCompletedBy: toString(json['hdCompletedBy']),
      dialysisStartTime: toString(json['dialysisStartTime']),
      dialysisStopTime: toString(json['dialysisStopTime']),
      machineName: toString(json['machineName']),
      event: toString(json['event']),
      event1: toString(json['event1']),
      eventDate: parseDate(json['eventDate']),
      eventDescription: toString(json['eventDescription']),
      actionTaken: toString(json['actionTaken']),
      listOfData: json['listOfData'] is List ? (json['listOfData'] as List) : null,
      tubeBarcodeSerialNo: toString(json['tubeBarcodeSerialNo']),
      vascularAccessType: toString(json['vascularAccessType']),
      dryWeight: toDouble(json['dryWeight']),
    );
  }

  Map<String, dynamic> toJson() {
    String? fmtDate(DateTime? d) =>
        d == null ? null : '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

    return {
      'patientId': patientId,
      'treatmentId': treatmentId,
      'dialysisStartDate': fmtDate(dialysisStartDate),
      'dialysisStopDate': fmtDate(dialysisStopDate),
      'duration': duration,
      'dialysarType': dialysarType,
      'dialyserReuseNo': dialyserReuseNo,
      'tubeReuseNo': tubeReuseNo,
      'heparin': heparin,
      'preDialysisWeight': preDialysisWeight,
      'intraDialyticWeight': intraDialyticWeight,
      'ufTarget': ufTarget,
      'prePulse': prePulse,
      'respiratoryRate': respiratoryRate,
      'preBloodPressureH': preBloodPressureH,
      'preBloodPressureL': preBloodPressureL,
      'preBloodPressre': preBloodPressre,
      'posBloodPressre': posBloodPressre,
      'preDialysisTemperature': preDialysisTemperature,
      'hdStartedBy': hdStartedBy,
      'postDialysisWeight': postDialysisWeight,
      'weightDifference': weightDifference,
      'postBloodPressureH': postBloodPressureH,
      'postBloodPressureL': postBloodPressureL,
      'postDialysisTemperature': postDialysisTemperature,
      'postPulse': postPulse,
      'hdCompletedBy': hdCompletedBy,
      'dialysisStartTime': dialysisStartTime,
      'dialysisStopTime': dialysisStopTime,
      'machineName': machineName,
      'event': event,
      'event1': event1,
      'eventDate': fmtDate(eventDate),
      'eventDescription': eventDescription,
      'actionTaken': actionTaken,
      'listOfData': listOfData,
      'tubeBarcodeSerialNo': tubeBarcodeSerialNo,
      'vascularAccessType': vascularAccessType,
      'dryWeight': dryWeight,
    };
  }

  static HdChartTableData fromJsonString(String str) =>
      HdChartTableData.fromJson(json.decode(str) as Map<String, dynamic>);

  String toJsonString() => json.encode(toJson());

  HdChartTableData copyWith({
    int? patientId,
    int? treatmentId,
    DateTime? dialysisStartDate,
    DateTime? dialysisStopDate,
    String? duration,
    String? dialysarType,
    int? dialyserReuseNo,
    int? tubeReuseNo,
    int? heparin,
    double? preDialysisWeight,
    String? intraDialyticWeight,
    double? ufTarget,
    int? prePulse,
    int? respiratoryRate,
    int? preBloodPressureH,
    int? preBloodPressureL,
    String? preBloodPressre,
    String? posBloodPressre,
    double? preDialysisTemperature,
    String? hdStartedBy,
    double? postDialysisWeight,
    double? weightDifference,
    int? postBloodPressureH,
    int? postBloodPressureL,
    double? postDialysisTemperature,
    int? postPulse,
    String? hdCompletedBy,
    String? dialysisStartTime,
    String? dialysisStopTime,
    String? machineName,
    String? event,
    String? event1,
    DateTime? eventDate,
    String? eventDescription,
    String? actionTaken,
    List<dynamic>? listOfData,
    String? tubeBarcodeSerialNo,
    String? vascularAccessType,
    double? dryWeight,
  }) {
    return HdChartTableData(
      patientId: patientId ?? this.patientId,
      treatmentId: treatmentId ?? this.treatmentId,
      dialysisStartDate: dialysisStartDate ?? this.dialysisStartDate,
      dialysisStopDate: dialysisStopDate ?? this.dialysisStopDate,
      duration: duration ?? this.duration,
      dialysarType: dialysarType ?? this.dialysarType,
      dialyserReuseNo: dialyserReuseNo ?? this.dialyserReuseNo,
      tubeReuseNo: tubeReuseNo ?? this.tubeReuseNo,
      heparin: heparin ?? this.heparin,
      preDialysisWeight: preDialysisWeight ?? this.preDialysisWeight,
      intraDialyticWeight: intraDialyticWeight ?? this.intraDialyticWeight,
      ufTarget: ufTarget ?? this.ufTarget,
      prePulse: prePulse ?? this.prePulse,
      respiratoryRate: respiratoryRate ?? this.respiratoryRate,
      preBloodPressureH: preBloodPressureH ?? this.preBloodPressureH,
      preBloodPressureL: preBloodPressureL ?? this.preBloodPressureL,
      preBloodPressre: preBloodPressre ?? this.preBloodPressre,
      posBloodPressre: posBloodPressre ?? this.posBloodPressre,
      preDialysisTemperature: preDialysisTemperature ?? this.preDialysisTemperature,
      hdStartedBy: hdStartedBy ?? this.hdStartedBy,
      postDialysisWeight: postDialysisWeight ?? this.postDialysisWeight,
      weightDifference: weightDifference ?? this.weightDifference,
      postBloodPressureH: postBloodPressureH ?? this.postBloodPressureH,
      postBloodPressureL: postBloodPressureL ?? this.postBloodPressureL,
      postDialysisTemperature: postDialysisTemperature ?? this.postDialysisTemperature,
      postPulse: postPulse ?? this.postPulse,
      hdCompletedBy: hdCompletedBy ?? this.hdCompletedBy,
      dialysisStartTime: dialysisStartTime ?? this.dialysisStartTime,
      dialysisStopTime: dialysisStopTime ?? this.dialysisStopTime,
      machineName: machineName ?? this.machineName,
      event: event ?? this.event,
      event1: event1 ?? this.event1,
      eventDate: eventDate ?? this.eventDate,
      eventDescription: eventDescription ?? this.eventDescription,
      actionTaken: actionTaken ?? this.actionTaken,
      listOfData: listOfData ?? this.listOfData,
      tubeBarcodeSerialNo: tubeBarcodeSerialNo ?? this.tubeBarcodeSerialNo,
      vascularAccessType: vascularAccessType ?? this.vascularAccessType,
      dryWeight: dryWeight ?? this.dryWeight,
    );
  }
}
