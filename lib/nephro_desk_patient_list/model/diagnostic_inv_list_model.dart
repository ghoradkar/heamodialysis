class DiagnosticInvListModel {
  DiagnosticInvListModel({
      this.treatmentId, 
      this.billDetailsId, 
      this.serviceId, 
      this.subServiceId, 
      this.chargesSlaveId, 
      this.unitId, 
      this.categoryName, 
      this.bedHall, 
      this.bedDate, 
      this.hallID, 
      this.specialityId, 
      this.docId, 
      this.docName, 
      this.isCombination, 
      this.iscombination, 
      this.rate, 
      this.charges, 
      this.otherRate, 
      this.otherAmount, 
      this.otherPay, 
      this.otherConcession, 
      this.otherCoPay, 
      this.amount, 
      this.concessionOnPerc, 
      this.concessionPer, 
      this.drdeskflag, 
      this.quantity, 
      this.paidFlag, 
      this.sndtolabflag, 
      this.paidByCashFlag, 
      this.sampleTypeId, 
      this.barCode, 
      this.inOutHouse, 
      this.histopathLab, 
      this.sampleCount, 
      this.collectionDate, 
      this.collectionTime, 
      this.regRefDocId, 
      this.templateWise, 
      this.invName, 
      this.pay, 
      this.coPay, 
      this.concession, 
      this.cancle, 
      this.isModify, 
      this.cghsCode, 
      this.createdDateTime, 
      this.createdDate, 
      this.emrPer, 
      this.sndtorisflag, 
      this.serviceName, 
      this.otFlag,
      this.clinicalNotes, 
      this.instructions, 
      this.countOt, 
      this.investigationEvent, 
      this.investigationEventDesc, 
      this.sendtotechflag, 
      this.listBillNobleServiceDto, 
      this.listSubServiceIpdDto, 
      this.listSubServiceInventoryDto, 
      this.oname,});

  DiagnosticInvListModel.fromJson(dynamic json) {
    treatmentId = json['treatmentId'];
    billDetailsId = json['billDetailsId'];
    serviceId = json['serviceId'];
    subServiceId = json['subServiceId'];
    chargesSlaveId = json['chargesSlaveId'];
    unitId = json['unitId'];
    categoryName = json['categoryName'];
    bedHall = json['bedHall'];
    bedDate = json['bedDate'];
    hallID = json['hallID'];
    specialityId = json['specialityId'];
    docId = json['docId'];
    docName = json['docName'];
    isCombination = json['isCombination'];
    iscombination = json['iscombination'];
    rate = json['rate'];
    charges = json['charges'];
    otherRate = json['otherRate'];
    otherAmount = json['otherAmount'];
    otherPay = json['otherPay'];
    otherConcession = json['otherConcession'];
    otherCoPay = json['otherCoPay'];
    amount = json['amount'];
    concessionOnPerc = json['concessionOnPerc'];
    concessionPer = json['concessionPer'];
    drdeskflag = json['drdeskflag'];
    quantity = json['quantity'];
    paidFlag = json['paidFlag'];
    sndtolabflag = json['sndtolabflag'];
    paidByCashFlag = json['paidByCashFlag'];
    sampleTypeId = json['sampleTypeId'];
    barCode = json['barCode'];
    inOutHouse = json['inOutHouse'];
    histopathLab = json['histopathLab'];
    sampleCount = json['sampleCount'];
    collectionDate = json['collectionDate'];
    collectionTime = json['collectionTime'];
    regRefDocId = json['regRefDocId'];
    templateWise = json['templateWise'];
    invName = json['invName'];
    pay = json['pay'];
    coPay = json['coPay'];
    concession = json['concession'];
    cancle = json['cancle'];
    isModify = json['isModify'];
    cghsCode = json['cghsCode'];
    createdDateTime = json['createdDateTime'];
    createdDate = json['createdDate'];
    emrPer = json['emrPer'];
    sndtorisflag = json['sndtorisflag'];
    serviceName = json['serviceName'];
    otFlag = json['otFlag'];
    templateWise = json['template_wise'];
    clinicalNotes = json['clinical_notes'];
    instructions = json['instructions'];
    countOt = json['count_ot'];
    investigationEvent = json['investigation_event'];
    investigationEventDesc = json['investigation_event_desc'];
    sendtotechflag = json['sendtotechflag'];
    listBillNobleServiceDto = json['listBillNobleServiceDto'];
    if (json['listSubServiceIpdDto'] != null) {
      listSubServiceIpdDto = [];
      json['listSubServiceIpdDto'].forEach((v) {
        listSubServiceIpdDto?.add(ListSubServiceIpdDto.fromJson(v));
      });
    }
    listSubServiceInventoryDto = json['listSubServiceInventoryDto'];
    oname = json['oname'];
  }
  int? treatmentId;
  dynamic billDetailsId;
  int? serviceId;
  dynamic subServiceId;
  dynamic chargesSlaveId;
  dynamic unitId;
  dynamic categoryName;
  dynamic bedHall;
  dynamic bedDate;
  dynamic hallID;
  dynamic specialityId;
  dynamic docId;
  dynamic docName;
  dynamic isCombination;
  dynamic iscombination;
  double? rate;
  double? charges;
  double? otherRate;
  double? otherAmount;
  double? otherPay;
  double? otherConcession;
  double? otherCoPay;
  double? amount;
  double? concessionOnPerc;
  double? concessionPer;
  dynamic drdeskflag;
  double? quantity;
  String? paidFlag;
  dynamic sndtolabflag;
  dynamic paidByCashFlag;
  int? sampleTypeId;
  dynamic barCode;
  int? inOutHouse;
  String? histopathLab;
  int? sampleCount;
  String? collectionDate;
  String? collectionTime;
  int? regRefDocId;
  String? templateWise;
  dynamic invName;
  double? pay;
  double? coPay;
  double? concession;
  String? cancle;
  dynamic isModify;
  dynamic cghsCode;
  dynamic createdDateTime;
  dynamic createdDate;
  double? emrPer;
  dynamic sndtorisflag;
  dynamic serviceName;
  dynamic otFlag;
  dynamic clinicalNotes;
  dynamic instructions;
  dynamic countOt;
  dynamic investigationEvent;
  dynamic investigationEventDesc;
  dynamic sendtotechflag;
  dynamic listBillNobleServiceDto;
  List<ListSubServiceIpdDto>? listSubServiceIpdDto;
  dynamic listSubServiceInventoryDto;
  dynamic oname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['treatmentId'] = treatmentId;
    map['billDetailsId'] = billDetailsId;
    map['serviceId'] = serviceId;
    map['subServiceId'] = subServiceId;
    map['chargesSlaveId'] = chargesSlaveId;
    map['unitId'] = unitId;
    map['categoryName'] = categoryName;
    map['bedHall'] = bedHall;
    map['bedDate'] = bedDate;
    map['hallID'] = hallID;
    map['specialityId'] = specialityId;
    map['docId'] = docId;
    map['docName'] = docName;
    map['isCombination'] = isCombination;
    map['iscombination'] = iscombination;
    map['rate'] = rate;
    map['charges'] = charges;
    map['otherRate'] = otherRate;
    map['otherAmount'] = otherAmount;
    map['otherPay'] = otherPay;
    map['otherConcession'] = otherConcession;
    map['otherCoPay'] = otherCoPay;
    map['amount'] = amount;
    map['concessionOnPerc'] = concessionOnPerc;
    map['concessionPer'] = concessionPer;
    map['drdeskflag'] = drdeskflag;
    map['quantity'] = quantity;
    map['paidFlag'] = paidFlag;
    map['sndtolabflag'] = sndtolabflag;
    map['paidByCashFlag'] = paidByCashFlag;
    map['sampleTypeId'] = sampleTypeId;
    map['barCode'] = barCode;
    map['inOutHouse'] = inOutHouse;
    map['histopathLab'] = histopathLab;
    map['sampleCount'] = sampleCount;
    map['collectionDate'] = collectionDate;
    map['collectionTime'] = collectionTime;
    map['regRefDocId'] = regRefDocId;
    map['templateWise'] = templateWise;
    map['invName'] = invName;
    map['pay'] = pay;
    map['coPay'] = coPay;
    map['concession'] = concession;
    map['cancle'] = cancle;
    map['isModify'] = isModify;
    map['cghsCode'] = cghsCode;
    map['createdDateTime'] = createdDateTime;
    map['createdDate'] = createdDate;
    map['emrPer'] = emrPer;
    map['sndtorisflag'] = sndtorisflag;
    map['serviceName'] = serviceName;
    map['otFlag'] = otFlag;
    map['template_wise'] = templateWise;
    map['clinical_notes'] = clinicalNotes;
    map['instructions'] = instructions;
    map['count_ot'] = countOt;
    map['investigation_event'] = investigationEvent;
    map['investigation_event_desc'] = investigationEventDesc;
    map['sendtotechflag'] = sendtotechflag;
    map['listBillNobleServiceDto'] = listBillNobleServiceDto;
    if (listSubServiceIpdDto != null) {
      map['listSubServiceIpdDto'] = listSubServiceIpdDto?.map((v) => v.toJson()).toList();
    }
    map['listSubServiceInventoryDto'] = listSubServiceInventoryDto;
    map['oname'] = oname;
    return map;
  }

}

