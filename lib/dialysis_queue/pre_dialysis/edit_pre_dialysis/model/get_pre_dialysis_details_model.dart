import 'get_pre_dialysis_detail_data.dart';

class GetPreDialysisDetailsModel {
  GetPreDialysisDetailsModel({
      this.code, 
      this.status, 
      this.data,});

  GetPreDialysisDetailsModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GetPreDialysisDetailsData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<GetPreDialysisDetailsData>? data;

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