import 'bed_data.dart';

class BedAvailableModel {
  BedAvailableModel({
      this.code, 
      this.status, 
      this.data,});

  BedAvailableModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BedData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<BedData>? data;

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