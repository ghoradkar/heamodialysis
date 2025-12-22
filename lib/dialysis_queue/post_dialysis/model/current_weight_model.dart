class CurrentWeightModel {
  CurrentWeightModel({
      this.code, 
      this.status, 
      this.weight, 
      this.stopDate,});

  CurrentWeightModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    weight = json['weight'];
    stopDate = json['stopDate'];
  }
  int? code;
  String? status;
  double? weight;
  dynamic stopDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    map['weight'] = weight;
    map['stopDate'] = stopDate;
    return map;
  }

}