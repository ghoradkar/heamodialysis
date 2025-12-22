class ProLi {
  ProLi({
      this.roDisinfectionDetailsId, 
      this.inspectionDate, 
      this.nextInspectionDate, 
      this.comments, 
      this.doneBy, 
      this.status, 
      this.createdDate, 
      this.createdBy, 
      this.updatedDate, 
      this.updatedBy, 
      this.macId, 
      this.ipAddress, 
      this.deviceFrom, 
      this.unitId, 
      this.roMachineMasterId, 
      this.lookupDetId, 
      this.machineName, 
      this.unitName, 
      this.lookupDetDescEn, 
      this.userId, 
      this.proLi, 
      this.count, 
      this.machineNameList,});

  ProLi.fromJson(dynamic json) {
    roDisinfectionDetailsId = json['roDisinfectionDetailsId'];
    inspectionDate = json['inspectionDate'];
    nextInspectionDate = json['nextInspectionDate'];
    comments = json['comments'];
    doneBy = json['doneBy'];
    status = json['status'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    unitId = json['unitId'];
    roMachineMasterId = json['roMachineMasterId'];
    lookupDetId = json['lookupDetId'];
    machineName = json['machineName'];
    unitName = json['unitName'];
    lookupDetDescEn = json['lookupDetDescEn'];
    userId = json['userId'];
    proLi = json['proLi'];
    count = json['count'];
    machineNameList = json['machineNameList'];
  }
  int? roDisinfectionDetailsId;
  int? inspectionDate;
  int? nextInspectionDate;
  String? comments;
  String? doneBy;
  dynamic status;
  dynamic createdDate;
  dynamic createdBy;
  dynamic updatedDate;
  dynamic updatedBy;
  dynamic macId;
  dynamic ipAddress;
  dynamic deviceFrom;
  dynamic unitId;
  dynamic roMachineMasterId;
  dynamic lookupDetId;
  String? machineName;
  String? unitName;
  String? lookupDetDescEn;
  dynamic userId;
  dynamic proLi;
  dynamic count;
  dynamic machineNameList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roDisinfectionDetailsId'] = roDisinfectionDetailsId;
    map['inspectionDate'] = inspectionDate;
    map['nextInspectionDate'] = nextInspectionDate;
    map['comments'] = comments;
    map['doneBy'] = doneBy;
    map['status'] = status;
    map['createdDate'] = createdDate;
    map['createdBy'] = createdBy;
    map['updatedDate'] = updatedDate;
    map['updatedBy'] = updatedBy;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    map['unitId'] = unitId;
    map['roMachineMasterId'] = roMachineMasterId;
    map['lookupDetId'] = lookupDetId;
    map['machineName'] = machineName;
    map['unitName'] = unitName;
    map['lookupDetDescEn'] = lookupDetDescEn;
    map['userId'] = userId;
    map['proLi'] = proLi;
    map['count'] = count;
    map['machineNameList'] = machineNameList;
    return map;
  }

}