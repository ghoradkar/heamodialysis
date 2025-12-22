import 'access_type_site_data2.dart';

class AccessTypeSiteModel {
  AccessTypeSiteModel({
      this.code, 
      this.status, 
      this.data, 
      this.data2,});

  AccessTypeSiteModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data2'] != null) {
      data2 = [];
      json['data2'].forEach((v) {
        data2?.add(AccessTypeSiteData2.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<dynamic>? data;
  List<AccessTypeSiteData2>? data2;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (data2 != null) {
      map['data2'] = data2?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}