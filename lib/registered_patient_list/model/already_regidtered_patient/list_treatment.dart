

import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/list_bill.dart';

class ListTreatment {
  ListTreatment({
      this.treatmentId, 
      this.patientId, 
      this.departmentId, 
      this.doctorIdList, 
      this.centerPatientId, 
      this.token, 
      this.tFlag, 
      this.unitId, 
      this.deleted, 
      this.refDocId, 
      this.refDocName, 
      this.caseType, 
      this.weight, 
      this.height, 
      this.mheight, 
      this.fheight, 
      this.notes, 
      this.empid, 
      this.count, 
      this.trcount, 
      this.opdipdno, 
      this.tpaid, 
      this.cancelNarration, 
      this.admCancelFlag, 
      this.ivfPayFlag, 
      this.narration, 
      this.ivfTreatID, 
      this.tokenno, 
      this.reqGenFormId, 
      this.referredBy, 
      this.referredSource, 
      this.referredSourceSlave, 
      this.referredSourceDocId, 
      this.refDate, 
      this.sponsorId, 
      this.sactionOrdNo, 
      this.sanctionAmt, 
      this.neisNo, 
      this.visitNo, 
      this.ipdOrOpd, 
      this.treatPermited, 
      this.diseToBeTreat, 
      this.validUpToDate, 
      this.admissionCanDateTime, 
      this.admissionCanceledBy, 
      this.admissionDateTime, 
      this.reasonofvisit, 
      this.ivfTreatFlag, 
      this.patientName, 
      this.mobile, 
      this.userName, 
      this.cancelDate, 
      this.cancelTime, 
      this.phyDateTime, 
      this.phyDisFlag, 
      this.outtime, 
      this.casualityFlag, 
      this.organDonarFlag, 
      this.specialityId, 
      this.emrHighrisk, 
      this.createdBy, 
      this.createdDateTime, 
      this.updatedBy, 
      this.updatedDateTime, 
      this.deletedBy, 
      this.deletedDateTime, 
      this.emergencyFlag, 
      this.businessType, 
      this.customerType, 
      this.customerId, 
      this.collectionDate, 
      this.collectionTime, 
      this.registeredAt, 
      this.appointmentId, 
      this.mjpjaycaseNumber, 
      this.mjpjayclaimNumber, 
      this.mjpjayIPNumber, 
      this.preAuthapdate, 
      this.filePath, 
      this.listTreatment, 
      this.listBill, 
      this.invoiceCount,
      this.lookupDetIdSchemeAdopt, 
      this.pathologyMachineMasterId, 
      this.lookupDetIdStage, 
      this.dischargeDate, 
      this.mjpjayenrollmentNo, 
      this.treatendDate, 
      this.bmi, 
      this.bsa, 
      this.hcim, 
      this.targetheight,});

