class SendForApprovalReq {
  SendForApprovalReq({
      this.invoiceStateId, 
      this.serviceCode, 
      this.billStatus, 
      this.levelValue, 
      this.unitId, 
      this.userIdd, 
      this.ttInvoiceStatewiseBean,});

  SendForApprovalReq.fromJson(dynamic json) {
    invoiceStateId = json['invoiceStateId'];
    serviceCode = json['serviceCode'];
    billStatus = json['billStatus'];
    levelValue = json['levelValue'];
    unitId = json['unitId'];
    userIdd = json['userIdd'];
    if (json['ttInvoiceStatewiseBean'] != null) {
      ttInvoiceStatewiseBean = [];
      json['ttInvoiceStatewiseBean'].forEach((v) {
        ttInvoiceStatewiseBean?.add(TtInvoiceStatewiseBean.fromJson(v));
      });
    }
  }
  int? invoiceStateId;
  String? serviceCode;
  String? billStatus;
  String? levelValue;
  int? unitId;
  int? userIdd;
  List<TtInvoiceStatewiseBean>? ttInvoiceStatewiseBean;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoiceStateId'] = invoiceStateId;
    map['serviceCode'] = serviceCode;
    map['billStatus'] = billStatus;
    map['levelValue'] = levelValue;
    map['unitId'] = unitId;
    map['userIdd'] = userIdd;
    if (ttInvoiceStatewiseBean != null) {
      map['ttInvoiceStatewiseBean'] = ttInvoiceStatewiseBean?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TtInvoiceStatewiseBean {
  TtInvoiceStatewiseBean({
      this.invoiceStateId, 
      this.serviceCode, 
      this.billStatus, 
      this.levelValue,});

  TtInvoiceStatewiseBean.fromJson(dynamic json) {
    invoiceStateId = json['invoiceStateId'];
    serviceCode = json['serviceCode'];
    billStatus = json['billStatus'];
    levelValue = json['levelValue'];
  }
  int? invoiceStateId;
  String? serviceCode;
  String? billStatus;
  String? levelValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['invoiceStateId'] = invoiceStateId;
    map['serviceCode'] = serviceCode;
    map['billStatus'] = billStatus;
    map['levelValue'] = levelValue;
    return map;
  }

}