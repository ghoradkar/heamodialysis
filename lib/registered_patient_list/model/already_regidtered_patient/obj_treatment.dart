class ObjTreatment {
  ObjTreatment({
      this.claimTime, 
      this.treatmentID, 
      this.manageFlag, 
      this.patientID, 
      this.tDate, 
      this.tFlag, 
      this.weight, 
      this.referedBy, 
      this.referedTo, 
      this.symptoms, 
      this.tstartDate, 
      this.tendDate, 
      this.litreatment, 
      this.intime, 
      this.outtime, 
      this.opd, 
      this.echo, 
      this.note, 
      this.tmt, 
      this.opdDate, 
      this.oprDate, 
      this.sdiscount, 
      this.noOfVisit, 
      this.specialDiscount, 
      this.empId, 
      this.bedridden, 
      this.seropositive, 
      this.department, 
      this.selReferredBy, 
      this.txtReferredBy, 
      this.otherRefDoc, 
      this.txtReferredByNM, 
      this.treatmentCount, 
      this.idreadiology, 
      this.createdDate, 
      this.typeOfPayment, 
      this.paymentPerName, 
      this.relAge, 
      this.relSex, 
      this.relRelation, 
      this.relAddress, 
      this.relMobile, 
      this.selCompany, 
      this.insuranceCmpny, 
      this.memoNo, 
      this.popupContainer4, 
      this.cashlessPolicyNo, 
      this.cnnnNo, 
      this.convertToIpd, 
      this.ipdAdmissionDate, 
      this.billCategory, 
      this.billCategoryName, 
      this.billCategoryDiscount, 
      this.erFlag, 
      this.docterId, 
      this.hospitalId, 
      this.companyname, 
      this.companyid, 
      this.refundReceiptList, 
      this.reasonOfVisitId, 
      this.chkRefDoc,});

  ObjTreatment.fromJson(dynamic json) {
    claimTime = json['claim_time'];
    treatmentID = json['treatment_ID'];
    manageFlag = json['manage_flag'];
    patientID = json['patient_ID'];
    tDate = json['tDate'];
    tFlag = json['tFlag'];
    weight = json['weight'];
    referedBy = json['referedBy'];
    referedTo = json['referedTo'];
    symptoms = json['symptoms'];
    tstartDate = json['tstartDate'];
    tendDate = json['tendDate'];
    litreatment = json['litreatment'];
    intime = json['intime'];
    outtime = json['outtime'];
    opd = json['opd'];
    echo = json['echo'];
    note = json['note'];
    tmt = json['tmt'];
    opdDate = json['opd_date'];
    oprDate = json['oprDate'];
    sdiscount = json['sdiscount'];
    noOfVisit = json['noOfVisit'];
    specialDiscount = json['specialDiscount'];
    empId = json['empId'];
    bedridden = json['bedridden'];
    seropositive = json['seropositive'];
    department = json['department'];
    selReferredBy = json['selReferredBy'];
    txtReferredBy = json['txtReferredBy'];
    otherRefDoc = json['otherRefDoc'];
    txtReferredByNM = json['txtReferredByNM'];
    treatmentCount = json['treatmentCount'];
    idreadiology = json['idreadiology'];
    createdDate = json['createdDate'];
    typeOfPayment = json['typeOfPayment'];
    paymentPerName = json['paymentPerName'];
    relAge = json['relAge'];
    relSex = json['relSex'];
    relRelation = json['relRelation'];
    relAddress = json['relAddress'];
    relMobile = json['relMobile'];
    selCompany = json['selCompany'];
    insuranceCmpny = json['insuranceCmpny'];
    memoNo = json['memoNo'];
    popupContainer4 = json['popup_container4'];
    cashlessPolicyNo = json['cashlessPolicyNo'];
    cnnnNo = json['cnnnNo'];
    convertToIpd = json['convertToIpd'];
    ipdAdmissionDate = json['ipdAdmissionDate'];
    billCategory = json['billCategory'];
    billCategoryName = json['billCategory_Name'];
    billCategoryDiscount = json['billCategory_Discount'];
    erFlag = json['erFlag'];
    docterId = json['docter_id'];
    hospitalId = json['hospital_id'];
    companyname = json['companyname'];
    companyid = json['companyid'];
    refundReceiptList = json['refundReceiptList'];
    reasonOfVisitId = json['reasonOfVisit_id'];
    chkRefDoc = json['chkRefDoc'];
  }
  dynamic claimTime;
  int? treatmentID;
  dynamic manageFlag;
  int? patientID;
  dynamic tDate;
  dynamic tFlag;
  dynamic weight;
  dynamic referedBy;
  dynamic referedTo;
  dynamic symptoms;
  dynamic tstartDate;
  dynamic tendDate;
  dynamic litreatment;
  dynamic intime;
  dynamic outtime;
  dynamic opd;
  dynamic echo;
  dynamic note;
  dynamic tmt;
  dynamic opdDate;
  dynamic oprDate;
  dynamic sdiscount;
  int? noOfVisit;
  int? specialDiscount;
  dynamic empId;
  dynamic bedridden;
  dynamic seropositive;
  dynamic department;
  dynamic selReferredBy;
  dynamic txtReferredBy;
  dynamic otherRefDoc;
  dynamic txtReferredByNM;
  dynamic treatmentCount;
  int? idreadiology;
  dynamic createdDate;
  dynamic typeOfPayment;
  dynamic paymentPerName;
  dynamic relAge;
  dynamic relSex;
  dynamic relRelation;
  dynamic relAddress;
  dynamic relMobile;
  dynamic selCompany;
  dynamic insuranceCmpny;
  dynamic memoNo;
  dynamic popupContainer4;
  dynamic cashlessPolicyNo;
  dynamic cnnnNo;
  dynamic convertToIpd;
  dynamic ipdAdmissionDate;
  dynamic billCategory;
  dynamic billCategoryName;
  double? billCategoryDiscount;
  dynamic erFlag;
  int? docterId;
  int? hospitalId;
  dynamic companyname;
  int? companyid;
  dynamic refundReceiptList;
  int? reasonOfVisitId;
  bool? chkRefDoc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['claim_time'] = claimTime;
    map['treatment_ID'] = treatmentID;
    map['manage_flag'] = manageFlag;
    map['patient_ID'] = patientID;
    map['tDate'] = tDate;
    map['tFlag'] = tFlag;
    map['weight'] = weight;
    map['referedBy'] = referedBy;
    map['referedTo'] = referedTo;
    map['symptoms'] = symptoms;
    map['tstartDate'] = tstartDate;
    map['tendDate'] = tendDate;
    map['litreatment'] = litreatment;
    map['intime'] = intime;
    map['outtime'] = outtime;
    map['opd'] = opd;
    map['echo'] = echo;
    map['note'] = note;
    map['tmt'] = tmt;
    map['opd_date'] = opdDate;
    map['oprDate'] = oprDate;
    map['sdiscount'] = sdiscount;
    map['noOfVisit'] = noOfVisit;
    map['specialDiscount'] = specialDiscount;
    map['empId'] = empId;
    map['bedridden'] = bedridden;
    map['seropositive'] = seropositive;
    map['department'] = department;
    map['selReferredBy'] = selReferredBy;
    map['txtReferredBy'] = txtReferredBy;
    map['otherRefDoc'] = otherRefDoc;
    map['txtReferredByNM'] = txtReferredByNM;
    map['treatmentCount'] = treatmentCount;
    map['idreadiology'] = idreadiology;
    map['createdDate'] = createdDate;
    map['typeOfPayment'] = typeOfPayment;
    map['paymentPerName'] = paymentPerName;
    map['relAge'] = relAge;
    map['relSex'] = relSex;
    map['relRelation'] = relRelation;
    map['relAddress'] = relAddress;
    map['relMobile'] = relMobile;
    map['selCompany'] = selCompany;
    map['insuranceCmpny'] = insuranceCmpny;
    map['memoNo'] = memoNo;
    map['popup_container4'] = popupContainer4;
    map['cashlessPolicyNo'] = cashlessPolicyNo;
    map['cnnnNo'] = cnnnNo;
    map['convertToIpd'] = convertToIpd;
    map['ipdAdmissionDate'] = ipdAdmissionDate;
    map['billCategory'] = billCategory;
    map['billCategory_Name'] = billCategoryName;
    map['billCategory_Discount'] = billCategoryDiscount;
    map['erFlag'] = erFlag;
    map['docter_id'] = docterId;
    map['hospital_id'] = hospitalId;
    map['companyname'] = companyname;
    map['companyid'] = companyid;
    map['refundReceiptList'] = refundReceiptList;
    map['reasonOfVisit_id'] = reasonOfVisitId;
    map['chkRefDoc'] = chkRefDoc;
    return map;
  }

}