import 'backwash_rinse_data.dart';

class GetBackWashAndRinseModel {
  GetBackWashAndRinseModel({
      this.code, 
      this.status, 
      this.data,});

  GetBackWashAndRinseModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BackWashRinseData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<BackWashRinseData>? data;

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