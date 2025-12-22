class DashboardCountModel {
  DashboardCountModel({
    this.patientAdded,
    this.roReport,
    this.totalDialysisDone,
    this.totalDialysis,
    this.totalDischarge,
    this.machineReport,
    this.labs,
    this.treatUnderMjpjay,
    this.treatUnderNonMjpjay,
    this.ticket,
    this.complaints,
    this.feedback,
    this.currentDatePatient,
    this.currentDateAbhaReg,
    this.totalDialysisSession,
    this.currentDateDialysisSession,
    this.totalLbTest,
    this.currentDateLabTest,
    this.totalEvent,
    this.currentDateEvent,
    this.totalMachine,
    this.currentDateFeedback,
    this.currentDateTicket,
    this.completTicket,
    this.mjpjayCount,
    this.nonMjpjayCount,
    this.complaintDashDown,
    this.complaintDenialService,
    this.complaintMonetTakeBytreatment,
    this.complaintMachineDown,
    this.dataCorrectionTicketCount,
    this.newRequirmentTIcketCount,
    this.operatorIssueTicketCount,
    this.softwereServiceTicketCount,
    this.bugTicketCount,
    this.inhancementTicketCount,
    this.hivCount,
    this.negativeCount,
    this.hepatiteCpCount,
    this.hepatiteBpCount,
    this.machineRelatedEventCount,
    this.tuningrelatedEvenetCount,
    this.dialyzerRelatedEventCount,
    this.dialysateRelatedEventCount,
    this.accessRelatedEventCOunt,
    this.functionalCenter,
    this.totalCentre,
    this.pendingTickets,
    this.totalComplaint,
    this.completeComplaint,
    this.pendingComplaint,
    this.totalDialysisCnacel,
    this.currentdialCancel,
    this.machineDown,
    this.machineWorking,
    this.currentDateCompleteTicket,
    this.totalInvoiceAmount,
    this.currentMonthInvAmt,
    this.totalInvoicePayment,
    this.currentMonthInvPymt,
    this.unitName,
    this.total,
    this.generatedInvoiceUnitName,
    this.pendingInvoiceUnitName,
    this.pendingTest,
    this.months,
    this.abhaRegistration,});

  DashboardCountModel.fromJson(dynamic json) {
    patientAdded = json['patientAdded'];
    roReport = json['roReport'];
    totalDialysisDone = json['totalDialysisDone'];
    totalDialysis = json['totalDialysis'];
    totalDischarge = json['totalDischarge'];
    machineReport = json['machineReport'];
    labs = json['labs'];
    treatUnderMjpjay = json['treatUnderMjpjay'];
    treatUnderNonMjpjay = json['treatUnderNonMjpjay'];
    ticket = json['ticket'];
    complaints = json['complaints'];
    feedback = json['feedback'];
    currentDatePatient = json['currentDatePatient'];
    currentDateAbhaReg = json['currentDateAbhaReg'];
    totalDialysisSession = json['totalDialysisSession'];
    currentDateDialysisSession = json['currentDateDialysisSession'];
    totalLbTest = json['totalLbTest'];
    currentDateLabTest = json['currentDateLabTest'];
    totalEvent = json['totalEvent'];
    currentDateEvent = json['currentDateEvent'];
    totalMachine = json['totalMachine'];
    currentDateFeedback = json['currentDateFeedback'];
    currentDateTicket = json['currentDateTicket'];
    completTicket = json['completTicket'];
    mjpjayCount = json['mjpjayCount'];
    nonMjpjayCount = json['nonMjpjayCount'];
    complaintDashDown = json['complaintDashDown'];
    complaintDenialService = json['complaintDenialService'];
    complaintMonetTakeBytreatment = json['complaintMonetTakeBytreatment'];
    complaintMachineDown = json['complaintMachineDown'];
    dataCorrectionTicketCount = json['dataCorrectionTicketCount'];
    newRequirmentTIcketCount = json['newRequirmentTIcketCount'];
    operatorIssueTicketCount = json['operatorIssueTicketCount'];
    softwereServiceTicketCount = json['softwereServiceTicketCount'];
    bugTicketCount = json['bugTicketCount'];
    inhancementTicketCount = json['inhancementTicketCount'];
    hivCount = json['hivCount'];
    negativeCount = json['negativeCount'];
    hepatiteCpCount = json['hepatiteCpCount'];
    hepatiteBpCount = json['hepatiteBpCount'];
    machineRelatedEventCount = json['machineRelatedEventCount'];
    tuningrelatedEvenetCount = json['tuningrelatedEvenetCount'];
    dialyzerRelatedEventCount = json['dialyzerRelatedEventCount'];
    dialysateRelatedEventCount = json['dialysateRelatedEventCount'];
    accessRelatedEventCOunt = json['accessRelatedEventCOunt'];
    functionalCenter = json['functionalCenter'];
    totalCentre = json['totalCentre'];
    pendingTickets = json['pendingTickets'];
    totalComplaint = json['totalComplaint'];
    completeComplaint = json['completeComplaint'];
    pendingComplaint = json['pendingComplaint'];
    totalDialysisCnacel = json['totalDialysisCnacel'];
    currentdialCancel = json['currentdialCancel'];
    machineDown = json['machineDown'];
    machineWorking = json['machineWorking'];
    currentDateCompleteTicket = json['currentDateCompleteTicket'];
    totalInvoiceAmount = json['totalInvoiceAmount'];
    currentMonthInvAmt = json['currentMonthInvAmt'];
    totalInvoicePayment = json['totalInvoicePayment'];
    currentMonthInvPymt = json['currentMonthInvPymt'];
    unitName = json['unitName'];
    total = json['total'];
    generatedInvoiceUnitName = json['generatedInvoiceUnitName'];
    pendingInvoiceUnitName = json['pendingInvoiceUnitName'];
    pendingTest = json['pendingTest'];
    months = json['months'];
    abhaRegistration = json['abhaRegistration'];
  }
  int? patientAdded;
  dynamic roReport;
  dynamic totalDialysisDone;
  dynamic totalDialysis;
  dynamic totalDischarge;
  dynamic machineReport;
  dynamic labs;
  dynamic treatUnderMjpjay;
  dynamic treatUnderNonMjpjay;
  int? ticket;
  dynamic complaints;
  int? feedback;
  int? currentDatePatient;
  int? currentDateAbhaReg;
  int? totalDialysisSession;
  int? currentDateDialysisSession;
  int? totalLbTest;
  int? currentDateLabTest;
  int? totalEvent;
  int? currentDateEvent;
  int? totalMachine;
  int? currentDateFeedback;
  int? currentDateTicket;
  int? completTicket;
  dynamic mjpjayCount;
  dynamic nonMjpjayCount;
  dynamic complaintDashDown;
  dynamic complaintDenialService;
  dynamic complaintMonetTakeBytreatment;
  dynamic complaintMachineDown;
  dynamic dataCorrectionTicketCount;
  dynamic newRequirmentTIcketCount;
  dynamic operatorIssueTicketCount;
  dynamic softwereServiceTicketCount;
  dynamic bugTicketCount;
  dynamic inhancementTicketCount;
  dynamic hivCount;
  dynamic negativeCount;
  dynamic hepatiteCpCount;
  dynamic hepatiteBpCount;
  dynamic machineRelatedEventCount;
  dynamic tuningrelatedEvenetCount;
  dynamic dialyzerRelatedEventCount;
  dynamic dialysateRelatedEventCount;
  dynamic accessRelatedEventCOunt;
  int? functionalCenter;
  int? totalCentre;
  int? pendingTickets;
  int? totalComplaint;
  int? completeComplaint;
  int? pendingComplaint;
  int? totalDialysisCnacel;
  int? currentdialCancel;
  int? machineDown;
  int? machineWorking;
  int? currentDateCompleteTicket;
  dynamic totalInvoiceAmount;
  dynamic currentMonthInvAmt;
  dynamic totalInvoicePayment;
  dynamic currentMonthInvPymt;
  dynamic unitName;
  dynamic total;
  dynamic generatedInvoiceUnitName;
  dynamic pendingInvoiceUnitName;
  dynamic pendingTest;
  dynamic months;
  int? abhaRegistration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientAdded'] = patientAdded;
    map['roReport'] = roReport;
    map['totalDialysisDone'] = totalDialysisDone;
    map['totalDialysis'] = totalDialysis;
    map['totalDischarge'] = totalDischarge;
    map['machineReport'] = machineReport;
    map['labs'] = labs;
    map['treatUnderMjpjay'] = treatUnderMjpjay;
    map['treatUnderNonMjpjay'] = treatUnderNonMjpjay;
    map['ticket'] = ticket;
    map['complaints'] = complaints;
    map['feedback'] = feedback;
    map['currentDatePatient'] = currentDatePatient;
    map['currentDateAbhaReg'] = currentDateAbhaReg;
    map['totalDialysisSession'] = totalDialysisSession;
    map['currentDateDialysisSession'] = currentDateDialysisSession;
    map['totalLbTest'] = totalLbTest;
    map['currentDateLabTest'] = currentDateLabTest;
    map['totalEvent'] = totalEvent;
    map['currentDateEvent'] = currentDateEvent;
    map['totalMachine'] = totalMachine;
    map['currentDateFeedback'] = currentDateFeedback;
    map['currentDateTicket'] = currentDateTicket;
    map['completTicket'] = completTicket;
    map['mjpjayCount'] = mjpjayCount;
    map['nonMjpjayCount'] = nonMjpjayCount;
    map['complaintDashDown'] = complaintDashDown;
    map['complaintDenialService'] = complaintDenialService;
    map['complaintMonetTakeBytreatment'] = complaintMonetTakeBytreatment;
    map['complaintMachineDown'] = complaintMachineDown;
    map['dataCorrectionTicketCount'] = dataCorrectionTicketCount;
    map['newRequirmentTIcketCount'] = newRequirmentTIcketCount;
    map['operatorIssueTicketCount'] = operatorIssueTicketCount;
    map['softwereServiceTicketCount'] = softwereServiceTicketCount;
    map['bugTicketCount'] = bugTicketCount;
    map['inhancementTicketCount'] = inhancementTicketCount;
    map['hivCount'] = hivCount;
    map['negativeCount'] = negativeCount;
    map['hepatiteCpCount'] = hepatiteCpCount;
    map['hepatiteBpCount'] = hepatiteBpCount;
    map['machineRelatedEventCount'] = machineRelatedEventCount;
    map['tuningrelatedEvenetCount'] = tuningrelatedEvenetCount;
    map['dialyzerRelatedEventCount'] = dialyzerRelatedEventCount;
    map['dialysateRelatedEventCount'] = dialysateRelatedEventCount;
    map['accessRelatedEventCOunt'] = accessRelatedEventCOunt;
    map['functionalCenter'] = functionalCenter;
    map['totalCentre'] = totalCentre;
    map['pendingTickets'] = pendingTickets;
    map['totalComplaint'] = totalComplaint;
    map['completeComplaint'] = completeComplaint;
    map['pendingComplaint'] = pendingComplaint;
    map['totalDialysisCnacel'] = totalDialysisCnacel;
    map['currentdialCancel'] = currentdialCancel;
    map['machineDown'] = machineDown;
    map['machineWorking'] = machineWorking;
    map['currentDateCompleteTicket'] = currentDateCompleteTicket;
    map['totalInvoiceAmount'] = totalInvoiceAmount;
    map['currentMonthInvAmt'] = currentMonthInvAmt;
    map['totalInvoicePayment'] = totalInvoicePayment;
    map['currentMonthInvPymt'] = currentMonthInvPymt;
    map['unitName'] = unitName;
    map['total'] = total;
    map['generatedInvoiceUnitName'] = generatedInvoiceUnitName;
    map['pendingInvoiceUnitName'] = pendingInvoiceUnitName;
    map['pendingTest'] = pendingTest;
    map['months'] = months;
    map['abhaRegistration'] = abhaRegistration;
    return map;
  }

}