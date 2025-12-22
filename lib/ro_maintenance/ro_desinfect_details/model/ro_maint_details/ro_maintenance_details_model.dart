import 'pro_li_data.dart';

class RoMaintenanceDetailsModel {
  RoMaintenanceDetailsModel({
      this.code, 
      this.status, 
      this.data,});

  RoMaintenanceDetailsModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProLiData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<ProLiData>? data;

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