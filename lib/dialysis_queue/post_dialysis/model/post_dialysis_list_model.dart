import 'post_dialysis_data.dart';

class PostDialysisListModel {
  PostDialysisListModel({
      this.code, 
      this.status, 
      this.data,});

  PostDialysisListModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PostDialysisData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<PostDialysisData>? data;

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