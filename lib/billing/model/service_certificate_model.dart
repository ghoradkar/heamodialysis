class ServiceCertificateModel {
  ServiceCertificateModel({
      this.district, 
      this.fromDate, 
      this.toDate, 
      this.month, 
      this.year, 
      this.machineId, 
      this.unitId, 
      this.userId, 
      this.userType, 
      this.serviceId, 
      this.startIndex, 
      this.distId, 
      this.date, 
      this.serviceCode, 
      this.billStatus, 
      this.expectedMavPerDayTot, 
      this.noOfDaysInTheMonthTot, 
      this.expectedDialysisCyclesTot, 
      this.actualNoOfDialysisCyclesConductedTot, 
      this.differenceTot, 
      this.differenceAmountTot, 
      this.lookupDetValue, 
      this.viewSerCertDocEntryId, 
      this.listDataOfsearchRequestBean, 
      this.expMavDay, 
      this.daysInMonth, 
      this.diffrenceAmount, 
      this.machineCommencedate, 
      this.expectedDialysisCycles, 
      this.actualNoOfDialysisCyclesConducted, 
      this.nhmAmount, 
      this.difference, 
      this.treatCount, 
      this.treatInvCount, 
      this.invoiceId, 
      this.invoiceNo, 
      this.extInvoiceNo, 
      this.invStateId, 
      this.stateInvNo, 
      this.unitName, 
      this.billMonth, 
      this.serCerFilePath, 
      this.level, 
      this.stateId, 
      this.divId, 
      this.lookupDetId,});

  ServiceCertificateModel.fromJson(dynamic json) {
    district = json['district'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    month = json['month'];
    year = json['year'];
    machineId = json['machineId'];
    unitId = json['unitId'];
    userId = json['userId'];
    userType = json['userType'];
    serviceId = json['serviceId'];
    startIndex = json['startIndex'];
    distId = json['distId'];
    date = json['date'];
    serviceCode = json['serviceCode'];
    billStatus = json['billStatus'];
    expectedMavPerDayTot = json['expectedMavPerDayTot'];
    noOfDaysInTheMonthTot = json['noOfDaysInTheMonthTot'];
    expectedDialysisCyclesTot = json['expectedDialysisCyclesTot'];
    actualNoOfDialysisCyclesConductedTot = json['actualNoOfDialysisCyclesConductedTot'];
    differenceTot = json['differenceTot'];
    differenceAmountTot = json['differenceAmountTot'];
    lookupDetValue = json['lookupDetValue'];
    viewSerCertDocEntryId = json['viewSerCertDocEntryId'];
    listDataOfsearchRequestBean = json['listDataOfsearchRequestBean'];
    expMavDay = json['expMavDay'];
    daysInMonth = json['daysInMonth'];
    diffrenceAmount = json['diffrenceAmount'];
    machineCommencedate = json['machineCommencedate'];
    expectedDialysisCycles = json['expectedDialysisCycles'];
    actualNoOfDialysisCyclesConducted = json['actualNoOfDialysisCyclesConducted'];
    nhmAmount = json['nhmAmount'];
    difference = json['difference'];
    treatCount = json['treatCount'];
    treatInvCount = json['treatInvCount'];
    invoiceId = json['invoiceId'];
    invoiceNo = json['invoiceNo'];
    extInvoiceNo = json['extInvoiceNo'];
    invStateId = json['invStateId'];
    stateInvNo = json['stateInvNo'];
    unitName = json['unitName'];
    billMonth = json['billMonth'];
    serCerFilePath = json['serCerFilePath'];
    level = json['level'];
    stateId = json['stateId'];
    divId = json['divId'];
    lookupDetId = json['lookupDetId'];
  }
  dynamic district;
  bool isSelected = false;
  dynamic fromDate;
  dynamic toDate;
  dynamic month;
  int? year;
  dynamic machineId;
  dynamic unitId;
  dynamic userId;
  dynamic userType;
  dynamic serviceId;
  dynamic startIndex;
  dynamic distId;
  dynamic date;
  dynamic serviceCode;
  dynamic billStatus;
  dynamic expectedMavPerDayTot;
  dynamic noOfDaysInTheMonthTot;
  int? expectedDialysisCyclesTot;
  int? actualNoOfDialysisCyclesConductedTot;
  int? differenceTot;
  dynamic differenceAmountTot;
  dynamic lookupDetValue;
  int? viewSerCertDocEntryId;
  dynamic listDataOfsearchRequestBean;
  dynamic expMavDay;
  dynamic daysInMonth;
  dynamic diffrenceAmount;
  dynamic machineCommencedate;
  dynamic expectedDialysisCycles;
  dynamic actualNoOfDialysisCyclesConducted;
  double? nhmAmount;
  dynamic difference;
  dynamic treatCount;
  dynamic treatInvCount;
  int? invoiceId;
  String? invoiceNo;
  dynamic extInvoiceNo;
  int? invStateId;
  dynamic stateInvNo;
  String? unitName;
  String? billMonth;
  String? serCerFilePath;
  String? level;
  dynamic stateId;
  dynamic divId;
  dynamic lookupDetId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['district'] = district;
    map['fromDate'] = fromDate;
    map['toDate'] = toDate;
    map['month'] = month;
    map['year'] = year;
    map['machineId'] = machineId;
    map['unitId'] = unitId;
    map['userId'] = userId;
    map['userType'] = userType;
    map['serviceId'] = serviceId;
    map['startIndex'] = startIndex;
    map['distId'] = distId;
    map['date'] = date;
    map['serviceCode'] = serviceCode;
    map['billStatus'] = billStatus;
    map['expectedMavPerDayTot'] = expectedMavPerDayTot;
    map['noOfDaysInTheMonthTot'] = noOfDaysInTheMonthTot;
    map['expectedDialysisCyclesTot'] = expectedDialysisCyclesTot;
    map['actualNoOfDialysisCyclesConductedTot'] = actualNoOfDialysisCyclesConductedTot;
    map['differenceTot'] = differenceTot;
    map['differenceAmountTot'] = differenceAmountTot;
    map['lookupDetValue'] = lookupDetValue;
    map['viewSerCertDocEntryId'] = viewSerCertDocEntryId;
    map['listDataOfsearchRequestBean'] = listDataOfsearchRequestBean;
    map['expMavDay'] = expMavDay;
    map['daysInMonth'] = daysInMonth;
    map['diffrenceAmount'] = diffrenceAmount;
    map['machineCommencedate'] = machineCommencedate;
    map['expectedDialysisCycles'] = expectedDialysisCycles;
    map['actualNoOfDialysisCyclesConducted'] = actualNoOfDialysisCyclesConducted;
    map['nhmAmount'] = nhmAmount;
    map['difference'] = difference;
    map['treatCount'] = treatCount;
    map['treatInvCount'] = treatInvCount;
    map['invoiceId'] = invoiceId;
    map['invoiceNo'] = invoiceNo;
    map['extInvoiceNo'] = extInvoiceNo;
    map['invStateId'] = invStateId;
    map['stateInvNo'] = stateInvNo;
    map['unitName'] = unitName;
    map['billMonth'] = billMonth;
    map['serCerFilePath'] = serCerFilePath;
    map['level'] = level;
    map['stateId'] = stateId;
    map['divId'] = divId;
    map['lookupDetId'] = lookupDetId;
    return map;
  }

}