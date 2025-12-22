// lib/registered_patient_list/model/patient_models.dart
import 'dart:convert';

Map<String, dynamic> _normalizeMapKeys(Map m) {
  // Remove wrappers like &quot;, extra quotes, etc.
  final out = <String, dynamic>{};
  m.forEach((k, v) {
    var key = k.toString();
    key = key.replaceAll('&quot;', '').replaceAll('"', '').trim();
    if (v is Map) {
      out[key] = _normalizeMapKeys(v);
    } else if (v is List) {
      out[key] = v.map((e) => e is Map ? _normalizeMapKeys(e) : e).toList();
    } else {
      // If string values contain surrounding quotes like '"value"', strip them.
      if (v is String) {
        var vv = v;
        if (vv.startsWith('"') && vv.endsWith('"') && vv.length > 1) {
          vv = vv.substring(1, vv.length - 1);
        }
        out[key] = vv;
      } else {
        out[key] = v;
      }
    }
  });
  return out;
}

class DialysisVitalPatientListModel {
  final String? abhaNo;
  final String? patientName;
  final String? unitName;
  final String? districtName;
  final String? gender;
  final int? patientId;
  final String? divisionName;
  final String? talukaName;
  final int? treatmentId;
  final String? bloodGroup;
  final dynamic comorbidities;
  final int? srNo;
  final int? unitId;
  final String? mjpayEnrollNo;
  final int? age;

  DialysisVitalPatientListModel({
    this.abhaNo,
    this.patientName,
    this.unitName,
    this.districtName,
    this.gender,
    this.patientId,
    this.divisionName,
    this.talukaName,
    this.treatmentId,
    this.bloodGroup,
    this.comorbidities,
    this.srNo,
    this.unitId,
    this.mjpayEnrollNo,
    this.age,
  });

  factory DialysisVitalPatientListModel.fromMap(Map m) {
    final map = _normalizeMapKeys(m);
    return DialysisVitalPatientListModel(
      abhaNo: map['abhaNo']?.toString(),
      patientName: map['patientName']?.toString(),
      unitName: map['unitName']?.toString(),
      districtName: map['districtName']?.toString(),
      gender: map['gender']?.toString(),
      patientId: map['patientId'] is String
          ? int.tryParse(map['patientId'])
          : (map['patientId'] is int ? map['patientId'] : int.tryParse(map['patientId']?.toString() ?? '')),
      divisionName: map['divisionName']?.toString(),
      talukaName: map['talukaName']?.toString(),
      treatmentId: map['treatmentId'] is String
          ? int.tryParse(map['treatmentId'])
          : (map['treatmentId'] is int ? map['treatmentId'] : int.tryParse(map['treatmentId']?.toString() ?? '')),
      bloodGroup: map['bloodGroup']?.toString(),
      comorbidities: map['comorbidities'],
      srNo: map['srNo'] is int ? map['srNo'] : int.tryParse(map['srNo']?.toString() ?? ''),
      unitId: map['unitId'] is int ? map['unitId'] : int.tryParse(map['unitId']?.toString() ?? ''),
      mjpayEnrollNo: map['mjpayEnrollNo']?.toString(),
      age: map['age'] is int ? map['age'] : int.tryParse(map['age']?.toString() ?? ''),
    );
  }

  factory DialysisVitalPatientListModel.fromJson(String source) =>
      DialysisVitalPatientListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PatientListResponse {
  final int totalRecords;
  final List<DialysisVitalPatientListModel> data;

  PatientListResponse({
    required this.totalRecords,
    required this.data,
  });

  factory PatientListResponse.fromMap(Map m) {
    final map = _normalizeMapKeys(m);

    int total = 0;
    if (map['totalRecords'] != null) {
      if (map['totalRecords'] is int) {
        total = map['totalRecords'];
      } else {
        total = int.tryParse(map['totalRecords'].toString()) ?? 0;
      }
    }

    List<DialysisVitalPatientListModel> list = [];
    final rawData = map['data'];
    if (rawData is List) {
      list = rawData.map((e) {
        if (e is Map) return DialysisVitalPatientListModel.fromMap(e);
        try {
          return DialysisVitalPatientListModel.fromMap(json.decode(e.toString()));
        } catch (_) {
          return DialysisVitalPatientListModel.fromMap({}); // fallback
        }
      }).toList();
    }

    return PatientListResponse(totalRecords: total, data: list);
  }
}
