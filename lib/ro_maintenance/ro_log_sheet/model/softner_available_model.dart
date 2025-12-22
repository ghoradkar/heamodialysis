import 'softner_available_data.dart';

class SoftnerAvailableModel {
  SoftnerAvailableModel({
      this.code, 
      this.status, 
      this.data,});

  SoftnerAvailableModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SoftnerAvailableData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<SoftnerAvailableData>? data;

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