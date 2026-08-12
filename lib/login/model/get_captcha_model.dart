class GetCaptchaModel {
  GetCaptchaModel({
      this.code, 
      this.status, 
      this.captcha,});

  GetCaptchaModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    captcha = json['captcha'];
  }
  int? code;
  String? status;
  String? captcha;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    map['captcha'] = captcha;
    return map;
  }

}