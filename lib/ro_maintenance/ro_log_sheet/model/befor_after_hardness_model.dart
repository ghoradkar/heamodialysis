import 'before_after_hardness_data.dart';

class BeforAfterHardnessModel {
  BeforAfterHardnessModel({
      this.code, 
      this.status, 
      this.data,});

  BeforAfterHardnessModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BeforAfterHardData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<BeforAfterHardData>? data;

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