class DeletePhotoModel {
  DeletePhotoModel({
      this.id, 
      this.code, 
      this.status,});

  DeletePhotoModel.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    status = json['status'];
  }
  int? id;
  int? code;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['status'] = status;
    return map;
  }

}