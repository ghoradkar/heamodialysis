import 'special_dialysis_data.dart';

class SpecialDialysisModel {
  SpecialDialysisModel({
      this.code, 
      this.status, 
      this.data,});

  SpecialDialysisModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SpecialDialysisData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<SpecialDialysisData>? data;

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