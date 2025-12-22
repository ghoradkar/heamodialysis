import 'dialyzer_type_data.dart';

class DialyzerTypeModel {
  DialyzerTypeModel({
      this.code, 
      this.status, 
      this.data,});

  DialyzerTypeModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DialyzerTypeData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<DialyzerTypeData>? data;

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