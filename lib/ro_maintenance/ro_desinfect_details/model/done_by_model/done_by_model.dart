import 'done_data.dart';

class DoneByModel {
  DoneByModel({
      this.code, 
      this.status, 
      this.data,});

  DoneByModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DoneByData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<DoneByData>? data;

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