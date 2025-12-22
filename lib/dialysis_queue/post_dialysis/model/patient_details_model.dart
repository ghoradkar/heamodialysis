import 'patient_data.dart';
import 'data_event.dart';

class PatientDetailsModel {
  PatientDetailsModel({
      this.code, 
      this.status, 
      this.data, 
      this.dataEvent,});

  PatientDetailsModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? PatientData.fromJson(json['data']) : null;
    if (json['dataEvent'] != null) {
      dataEvent = [];
      json['dataEvent'].forEach((v) {
        dataEvent?.add(DataEvent.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  PatientData? data;
  List<DataEvent>? dataEvent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (dataEvent != null) {
      map['dataEvent'] = dataEvent?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}