  ListTreatment.fromJson(dynamic json) {
    treatmentId = json['treatmentId'];
    patientId = json['patientId'];
    departmentId = json['departmentId'];
    doctorIdList = json['doctorIdList'];
    centerPatientId = json['centerPatientId'];
    token = json['token'];
    tFlag = json['tFlag'];
    unitId = json['unitId'];
    deleted = json['deleted'];
    refDocId = json['refDocId'];
    refDocName = json['refDocName'];
    caseType = json['caseType'];
    weight = json['weight'];
    height = json['height'];
    mheight = json['mheight'];
    fheight = json['fheight'];
    notes = json['notes'];
    empid = json['empid'];
    count = json['count'];
    trcount = json['trcount'];
    opdipdno = json['opdipdno'];
    tpaid = json['tpaid'];
    cancelNarration = json['cancelNarration'];
    admCancelFlag = json['admCancelFlag'];
    ivfPayFlag = json['ivfPayFlag'];
    narration = json['narration'];
    ivfTreatID = json['ivfTreatID'];
    tokenno = json['tokenno'];
    reqGenFormId = json['reqGenFormId'];
    referredBy = json['referredBy'];
    referredSource = json['referredSource'];
    referredSourceSlave = json['referredSourceSlave'];
    referredSourceDocId = json['referredSourceDocId'];
    refDate = json['refDate'];
    sponsorId = json['sponsorId'];
    sactionOrdNo = json['sactionOrdNo'];
    sanctionAmt = json['sanctionAmt'];
    neisNo = json['neisNo'];
    visitNo = json['visitNo'];
    ipdOrOpd = json['ipdOrOpd'];
    treatPermited = json['treatPermited'];
    diseToBeTreat = json['diseToBeTreat'];
    validUpToDate = json['validUpToDate'];
    admissionCanDateTime = json['admissionCanDateTime'];
    admissionCanceledBy = json['admissionCanceledBy'];
    admissionDateTime = json['admissionDateTime'];
    reasonofvisit = json['reasonofvisit'];
    ivfTreatFlag = json['ivfTreatFlag'];
    patientName = json['patientName'];
    mobile = json['mobile'];
    userName = json['userName'];
    cancelDate = json['cancelDate'];
    cancelTime = json['cancelTime'];
    phyDateTime = json['phyDateTime'];
    phyDisFlag = json['phyDisFlag'];
    outtime = json['outtime'];
    casualityFlag = json['casualityFlag'];
    organDonarFlag = json['organDonarFlag'];
    specialityId = json['specialityId'];
    emrHighrisk = json['emrHighrisk'];
    createdBy = json['createdBy'];
    createdDateTime = json['createdDateTime'];
    updatedBy = json['updatedBy'];
    updatedDateTime = json['updatedDateTime'];
    deletedBy = json['deletedBy'];
    deletedDateTime = json['deletedDateTime'];
    emergencyFlag = json['emergencyFlag'];
    businessType = json['businessType'];
    customerType = json['customerType'];
    customerId = json['customerId'];
    collectionDate = json['collectionDate'];
    collectionTime = json['collectionTime'];
    registeredAt = json['registeredAt'];
    appointmentId = json['appointmentId'];
    mjpjaycaseNumber = json['mjpjaycaseNumber'];
    mjpjayclaimNumber = json['mjpjayclaimNumber'];
    mjpjayIPNumber = json['mjpjayIPNumber'];
    preAuthapdate = json['preAuthapdate'];
    filePath = json['filePath'];
    listTreatment = json['listTreatment'];
    if (json['listBill'] != null) {
      listBill = [];
      json['listBill'].forEach((v) {
        listBill?.add(ListBill.fromJson(v));
      });
    }
    invoiceCount = json['invoiceCount'];
    lookupDetIdSchemeAdopt = json['lookupDetIdSchemeAdopt'];
    pathologyMachineMasterId = json['pathologyMachineMasterId'];
    lookupDetIdStage = json['lookupDetIdStage'];
    dischargeDate = json['dischargeDate'];
    mjpjayenrollmentNo = json['mjpjayenrollmentNo'];
    treatendDate = json['treatendDate'];
    bmi = json['BMI'];
    bsa = json['BSA'];
    hcim = json['HCIM'];
    targetheight = json['TARGET_HEIGHT'];
  }
  int? treatmentId;
  int? patientId;
  int? departmentId;
  dynamic doctorIdList;
  String? centerPatientId;
  int? token;
  String? tFlag;
  int? unitId;
  String? deleted;
  int? refDocId;
  String? refDocName;
  int? caseType;
  double? weight;
  double? height;
  double? mheight;
  double? fheight;
  String? notes;
  String? empid;
  int? count;
  String? trcount;
  String? opdipdno;
  String? tpaid;
  String? cancelNarration;
  String? admCancelFlag;
  String? ivfPayFlag;
  dynamic narration;
  dynamic ivfTreatID;
  String? tokenno;
  int? reqGenFormId;
  String? referredBy;
  int? referredSource;
  String? referredSourceSlave;
  int? referredSourceDocId;
  dynamic refDate;
  int? sponsorId;
  String? sactionOrdNo;
  double? sanctionAmt;
  String? neisNo;
  String? visitNo;
  String? ipdOrOpd;
  String? treatPermited;
  String? diseToBeTreat;
  dynamic validUpToDate;
  dynamic admissionCanDateTime;
  dynamic admissionCanceledBy;
  String? admissionDateTime;
  int? reasonofvisit;
  String? ivfTreatFlag;
  String? patientName;
  String? mobile;
  String? userName;
  dynamic cancelDate;
  dynamic cancelTime;
  dynamic phyDateTime;
  String? phyDisFlag;
  dynamic outtime;
  String? casualityFlag;
  String? organDonarFlag;
  String? specialityId;
  int? emrHighrisk;
  int? createdBy;
  int? createdDateTime;
  dynamic updatedBy;
  dynamic updatedDateTime;
  dynamic deletedBy;
  dynamic deletedDateTime;
  String? emergencyFlag;
  int? businessType;
  int? customerType;
  int? customerId;
  String? collectionDate;
  String? collectionTime;
  String? registeredAt;
  int? appointmentId;
  dynamic mjpjaycaseNumber;
  dynamic mjpjayclaimNumber;
  dynamic mjpjayIPNumber;
  dynamic preAuthapdate;
  dynamic filePath;
  dynamic listTreatment;
  List<ListBill>? listBill;
  dynamic invoiceCount;
  dynamic lookupDetIdSchemeAdopt;
  dynamic pathologyMachineMasterId;
  dynamic lookupDetIdStage;
  dynamic dischargeDate;
  dynamic mjpjayenrollmentNo;
  dynamic treatendDate;
  double? bmi;
  double? bsa;
  double? hcim;
  double? targetheight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['treatmentId'] = treatmentId;
    map['patientId'] = patientId;
    map['departmentId'] = departmentId;
    map['doctorIdList'] = doctorIdList;
    map['centerPatientId'] = centerPatientId;
    map['token'] = token;
    map['tFlag'] = tFlag;
    map['unitId'] = unitId;
    map['deleted'] = deleted;
    map['refDocId'] = refDocId;
    map['refDocName'] = refDocName;
    map['caseType'] = caseType;
    map['weight'] = weight;
    map['height'] = height;
    map['mheight'] = mheight;
    map['fheight'] = fheight;
    map['notes'] = notes;
    map['empid'] = empid;
    map['count'] = count;
    map['trcount'] = trcount;
    map['opdipdno'] = opdipdno;
    map['tpaid'] = tpaid;
    map['cancelNarration'] = cancelNarration;
    map['admCancelFlag'] = admCancelFlag;
    map['ivfPayFlag'] = ivfPayFlag;
    map['narration'] = narration;
    map['ivfTreatID'] = ivfTreatID;
    map['tokenno'] = tokenno;
    map['reqGenFormId'] = reqGenFormId;
    map['referredBy'] = referredBy;
    map['referredSource'] = referredSource;
    map['referredSourceSlave'] = referredSourceSlave;
    map['referredSourceDocId'] = referredSourceDocId;
    map['refDate'] = refDate;
    map['sponsorId'] = sponsorId;
    map['sactionOrdNo'] = sactionOrdNo;
    map['sanctionAmt'] = sanctionAmt;
    map['neisNo'] = neisNo;
    map['visitNo'] = visitNo;
    map['ipdOrOpd'] = ipdOrOpd;
    map['treatPermited'] = treatPermited;
    map['diseToBeTreat'] = diseToBeTreat;
    map['validUpToDate'] = validUpToDate;
    map['admissionCanDateTime'] = admissionCanDateTime;
    map['admissionCanceledBy'] = admissionCanceledBy;
    map['admissionDateTime'] = admissionDateTime;
    map['reasonofvisit'] = reasonofvisit;
    map['ivfTreatFlag'] = ivfTreatFlag;
    map['patientName'] = patientName;
    map['mobile'] = mobile;
    map['userName'] = userName;
    map['cancelDate'] = cancelDate;
    map['cancelTime'] = cancelTime;
    map['phyDateTime'] = phyDateTime;
    map['phyDisFlag'] = phyDisFlag;
    map['outtime'] = outtime;
    map['casualityFlag'] = casualityFlag;
    map['organDonarFlag'] = organDonarFlag;
    map['specialityId'] = specialityId;
    map['emrHighrisk'] = emrHighrisk;
    map['createdBy'] = createdBy;
    map['createdDateTime'] = createdDateTime;
    map['updatedBy'] = updatedBy;
    map['updatedDateTime'] = updatedDateTime;
    map['deletedBy'] = deletedBy;
    map['deletedDateTime'] = deletedDateTime;
    map['emergencyFlag'] = emergencyFlag;
    map['businessType'] = businessType;
    map['customerType'] = customerType;
    map['customerId'] = customerId;
    map['collectionDate'] = collectionDate;
    map['collectionTime'] = collectionTime;
    map['registeredAt'] = registeredAt;
    map['appointmentId'] = appointmentId;
    map['mjpjaycaseNumber'] = mjpjaycaseNumber;
    map['mjpjayclaimNumber'] = mjpjayclaimNumber;
    map['mjpjayIPNumber'] = mjpjayIPNumber;
    map['preAuthapdate'] = preAuthapdate;
    map['filePath'] = filePath;
    map['listTreatment'] = listTreatment;
    if (listBill != null) {
      map['listBill'] = listBill?.map((v) => v.toJson()).toList();
    }
    map['invoiceCount'] = invoiceCount;
    map['lookupDetIdSchemeAdopt'] = lookupDetIdSchemeAdopt;
    map['pathologyMachineMasterId'] = pathologyMachineMasterId;
    map['lookupDetIdStage'] = lookupDetIdStage;
    map['dischargeDate'] = dischargeDate;
    map['mjpjayenrollmentNo'] = mjpjayenrollmentNo;
    map['treatendDate'] = treatendDate;
    map['BMI'] = bmi;
    map['BSA'] = bsa;
    map['HCIM'] = hcim;
    map['TARGET_HEIGHT'] = targetheight;
    return map;
  }

}