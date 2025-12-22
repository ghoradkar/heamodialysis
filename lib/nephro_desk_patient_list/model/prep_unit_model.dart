class PrepUnitModel {
  PrepUnitModel({
      this.uomId, 
      this.uomName, 
      this.uomDeleteFlag, 
      this.uomUpdateDate, 
      this.uomAddDate, 
      this.deletedDate, 
      this.userId, 
      this.unitId, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy, 
      this.listUomMaster,});

  PrepUnitModel.fromJson(dynamic json) {
    uomId = json['uomId'];
    uomName = json['uomName'];
    uomDeleteFlag = json['uomDeleteFlag'];
    uomUpdateDate = json['uomUpdateDate'];
    uomAddDate = json['uomAddDate'];
    deletedDate = json['deletedDate'];
    userId = json['userId'];
    unitId = json['unitId'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    if (json['listUomMaster'] != null) {
      listUomMaster = [];
      json['listUomMaster'].forEach((v) {
        listUomMaster?.add(ListUomMaster.fromJson(v));
      });
    }
  }
  dynamic uomId;
  dynamic uomName;
  dynamic uomDeleteFlag;
  dynamic uomUpdateDate;
  dynamic uomAddDate;
  dynamic deletedDate;
  int? userId;
  dynamic unitId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  List<ListUomMaster>? listUomMaster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uomId'] = uomId;
    map['uomName'] = uomName;
    map['uomDeleteFlag'] = uomDeleteFlag;
    map['uomUpdateDate'] = uomUpdateDate;
    map['uomAddDate'] = uomAddDate;
    map['deletedDate'] = deletedDate;
    map['userId'] = userId;
    map['unitId'] = unitId;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedBy'] = deletedBy;
    if (listUomMaster != null) {
      map['listUomMaster'] = listUomMaster?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ListUomMaster {
  ListUomMaster({
      this.uomId, 
      this.uomName, 
      this.uomDeleteFlag, 
      this.uomUpdateDate, 
      this.uomAddDate, 
      this.deletedDate, 
      this.userId, 
      this.unitId, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy, 
      this.listUomMaster,});

  ListUomMaster.fromJson(dynamic json) {
    uomId = json['uomId'];
    uomName = json['uomName'];
    uomDeleteFlag = json['uomDeleteFlag'];
    uomUpdateDate = json['uomUpdateDate'];
    uomAddDate = json['uomAddDate'];
    deletedDate = json['deletedDate'];
    userId = json['userId'];
    unitId = json['unitId'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    listUomMaster = json['listUomMaster'];
  }
  int? uomId;
  String? uomName;
  int? uomDeleteFlag;
  String? uomUpdateDate;
  String? uomAddDate;
  dynamic deletedDate;
  int? userId;
  dynamic unitId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic listUomMaster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uomId'] = uomId;
    map['uomName'] = uomName;
    map['uomDeleteFlag'] = uomDeleteFlag;
    map['uomUpdateDate'] = uomUpdateDate;
    map['uomAddDate'] = uomAddDate;
    map['deletedDate'] = deletedDate;
    map['userId'] = userId;
    map['unitId'] = unitId;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedBy'] = deletedBy;
    map['listUomMaster'] = listUomMaster;
    return map;
  }

}