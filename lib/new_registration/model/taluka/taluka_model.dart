import 'taluka_data.dart';

class TalukaModel {
  TalukaModel({
      this.code, 
      this.status, 
      this.data,});

  TalukaModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TalukaData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<TalukaData>? data;

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