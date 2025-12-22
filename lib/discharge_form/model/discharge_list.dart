class DischargeListModel {
  final int patientId;
  final String centerPatientId;
  final String fName;
  final String mobile;
  final String gender;
  final int age;
  final String? imageName;
  final String? aadharImageName;
  final String blockFlag;
  final String? dialysisSupportType;
  final String? procedureType;
  final int? treatmentId;
  final String? dialysisDate;

  DischargeListModel({
    required this.patientId,
    required this.centerPatientId,
    required this.fName,
    required this.mobile,
    required this.gender,
    required this.age,
     this.imageName,
     this.aadharImageName,
    required this.blockFlag,
     this.dialysisSupportType,
     this.procedureType,
     this.treatmentId,
     this.dialysisDate,
  });

  factory DischargeListModel.fromJson(Map<String, dynamic> json) {
    return DischargeListModel(
      patientId: json['patientId'],
      centerPatientId: json['centerPatientId'],
      fName: json['fName'],
      mobile: json['mobile'],
      gender: json['gender'],
      age: json['age'],
      imageName: json['imageName'],
      aadharImageName: json['aadharImageName'],
      blockFlag: json['blockFlag'],
      dialysisSupportType: json['dialysisSupportType'],
      procedureType: json['procedureType'],
      treatmentId: json['treatmentId'],
      dialysisDate: json['dialysisDate'],
    );
  }
}
