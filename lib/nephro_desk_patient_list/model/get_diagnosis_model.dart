class GetDiagonisisList {
  GetDiagonisisList({
      this.idicd10L, 
      this.icdCodeL, 
      this.nameL, 
      this.nameL1, 
      this.icdFlag, 
      this.icdStatus, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deleted, 
      this.deletedBy, 
      this.deletedDate, 
      this.unitId, 
      this.icd10LList, 
      this.icd10L1List, 
      this.icd10L2List,});

  GetDiagonisisList.fromJson(dynamic json) {
    idicd10L = json['idicd10_L'];
    icdCodeL = json['icd_code_L'];
    nameL = json['name_L'];
    nameL1 = json['name_L1'];
    icdFlag = json['icd_Flag'];
    icdStatus = json['icdStatus'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deleted = json['deleted'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
    unitId = json['unitId'];
    icd10LList = json['icd10_L_List'];
    icd10L1List = json['icd10_L1_List'];
    icd10L2List = json['icd10_L2_List'];
  }
  int? idicd10L;
  dynamic icdCodeL;
  String? nameL;
  dynamic nameL1;
  int? icdFlag;
  dynamic icdStatus;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  String? deleted;
  dynamic deletedBy;
  dynamic deletedDate;
  dynamic unitId;
  dynamic icd10LList;
  dynamic icd10L1List;
  dynamic icd10L2List;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idicd10_L'] = idicd10L;
    map['icd_code_L'] = icdCodeL;
    map['name_L'] = nameL;
    map['name_L1'] = nameL1;
    map['icd_Flag'] = icdFlag;
    map['icdStatus'] = icdStatus;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deleted'] = deleted;
    map['deletedBy'] = deletedBy;
    map['deletedDate'] = deletedDate;
    map['unitId'] = unitId;
    map['icd10_L_List'] = icd10LList;
    map['icd10_L1_List'] = icd10L1List;
    map['icd10_L2_List'] = icd10L2List;
    return map;
  }

}