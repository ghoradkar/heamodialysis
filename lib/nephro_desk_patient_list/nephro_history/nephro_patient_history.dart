import 'nepheo_patient_history_data.dart';

class NephroPatientHistory {
  NephroPatientHistory({
      this.code, 
      this.status, 
      this.data,});

  NephroPatientHistory.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NephroPatientHistoryData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<NephroPatientHistoryData>? data;

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