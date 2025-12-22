import 'regis_patient_history_data.dart';

class RegisPatientHistory {
  RegisPatientHistory({
      this.code, 
      this.status, 
      this.data,});

  RegisPatientHistory.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RegisPatientHistoryData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<RegisPatientHistoryData>? data;

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