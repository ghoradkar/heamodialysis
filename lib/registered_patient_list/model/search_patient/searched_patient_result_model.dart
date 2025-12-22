import 'searched_result_data.dart';

class SearchedPatientResultModel {
  SearchedPatientResultModel({
      this.code, 
      this.status, 
      this.data,});

  SearchedPatientResultModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SearchedResultData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<SearchedResultData>? data;

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