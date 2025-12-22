import 'search_data.dart';

class SearchRegisteredPatientModel {
  SearchRegisteredPatientModel({
      this.code, 
      this.status, 
      this.data,});

  SearchRegisteredPatientModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SearchedData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<SearchedData>? data;

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