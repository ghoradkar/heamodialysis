import 'login_data.dart';

class LoginModel {
  LoginModel({
      this.code, 
      this.status, 
      this.data,});

  LoginModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(LoginData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<LoginData>? data;

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