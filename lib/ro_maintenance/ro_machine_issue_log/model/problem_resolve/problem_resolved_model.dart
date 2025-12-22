import 'problem_data.dart';

class ProblemResolvedModel {
  ProblemResolvedModel({
      this.code, 
      this.status, 
      this.data,});

  ProblemResolvedModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProblemData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<ProblemData>? data;

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