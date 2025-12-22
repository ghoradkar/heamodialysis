class AddConsumableEntryModel {
  AddConsumableEntryModel({
      this.physicalConsumableDetId, 
      this.itemId, 
      this.patientId, 
      this.treatmentId, 
      this.consumedQuantity, 
      this.usedQuantity, 
      this.variableQuantity, 
      this.consumableModeFlag, 
      this.unitId, 
      this.remark, 
      this.itenName, 
      this.batchNo, 
      this.expiryDate, 
      this.orderNo, 
      this.userId,});

  AddConsumableEntryModel.fromJson(dynamic json) {
    physicalConsumableDetId = json['physicalConsumableDetId'];
    itemId = json['itemId'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    consumedQuantity = json['consumedQuantity'];
    usedQuantity = json['usedQuantity'];
    variableQuantity = json['variableQuantity'];
    consumableModeFlag = json['consumableModeFlag'];
    unitId = json['unitId'];
    remark = json['remark'];
    itenName = json['itenName'];
    batchNo = json['batchNo'];
    expiryDate = json['expiryDate'];
    orderNo = json['orderNo'];
    userId = json['userId'];
  }
  String? physicalConsumableDetId;
  String? itemId;
  String? patientId;
  String? treatmentId;
  String? consumedQuantity;
  String? usedQuantity;
  String? variableQuantity;
  String? consumableModeFlag;
  String? unitId;
  String? remark;
  String? itenName;
  String? batchNo;
  String? expiryDate;
  String? orderNo;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['physicalConsumableDetId'] = physicalConsumableDetId;
    map['itemId'] = itemId;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['consumedQuantity'] = consumedQuantity;
    map['usedQuantity'] = usedQuantity;
    map['variableQuantity'] = variableQuantity;
    map['consumableModeFlag'] = consumableModeFlag;
    map['unitId'] = unitId;
    map['remark'] = remark;
    map['itenName'] = itenName;
    map['batchNo'] = batchNo;
    map['expiryDate'] = expiryDate;
    map['orderNo'] = orderNo;
    map['userId'] = userId;
    return map;
  }

}