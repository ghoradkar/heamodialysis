import 'slot_data.dart';

class SlotListModel {
  SlotListModel({
      this.code, 
      this.status, 
      this.data,});

  SlotListModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SlotData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<SlotData>? data;

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