import 'post_carbon_chlorid_data.dart';

class PostCarbonChloridModel {
  PostCarbonChloridModel({
      this.code, 
      this.status, 
      this.data,});

  PostCarbonChloridModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PostCarbonChloridData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<PostCarbonChloridData>? data;

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