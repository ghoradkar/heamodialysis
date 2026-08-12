class NephroDeskDropDown {
  NephroDeskDropDown({
      this.lookupList, 
      this.unitList,});

  NephroDeskDropDown.fromJson(dynamic json) {
    if (json['lookupList'] != null) {
      lookupList = [];
      json['lookupList'].forEach((v) {
        lookupList?.add(LookupList.fromJson(v));
      });
    }
    if (json['unitList'] != null) {
      unitList = [];
      json['unitList'].forEach((v) {
        unitList?.add(UnitList.fromJson(v));
      });
    }
  }
  List<LookupList>? lookupList;
  List<UnitList>? unitList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (lookupList != null) {
      map['lookupList'] = lookupList?.map((v) => v.toJson()).toList();
    }
    if (unitList != null) {
      map['unitList'] = unitList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class UnitList {
  UnitList({
    this.unitName,
    this.districtName,
    this.unitId,});

  UnitList.fromJson(dynamic json) {
    unitName = json['unitName'];
    districtName = json['districtName'];
    unitId = json['unitId'];
  }
  String? unitName;
  String? districtName;
  String? unitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitName'] = unitName;
    map['districtName'] = districtName;
    map['unitId'] = unitId;
    return map;
  }

}

class LookupList {
  LookupList({
    this.lookupId,
    this.lookupDetDescEn,
    this.lookupDetId,
    this.lookupDetValue,
    this.lookupDetDescRg,});

  LookupList.fromJson(dynamic json) {
    lookupId = json['lookupId'];
    lookupDetDescEn = json['lookupDetDescEn'];
    lookupDetId = json['lookupDetId'];
    lookupDetValue = json['lookupDetValue'];
    lookupDetDescRg = json['lookupDetDescRg'];
  }
  String? lookupId;
  String? lookupDetDescEn;
  String? lookupDetId;
  String? lookupDetValue;
  String? lookupDetDescRg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupId'] = lookupId;
    map['lookupDetDescEn'] = lookupDetDescEn;
    map['lookupDetId'] = lookupDetId;
    map['lookupDetValue'] = lookupDetValue;
    map['lookupDetDescRg'] = lookupDetDescRg;
    return map;
  }

}