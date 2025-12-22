import 'return_loop_data.dart';

class ReturnLoopRangeModel {
  ReturnLoopRangeModel({
      this.code, 
      this.status, 
      this.data,});

  ReturnLoopRangeModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ReturnLoopData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<ReturnLoopData>? data;

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