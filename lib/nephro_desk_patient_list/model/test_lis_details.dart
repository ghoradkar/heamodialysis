class TestListDetails {
  TestListDetails({
      this.masterconfigid, 
      this.unitid, 
      this.deptId, 
      this.categoryid, 
      this.categoryName, 
      this.isCategory, 
      this.categorycharges, 
      this.categorydeleted, 
      this.serviceid, 
      this.serviceName, 
      this.servicdeleted, 
      this.iscombination, 
      this.isModify, 
      this.codeName, 
      this.lstService, 
      this.configCharges, 
      this.stockqty, 
      this.batchid, 
      this.stockid, 
      this.unitPrice, 
      this.currentSubInventoryStockUpdated, 
      this.availableQty, 
      this.batchCode, 
      this.batchExp, 
      this.templateWise,});

  TestListDetails.fromJson(dynamic json) {
    masterconfigid = json['masterconfigid'];
    unitid = json['unitid'];
    deptId = json['dept_id'];
    categoryid = json['categoryid'];
    categoryName = json['categoryName'];
    isCategory = json['isCategory'];
    categorycharges = json['categorycharges'];
    categorydeleted = json['categorydeleted'];
    serviceid = json['serviceid'];
    serviceName = json['serviceName'];
    servicdeleted = json['servicdeleted'];
    iscombination = json['iscombination'];
    isModify = json['isModify'];
    codeName = json['codeName'];
    if (json['lstService'] != null) {
      lstService = [];
      json['lstService'].forEach((v) {
        lstService?.add(LstService.fromJson(v));
      });
    }
    configCharges = json['configCharges'];
    stockqty = json['stockqty'];
    batchid = json['batchid'];
    stockid = json['stockid'];
    unitPrice = json['unitPrice'];
    currentSubInventoryStockUpdated = json['currentSubInventoryStockUpdated'];
    availableQty = json['availableQty'];
    batchCode = json['batchCode'];
    batchExp = json['batchExp'];
    templateWise = json['templateWise'];
  }
  int? masterconfigid;
  int? unitid;
  int? deptId;
  int? categoryid;
  dynamic categoryName;
  dynamic isCategory;
  dynamic categorycharges;
  dynamic categorydeleted;
  int? serviceid;
  dynamic serviceName;
  dynamic servicdeleted;
  dynamic iscombination;
  dynamic isModify;
  dynamic codeName;
  List<LstService>? lstService;
  double? configCharges;
  dynamic stockqty;
  int? batchid;
  int? stockid;
  dynamic unitPrice;
  dynamic currentSubInventoryStockUpdated;
  dynamic availableQty;
  dynamic batchCode;
  dynamic batchExp;
  dynamic templateWise;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['masterconfigid'] = masterconfigid;
    map['unitid'] = unitid;
    map['dept_id'] = deptId;
    map['categoryid'] = categoryid;
    map['categoryName'] = categoryName;
    map['isCategory'] = isCategory;
    map['categorycharges'] = categorycharges;
    map['categorydeleted'] = categorydeleted;
    map['serviceid'] = serviceid;
    map['serviceName'] = serviceName;
    map['servicdeleted'] = servicdeleted;
    map['iscombination'] = iscombination;
    map['isModify'] = isModify;
    map['codeName'] = codeName;
    if (lstService != null) {
      map['lstService'] = lstService?.map((v) => v.toJson()).toList();
    }
    map['configCharges'] = configCharges;
    map['stockqty'] = stockqty;
    map['batchid'] = batchid;
    map['stockid'] = stockid;
    map['unitPrice'] = unitPrice;
    map['currentSubInventoryStockUpdated'] = currentSubInventoryStockUpdated;
    map['availableQty'] = availableQty;
    map['batchCode'] = batchCode;
    map['batchExp'] = batchExp;
    map['templateWise'] = templateWise;
    return map;
  }

}

class LstService {
  LstService({
      this.masterconfigid, 
      this.unitid, 
      this.deptId, 
      this.categoryid, 
      this.categoryName, 
      this.isCategory, 
      this.categorycharges, 
      this.categorydeleted, 
      this.serviceid, 
      this.serviceName, 
      this.servicdeleted, 
      this.iscombination, 
      this.isModify, 
      this.codeName, 
      this.lstService, 
      this.configCharges, 
      this.stockqty, 
      this.batchid, 
      this.stockid, 
      this.unitPrice, 
      this.currentSubInventoryStockUpdated, 
      this.availableQty, 
      this.batchCode, 
      this.batchExp, 
      this.templateWise,});

  LstService.fromJson(dynamic json) {
    masterconfigid = json['masterconfigid'];
    unitid = json['unitid'];
    deptId = json['dept_id'];
    categoryid = json['categoryid'];
    categoryName = json['categoryName'];
    isCategory = json['isCategory'];
    categorycharges = json['categorycharges'];
    categorydeleted = json['categorydeleted'];
    serviceid = json['serviceid'];
    serviceName = json['serviceName'];
    servicdeleted = json['servicdeleted'];
    iscombination = json['iscombination'];
    isModify = json['isModify'];
    codeName = json['codeName'];
    lstService = json['lstService'];
    configCharges = json['configCharges'];
    stockqty = json['stockqty'];
    batchid = json['batchid'];
    stockid = json['stockid'];
    unitPrice = json['unitPrice'];
    currentSubInventoryStockUpdated = json['currentSubInventoryStockUpdated'];
    availableQty = json['availableQty'];
    batchCode = json['batchCode'];
    batchExp = json['batchExp'];
    templateWise = json['templateWise'];
  }
  int? masterconfigid;
  int? unitid;
  int? deptId;
  int? categoryid;
  String? categoryName;
  String? isCategory;
  double? categorycharges;
  String? categorydeleted;
  int? serviceid;
  String? serviceName;
  String? servicdeleted;
  String? iscombination;
  String? isModify;
  String? codeName;
  dynamic lstService;
  double? configCharges;
  dynamic stockqty;
  int? batchid;
  int? stockid;
  dynamic unitPrice;
  dynamic currentSubInventoryStockUpdated;
  dynamic availableQty;
  dynamic batchCode;
  dynamic batchExp;
  String? templateWise;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['masterconfigid'] = masterconfigid;
    map['unitid'] = unitid;
    map['dept_id'] = deptId;
    map['categoryid'] = categoryid;
    map['categoryName'] = categoryName;
    map['isCategory'] = isCategory;
    map['categorycharges'] = categorycharges;
    map['categorydeleted'] = categorydeleted;
    map['serviceid'] = serviceid;
    map['serviceName'] = serviceName;
    map['servicdeleted'] = servicdeleted;
    map['iscombination'] = iscombination;
    map['isModify'] = isModify;
    map['codeName'] = codeName;
    map['lstService'] = lstService;
    map['configCharges'] = configCharges;
    map['stockqty'] = stockqty;
    map['batchid'] = batchid;
    map['stockid'] = stockid;
    map['unitPrice'] = unitPrice;
    map['currentSubInventoryStockUpdated'] = currentSubInventoryStockUpdated;
    map['availableQty'] = availableQty;
    map['batchCode'] = batchCode;
    map['batchExp'] = batchExp;
    map['templateWise'] = templateWise;
    return map;
  }

}