import 'town_data.dart';

class TownModel {
  TownModel({
      this.code, 
      this.status, 
      this.data,});

  TownModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TownData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<TownData>? data;

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