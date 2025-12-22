import 'edit_pre_dialysis_data.dart';

class EditPreDialysisModel {
  EditPreDialysisModel({
      this.code, 
      this.status, 
      this.data,});

  EditPreDialysisModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? EditPreDialysisData.fromJson(json['data']) : null;
  }
  int? code;
  String? status;
  EditPreDialysisData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}