class ListSubServiceIpdDto {
  ListSubServiceIpdDto({
      this.treatmentId, 
      this.billDetailsId, 
      this.serviceId, 
      this.subServiceId, 
      this.chargesSlaveId, 
      this.unitId, 
      this.categoryName, 
      this.bedHall, 
      this.bedDate, 
      this.hallID, 
      this.specialityId, 
      this.docId, 
      this.docName, 
      this.isCombination, 
      this.iscombination, 
      this.rate, 
      this.charges, 
      this.otherRate, 
      this.otherAmount, 
      this.otherPay, 
      this.otherConcession, 
      this.otherCoPay, 
      this.amount, 
      this.concessionOnPerc, 
      this.concessionPer, 
      this.drdeskflag, 
      this.quantity, 
      this.paidFlag, 
      this.sndtolabflag, 
      this.paidByCashFlag, 
      this.sampleTypeId, 
      this.barCode, 
      this.inOutHouse, 
      this.histopathLab, 
      this.sampleCount, 
      this.collectionDate, 
      this.collectionTime, 
      this.regRefDocId, 
      this.templateWise, 
      this.invName, 
      this.pay, 
      this.coPay, 
      this.concession, 
      this.cancle, 
      this.isModify, 
      this.cghsCode, 
      this.createdDateTime, 
      this.createdDate, 
      this.emrPer, 
      this.sndtorisflag, 
      this.serviceName, 
      this.otFlag,
      this.clinicalNotes, 
      this.instructions, 
      this.countOt, 
      this.investigationEvent, 
      this.investigationEventDesc, 
      this.sendtotechflag, 
      this.listBillNobleServiceDto, 
      this.listSubServiceIpdDto, 
      this.listSubServiceInventoryDto, 
      this.oname,});

