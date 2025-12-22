class PrescriptionListModel {
  PrescriptionListModel({
      this.prescriptionId, 
      this.patientId, 
      this.treatmentId, 
      this.prep, 
      this.medicineId, 
      this.medicineName, 
      this.strength, 
      this.unit, 
      this.dose, 
      this.frequency, 
      this.instruction, 
      this.route, 
      this.days, 
      this.qty, 
      this.paediatricsMedicineFlag, 
      this.paediatricsMedicineCapacity, 
      this.dayPrescription, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deletedDate, 
      this.deletedBy, 
      this.unitId, 
      this.deleted, 
      this.prepName, 
      this.unitName, 
      this.instructionName, 
      this.instructionNameForUI, 
      this.administeredStatus, 
      this.drugName, 
      this.nutracalProductFlag, 
      this.uomName, 
      this.userName, 
      this.listIPDNursingStationMedication, 
      this.listOPDPrescriptionDtoSP,});

  PrescriptionListModel.fromJson(dynamic json) {
    prescriptionId = json['prescriptionId'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    prep = json['prep'];
    medicineId = json['medicineId'];
    medicineName = json['medicineName'];
    strength = json['strength'];
    unit = json['unit'];
    dose = json['dose'];
    frequency = json['frequency'];
    instruction = json['instruction'];
    route = json['route'];
    days = json['days'];
    qty = json['qty'];
    paediatricsMedicineFlag = json['paediatricsMedicineFlag'];
    paediatricsMedicineCapacity = json['paediatricsMedicineCapacity'];
    dayPrescription = json['dayPrescription'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    prepName = json['prepName'];
    unitName = json['unitName'];
    instructionName = json['instructionName'];
    instructionNameForUI = json['instructionNameForUI'];
    administeredStatus = json['administered_status'];
    drugName = json['drugName'];
    nutracalProductFlag = json['nutracalProductFlag'];
    uomName = json['uom_name'];
    userName = json['user_name'];
    listIPDNursingStationMedication = json['listIPDNursingStationMedication'];
    if (json['listOPDPrescriptionDtoSP'] != null) {
      listOPDPrescriptionDtoSP = [];
      json['listOPDPrescriptionDtoSP'].forEach((v) {
        listOPDPrescriptionDtoSP?.add(ListOpdPrescriptionDtoSp.fromJson(v));
      });
    }
  }
  dynamic prescriptionId;
  dynamic patientId;
  dynamic treatmentId;
  dynamic prep;
  dynamic medicineId;
  dynamic medicineName;
  dynamic strength;
  dynamic unit;
  dynamic dose;
  double? frequency;
  dynamic instruction;
  dynamic route;
  double? days;
  double? qty;
  dynamic paediatricsMedicineFlag;
  dynamic paediatricsMedicineCapacity;
  dynamic dayPrescription;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  dynamic deletedDate;
  dynamic deletedBy;
  dynamic unitId;
  dynamic deleted;
  dynamic prepName;
  dynamic unitName;
  dynamic instructionName;
  dynamic instructionNameForUI;
  dynamic administeredStatus;
  dynamic drugName;
  int? nutracalProductFlag;
  dynamic uomName;
  dynamic userName;
  dynamic listIPDNursingStationMedication;
  List<ListOpdPrescriptionDtoSp>? listOPDPrescriptionDtoSP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prescriptionId'] = prescriptionId;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['prep'] = prep;
    map['medicineId'] = medicineId;
    map['medicineName'] = medicineName;
    map['strength'] = strength;
    map['unit'] = unit;
    map['dose'] = dose;
    map['frequency'] = frequency;
    map['instruction'] = instruction;
    map['route'] = route;
    map['days'] = days;
    map['qty'] = qty;
    map['paediatricsMedicineFlag'] = paediatricsMedicineFlag;
    map['paediatricsMedicineCapacity'] = paediatricsMedicineCapacity;
    map['dayPrescription'] = dayPrescription;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deletedDate'] = deletedDate;
    map['deletedBy'] = deletedBy;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['prepName'] = prepName;
    map['unitName'] = unitName;
    map['instructionName'] = instructionName;
    map['instructionNameForUI'] = instructionNameForUI;
    map['administered_status'] = administeredStatus;
    map['drugName'] = drugName;
    map['nutracalProductFlag'] = nutracalProductFlag;
    map['uom_name'] = uomName;
    map['user_name'] = userName;
    map['listIPDNursingStationMedication'] = listIPDNursingStationMedication;
    if (listOPDPrescriptionDtoSP != null) {
      map['listOPDPrescriptionDtoSP'] = listOPDPrescriptionDtoSP?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ListOpdPrescriptionDtoSp {
  ListOpdPrescriptionDtoSp({
      this.prescriptionId, 
      this.patientId, 
      this.treatmentId, 
      this.prep, 
      this.medicineId, 
      this.medicineName, 
      this.strength, 
      this.unit, 
      this.dose, 
      this.frequency, 
      this.instruction, 
      this.route, 
      this.days, 
      this.qty, 
      this.paediatricsMedicineFlag, 
      this.paediatricsMedicineCapacity, 
      this.dayPrescription, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deletedDate, 
      this.deletedBy, 
      this.unitId, 
      this.deleted, 
      this.prepName, 
      this.unitName, 
      this.instructionName, 
      this.instructionNameForUI, 
      this.administeredStatus, 
      this.drugName, 
      this.nutracalProductFlag, 
      this.uomName, 
      this.userName, 
      this.listIPDNursingStationMedication, 
      this.listOPDPrescriptionDtoSP,});

  ListOpdPrescriptionDtoSp.fromJson(dynamic json) {
    prescriptionId = json['prescriptionId'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    prep = json['prep'];
    medicineId = json['medicineId'];
    medicineName = json['medicineName'];
    strength = json['strength'];
    unit = json['unit'];
    dose = json['dose'];
    frequency = json['frequency'];
    instruction = json['instruction'];
    route = json['route'];
    days = json['days'];
    qty = json['qty'];
    paediatricsMedicineFlag = json['paediatricsMedicineFlag'];
    paediatricsMedicineCapacity = json['paediatricsMedicineCapacity'];
    dayPrescription = json['dayPrescription'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    prepName = json['prepName'];
    unitName = json['unitName'];
    instructionName = json['instructionName'];
    instructionNameForUI = json['instructionNameForUI'];
    administeredStatus = json['administered_status'];
    drugName = json['drugName'];
    nutracalProductFlag = json['nutracalProductFlag'];
    uomName = json['uom_name'];
    userName = json['user_name'];
    listIPDNursingStationMedication = json['listIPDNursingStationMedication'];
    listOPDPrescriptionDtoSP = json['listOPDPrescriptionDtoSP'];
  }
  int? prescriptionId;
  int? patientId;
  int? treatmentId;
  int? prep;
  int? medicineId;
  String? medicineName;
  String? strength;
  int? unit;
  dynamic dose;
  double? frequency;
  int? instruction;
  int? route;
  double? days;
  double? qty;
  String? paediatricsMedicineFlag;
  int? paediatricsMedicineCapacity;
  String? dayPrescription;
  int? createdBy;
  dynamic updatedBy;
  String? createdDate;
  String? updatedDate;
  String? deletedDate;
  dynamic deletedBy;
  int? unitId;
  String? deleted;
  String? prepName;
  String? unitName;
  String? instructionName;
  String? instructionNameForUI;
  dynamic administeredStatus;
  String? drugName;
  int? nutracalProductFlag;
  String? uomName;
  String? userName;
  dynamic listIPDNursingStationMedication;
  dynamic listOPDPrescriptionDtoSP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prescriptionId'] = prescriptionId;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['prep'] = prep;
    map['medicineId'] = medicineId;
    map['medicineName'] = medicineName;
    map['strength'] = strength;
    map['unit'] = unit;
    map['dose'] = dose;
    map['frequency'] = frequency;
    map['instruction'] = instruction;
    map['route'] = route;
    map['days'] = days;
    map['qty'] = qty;
    map['paediatricsMedicineFlag'] = paediatricsMedicineFlag;
    map['paediatricsMedicineCapacity'] = paediatricsMedicineCapacity;
    map['dayPrescription'] = dayPrescription;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deletedDate'] = deletedDate;
    map['deletedBy'] = deletedBy;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['prepName'] = prepName;
    map['unitName'] = unitName;
    map['instructionName'] = instructionName;
    map['instructionNameForUI'] = instructionNameForUI;
    map['administered_status'] = administeredStatus;
    map['drugName'] = drugName;
    map['nutracalProductFlag'] = nutracalProductFlag;
    map['uom_name'] = uomName;
    map['user_name'] = userName;
    map['listIPDNursingStationMedication'] = listIPDNursingStationMedication;
    map['listOPDPrescriptionDtoSP'] = listOPDPrescriptionDtoSP;
    return map;
  }

}