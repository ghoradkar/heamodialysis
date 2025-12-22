class AddEditDialysisEventReq {
  AddEditDialysisEventReq({
      this.dialysisEventDetID, 
      this.unitId, 
      this.patientId, 
      this.treatmentId, 
      this.eventDateTime, 
      this.lookupDetIdIncidentType, 
      this.eventDescription, 
      this.eventAction, 
      this.createdBy, 
      this.lookupDetIdIncidentSubType, 
      this.actionTaken, 
      this.date,this.incidentT,this.incidentSubT,this.time});

  AddEditDialysisEventReq.fromJson(dynamic json) {
    dialysisEventDetID = json['dialysisEventDetID'];
    unitId = json['unitId'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    eventDateTime = json['eventDateTime'];
    lookupDetIdIncidentType = json['lookupDetIdIncidentType'];
    eventDescription = json['eventDescription'];
    eventAction = json['eventAction'];
    createdBy = json['createdBy'];
    lookupDetIdIncidentSubType = json['lookupDetIdIncidentSubType'];
    actionTaken = json['actionTaken'];
    date = json['date'];
  }
  int? dialysisEventDetID;
  int? unitId;
  int? patientId;
  int? treatmentId;
  String? eventDateTime;
  int? lookupDetIdIncidentType;
  String? eventDescription;
  String? incidentT;
  String? incidentSubT;
  String? eventAction;
  String? time;
  int? createdBy;
  int? lookupDetIdIncidentSubType;
  String? actionTaken;
  String? date;

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
    map['lookupDetIdIncidentSubType'] = lookupDetIdIncidentSubType;
    map['actionTaken'] = actionTaken;
    map['date'] = date;
    return map;
  }

}