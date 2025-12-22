class SchemaData {
  SchemaData({
      this.lookupDetId, 
      this.lookupDetIdPatientType,
      this.lookupDetValue,
      this.lookupDetDescEn, 
      this.lookupDetDescRg, 
      this.lookupDetParentId, 
      this.lookupDetParentLevel, 
      this.lookupDetParentName, 
      this.lookupDetList, 
      this.ulbId,});

  SchemaData.fromJson(dynamic json) {
    lookupDetId = json['lookupDetId'];
    lookupDetIdPatientType = json['lookupDetIdPatientType'];
    lookupDetValue = json['lookupDetValue'];
    lookupDetDescEn = json['lookupDetDescEn'];
    lookupDetDescRg = json['lookupDetDescRg'];
    lookupDetParentId = json['lookupDetParentId'];
    lookupDetParentLevel = json['lookupDetParentLevel'];
    lookupDetParentName = json['lookupDetParentName'];
    lookupDetList = json['lookupDetList'];
    ulbId = json['ulbId'];
  }
  int? lookupDetId;
  String? lookupDetValue;
  int? lookupDetIdPatientType;
  String? lookupDetDescEn;
  dynamic lookupDetDescRg;
  dynamic lookupDetParentId;
  dynamic lookupDetParentLevel;
  String? lookupDetParentName;
  dynamic lookupDetList;
  dynamic ulbId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupDetId'] = lookupDetId;
    map['lookupDetIdPatientType'] = lookupDetIdPatientType;
    map['lookupDetValue'] = lookupDetValue;
    map['lookupDetDescEn'] = lookupDetDescEn;
    map['lookupDetDescRg'] = lookupDetDescRg;
    map['lookupDetParentId'] = lookupDetParentId;
    map['lookupDetParentLevel'] = lookupDetParentLevel;
    map['lookupDetParentName'] = lookupDetParentName;
    map['lookupDetList'] = lookupDetList;
    map['ulbId'] = ulbId;
    return map;
  }

}