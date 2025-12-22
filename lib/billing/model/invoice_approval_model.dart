class InvoiceApprovalModel {
  InvoiceApprovalModel({
      this.invoiceStateId, 
      this.serviceIdTypeofbilling, 
      this.invNo, 
      this.invoiceAmount, 
      this.invoiceRemark, 
      this.unitId, 
      this.status, 
      this.createBy, 
      this.createdDate, 
      this.updatedBy, 
      this.updatedDate, 
      this.districtId, 
      this.count, 
      this.inoviceId, 
      this.billGenerate, 
      this.serviceCode, 
      this.month, 
      this.year, 
      this.monthName, 
      this.billStatus, 
      this.expectedMavPerDayTot, 
      this.noOfDaysInTheMonthTot, 
      this.expectedDialysisCyclesTot, 
      this.actualNoOfDialysisCyclesConductedTot, 
      this.differenceTot, 
      this.differenceAmountTot, 
      this.invoiceDate, 
      this.remark, 
      this.approveRejectFlag, 
      this.levelValue, 
      this.ttInvoiceStatewiseBean,});

  InvoiceApprovalModel.fromJson(dynamic json) {
    invoiceStateId = json['invoiceStateId'];
    serviceIdTypeofbilling = json['serviceIdTypeofbilling'];
    invNo = json['invNo'];
    invoiceAmount = json['invoiceAmount'];
    invoiceRemark = json['invoiceRemark'];
    unitId = json['unitId'];
    status = json['status'];
    createBy = json['createBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    districtId = json['districtId'];
    count = json['count'];
    inoviceId = json['inoviceId'];
    billGenerate = json['billGenerate'];
    serviceCode = json['serviceCode'];
    month = json['month'];
    year = json['year'];
    monthName = json['monthName'];
    billStatus = json['billStatus'];
    expectedMavPerDayTot = json['expectedMavPerDayTot'];
    noOfDaysInTheMonthTot = json['noOfDaysInTheMonthTot'];
    expectedDialysisCyclesTot = json['expectedDialysisCyclesTot'];
    actualNoOfDialysisCyclesConductedTot = json['actualNoOfDialysisCyclesConductedTot'];
    differenceTot = json['differenceTot'];
    differenceAmountTot = json['differenceAmountTot'];
    invoiceDate = json['invoiceDate'];
    remark = json['remark'];
    approveRejectFlag = json['approveRejectFlag'];
    levelValue = json['levelValue'];
    ttInvoiceStatewiseBean = json['ttInvoiceStatewiseBean'];
  }
  int? invoiceStateId;
  dynamic serviceIdTypeofbilling;
  String? invNo;
  double? invoiceAmount;
  dynamic invoiceRemark;
  dynamic unitId;
  dynamic status;
  dynamic createBy;
  String? createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic districtId;
  dynamic count;
  dynamic inoviceId;
  dynamic billGenerate;
  dynamic serviceCode;
  int? month;
  int? year;
  String? monthName;
  dynamic billStatus;
  dynamic expectedMavPerDayTot;
  dynamic noOfDaysInTheMonthTot;
  dynamic expectedDialysisCyclesTot;
  dynamic actualNoOfDialysisCyclesConductedTot;
  dynamic differenceTot;
  dynamic differenceAmountTot;
  dynamic invoiceDate;
  dynamic remark;
  dynamic approveRejectFlag;
  dynamic levelValue;
  dynamic ttInvoiceStatewiseBean;
  bool isSelected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoiceStateId'] = invoiceStateId;
    map['serviceIdTypeofbilling'] = serviceIdTypeofbilling;
    map['invNo'] = invNo;
    map['invoiceAmount'] = invoiceAmount;
    map['invoiceRemark'] = invoiceRemark;
    map['unitId'] = unitId;
    map['status'] = status;
    map['createBy'] = createBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['districtId'] = districtId;
    map['count'] = count;
    map['inoviceId'] = inoviceId;
    map['billGenerate'] = billGenerate;
    map['serviceCode'] = serviceCode;
    map['month'] = month;
    map['year'] = year;
    map['monthName'] = monthName;
    map['billStatus'] = billStatus;
    map['expectedMavPerDayTot'] = expectedMavPerDayTot;
    map['noOfDaysInTheMonthTot'] = noOfDaysInTheMonthTot;
    map['expectedDialysisCyclesTot'] = expectedDialysisCyclesTot;
    map['actualNoOfDialysisCyclesConductedTot'] = actualNoOfDialysisCyclesConductedTot;
    map['differenceTot'] = differenceTot;
    map['differenceAmountTot'] = differenceAmountTot;
    map['invoiceDate'] = invoiceDate;
    map['remark'] = remark;
    map['approveRejectFlag'] = approveRejectFlag;
    map['levelValue'] = levelValue;
    map['ttInvoiceStatewiseBean'] = ttInvoiceStatewiseBean;
    return map;
  }

}