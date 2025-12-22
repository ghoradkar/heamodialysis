class AddEditMachineIssueLogReq {
  AddEditMachineIssueLogReq({
      this.roMachineIssueLogsId, 
      this.roMachineMasterId, 
      this.issueDate, 
      this.issueDescription, 
      this.informedTo, 
      this.informedBy, 
      this.informationDate, 
      this.callAttendedBy, 
      this.correctiveAction, 
      this.lookupDetId, 
      this.comments, 
      this.createdBy, 
      this.unitId,});

  AddEditMachineIssueLogReq.fromJson(dynamic json) {
    roMachineIssueLogsId = json['roMachineIssueLogsId'];
    roMachineMasterId = json['roMachineMasterId'];
    issueDate = json['issueDate'];
    issueDescription = json['issueDescription'];
    informedTo = json['informedTo'];
    informedBy = json['informedBy'];
    informationDate = json['informationDate'];
    callAttendedBy = json['callAttendedBy'];
    correctiveAction = json['correctiveAction'];
    lookupDetId = json['lookupDetId'];
    comments = json['comments'];
    createdBy = json['createdBy'];
    unitId = json['unitId'];
  }
  int? roMachineIssueLogsId;
  int? roMachineMasterId;
  String? issueDate;
  String? issueDescription;
  String? informedTo;
  String? informedBy;
  String? informationDate;
  String? callAttendedBy;
  String? correctiveAction;
  int? lookupDetId;
  String? comments;
  int? createdBy;
  int? unitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roMachineIssueLogsId'] = roMachineIssueLogsId;
    map['roMachineMasterId'] = roMachineMasterId;
    map['issueDate'] = issueDate;
    map['issueDescription'] = issueDescription;
    map['informedTo'] = informedTo;
    map['informedBy'] = informedBy;
    map['informationDate'] = informationDate;
    map['callAttendedBy'] = callAttendedBy;
    map['correctiveAction'] = correctiveAction;
    map['lookupDetId'] = lookupDetId;
    map['comments'] = comments;
    map['createdBy'] = createdBy;
    map['unitId'] = unitId;
    return map;
  }

}