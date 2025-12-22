import 'unit_master_dto_issue_log.dart';
import 'tm_ro_machine_master_issue_log.dart';
import 'tm_cm_lookup_det.dart';

class RoIssueLogData {
  RoIssueLogData({
      this.roMachineIssueLogsId, 
      this.unitMasterDto, 
      this.tmRoMachineMaster, 
      this.tmCmLookupDet, 
      this.createdDate, 
      this.createdBy, 
      this.updatedDate, 
      this.updatedBy, 
      this.macId, 
      this.ipAddress, 
      this.deviceFrom, 
      this.status, 
      this.comments, 
      this.issueDate, 
      this.informationDate, 
      this.issueDescription, 
      this.informedTo, 
      this.informedBy, 
      this.fIssueDate,
      this.callAttendedBy,
      this.correctiveAction, 
      this.proLi, 
      this.count, 
      this.machineNameList,});

  RoIssueLogData.fromJson(dynamic json) {
    roMachineIssueLogsId = json['roMachineIssueLogsId'];
    unitMasterDto = json['unitMasterDto'] != null ? UnitMasterDto.fromJson(json['unitMasterDto']) : null;
    tmRoMachineMaster = json['tmRoMachineMaster'] != null ? TmRoMachineMaster.fromJson(json['tmRoMachineMaster']) : null;
    tmCmLookupDet = json['tmCmLookupDet'] != null ? TmCmLookupDet.fromJson(json['tmCmLookupDet']) : null;
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    status = json['status'];
    comments = json['comments'];
    issueDate = json['issueDate'];
    informationDate = json['informationDate'];
    issueDescription = json['issueDescription'];
    informedTo = json['informedTo'];
    informedBy = json['informedBy'];
    fIssueDate = json['fIssueDate'];
    fInformationDate = json['fInformationDate'];
    callAttendedBy = json['callAttendedBy'];
    correctiveAction = json['correctiveAction'];
    proLi = json['proLi'];
    count = json['count'];
    machineNameList = json['machineNameList'];
  }
  int? roMachineIssueLogsId;
  UnitMasterDto? unitMasterDto;
  TmRoMachineMaster? tmRoMachineMaster;
  TmCmLookupDet? tmCmLookupDet;
  String? createdDate;
  dynamic createdBy;
  dynamic updatedDate;
  dynamic updatedBy;
  dynamic macId;
  dynamic ipAddress;
  dynamic deviceFrom;
  int? status;
  String? comments;
  String? issueDate;
  String? informationDate;
  String? issueDescription;
  String? informedTo;
  String? informedBy;
  String? fIssueDate;
  String? fInformationDate;
  String? callAttendedBy;
  String? correctiveAction;
  dynamic proLi;
  dynamic count;
  dynamic machineNameList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roMachineIssueLogsId'] = roMachineIssueLogsId;
    if (unitMasterDto != null) {
      map['unitMasterDto'] = unitMasterDto?.toJson();
    }
    if (tmRoMachineMaster != null) {
      map['tmRoMachineMaster'] = tmRoMachineMaster?.toJson();
    }
    if (tmCmLookupDet != null) {
      map['tmCmLookupDet'] = tmCmLookupDet?.toJson();
    }
    map['createdDate'] = createdDate;
    map['createdBy'] = createdBy;
    map['updatedDate'] = updatedDate;
    map['updatedBy'] = updatedBy;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    map['status'] = status;
    map['comments'] = comments;
    map['issueDate'] = issueDate;
    map['informationDate'] = informationDate;
    map['issueDescription'] = issueDescription;
    map['informedTo'] = informedTo;
    map['informedBy'] = informedBy;
    map['fIssueDate'] = fIssueDate;
    map['fInformationDate'] = fInformationDate;
    map['callAttendedBy'] = callAttendedBy;
    map['correctiveAction'] = correctiveAction;
    map['proLi'] = proLi;
    map['count'] = count;
    map['machineNameList'] = machineNameList;
    return map;
  }

}