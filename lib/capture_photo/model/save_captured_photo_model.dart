class SaveCapturedPhotoModel {
  SaveCapturedPhotoModel({
      this.patientId, 
      this.unitId, 
      this.userId,});

  SaveCapturedPhotoModel.fromJson(dynamic json) {
    patientId = json['patientId'];
    unitId = json['unitId'];
    userId = json['userId'];
  }
  String? patientId;
  String? unitId;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['unitId'] = unitId;
    map['userId'] = userId;
    return map;
  }

}