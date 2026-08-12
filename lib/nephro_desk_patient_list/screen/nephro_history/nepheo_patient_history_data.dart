class NephroPatientHistoryData {
  NephroPatientHistoryData({
      this.id, 
      this.patientId, 
      this.treatmentId, 
      this.lookupDetIdStagePts, 
      this.stageDescription, 
      this.sendFromUserId, 
      this.sendToUserId, 
      this.unitId, 
      this.status, 
      this.createdBy, 
      this.createdDateTime, 
      this.updatedBy, 
      this.updatedDateTime, 
      this.lookupDetValue, 
      this.instituteName, 
      this.appointmentDate, 
      this.slotTime, 
      this.dischargeDate, 
      this.bedNo, 
      this.machineSerialNumber,});

  NephroPatientHistoryData.fromJson(dynamic json) {
    id = json['id'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    lookupDetIdStagePts = json['lookupDetIdStagePts'];
    stageDescription = json['stageDescription'];
    sendFromUserId = json['sendFromUserId'];
    sendToUserId = json['sendToUserId'];
    unitId = json['unitId'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    lookupDetValue = json['lookupDetValue'];
    instituteName = json['instituteName'];
    appointmentDate = json['appointmentDate'];
    slotTime = json['slotTime'];
    dischargeDate = json['dischargeDate'];
    bedNo = json['bedNo'];
    machineSerialNumber = json['machineSerialNumber'];
  }
  dynamic id;
  int? patientId;
  int? treatmentId;
  dynamic lookupDetIdStagePts;
  String? stageDescription;
  dynamic sendFromUserId;
  dynamic sendToUserId;
  dynamic unitId;
  dynamic status;
  dynamic createdBy;
  String? createdDateTime;
  dynamic updatedBy;
  dynamic updatedDateTime;
  String? lookupDetValue;
  dynamic instituteName;
  dynamic appointmentDate;
  dynamic slotTime;
  dynamic dischargeDate;
  dynamic bedNo;
  dynamic machineSerialNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['lookupDetIdStagePts'] = lookupDetIdStagePts;
    map['stageDescription'] = stageDescription;
    map['sendFromUserId'] = sendFromUserId;
    map['sendToUserId'] = sendToUserId;
    map['unitId'] = unitId;
    map['status'] = status;
    map['createdBy'] = createdBy;
    map['createdDateTime'] = createdDateTime;
    map['updatedBy'] = updatedBy;
    map['updatedDateTime'] = updatedDateTime;
    map['lookupDetValue'] = lookupDetValue;
    map['instituteName'] = instituteName;
    map['appointmentDate'] = appointmentDate;
    map['slotTime'] = slotTime;
    map['dischargeDate'] = dischargeDate;
    map['bedNo'] = bedNo;
    map['machineSerialNumber'] = machineSerialNumber;
    return map;
  }

}