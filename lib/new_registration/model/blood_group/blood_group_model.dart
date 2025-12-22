import 'blood_data.dart';

class BloodGroupModel {
  BloodGroupModel({
      this.code, 
      this.status, 
      this.data,});

  BloodGroupModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BloodData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<BloodData>? data;

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