class IncedentTypeModel {
  IncedentTypeModel({
      this.lookupDetId, 
      this.lookupDetValue, 
      this.lookupDetDescEn, 
      this.lookupDetParentName,});

  IncedentTypeModel.fromJson(dynamic json) {
    lookupDetId = json['lookupDetId'];
    lookupDetValue = json['lookupDetValue'];
    lookupDetDescEn = json['lookupDetDescEn'];
    lookupDetParentName = json['lookupDetParentName'];
  }
  int? lookupDetId;
  String? lookupDetValue;
  String? lookupDetDescEn;
  String? lookupDetParentName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupDetId'] = lookupDetId;
    map['lookupDetValue'] = lookupDetValue;
    map['lookupDetDescEn'] = lookupDetDescEn;
    map['lookupDetParentName'] = lookupDetParentName;
    return map;
  }

}