import 'ro_water_conduct_data.dart';

class RoWaterConductivityModel {
  RoWaterConductivityModel({
      this.code, 
      this.status, 
      this.data,});

  RoWaterConductivityModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RoWaterConductData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<RoWaterConductData>? data;

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