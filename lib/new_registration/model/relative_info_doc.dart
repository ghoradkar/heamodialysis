class RelativeInfoDoc {
  RelativeInfoDoc({
    this.patientId,
    this.realtiveId,
    this.realtionId,
    this.docpath,
    this.realtiveName,
    this.realtiveMobile,
  });

  RelativeInfoDoc.fromJson(dynamic json) {
    patientId = json['patientId'];
    realtiveId = json['realtiveId'];
    realtionId = json['realtionId'];
    docpath = json['docpath'];
    realtiveName = json['realtiveName'];
    realtiveMobile = json['realtiveMobile'];
  }

  int? patientId;
  int? realtiveId;
  int? realtionId;
  String? docpath;
  String? realtiveName;
  String? realtiveMobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['realtiveId'] = realtiveId;
    map['realtionId'] = realtionId;
    map['docpath'] = docpath;
    map['realtiveName'] = realtiveName;
    map['realtiveMobile'] = realtiveMobile;
    return map;
  }
}
