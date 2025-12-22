import 'ro_issue_log_data.dart';

class RoMachineIssueLogModel {
  RoMachineIssueLogModel({
      this.code, 
      this.status, 
      this.data,});

  RoMachineIssueLogModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RoIssueLogData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<RoIssueLogData>? data;

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