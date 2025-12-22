import 'referred_by_data.dart';

class ReferredByModel {
  ReferredByModel({
      this.code, 
      this.status, 
      this.data,});

  ReferredByModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ReferredByData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<ReferredByData>? data;

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