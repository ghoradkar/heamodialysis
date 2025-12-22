class CheckBoxFlagDischarge {
  CheckBoxFlagDischarge({
      this.code, 
      this.status, 
      this.weight, 
      this.stopDate, 
      this.patid, 
      this.userId,});

  CheckBoxFlagDischarge.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    weight = json['weight'];
    stopDate = json['stopDate'];
    patid = json['patid'];
    userId = json['userId'];
  }
  int? code;
  String? status;
  double? weight;
  String? stopDate;
  int? patid;
  dynamic userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    map['weight'] = weight;
    map['stopDate'] = stopDate;
    map['patid'] = patid;
    map['userId'] = userId;
    return map;
  }

}