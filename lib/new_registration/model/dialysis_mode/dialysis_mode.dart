import 'dialysis_data.dart';

class DialysisMode {
  DialysisMode({
      this.code, 
      this.status, 
      this.data,});

  DialysisMode.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DialysisModeData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<DialysisModeData>? data;

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