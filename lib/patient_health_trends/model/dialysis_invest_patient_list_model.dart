class DialysisInvestPatientListModel {
  final String abhaNo;
  final String patientName;
  final String districtName;
  final String gender;
  final int patientId;
  final String divisionName;
  final String talukaName;
  final String instituteName;
  final String bloodGroup;
  final String? comorbidities;
  final int srNo;
  final int unitId;
  final String mjpayEnrollNo;
  final int age;

  DialysisInvestPatientListModel({
    required this.abhaNo,
    required this.patientName,
    required this.districtName,
    required this.gender,
    required this.patientId,
    required this.divisionName,
    required this.talukaName,
    required this.instituteName,
    required this.bloodGroup,
    this.comorbidities,
    required this.srNo,
    required this.unitId,
    required this.mjpayEnrollNo,
    required this.age,
  });

  factory DialysisInvestPatientListModel.fromJson(Map<String, dynamic> json) {
    return DialysisInvestPatientListModel(
      abhaNo: json['abhaNo'] ?? '',
      patientName: json['patientName'] ?? '',
      districtName: json['districtName'] ?? '',
      gender: json['gender'] ?? '',
      patientId: json['patientId'] ?? 0,
      divisionName: json['divisionName'] ?? '',
      talukaName: json['talukaName'] ?? '',
      instituteName: json['instituteName'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      comorbidities: json['comorbidities'],
      srNo: json['srNo'] ?? 0,
      unitId: json['unitId'] ?? 0,
      mjpayEnrollNo: json['mjpayEnrollNo'] ?? '',
      age: json['age'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abhaNo': abhaNo,
      'patientName': patientName,
      'districtName': districtName,
      'gender': gender,
      'patientId': patientId,
      'divisionName': divisionName,
      'talukaName': talukaName,
      'instituteName': instituteName,
      'bloodGroup': bloodGroup,
      'comorbidities': comorbidities,
      'srNo': srNo,
      'unitId': unitId,
      'mjpayEnrollNo': mjpayEnrollNo,
      'age': age,
    };
  }
}
