import 'captured_photo_data.dart';

class CapturedPhotoListModel {
  CapturedPhotoListModel({
      this.code, 
      this.status, 
      this.data,});

  CapturedPhotoListModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CapturedPhotoData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<CapturedPhotoData>? data;

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