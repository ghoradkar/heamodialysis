class RoDisinfectionDoc {
  RoDisinfectionDoc({
      this.id, 
      this.roDisId, 
      this.docpath,});

  RoDisinfectionDoc.fromJson(dynamic json) {
    id = json['Id'];
    roDisId = json['roDisId'];
    docpath = json['docpath'];
  }
  int? id;
  int? roDisId;
  String? docpath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['roDisId'] = roDisId;
    map['docpath'] = docpath;
    return map;
  }

}