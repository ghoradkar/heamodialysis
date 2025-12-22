import 'schema_data.dart';

class SchemaAdoptedModel {
  SchemaAdoptedModel({
      this.code, 
      this.status, 
      this.data,});

  SchemaAdoptedModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SchemaData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<SchemaData>? data;

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