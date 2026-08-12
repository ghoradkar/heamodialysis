class SearchedData {
  SearchedData({
      this.lookupDetId, 
      this.lookupDetValue, 
      this.lookupDetDescEn, 
      this.lookupDetDescRg, 
      this.lookupDetParentId, 
      this.lookupDetParentLevel, 
      this.lookupDetParentName, 
      this.lookupDetList, 
      this.ulbId,});

  SearchedData.fromJson(dynamic json) {
    lookupDetId = json['lookupDetId'];
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchedData &&
          runtimeType == other.runtimeType &&
          lookupDetId == other.lookupDetId;

  @override
  int get hashCode => lookupDetId.hashCode;
}