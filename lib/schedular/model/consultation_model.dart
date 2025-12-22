class ConsultationModel {
  ConsultationModel({
      this.patientId, 
      this.treatmentId, 
      this.instituteName, 
      this.slotTime, 
      this.dischargeDate, 
      this.bedNo, 
      this.machineSerialNumber, 
      this.appointmentDateS,});

  ConsultationModel.fromJson(dynamic json) {
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    instituteName = json['instituteName'];
    slotTime = json['slotTime'];
    dischargeDate = json['dischargeDate'];
    bedNo = json['bedNo'];
    machineSerialNumber = json['machineSerialNumber'];
    appointmentDateS = json['appointmentDateS'];
  }
  int? patientId;
  int? treatmentId;
  String? instituteName;
  String? slotTime;
  String? dischargeDate;
  String? bedNo;
  String? machineSerialNumber;
  String? appointmentDateS;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['instituteName'] = instituteName;
    map['slotTime'] = slotTime;
    map['dischargeDate'] = dischargeDate;
    map['bedNo'] = bedNo;
    map['machineSerialNumber'] = machineSerialNumber;
    map['appointmentDateS'] = appointmentDateS;
    return map;
  }

}