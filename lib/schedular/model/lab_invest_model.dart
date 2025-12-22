class LabInvestModel {
  final int? patientId;
  final int? treatmentId;
  final String? testPackageName;
  final String? testReportLink;
  final String? testNames;
  final String? testBarcodeNo;
  final List<dynamic>? commentBeans;
  final String? sampleCollDate;

  LabInvestModel({
    this.patientId,
    this.treatmentId,
    this.testPackageName,
    this.testReportLink,
    this.testNames,
    this.testBarcodeNo,
    this.commentBeans,
    this.sampleCollDate,
  });

  factory LabInvestModel.fromJson(Map<String, dynamic> json) {
    return LabInvestModel(
      patientId: json['patientId'],
      treatmentId: json['treatmentId'],
      testPackageName: json['testPackageName'],
      testReportLink: json['testReportLink'],
      testNames: json['testNames'],
      testBarcodeNo: json['testBarcodeNo'],
      commentBeans: json['commentBeans'] ?? [],
      sampleCollDate: json['sampleCollDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'treatmentId': treatmentId,
      'testPackageName': testPackageName,
      'testReportLink': testReportLink,
      'testNames': testNames,
      'testBarcodeNo': testBarcodeNo,
      'commentBeans': commentBeans,
      'sampleCollDate': sampleCollDate,
    };
  }

  static List<LabInvestModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => LabInvestModel.fromJson(e)).toList();
  }
}
