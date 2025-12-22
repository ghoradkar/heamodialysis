class TmCmLookupDet {
  TmCmLookupDet({
      this.lookupDetId, 
      this.ulbId, 
      this.lookupDetValue, 
      this.lookupDetDescEn, 
      this.lookupDetDescRg, 
      this.lookupDetParentId, 
      this.lookupDetParentLevel, 
      this.createdBy, 
      this.createdDate, 
      this.updatedBy, 
      this.updatedDate, 
      this.macId, 
      this.ipAddress, 
      this.deviceFrom, 
      this.lookupDetOthers, 
      this.lookupDetDefault, 
      this.stateUlbFlag, 
      this.lookupOrderby, 
      this.lookupDetStatus,});

  TmCmLookupDet.fromJson(dynamic json) {
    lookupDetId = json['lookupDetId'];
    ulbId = json['ulbId'];
    lookupDetValue = json['lookupDetValue'];
    lookupDetDescEn = json['lookupDetDescEn'];
    lookupDetDescRg = json['lookupDetDescRg'];
    lookupDetParentId = json['lookupDetParentId'];
    lookupDetParentLevel = json['lookupDetParentLevel'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    lookupDetOthers = json['lookupDetOthers'];
    lookupDetDefault = json['lookupDetDefault'];
    stateUlbFlag = json['stateUlbFlag'];
    lookupOrderby = json['lookupOrderby'];
    lookupDetStatus = json['lookupDetStatus'];
  }
  int? lookupDetId;
  int? ulbId;
  String? lookupDetValue;
  String? lookupDetDescEn;
  String? lookupDetDescRg;
  dynamic lookupDetParentId;
  int? lookupDetParentLevel;
  int? createdBy;
  String? createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  String? macId;
  String? ipAddress;
  String? deviceFrom;
  String? lookupDetOthers;
  String? lookupDetDefault;
  String? stateUlbFlag;
  int? lookupOrderby;
  int? lookupDetStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupDetId'] = lookupDetId;
    map['ulbId'] = ulbId;
    map['lookupDetValue'] = lookupDetValue;
    map['lookupDetDescEn'] = lookupDetDescEn;
    map['lookupDetDescRg'] = lookupDetDescRg;
    map['lookupDetParentId'] = lookupDetParentId;
    map['lookupDetParentLevel'] = lookupDetParentLevel;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    map['lookupDetOthers'] = lookupDetOthers;
    map['lookupDetDefault'] = lookupDetDefault;
    map['stateUlbFlag'] = stateUlbFlag;
    map['lookupOrderby'] = lookupOrderby;
    map['lookupDetStatus'] = lookupDetStatus;
    return map;
  }

}