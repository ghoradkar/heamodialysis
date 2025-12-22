import 'view_patient_data.dart';

class ViewPatientModel {
  ViewPatientModel({
      this.code, 
      this.status, 
      this.data,});

  ViewPatientModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? ViewPatientData.fromJson(json['data']) : null;
  }
  int? code;
  String? status;
  ViewPatientData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}