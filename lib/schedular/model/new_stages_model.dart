class NewStagesModel {
  NewStagesModel({
      this.patientId, 
      this.treatmentId, 
      this.stageDescription, 
      this.createdDateTime, 
      this.lookupDetValue, 
      this.patientTrackHistoryBean,});

  NewStagesModel.fromJson(dynamic json) {
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    stageDescription = json['stageDescription'];
    createdDateTime = json['createdDateTime'];
    lookupDetValue = json['lookupDetValue'];
    if (json['patientTrackHistoryBean'] != null) {
      patientTrackHistoryBean = [];
      json['patientTrackHistoryBean'].forEach((v) {
        patientTrackHistoryBean?.add(PatientTrackHistoryBean.fromJson(v));
      });
    }
  }
  int? patientId;
  int? treatmentId;
  String? stageDescription;
  String? createdDateTime;
  String? lookupDetValue;
  List<PatientTrackHistoryBean>? patientTrackHistoryBean;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['stageDescription'] = stageDescription;
    map['createdDateTime'] = createdDateTime;
    map['lookupDetValue'] = lookupDetValue;
    if (patientTrackHistoryBean != null) {
      map['patientTrackHistoryBean'] = patientTrackHistoryBean?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PatientTrackHistoryBean {
  PatientTrackHistoryBean({
      this.stageDescription, 
      this.lookupDetValue,});

  PatientTrackHistoryBean.fromJson(dynamic json) {
    stageDescription = json['stageDescription'];
    lookupDetValue = json['lookupDetValue'];
  }
  String? stageDescription;
  String? lookupDetValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stageDescription'] = stageDescription;
    map['lookupDetValue'] = lookupDetValue;
    return map;
  }

}