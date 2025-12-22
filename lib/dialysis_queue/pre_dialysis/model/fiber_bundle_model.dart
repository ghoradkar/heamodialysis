class FiberBundleModel {
  FiberBundleModel({
      this.lookupDetHierId, 
      this.lookupDetHierDescEn,});

  FiberBundleModel.fromJson(dynamic json) {
    lookupDetHierId = json['lookupDetHierId'];
    lookupDetHierDescEn = json['lookupDetHierDescEn'];
  }
  int? lookupDetHierId;
  String? lookupDetHierDescEn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookupDetHierId'] = lookupDetHierId;
    map['lookupDetHierDescEn'] = lookupDetHierDescEn;
    return map;
  }

}