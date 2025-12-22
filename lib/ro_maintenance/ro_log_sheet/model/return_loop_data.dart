class ReturnLoopData {
  ReturnLoopData({
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

  ReturnLoopData.fromJson(dynamic json) {
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
  dynamic ulbId;
  String? lookupDetValue;
  String? lookupDetDescEn;
  dynamic lookupDetDescRg;
  dynamic lookupDetParentId;
  dynamic lookupDetParentLevel;
  dynamic createdBy;
  dynamic createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic macId;
  dynamic ipAddress;
  dynamic deviceFrom;
  dynamic lookupDetOthers;
  dynamic lookupDetDefault;
  dynamic stateUlbFlag;
  dynamic lookupOrderby;
  dynamic lookupDetStatus;

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