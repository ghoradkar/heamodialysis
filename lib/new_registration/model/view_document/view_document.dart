class ViewDocument {
  ViewDocument({
      this.code, 
      this.status, 
      this.obj,});

  ViewDocument.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    obj = json['obj'];
  }
  int? code;
  String? status;
  List<dynamic>? obj;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    map['obj'] = obj ?? [];
    return map;
  }

}