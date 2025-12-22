

class AddTestPackageModel {
  AddTestPackageModel({
      this.patienttId, 
      this.perticularSName, 
      this.billDetailsId, 
      this.serviceId, 
      this.doctorId, 
      this.treatmentId, 
      this.departmentId, 
      this.billId, 
      this.rate, 
      this.concession, 
      this.concessionPer, 
      this.quantity, 
      this.amount, 
      this.pay, 
      this.coPay, 
      this.instructions, 
      this.clinicalnotes, 
      this.subServiceId, 
      this.unitId, 
      this.createdDateTime, 
      this.urgentFlag, 
      this.callfrom, 
      this.masterReceiptId, 
      this.subservicesname, 
      this.sponsorId, 
      this.chargesSlaveId, 
      this.otherAmount, 
      this.otherCoPay, 
      this.otherPay, 
      this.otherConcession, 
      this.narration, 
      this.hallId, 
      this.narrationidBill, 
      this.accountStatusIpd, 
      this.emrPer, 
      this.sendToRisIpdBill, 
      this.otFlag, 
      this.sndToLabFlag, 
      this.drdeskflag, 
      this.sampleTypeId, 
      this.barCode, 
      this.inOutHouse, 
      this.businessType, 
      this.customerId, 
      this.customerType, 
      this.regRefDocId, 
      this.event, 
      this.ivfTreatFlag,});

  AddTestPackageModel.fromJson(dynamic json) {
    patienttId = json['patienttId'];
    perticularSName = json['perticularSName'];
    billDetailsId = json['billDetailsId'];
    serviceId = json['serviceId'];
    doctorId = json['doctorId'];
    treatmentId = json['treatmentId'];
    departmentId = json['departmentId'];
    billId = json['billId'];
    rate = json['rate'];
    concession = json['concession'];
    concessionPer = json['concessionPer'];
    quantity = json['quantity'];
    amount = json['amount'];
    pay = json['pay'];
    coPay = json['coPay'];
    instructions = json['instructions'];
    clinicalnotes = json['clinicalnotes'];
    subServiceId = json['subServiceId'];
    unitId = json['unitId'];
    createdDateTime = json['createdDateTime'];
    urgentFlag = json['urgentFlag'];
    callfrom = json['callfrom'];
    masterReceiptId = json['masterReceiptId'];
    subservicesname = json['subservicesname'];
    sponsorId = json['sponsorId'];
    chargesSlaveId = json['chargesSlaveId'];
    otherAmount = json['otherAmount'];
    otherCoPay = json['otherCoPay'];
    otherPay = json['otherPay'];
    otherConcession = json['otherConcession'];
    narration = json['narration'];
    hallId = json['hallId'];
    narrationidBill = json['narrationidBill'];
    accountStatusIpd = json['accountStatusIpd'];
    emrPer = json['emrPer'];
    sendToRisIpdBill = json['sendToRisIpdBill'];
    otFlag = json['ot_flag'];
    sndToLabFlag = json['sndToLabFlag'];
    drdeskflag = json['drdeskflag'];
    sampleTypeId = json['sampleTypeId'];
    barCode = json['barCode'];
    inOutHouse = json['inOutHouse'];
    businessType = json['businessType'];
    customerId = json['customerId'];
    customerType = json['customerType'];
    regRefDocId = json['regRefDocId'];
    event = json['event'];
    ivfTreatFlag = json['ivfTreatFlag'];
  }
  String? patienttId;
  String? perticularSName;
  String? billDetailsId;
  String? serviceId;
  String? doctorId;
  String? treatmentId;
  String? departmentId;
  dynamic billId;
  String? rate;
  String? concession;
  String? concessionPer;
  int? quantity;
  String? amount;
  String? pay;
  String? coPay;
  String? instructions;
  String? clinicalnotes;
  int? subServiceId;
  String? unitId;
  dynamic createdDateTime;
  String? urgentFlag;
  String? callfrom;
  String? masterReceiptId;
  String? subservicesname;
  int? sponsorId;
  int? chargesSlaveId;
  dynamic otherAmount;
  int? otherCoPay;
  dynamic otherPay;
  String? otherConcession;
  String? narration;
  int? hallId;
  String? narrationidBill;
  String? accountStatusIpd;
  int? emrPer;
  String? sendToRisIpdBill;
  String? otFlag;
  String? sndToLabFlag;
  String? drdeskflag;
  int? sampleTypeId;
  int? barCode;
  String? inOutHouse;
  int? businessType;
  int? customerId;
  int? customerType;
  int? regRefDocId;
  String? event;
  String? ivfTreatFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patienttId'] = patienttId;
    map['perticularSName'] = perticularSName;
    map['billDetailsId'] = billDetailsId;
    map['serviceId'] = serviceId;
    map['doctorId'] = doctorId;
    map['treatmentId'] = treatmentId;
    map['departmentId'] = departmentId;
    map['billId'] = billId;
    map['rate'] = rate;
    map['concession'] = concession;
    map['concessionPer'] = concessionPer;
    map['quantity'] = quantity;
    map['amount'] = amount;
    map['pay'] = pay;
    map['coPay'] = coPay;
    map['instructions'] = instructions;
    map['clinicalnotes'] = clinicalnotes;
    map['subServiceId'] = subServiceId;
    map['unitId'] = unitId;
    map['createdDateTime'] = createdDateTime;
    map['urgentFlag'] = urgentFlag;
    map['callfrom'] = callfrom;
    map['masterReceiptId'] = masterReceiptId;
    map['subservicesname'] = subservicesname;
    map['sponsorId'] = sponsorId;
    map['chargesSlaveId'] = chargesSlaveId;
    map['otherAmount'] = otherAmount;
    map['otherCoPay'] = otherCoPay;
    map['otherPay'] = otherPay;
    map['otherConcession'] = otherConcession;
    map['narration'] = narration;
    map['hallId'] = hallId;
    map['narrationidBill'] = narrationidBill;
    map['accountStatusIpd'] = accountStatusIpd;
    map['emrPer'] = emrPer;
    map['sendToRisIpdBill'] = sendToRisIpdBill;
    map['ot_flag'] = otFlag;
    map['sndToLabFlag'] = sndToLabFlag;
    map['drdeskflag'] = drdeskflag;
    map['sampleTypeId'] = sampleTypeId;
    map['barCode'] = barCode;
    map['inOutHouse'] = inOutHouse;
    map['businessType'] = businessType;
    map['customerId'] = customerId;
    map['customerType'] = customerType;
    map['regRefDocId'] = regRefDocId;
    map['event'] = event;
    map['ivfTreatFlag'] = ivfTreatFlag;
    return map;
  }

}