import 'ro_water_tds_data.dart';

class RoWaterTdsModel {
  RoWaterTdsModel({
      this.code, 
      this.status, 
      this.data,});

  RoWaterTdsModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RoWaterTdsData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<RoWaterTdsData>? data;

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