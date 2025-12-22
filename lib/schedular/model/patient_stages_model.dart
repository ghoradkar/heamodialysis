class PatientStagesModel {
  int? patientId;
  int? treatmentId;
  String? stageDescription;
  String? createdDateTime;
  String? lookupDetValue;
  List<PatientTrackHistoryBean>? patientTrackHistoryBean;

  PatientStagesModel({
    this.patientId,
    this.treatmentId,
    this.stageDescription,
    this.createdDateTime,
    this.lookupDetValue,
    this.patientTrackHistoryBean,
  });

  factory PatientStagesModel.fromJson(Map<String, dynamic> json) {
    return PatientStagesModel(
      patientId: json['patientId'],
      treatmentId: json['treatmentId'],
      stageDescription: json['stageDescription'],
      createdDateTime: json['createdDateTime'],
      lookupDetValue: json['lookupDetValue'],
      patientTrackHistoryBean: (json['patientTrackHistoryBean'] as List<dynamic>?)
          ?.map((e) => PatientTrackHistoryBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'treatmentId': treatmentId,
      'stageDescription': stageDescription,
      'createdDateTime': createdDateTime,
      'lookupDetValue': lookupDetValue,
      'patientTrackHistoryBean': patientTrackHistoryBean?.map((e) => e.toJson()).toList(),
    };
  }
}

class PatientTrackHistoryBean {
  String? stageDescription;
  String? lookupDetValue;

  PatientTrackHistoryBean({this.stageDescription, this.lookupDetValue});

  factory PatientTrackHistoryBean.fromJson(Map<String, dynamic> json) {
    return PatientTrackHistoryBean(
      stageDescription: json['stageDescription'],
      lookupDetValue: json['lookupDetValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stageDescription': stageDescription,
      'lookupDetValue': lookupDetValue,
    };
  }
}
