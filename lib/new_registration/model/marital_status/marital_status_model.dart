import 'marital_data.dart';

class MaritalStatusModel {
  MaritalStatusModel({
      this.code, 
      this.status, 
      this.data,});

  MaritalStatusModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MaritalData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<MaritalData>? data;

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