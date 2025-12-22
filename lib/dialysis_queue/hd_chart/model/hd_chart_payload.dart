import 'dart:convert';

/// Root payload
class HdChartPayload {
   int? treatmentHdChartId;
   int? unitId;
   int? patientId;
   int? treatmentId;

   String? hdTime;     // keep as "HH:mm" or raw string
   String? hdTimeNew;  // keep as "HH:mm" or raw string
   String? hdBp;       // e.g. "999"
   String? hdBpL;      // e.g. "20"
   int? hdPulse;
   int? hdAp;
   int? hdVp;
   int? hdTmp;
   int? hdUfr;
   int? hdUf;          // can be null
   String? hdAchieved; // often comes as string e.g. "60"
   int? hdBfr;
   int? hdCond;
   int? hdCbv;
   int? hdKtv;

   String? hdRemark;
   String? status;

   int? createdBy;
   DateTime? createdDate;
   int? updatedBy;

   String? macId;
   String? ipAddress;
   String? deviceFrom;

   int? userId;

   List<HdChartRow>? listOfData;

  HdChartPayload({
    this.treatmentHdChartId,
    this.unitId,
    this.patientId,
    this.treatmentId,
    this.hdTime,
    this.hdTimeNew,
    this.hdBp,
    this.hdBpL,
    this.hdPulse,
    this.hdAp,
    this.hdVp,
    this.hdTmp,
    this.hdUfr,
    this.hdUf,
    this.hdAchieved,
    this.hdBfr,
    this.hdCond,
    this.hdCbv,
    this.hdKtv,
    this.hdRemark,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.macId,
    this.ipAddress,
    this.deviceFrom,
    this.userId,
    this.listOfData,
  });

  // ---- parsing helpers ----
  static int? _toInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String && v.trim().isNotEmpty) return int.tryParse(v.trim());
    return null;
  }

  static String? _toStr(dynamic v) => v?.toString();

  static DateTime? _toDateTime(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
    return null;
  }

  factory HdChartPayload.fromJson(Map<String, dynamic> json) => HdChartPayload(
    treatmentHdChartId: _toInt(json['treatmentHdChartId']),
    unitId: _toInt(json['unitId']),
    patientId: _toInt(json['patientId']),
    treatmentId: _toInt(json['treatmentId']),
    hdTime: _toStr(json['hdTime']),
    hdTimeNew: _toStr(json['hdTimeNew']),
    hdBp: _toStr(json['hdBp']),
    hdBpL: _toStr(json['hdBpL']),
    hdPulse: _toInt(json['hdPulse']),
    hdAp: _toInt(json['hdAp']),
    hdVp: _toInt(json['hdVp']),
    hdTmp: _toInt(json['hdTmp']),
    hdUfr: _toInt(json['hdUfr']),
    hdUf: _toInt(json['hdUf']),
    hdAchieved: _toStr(json['hdAchieved']),
    hdBfr: _toInt(json['hdBfr']),
    hdCond: _toInt(json['hdCond']),
    hdCbv: _toInt(json['hdCbv']),
    hdKtv: _toInt(json['hdKtv']),
    hdRemark: _toStr(json['hdRemark']),
    status: _toStr(json['status']),
    createdBy: _toInt(json['createdBy']),
    createdDate: _toDateTime(json['createdDate']),
    updatedBy: _toInt(json['updatedBy']),
    macId: _toStr(json['macId']),
    ipAddress: _toStr(json['ipAddress']),
    deviceFrom: _toStr(json['deviceFrom']),
    userId: _toInt(json['userId']),
    listOfData: (json['listOfData'] is List)
        ? (json['listOfData'] as List)
        .map((e) => HdChartRow.fromJson(e as Map<String, dynamic>))
        .toList()
        : null,
  );

  Map<String, dynamic> toJson() => {
    'treatmentHdChartId': treatmentHdChartId,
    'unitId': unitId,
    'patientId': patientId,
    'treatmentId': treatmentId,
    'hdTime': hdTime,
    'hdTimeNew': hdTimeNew,
    'hdBp': hdBp,
    'hdBpL': hdBpL,
    'hdPulse': hdPulse,
    'hdAp': hdAp,
    'hdVp': hdVp,
    'hdTmp': hdTmp,
    'hdUfr': hdUfr,
    'hdUf': hdUf,
    'hdAchieved': hdAchieved,
    'hdBfr': hdBfr,
    'hdCond': hdCond,
    'hdCbv': hdCbv,
    'hdKtv': hdKtv,
    'hdRemark': hdRemark,
    'status': status,
    'createdBy': createdBy,
    'createdDate': createdDate?.toIso8601String(),
    'updatedBy': updatedBy,
    'macId': macId,
    'ipAddress': ipAddress,
    'deviceFrom': deviceFrom,
    'userId': userId,
    'listOfData': listOfData?.map((e) => e.toJson()).toList(),
  };

  static HdChartPayload fromJsonString(String s) =>
      HdChartPayload.fromJson(json.decode(s) as Map<String, dynamic>);

  String toJsonString() => json.encode(toJson());
}

