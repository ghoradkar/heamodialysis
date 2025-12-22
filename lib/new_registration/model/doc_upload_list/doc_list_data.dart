class DocListData {
  DocListData({
      this.docId, 
      this.subModuleId, 
      this.subModuleName, 
      this.docDescdetEn, 
      this.docDescDetReg, 
      this.decDetSerNo, 
      this.status, 
      this.createdBy, 
      this.createdDate, 
      this.updatedBy, 
      this.updatedDate, 
      this.macId, 
      this.ipAddress, 
      this.deviceFrom, 
      this.requiredFlag, 
      this.unitId,});

  DocListData.fromJson(dynamic json) {
    docId = json['docId'];
    subModuleId = json['subModuleId'];
    subModuleName = json['subModuleName'];
    docDescdetEn = json['docDescdetEn'];
    docDescDetReg = json['docDescDetReg'];
    decDetSerNo = json['decDetSerNo'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    requiredFlag = json['requiredFlag'];
    unitId = json['unitId'];
  }
  int? docId;
  dynamic subModuleId;
  dynamic subModuleName;
  String? docDescdetEn;
  dynamic docDescDetReg;
  dynamic decDetSerNo;
  dynamic status;
  dynamic createdBy;
  dynamic createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic macId;
  dynamic ipAddress;
  dynamic deviceFrom;
  String? requiredFlag;
  dynamic unitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['docId'] = docId;
    map['subModuleId'] = subModuleId;
    map['subModuleName'] = subModuleName;
    map['docDescdetEn'] = docDescdetEn;
    map['docDescDetReg'] = docDescDetReg;
    map['decDetSerNo'] = decDetSerNo;
    map['status'] = status;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    map['requiredFlag'] = requiredFlag;
    map['unitId'] = unitId;
    return map;
  }

}