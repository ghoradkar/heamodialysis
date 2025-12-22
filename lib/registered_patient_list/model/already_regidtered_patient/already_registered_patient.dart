import 'patient_data.dart';

class AlreadyRegisteredPatient {
  AlreadyRegisteredPatient({
      this.code, 
      this.status, 
      this.data,});

  AlreadyRegisteredPatient.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PatientData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<PatientData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}