/// Row object inside `listOfData`
class HdChartRow {
   int? treatmentHdChartId;
   int? unitId;
   int? patientId;
   int? treatmentId;

   String? hdTime;
    String? hdTimeNew;
   String? hdBp;
   String? hdBpL;
   int? hdPulse;
   int? hdAp;
   int? hdVp;
   int? hdTmp;
   int? hdUfr;
   int? hdUf;
   String? hdAchieved;
   int? hdBfr;
   int? hdCond;
   int? hdCbv;
   int? hdKtv;
   String? hdRemark;
   String? status;
   int? createdBy;
   DateTime? createdDate;
   int? updatedBy;
   String? macId;
   String? ipAddress;
   String? deviceFrom;

  // Nested list is null in your sample; keep for completeness
   List<HdChartRow>? listOfData;

  HdChartRow({
    this.treatmentHdChartId,
    this.unitId,
    this.patientId,
    this.treatmentId,
    this.hdTime,
    this.hdTimeNew,
    this.hdBp,
    this.hdBpL,
    this.hdPulse,
    this.hdAp,
    this.hdVp,
    this.hdTmp,
    this.hdUfr,
    this.hdUf,
    this.hdAchieved,
    this.hdBfr,
    this.hdCond,
    this.hdCbv,
    this.hdKtv,
    this.hdRemark,
    this.status,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.macId,
    this.ipAddress,
    this.deviceFrom,
    this.listOfData,
  });

  factory HdChartRow.fromJson(Map<String, dynamic> json) => HdChartRow(
    treatmentHdChartId: HdChartPayload._toInt(json['treatmentHdChartId']),
    unitId: HdChartPayload._toInt(json['unitId']),
    patientId: HdChartPayload._toInt(json['patientId']),
    treatmentId: HdChartPayload._toInt(json['treatmentId']),
    hdTime: HdChartPayload._toStr(json['hdTime']),
    hdTimeNew: HdChartPayload._toStr(json['hdTimeNew']),
    hdBp: HdChartPayload._toStr(json['hdBp']),
    hdBpL: HdChartPayload._toStr(json['hdBpL']),
    hdPulse: HdChartPayload._toInt(json['hdPulse']),
    hdAp: HdChartPayload._toInt(json['hdAp']),
    hdVp: HdChartPayload._toInt(json['hdVp']),
    hdTmp: HdChartPayload._toInt(json['hdTmp']),
    hdUfr: HdChartPayload._toInt(json['hdUfr']),
    hdUf: HdChartPayload._toInt(json['hdUf']),
    hdAchieved: HdChartPayload._toStr(json['hdAchieved']),
    hdBfr: HdChartPayload._toInt(json['hdBfr']),
    hdCond: HdChartPayload._toInt(json['hdCond']),
    hdCbv: HdChartPayload._toInt(json['hdCbv']),
    hdKtv: HdChartPayload._toInt(json['hdKtv']),
    hdRemark: HdChartPayload._toStr(json['hdRemark']),
    status: HdChartPayload._toStr(json['status']),
    createdBy: HdChartPayload._toInt(json['createdBy']),
    createdDate: HdChartPayload._toDateTime(json['createdDate']),
    updatedBy: HdChartPayload._toInt(json['updatedBy']),
    macId: HdChartPayload._toStr(json['macId']),
    ipAddress: HdChartPayload._toStr(json['ipAddress']),
    deviceFrom: HdChartPayload._toStr(json['deviceFrom']),
    listOfData: (json['listOfData'] is List)
        ? (json['listOfData'] as List)
        .map((e) => HdChartRow.fromJson(e as Map<String, dynamic>))
        .toList()
        : null,
  );

  Map<String, dynamic> toJson() => {
    'treatmentHdChartId': treatmentHdChartId,
    'unitId': unitId,
    'patientId': patientId,
    'treatmentId': treatmentId,
    'hdTime': hdTime,
    'hdTimeNew': hdTimeNew,
    'hdBp': hdBp,
    'hdBpL': hdBpL,
    'hdPulse': hdPulse,
    'hdAp': hdAp,
    'hdVp': hdVp,
    'hdTmp': hdTmp,
    'hdUfr': hdUfr,
    'hdUf': hdUf,
    'hdAchieved': hdAchieved,
    'hdBfr': hdBfr,
    'hdCond': hdCond,
    'hdCbv': hdCbv,
    'hdKtv': hdKtv,
    'hdRemark': hdRemark,
    'status': status,
    'createdBy': createdBy,
    'createdDate': createdDate?.toIso8601String(),
    'updatedBy': updatedBy,
    'macId': macId,
    'ipAddress': ipAddress,
    'deviceFrom': deviceFrom,
    'listOfData': listOfData?.map((e) => e.toJson()).toList(),
  };
}

// -------- convenience ----------
HdChartPayload hdChartPayloadFromJson(String s) =>
    HdChartPayload.fromJson(json.decode(s) as Map<String, dynamic>);
String hdChartPayloadToJson(HdChartPayload p) => json.encode(p.toJson());
