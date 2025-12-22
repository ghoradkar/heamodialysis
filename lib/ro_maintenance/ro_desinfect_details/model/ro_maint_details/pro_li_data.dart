import 'pro_li.dart';

class ProLiData {
  ProLiData({
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

  ProLiData.fromJson(dynamic json) {
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
    if (json['proLi'] != null) {
      proLi = [];
      json['proLi'].forEach((v) {
        proLi?.add(ProLi.fromJson(v));
      });
    }
    count = json['count'];
    machineNameList = json['machineNameList'];
  }
  int? roDisinfectionDetailsId;
  dynamic inspectionDate;
  dynamic nextInspectionDate;
  dynamic comments;
  dynamic doneBy;
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
  dynamic machineName;
  dynamic unitName;
  dynamic lookupDetDescEn;
  dynamic userId;
  List<ProLi>? proLi;
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
    if (proLi != null) {
      map['proLi'] = proLi?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    map['machineNameList'] = machineNameList;
    return map;
  }

}