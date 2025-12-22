import 'ro_log_sheet_data.dart';

class RoLogSheetModel {
  RoLogSheetModel({
      this.code, 
      this.status, 
      this.data,});

  RoLogSheetModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RoLogSheetData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<RoLogSheetData>? data;

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