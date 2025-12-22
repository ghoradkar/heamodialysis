import 'history_data.dart';

class HistoryModel {
  HistoryModel({
      this.code, 
      this.status,
      this.data2,});

  HistoryModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data2'] != null) {
      data2 = [];
      json['data2'].forEach((v) {
        data2?.add(HistoryData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<HistoryData>? data2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data2 != null) {
      map['data2'] = data2?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}