  ListSubServiceIpdDto.fromJson(dynamic json) {
    treatmentId = json['treatmentId'];
    billDetailsId = json['billDetailsId'];
    serviceId = json['serviceId'];
    subServiceId = json['subServiceId'];
    chargesSlaveId = json['chargesSlaveId'];
    unitId = json['unitId'];
    categoryName = json['categoryName'];
    bedHall = json['bedHall'];
    bedDate = json['bedDate'];
    hallID = json['hallID'];
    specialityId = json['specialityId'];
    docId = json['docId'];
    docName = json['docName'];
    isCombination = json['isCombination'];
    iscombination = json['iscombination'];
    rate = json['rate'];
    charges = json['charges'];
    otherRate = json['otherRate'];
    otherAmount = json['otherAmount'];
    otherPay = json['otherPay'];
    otherConcession = json['otherConcession'];
    otherCoPay = json['otherCoPay'];
    amount = json['amount'];
    concessionOnPerc = json['concessionOnPerc'];
    concessionPer = json['concessionPer'];
    drdeskflag = json['drdeskflag'];
    quantity = json['quantity'];
    paidFlag = json['paidFlag'];
    sndtolabflag = json['sndtolabflag'];
    paidByCashFlag = json['paidByCashFlag'];
    sampleTypeId = json['sampleTypeId'];
    barCode = json['barCode'];
    inOutHouse = json['inOutHouse'];
    histopathLab = json['histopathLab'];
    sampleCount = json['sampleCount'];
    collectionDate = json['collectionDate'];
    collectionTime = json['collectionTime'];
    regRefDocId = json['regRefDocId'];
    templateWise = json['templateWise'];
    invName = json['invName'];
    pay = json['pay'];
    coPay = json['coPay'];
    concession = json['concession'];
    cancle = json['cancle'];
    isModify = json['isModify'];
    cghsCode = json['cghsCode'];
    createdDateTime = json['createdDateTime'];
    createdDate = json['createdDate'];
    emrPer = json['emrPer'];
    sndtorisflag = json['sndtorisflag'];
    serviceName = json['serviceName'];
    otFlag = json['otFlag'];
    templateWise = json['template_wise'];
    clinicalNotes = json['clinical_notes'];
    instructions = json['instructions'];
    countOt = json['count_ot'];
    investigationEvent = json['investigation_event'];
    investigationEventDesc = json['investigation_event_desc'];
    sendtotechflag = json['sendtotechflag'];
    listBillNobleServiceDto = json['listBillNobleServiceDto'];
    listSubServiceIpdDto = json['listSubServiceIpdDto'];
    listSubServiceInventoryDto = json['listSubServiceInventoryDto'];
    oname = json['oname'];
  }
  int? treatmentId;
  int? billDetailsId;
  int? serviceId;
  int? subServiceId;
  int? chargesSlaveId;
  dynamic unitId;
  String? categoryName;
  dynamic bedHall;
  dynamic bedDate;
  dynamic hallID;
  int? specialityId;
  int? docId;
  String? docName;
  String? isCombination;
  dynamic iscombination;
  double? rate;
  double? charges;
  double? otherRate;
  double? otherAmount;
  dynamic otherPay;
  dynamic otherConcession;
  double? otherCoPay;
  double? amount;
  double? concessionOnPerc;
  double? concessionPer;
  String? drdeskflag;
  double? quantity;
  String? paidFlag;
  String? sndtolabflag;
  String? paidByCashFlag;
  int? sampleTypeId;
  String? barCode;
  int? inOutHouse;
  String? histopathLab;
  int? sampleCount;
  String? collectionDate;
  String? collectionTime;
  int? regRefDocId;
  String? templateWise;
  dynamic invName;
  double? pay;
  double? coPay;
  double? concession;
  String? cancle;
  String? isModify;
  String? cghsCode;
  dynamic createdDateTime;
  String? createdDate;
  double? emrPer;
  dynamic sndtorisflag;
  String? serviceName;
  String? otFlag;
  String? clinicalNotes;
  String? instructions;
  int? countOt;
  dynamic investigationEvent;
  String? investigationEventDesc;
  dynamic sendtotechflag;
  dynamic listBillNobleServiceDto;
  dynamic listSubServiceIpdDto;
  dynamic listSubServiceInventoryDto;
  String? oname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['treatmentId'] = treatmentId;
    map['billDetailsId'] = billDetailsId;
    map['serviceId'] = serviceId;
    map['subServiceId'] = subServiceId;
    map['chargesSlaveId'] = chargesSlaveId;
    map['unitId'] = unitId;
    map['categoryName'] = categoryName;
    map['bedHall'] = bedHall;
    map['bedDate'] = bedDate;
    map['hallID'] = hallID;
    map['specialityId'] = specialityId;
    map['docId'] = docId;
    map['docName'] = docName;
    map['isCombination'] = isCombination;
    map['iscombination'] = iscombination;
    map['rate'] = rate;
    map['charges'] = charges;
    map['otherRate'] = otherRate;
    map['otherAmount'] = otherAmount;
    map['otherPay'] = otherPay;
    map['otherConcession'] = otherConcession;
    map['otherCoPay'] = otherCoPay;
    map['amount'] = amount;
    map['concessionOnPerc'] = concessionOnPerc;
    map['concessionPer'] = concessionPer;
    map['drdeskflag'] = drdeskflag;
    map['quantity'] = quantity;
    map['paidFlag'] = paidFlag;
    map['sndtolabflag'] = sndtolabflag;
    map['paidByCashFlag'] = paidByCashFlag;
    map['sampleTypeId'] = sampleTypeId;
    map['barCode'] = barCode;
    map['inOutHouse'] = inOutHouse;
    map['histopathLab'] = histopathLab;
    map['sampleCount'] = sampleCount;
    map['collectionDate'] = collectionDate;
    map['collectionTime'] = collectionTime;
    map['regRefDocId'] = regRefDocId;
    map['templateWise'] = templateWise;
    map['invName'] = invName;
    map['pay'] = pay;
    map['coPay'] = coPay;
    map['concession'] = concession;
    map['cancle'] = cancle;
    map['isModify'] = isModify;
    map['cghsCode'] = cghsCode;
    map['createdDateTime'] = createdDateTime;
    map['createdDate'] = createdDate;
    map['emrPer'] = emrPer;
    map['sndtorisflag'] = sndtorisflag;
    map['serviceName'] = serviceName;
    map['otFlag'] = otFlag;
    map['template_wise'] = templateWise;
    map['clinical_notes'] = clinicalNotes;
    map['instructions'] = instructions;
    map['count_ot'] = countOt;
    map['investigation_event'] = investigationEvent;
    map['investigation_event_desc'] = investigationEventDesc;
    map['sendtotechflag'] = sendtotechflag;
    map['listBillNobleServiceDto'] = listBillNobleServiceDto;
    map['listSubServiceIpdDto'] = listSubServiceIpdDto;
    map['listSubServiceInventoryDto'] = listSubServiceInventoryDto;
    map['oname'] = oname;
    return map;
  }

}