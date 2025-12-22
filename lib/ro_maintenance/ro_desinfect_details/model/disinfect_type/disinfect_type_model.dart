import 'disinfect_data.dart';

class DisinfectTypeModel {
  DisinfectTypeModel({
      this.code, 
      this.status, 
      this.data,});

  DisinfectTypeModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DisinfectData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<DisinfectData>? data;

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