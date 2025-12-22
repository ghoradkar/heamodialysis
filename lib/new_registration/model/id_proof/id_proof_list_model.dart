import 'Id_proof_data.dart';

class IdProofListModel {
  IdProofListModel({
      this.code, 
      this.status, 
      this.data,});

  IdProofListModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(IdProofData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<IdProofData>? data;

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