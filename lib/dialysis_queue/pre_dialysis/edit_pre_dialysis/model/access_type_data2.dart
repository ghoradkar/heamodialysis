class AccessTypeData2 {
  AccessTypeData2({
      this.lookupDetHierId, 
      this.lookupDetHierValue, 
      this.lookupDetHierDescEn,});

  AccessTypeData2.fromJson(dynamic json) {
    lookupDetHierId = json['lookupDetHierId'];
    lookupDetHierValue = json['lookupDetHierValue'];
    lookupDetHierDescEn = json['lookupDetHierDescEn'];
  }
  int? lookupDetHierId;
  String? lookupDetHierValue;
  String? lookupDetHierDescEn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupDetHierId'] = lookupDetHierId;
    map['lookupDetHierValue'] = lookupDetHierValue;
    map['lookupDetHierDescEn'] = lookupDetHierDescEn;
    return map;
  }

}