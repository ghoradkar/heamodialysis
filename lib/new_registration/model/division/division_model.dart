import 'division_data.dart';

class DivisionModel {
  DivisionModel({
      this.code, 
      this.status, 
      this.data,});

  DivisionModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DivisionData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<DivisionData>? data;

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