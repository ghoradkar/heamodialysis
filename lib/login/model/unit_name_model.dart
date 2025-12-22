class UnitNameModel {
  UnitNameModel({
      this.unitId, 
      this.unitName, 
      this.deleted, 
      this.activeFlag,});

  UnitNameModel.fromJson(dynamic json) {
    unitId = json['unitId'];
    unitName = json['unitName'];
    deleted = json['deleted'];
    activeFlag = json['activeFlag'];
  }
  int? unitId;
  String? unitName;
  String? deleted;
  String? activeFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitId'] = unitId;
    map['unitName'] = unitName;
    map['deleted'] = deleted;
    map['activeFlag'] = activeFlag;
    return map;
  }

}