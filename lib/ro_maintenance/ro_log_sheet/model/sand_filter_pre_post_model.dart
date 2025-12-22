import 'sand_pre_post_data.dart';

class SandFilterPrePostModel {
  SandFilterPrePostModel({
      this.code, 
      this.status, 
      this.data,});

  SandFilterPrePostModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SandPrePostData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<SandPrePostData>? data;

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