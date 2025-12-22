class VisitorDocIdModel {
  VisitorDocIdModel({
      this.docId, 
      this.docDescdetEn, 
      this.requiredFlag,});

  VisitorDocIdModel.fromJson(dynamic json) {
    docId = json['docId'];
    docDescdetEn = json['docDescdetEn'];
    requiredFlag = json['requiredFlag'];
  }
  int? docId;
  String? docDescdetEn;
  String? requiredFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['docId'] = docId;
    map['docDescdetEn'] = docDescdetEn;
    map['requiredFlag'] = requiredFlag;
    return map;
  }

}