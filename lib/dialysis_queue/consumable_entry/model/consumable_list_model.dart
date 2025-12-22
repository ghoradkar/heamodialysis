class ConsumableListModel {
  int? physicalConsumableDetId;
  int? itemId;
  int? patientId;
  int? treatmentId;
  double? consumedQuantity;
  double? usedQuantity;
  String? consumableModeFlag;
  int? unitId;
  int? status;
  int? createdBy;
  String? createdDate;
  String? productOrderId;
  String? batchNumber;
  String? itemGrnExpiryDate;
  String? productName;
  String? itemName;
  ConsumablePatient? patient;
  ConsumableTreatment? treatment;

  ConsumableListModel({
    this.physicalConsumableDetId,
    this.itemId,
    this.patientId,
    this.treatmentId,
    this.consumedQuantity,
    this.usedQuantity,
    this.consumableModeFlag,
    this.unitId,
    this.status,
    this.createdBy,
    this.createdDate,
    this.productOrderId,
    this.batchNumber,
    this.itemGrnExpiryDate,
    this.productName,
    this.itemName,
    this.patient,
    this.treatment,
  });

  factory ConsumableListModel.fromJson(Map<String, dynamic> json) {
    return ConsumableListModel(
      physicalConsumableDetId: json['physicalConsumableDetId'],
      itemId: json['itemId'],
      patientId: json['patientId'],
      treatmentId: json['treatmentId'],
      consumedQuantity: json['consumedQuantity']?.toDouble(),
      usedQuantity: json['usedQuantity']?.toDouble(),
      consumableModeFlag: json['consumableModeFlag'],
      unitId: json['unitId'],
      status: json['status'],
      createdBy: json['createdBy'],
      createdDate: json['createdDate'],
      productOrderId: json['productOrderId'],
      batchNumber: json['batchNumber'],
      itemGrnExpiryDate: json['itemGrnExpiryDate'],
      productName: json['productName'],
      itemName: json['itemName'],
      patient: json['patient'] != null ? ConsumablePatient.fromJson(json['patient']) : null,
      treatment: json['treatment'] != null ? ConsumableTreatment.fromJson(json['treatment']) : null,
    );
  }
}
class ConsumablePatient {
  int? patientId;
  String? centerPatientId;
  String? fName;
  String? lName;
  String? mobile;
  String? dob;
  String? address;
  String? perAddress;
  String? emailId;
  String? gender;

  ConsumablePatient({
    this.patientId,
    this.centerPatientId,
    this.fName,
    this.lName,
    this.mobile,
    this.dob,
    this.address,
    this.perAddress,
    this.emailId,
    this.gender,
  });

  factory ConsumablePatient.fromJson(Map<String, dynamic> json) {
    return ConsumablePatient(
      patientId: json['patientId'],
      centerPatientId: json['centerPatientId'],
      fName: json['fName'],
      lName: json['lName'],
      mobile: json['mobile'],
      dob: json['dob'],
      address: json['address'],
      perAddress: json['perAddress'],
      emailId: json['emailId'],
      gender: json['gender'],
    );
  }
}
class ConsumableTreatment {
  int? treatmentId;
  int? departmentId;
  String? trcount;
  String? visitDate;
  String? visitTime;

  ConsumableTreatment({
    this.treatmentId,
    this.departmentId,
    this.trcount,
    this.visitDate,
    this.visitTime,
  });

  factory ConsumableTreatment.fromJson(Map<String, dynamic> json) {
    return ConsumableTreatment(
      treatmentId: json['treatmentId'],
      departmentId: json['departmentId'],
      trcount: json['trcount'],
      visitDate: json['visitDate'],
      visitTime: json['visitTime'],
    );
  }
}
