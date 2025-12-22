class ListBill {
  ListBill({
      this.billId, 
      this.treatmentId, 
      this.patienttId, 
      this.departmentId, 
      this.count, 
      this.sourceTypeId, 
      this.unitId, 
      this.deleted, 
      this.createdBy, 
      this.createdDateTime, 
      this.invoiceCreatedDateTime, 
      this.invCreatedBy, 
      this.updatedBy, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.invoiceFlag, 
      this.invoiceCount, 
      this.billType, 
      this.billTypeName, 
      this.deletedDateTime, 
      this.sponsorCatId, 
      this.patientCatId, 
      this.sponsorId, 
      this.totalBill, 
      this.totalPaid, 
      this.totalRemain, 
      this.totalRefund, 
      this.discount, 
      this.totalConcn, 
      this.billSettledFlag, 
      this.listBill});

  ListBill.fromJson(dynamic json) {
    billId = json['billId'];
    treatmentId = json['treatmentId'];
    patienttId = json['patienttId'];
    departmentId = json['departmentId'];
    count = json['count'];
    sourceTypeId = json['sourceTypeId'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
    invoiceCreatedDateTime = json['invoiceCreatedDateTime'];
    invCreatedBy = json['invCreatedBy'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    invoiceFlag = json['invoiceFlag'];
    invoiceCount = json['invoiceCount'];
    billType = json['billType'];
    billTypeName = json['billTypeName'];
    deletedDateTime = json['deletedDateTime'];
    sponsorCatId = json['sponsorCatId'];
    patientCatId = json['patientCatId'];
    sponsorId = json['sponsorId'];
    totalBill = json['totalBill'];
    totalPaid = json['totalPaid'];
    totalRemain = json['totalRemain'];
    totalRefund = json['totalRefund'];
    discount = json['discount'];
    totalConcn = json['totalConcn'];
    billSettledFlag = json['billSettledFlag'];
    listBill = json['listBill'];

  }
  int? billId;
  dynamic treatmentId;
  dynamic patienttId;
  int? departmentId;
  int? count;
  int? sourceTypeId;
  int? unitId;
  String? deleted;
  int? createdBy;
  int? createdDateTime;
  int? invoiceCreatedDateTime;
  int? invCreatedBy;
  dynamic updatedBy;
  dynamic updatedDateTime;
  dynamic deletedBy;
  String? invoiceFlag;
  int? invoiceCount;
  int? billType;
  dynamic billTypeName;
  dynamic deletedDateTime;
  int? sponsorCatId;
  int? patientCatId;
  int? sponsorId;
  double? totalBill;
  double? totalPaid;
  double? totalRemain;
  double? totalRefund;
  double? discount;
  double? totalConcn;
  String? billSettledFlag;
  dynamic listBill;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['billId'] = billId;
    map['treatmentId'] = treatmentId;
    map['patienttId'] = patienttId;
    map['departmentId'] = departmentId;
    map['count'] = count;
    map['sourceTypeId'] = sourceTypeId;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['createdBy'] = createdBy;
    map['createdDateTime'] = createdDateTime;
    map['invoiceCreatedDateTime'] = invoiceCreatedDateTime;
    map['invCreatedBy'] = invCreatedBy;
    map['updatedBy'] = updatedBy;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['invoiceFlag'] = invoiceFlag;
    map['invoiceCount'] = invoiceCount;
    map['billType'] = billType;
    map['billTypeName'] = billTypeName;
    map['deletedDateTime'] = deletedDateTime;
    map['sponsorCatId'] = sponsorCatId;
    map['patientCatId'] = patientCatId;
    map['sponsorId'] = sponsorId;
    map['totalBill'] = totalBill;
    map['totalPaid'] = totalPaid;
    map['totalRemain'] = totalRemain;
    map['totalRefund'] = totalRefund;
    map['discount'] = discount;
    map['totalConcn'] = totalConcn;
    map['billSettledFlag'] = billSettledFlag;
    map['listBill'] = listBill;

    return map;
  }

}