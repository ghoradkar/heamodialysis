class InvestModel {
  final int? treatmentId;
  final int? patientId;
  final int? testId;
  final int? packageId;
  final String? expectedSampleDispatchDate;
  final String? expectedSampleDispatchTime;
  final String? barcodeNo;
  final int? createdBy;

  InvestModel({
    this.treatmentId,
    this.patientId,
    this.testId,
    this.packageId,
    this.expectedSampleDispatchDate,
    this.expectedSampleDispatchTime,
    this.barcodeNo,
    this.createdBy,
  });

  /// Factory method to create object from JSON
  factory InvestModel.fromJson(Map<String, dynamic> json) {
    return InvestModel(
      treatmentId: json['treatmentId'],
      patientId: json['patientId'],
      testId: json['testId'],
      packageId: json['packageId'],
      expectedSampleDispatchDate: json['expectedSampleDispatchDate'],
      expectedSampleDispatchTime: json['expectedSampleDispatchTime'],
      barcodeNo: json['barcodeNo'],
      createdBy: json['createdBy'],
    );
  }

  /// Convert object to JSON (for API request)
  Map<String, dynamic> toJson() {
    return {
      "treatmentId": treatmentId,
      "patientId": patientId,
      "testId": testId,
      "packageId": packageId,
      "expectedSampleDispatchDate": expectedSampleDispatchDate,
      "expectedSampleDispatchTime": expectedSampleDispatchTime,
      "barcodeNo": barcodeNo,
      "createdBy": createdBy,
    };
  }
}
