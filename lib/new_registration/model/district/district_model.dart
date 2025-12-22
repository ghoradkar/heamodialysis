import 'district_data.dart';

class DistrictModel {
  DistrictModel({
      this.code, 
      this.status, 
      this.data,});

  DistrictModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DistrictData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<DistrictData>? data;

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