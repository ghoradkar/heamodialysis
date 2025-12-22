class AddRoDisinfectModel {
  AddRoDisinfectModel({
      this.roDisinfectionDetailsId, 
      this.roMachineMasterId, 
      this.lookupDetId, 
      this.nextInspectionDate, 
      this.comments, 
      this.doneBy, 
      this.inspectionDate, 
      this.createdBy, 
      this.unitId,});

  AddRoDisinfectModel.fromJson(dynamic json) {
    roDisinfectionDetailsId = json['roDisinfectionDetailsId'];
    roMachineMasterId = json['roMachineMasterId'];
    lookupDetId = json['lookupDetId'];
    nextInspectionDate = json['nextInspectionDate'];
    comments = json['comments'];
    doneBy = json['doneBy'];
    inspectionDate = json['inspectionDate'];
    createdBy = json['createdBy'];
    unitId = json['unitId'];
  }
  int? roDisinfectionDetailsId;
  int? roMachineMasterId;
  int? lookupDetId;
  String? nextInspectionDate;
  String? comments;
  String? doneBy;
  String? inspectionDate;
  int? createdBy;
  int? unitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roDisinfectionDetailsId'] = roDisinfectionDetailsId;
    map['roMachineMasterId'] = roMachineMasterId;
    map['lookupDetId'] = lookupDetId;
    map['nextInspectionDate'] = nextInspectionDate;
    map['comments'] = comments;
    map['doneBy'] = doneBy;
    map['inspectionDate'] = inspectionDate;
    map['createdBy'] = createdBy;
    map['unitId'] = unitId;
    return map;
  }

}