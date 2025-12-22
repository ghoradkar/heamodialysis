class PatientEventDetails {
  PatientEventDetails({
      this.dialysisEventDetID, 
      this.unitId, 
      this.patientId, 
      this.treatmentId, 
      this.eventDateTime, 
      this.lookupDetIdIncidentType, 
      this.eventDescription, 
      this.eventAction, 
      this.createdBy, 
      this.createdDate, 
      this.updatedBy, 
      this.updatedDate, 
      this.macId, 
      this.ipAddress, 
      this.deviceFrom, 
      this.bedNo, 
      this.machineNo, 
      this.machineName, 
      this.dateOfAdminssion, 
      this.gender, 
      this.consultingDoctor, 
      this.nephrologistName, 
      this.relativeName, 
      this.relativeNo, 
      this.lastDialysisCenter, 
      this.unitName, 
      this.patientName, 
      this.weight, 
      this.height, 
      this.heightInch, 
      this.doctorName, 
      this.lookupDetEng, 
      this.age, 
      this.bloodGroup, 
      this.viralLocalStatus, 
      this.patientNo, 
      this.regDate, 
      this.primaryNephroName, 
      this.filePath, 
      this.fullPath, 
      this.lookupDetIdIncidentSubType, 
      this.actionTaken, 
      this.dialyserFlag, 
      this.dialyserBarcodeSerialNo, 
      this.dialyserResueNo, 
      this.dialyserRemarks, 
      this.tubeFlag, 
      this.tubeBarcodeSerialNo, 
      this.tubeResueNo, 
      this.tubeRemarks, 
      this.date, 
      this.status, 
      this.incidentSubTypeName,});

  PatientEventDetails.fromJson(dynamic json) {
    dialysisEventDetID = json['dialysisEventDetID'];
    unitId = json['unitId'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    eventDateTime = json['eventDateTime'];
    lookupDetIdIncidentType = json['lookupDetIdIncidentType'];
    eventDescription = json['eventDescription'];
    eventAction = json['eventAction'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    bedNo = json['bedNo'];
    machineNo = json['machineNo'];
    machineName = json['machineName'];
    dateOfAdminssion = json['dateOfAdminssion'];
    gender = json['gender'];
    consultingDoctor = json['consultingDoctor'];
    nephrologistName = json['nephrologistName'];
    relativeName = json['relativeName'];
    relativeNo = json['relativeNo'];
    lastDialysisCenter = json['lastDialysisCenter'];
    unitName = json['unitName'];
    patientName = json['patientName'];
    weight = json['weight'];
    height = json['height'];
    heightInch = json['heightInch'];
    doctorName = json['doctorName'];
    lookupDetEng = json['lookupDetEng'];
    age = json['age'];
    bloodGroup = json['bloodGroup'];
    viralLocalStatus = json['viralLocalStatus'];
    patientNo = json['patientNo'];
    regDate = json['regDate'];
    primaryNephroName = json['primaryNephroName'];
    filePath = json['filePath'];
    fullPath = json['fullPath'];
    lookupDetIdIncidentSubType = json['lookupDetIdIncidentSubType'];
    actionTaken = json['actionTaken'];
    dialyserFlag = json['dialyserFlag'];
    dialyserBarcodeSerialNo = json['dialyserBarcodeSerialNo'];
    dialyserResueNo = json['dialyserResueNo'];
    dialyserRemarks = json['dialyserRemarks'];
    tubeFlag = json['tubeFlag'];
    tubeBarcodeSerialNo = json['tubeBarcodeSerialNo'];
    tubeResueNo = json['tubeResueNo'];
    tubeRemarks = json['tubeRemarks'];
    date = json['date'];
    status = json['status'];
    incidentSubTypeName = json['incidentSubTypeName'];
  }
  int? dialysisEventDetID;
  int? unitId;
  dynamic patientId;
  dynamic treatmentId;
  String? eventDateTime;
  int? lookupDetIdIncidentType;
  String? eventDescription;
  String? eventAction;
  dynamic createdBy;
  dynamic createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic macId;
  dynamic ipAddress;
  dynamic deviceFrom;
  dynamic bedNo;
  dynamic machineNo;
  dynamic machineName;
  dynamic dateOfAdminssion;
  dynamic gender;
  dynamic consultingDoctor;
  dynamic nephrologistName;
  dynamic relativeName;
  dynamic relativeNo;
  dynamic lastDialysisCenter;
  String? unitName;
  dynamic patientName;
  dynamic weight;
  dynamic height;
  dynamic heightInch;
  dynamic doctorName;
  String? lookupDetEng;
  dynamic age;
  dynamic bloodGroup;
  dynamic viralLocalStatus;
  dynamic patientNo;
  dynamic regDate;
  dynamic primaryNephroName;
  dynamic filePath;
  dynamic fullPath;
  dynamic lookupDetIdIncidentSubType;
  String? actionTaken;
  dynamic dialyserFlag;
  dynamic dialyserBarcodeSerialNo;
  dynamic dialyserResueNo;
  dynamic dialyserRemarks;
  dynamic tubeFlag;
  dynamic tubeBarcodeSerialNo;
  dynamic tubeResueNo;
  dynamic tubeRemarks;
  String? date;
  dynamic status;
  String? incidentSubTypeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dialysisEventDetID'] = dialysisEventDetID;
    map['unitId'] = unitId;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['eventDateTime'] = eventDateTime;
    map['lookupDetIdIncidentType'] = lookupDetIdIncidentType;
    map['eventDescription'] = eventDescription;
    map['eventAction'] = eventAction;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    map['bedNo'] = bedNo;
    map['machineNo'] = machineNo;
    map['machineName'] = machineName;
    map['dateOfAdminssion'] = dateOfAdminssion;
    map['gender'] = gender;
    map['consultingDoctor'] = consultingDoctor;
    map['nephrologistName'] = nephrologistName;
    map['relativeName'] = relativeName;
    map['relativeNo'] = relativeNo;
    map['lastDialysisCenter'] = lastDialysisCenter;
    map['unitName'] = unitName;
    map['patientName'] = patientName;
    map['weight'] = weight;
    map['height'] = height;
    map['heightInch'] = heightInch;
    map['doctorName'] = doctorName;
    map['lookupDetEng'] = lookupDetEng;
    map['age'] = age;
    map['bloodGroup'] = bloodGroup;
    map['viralLocalStatus'] = viralLocalStatus;
    map['patientNo'] = patientNo;
    map['regDate'] = regDate;
    map['primaryNephroName'] = primaryNephroName;
    map['filePath'] = filePath;
    map['fullPath'] = fullPath;
    map['lookupDetIdIncidentSubType'] = lookupDetIdIncidentSubType;
    map['actionTaken'] = actionTaken;
    map['dialyserFlag'] = dialyserFlag;
    map['dialyserBarcodeSerialNo'] = dialyserBarcodeSerialNo;
    map['dialyserResueNo'] = dialyserResueNo;
    map['dialyserRemarks'] = dialyserRemarks;
    map['tubeFlag'] = tubeFlag;
    map['tubeBarcodeSerialNo'] = tubeBarcodeSerialNo;
    map['tubeResueNo'] = tubeResueNo;
    map['tubeRemarks'] = tubeRemarks;
    map['date'] = date;
    map['status'] = status;
    map['incidentSubTypeName'] = incidentSubTypeName;
    return map;
  }

}