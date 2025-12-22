class MedicineDataById {
  MedicineDataById({
      this.productId, 
      this.productName, 
      this.productShortName, 
      this.companyMaster, 
      this.packingMaster, 
      this.categoryMaster, 
      this.hsnMaster, 
      this.taxMaster, 
      this.batchMaster, 
      this.stockMasters, 
      this.uomMaster, 
      this.preparationMaster, 
      this.strengthMaster, 
      this.hsn, 
      this.sgst, 
      this.cgst, 
      this.igst, 
      this.cess, 
      this.cathlabFlag, 
      this.plist, 
      this.routeName, 
      this.productUnit, 
      this.productAddDate, 
      this.vendorMasters, 
      this.drugMaster, 
      this.shelfMaster, 
      this.productShortList, 
      this.productSaleDisc, 
      this.productBillingMust, 
      this.productH1, 
      this.productNrx, 
      this.productX, 
      this.productNdps, 
      this.productBatch, 
      this.productMinLevel, 
      this.productMaxLevel, 
      this.productDesc, 
      this.productPhotoUrl, 
      this.productMarginRate, 
      this.productFixDiscount, 
      this.productScheme1, 
      this.productScheme1Qty, 
      this.productScheme2, 
      this.productScheme2Qty, 
      this.productScheme3, 
      this.productScheme3Qty, 
      this.productDeleteFlag, 
      this.productUpdateDate, 
      this.productLastMRP, 
      this.productLastPurRate, 
      this.rateEqualsMrp, 
      this.nutracalProduct, 
      this.productCreatedBy, 
      this.productIp, 
      this.productTime, 
      this.productModifyBy, 
      this.productDeletedBy, 
      this.productPrescription, 
      this.lstprod, 
      this.productID, 
      this.productname, 
      this.prescriptionName, 
      this.prescrioptionID, 
      this.strength, 
      this.unit, 
      this.cathlapFlag,});

  MedicineDataById.fromJson(dynamic json) {
    productId = json['productId'];
    productName = json['productName'];
    productShortName = json['productShortName'];
    companyMaster = json['companyMaster'] != null ? CompanyMaster.fromJson(json['companyMaster']) : null;
    packingMaster = json['packingMaster'] != null ? PackingMaster.fromJson(json['packingMaster']) : null;
    categoryMaster = json['categoryMaster'] != null ? CategoryMaster.fromJson(json['categoryMaster']) : null;
    hsnMaster = json['hsnMaster'];
    taxMaster = json['taxMaster'] != null ? TaxMaster.fromJson(json['taxMaster']) : null;

    uomMaster = json['uomMaster'] != null ? UomMaster.fromJson(json['uomMaster']) : null;
    preparationMaster = json['preparationMaster'] != null ? PreparationMaster.fromJson(json['preparationMaster']) : null;
    strengthMaster = json['strengthMaster'] != null ? StrengthMaster.fromJson(json['strengthMaster']) : null;
    hsn = json['hsn'];
    sgst = json['sgst'];
    cgst = json['cgst'];
    igst = json['igst'];
    cess = json['cess'];
    cathlabFlag = json['cathlabFlag'];
    plist = json['plist'];
    routeName = json['routeName'];
    productUnit = json['productUnit'];
    productAddDate = json['productAddDate'];
    drugMaster = json['drugMaster'] != null ? DrugMaster.fromJson(json['drugMaster']) : null;
    shelfMaster = json['shelfMaster'] != null ? ShelfMaster.fromJson(json['shelfMaster']) : null;
    productShortList = json['productShortList'];
    productSaleDisc = json['productSaleDisc'];
    productBillingMust = json['productBillingMust'];
    productH1 = json['productH1'];
    productNrx = json['productNrx'];
    productX = json['productX'];
    productNdps = json['productNdps'];
    productBatch = json['productBatch'];
    productMinLevel = json['productMinLevel'];
    productMaxLevel = json['productMaxLevel'];
    productDesc = json['productDesc'];
    productPhotoUrl = json['productPhotoUrl'];
    productMarginRate = json['productMarginRate'];
    productFixDiscount = json['productFixDiscount'];
    productScheme1 = json['productScheme1'];
    productScheme1Qty = json['productScheme1Qty'];
    productScheme2 = json['productScheme2'];
    productScheme2Qty = json['productScheme2Qty'];
    productScheme3 = json['productScheme3'];
    productScheme3Qty = json['productScheme3Qty'];
    productDeleteFlag = json['productDeleteFlag'];
    productUpdateDate = json['productUpdateDate'];
    productLastMRP = json['productLastMRP'];
    productLastPurRate = json['productLastPurRate'];
    rateEqualsMrp = json['rateEqualsMrp'];
    nutracalProduct = json['nutracalProduct'];
    productCreatedBy = json['productCreatedBy'];
    productIp = json['productIp'];
    productTime = json['productTime'];
    productModifyBy = json['productModifyBy'];
    productDeletedBy = json['productDeletedBy'];
    productPrescription = json['productPrescription'];
    lstprod = json['lstprod'];
    productID = json['productID'];
    productname = json['productname'];
    prescriptionName = json['prescriptionName'];
    prescrioptionID = json['prescrioptionID'];
    strength = json['strength'];
    unit = json['unit'];
    cathlapFlag = json['cathlapFlag'];
  }
  int? productId;
  String? productName;
  String? productShortName;
  CompanyMaster? companyMaster;
  PackingMaster? packingMaster;
  CategoryMaster? categoryMaster;
  dynamic hsnMaster;
  TaxMaster? taxMaster;
  List<dynamic>? batchMaster;
  List<dynamic>? stockMasters;
  UomMaster? uomMaster;
  PreparationMaster? preparationMaster;
  StrengthMaster? strengthMaster;
  String? hsn;
  dynamic sgst;
  dynamic cgst;
  dynamic igst;
  dynamic cess;
  int? cathlabFlag;
  dynamic plist;
  dynamic routeName;
  double? productUnit;
  dynamic productAddDate;
  List<dynamic>? vendorMasters;
  DrugMaster? drugMaster;
  ShelfMaster? shelfMaster;
  int? productShortList;
  int? productSaleDisc;
  int? productBillingMust;
  int? productH1;
  int? productNrx;
  int? productX;
  int? productNdps;
  int? productBatch;
  dynamic productMinLevel;
  dynamic productMaxLevel;
  String? productDesc;
  String? productPhotoUrl;
  double? productMarginRate;
  double? productFixDiscount;
  double? productScheme1;
  double? productScheme1Qty;
  double? productScheme2;
  double? productScheme2Qty;
  double? productScheme3;
  double? productScheme3Qty;
  dynamic productDeleteFlag;
  dynamic productUpdateDate;
  dynamic productLastMRP;
  dynamic productLastPurRate;
  int? rateEqualsMrp;
  int? nutracalProduct;
  dynamic productCreatedBy;
  dynamic productIp;
  dynamic productTime;
  int? productModifyBy;
  int? productDeletedBy;
  int? productPrescription;
  dynamic lstprod;
  dynamic productID;
  dynamic productname;
  dynamic prescriptionName;
  dynamic prescrioptionID;
  dynamic strength;
  dynamic unit;
  int? cathlapFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['productName'] = productName;
    map['productShortName'] = productShortName;
    if (companyMaster != null) {
      map['companyMaster'] = companyMaster?.toJson();
    }
    if (packingMaster != null) {
      map['packingMaster'] = packingMaster?.toJson();
    }
    if (categoryMaster != null) {
      map['categoryMaster'] = categoryMaster?.toJson();
    }
    map['hsnMaster'] = hsnMaster;
    if (taxMaster != null) {
      map['taxMaster'] = taxMaster?.toJson();
    }
    if (batchMaster != null) {
      map['batchMaster'] = batchMaster?.map((v) => v.toJson()).toList();
    }
    if (stockMasters != null) {
      map['stockMasters'] = stockMasters?.map((v) => v.toJson()).toList();
    }
    if (uomMaster != null) {
      map['uomMaster'] = uomMaster?.toJson();
    }
    if (preparationMaster != null) {
      map['preparationMaster'] = preparationMaster?.toJson();
    }
    if (strengthMaster != null) {
      map['strengthMaster'] = strengthMaster?.toJson();
    }
    map['hsn'] = hsn;
    map['sgst'] = sgst;
    map['cgst'] = cgst;
    map['igst'] = igst;
    map['cess'] = cess;
    map['cathlabFlag'] = cathlabFlag;
    map['plist'] = plist;
    map['routeName'] = routeName;
    map['productUnit'] = productUnit;
    map['productAddDate'] = productAddDate;
    if (vendorMasters != null) {
      map['vendorMasters'] = vendorMasters?.map((v) => v.toJson()).toList();
    }
    if (drugMaster != null) {
      map['drugMaster'] = drugMaster?.toJson();
    }
    if (shelfMaster != null) {
      map['shelfMaster'] = shelfMaster?.toJson();
    }
    map['productShortList'] = productShortList;
    map['productSaleDisc'] = productSaleDisc;
    map['productBillingMust'] = productBillingMust;
    map['productH1'] = productH1;
    map['productNrx'] = productNrx;
    map['productX'] = productX;
    map['productNdps'] = productNdps;
    map['productBatch'] = productBatch;
    map['productMinLevel'] = productMinLevel;
    map['productMaxLevel'] = productMaxLevel;
    map['productDesc'] = productDesc;
    map['productPhotoUrl'] = productPhotoUrl;
    map['productMarginRate'] = productMarginRate;
    map['productFixDiscount'] = productFixDiscount;
    map['productScheme1'] = productScheme1;
    map['productScheme1Qty'] = productScheme1Qty;
    map['productScheme2'] = productScheme2;
    map['productScheme2Qty'] = productScheme2Qty;
    map['productScheme3'] = productScheme3;
    map['productScheme3Qty'] = productScheme3Qty;
    map['productDeleteFlag'] = productDeleteFlag;
    map['productUpdateDate'] = productUpdateDate;
    map['productLastMRP'] = productLastMRP;
    map['productLastPurRate'] = productLastPurRate;
    map['rateEqualsMrp'] = rateEqualsMrp;
    map['nutracalProduct'] = nutracalProduct;
    map['productCreatedBy'] = productCreatedBy;
    map['productIp'] = productIp;
    map['productTime'] = productTime;
    map['productModifyBy'] = productModifyBy;
    map['productDeletedBy'] = productDeletedBy;
    map['productPrescription'] = productPrescription;
    map['lstprod'] = lstprod;
    map['productID'] = productID;
    map['productname'] = productname;
    map['prescriptionName'] = prescriptionName;
    map['prescrioptionID'] = prescrioptionID;
    map['strength'] = strength;
    map['unit'] = unit;
    map['cathlapFlag'] = cathlapFlag;
    return map;
  }

}

class ShelfMaster {
  ShelfMaster({
      this.shelfId, 
      this.shelfName, 
      this.shelfDeleteFlag, 
      this.shelfUpdateDate, 
      this.shelfAddDate, 
      this.deletedDate, 
      this.userId, 
      this.unitId, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy,});

  ShelfMaster.fromJson(dynamic json) {
    shelfId = json['shelfId'];
    shelfName = json['shelfName'];
    shelfDeleteFlag = json['shelfDeleteFlag'];
    shelfUpdateDate = json['shelfUpdateDate'];
    shelfAddDate = json['shelfAddDate'];
    deletedDate = json['deletedDate'];
    userId = json['userId'];
    unitId = json['unitId'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
  }
  int? shelfId;
  String? shelfName;
  dynamic shelfDeleteFlag;
  dynamic shelfUpdateDate;
  dynamic shelfAddDate;
  dynamic deletedDate;
  int? userId;
  dynamic unitId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['shelfId'] = shelfId;
    map['shelfName'] = shelfName;
    map['shelfDeleteFlag'] = shelfDeleteFlag;
    map['shelfUpdateDate'] = shelfUpdateDate;
    map['shelfAddDate'] = shelfAddDate;
    map['deletedDate'] = deletedDate;
    map['userId'] = userId;
    map['unitId'] = unitId;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedBy'] = deletedBy;
    return map;
  }

}

class DrugMaster {
  DrugMaster({
      this.drugId, 
      this.drugName, 
      this.drugTheraupticUse, 
      this.drugDisc, 
      this.drugBillingMust, 
      this.drugScheduleH1, 
      this.drugStockHold, 
      this.drugDeleteFlag, 
      this.drugAddDate, 
      this.drugUpdateDate, 
      this.deletedDate, 
      this.userId, 
      this.unitId, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy,});

  DrugMaster.fromJson(dynamic json) {
    drugId = json['drugId'];
    drugName = json['drugName'];
    drugTheraupticUse = json['drugTheraupticUse'];
    drugDisc = json['drugDisc'];
    drugBillingMust = json['drugBillingMust'];
    drugScheduleH1 = json['drugScheduleH1'];
    drugStockHold = json['drugStockHold'];
    drugDeleteFlag = json['drugDeleteFlag'];
    drugAddDate = json['drugAddDate'];
    drugUpdateDate = json['drugUpdateDate'];
    deletedDate = json['deletedDate'];
    userId = json['userId'];
    unitId = json['unitId'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
  }
  int? drugId;
  String? drugName;
  dynamic drugTheraupticUse;
  dynamic drugDisc;
  dynamic drugBillingMust;
  dynamic drugScheduleH1;
  dynamic drugStockHold;
  dynamic drugDeleteFlag;
  dynamic drugAddDate;
  dynamic drugUpdateDate;
  dynamic deletedDate;
  int? userId;
  dynamic unitId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['drugId'] = drugId;
    map['drugName'] = drugName;
    map['drugTheraupticUse'] = drugTheraupticUse;
    map['drugDisc'] = drugDisc;
    map['drugBillingMust'] = drugBillingMust;
    map['drugScheduleH1'] = drugScheduleH1;
    map['drugStockHold'] = drugStockHold;
    map['drugDeleteFlag'] = drugDeleteFlag;
    map['drugAddDate'] = drugAddDate;
    map['drugUpdateDate'] = drugUpdateDate;
    map['deletedDate'] = deletedDate;
    map['userId'] = userId;
    map['unitId'] = unitId;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedBy'] = deletedBy;
    return map;
  }

}

class StrengthMaster {
  StrengthMaster({
      this.strengthId, 
      this.strengthName, 
      this.strengthDeleteFlag, 
      this.strengthUpdateDate, 
      this.strengthAddDate,});

  StrengthMaster.fromJson(dynamic json) {
    strengthId = json['strengthId'];
    strengthName = json['strengthName'];
    strengthDeleteFlag = json['strengthDeleteFlag'];
    strengthUpdateDate = json['strengthUpdateDate'];
    strengthAddDate = json['strengthAddDate'];
  }
  int? strengthId;
  String? strengthName;
  dynamic strengthDeleteFlag;
  dynamic strengthUpdateDate;
  dynamic strengthAddDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strengthId'] = strengthId;
    map['strengthName'] = strengthName;
    map['strengthDeleteFlag'] = strengthDeleteFlag;
    map['strengthUpdateDate'] = strengthUpdateDate;
    map['strengthAddDate'] = strengthAddDate;
    return map;
  }

}

class PreparationMaster {
  PreparationMaster({
      this.preparationId, 
      this.preparationName, 
      this.preparationDeleteFlag, 
      this.preparationUpdateDate, 
      this.preparationAddDate, 
      this.preparationQty, 
      this.listpreparationmaster,});

  PreparationMaster.fromJson(dynamic json) {
    preparationId = json['preparationId'];
    preparationName = json['preparationName'];
    preparationDeleteFlag = json['preparationDeleteFlag'];
    preparationUpdateDate = json['preparationUpdateDate'];
    preparationAddDate = json['preparationAddDate'];
    preparationQty = json['preparationQty'];
    listpreparationmaster = json['listpreparationmaster'];
  }
  int? preparationId;
  String? preparationName;
  dynamic preparationDeleteFlag;
  dynamic preparationUpdateDate;
  dynamic preparationAddDate;
  String? preparationQty;
  dynamic listpreparationmaster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['preparationId'] = preparationId;
    map['preparationName'] = preparationName;
    map['preparationDeleteFlag'] = preparationDeleteFlag;
    map['preparationUpdateDate'] = preparationUpdateDate;
    map['preparationAddDate'] = preparationAddDate;
    map['preparationQty'] = preparationQty;
    map['listpreparationmaster'] = listpreparationmaster;
    return map;
  }

}

class UomMaster {
  UomMaster({
      this.uomId, 
      this.uomName, 
      this.uomDeleteFlag, 
      this.uomUpdateDate, 
      this.uomAddDate, 
      this.deletedDate, 
      this.userId, 
      this.unitId, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy, 
      this.listUomMaster,});

  UomMaster.fromJson(dynamic json) {
    uomId = json['uomId'];
    uomName = json['uomName'];
    uomDeleteFlag = json['uomDeleteFlag'];
    uomUpdateDate = json['uomUpdateDate'];
    uomAddDate = json['uomAddDate'];
    deletedDate = json['deletedDate'];
    userId = json['userId'];
    unitId = json['unitId'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    listUomMaster = json['listUomMaster'];
  }
  int? uomId;
  String? uomName;
  dynamic uomDeleteFlag;
  dynamic uomUpdateDate;
  dynamic uomAddDate;
  dynamic deletedDate;
  int? userId;
  dynamic unitId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic listUomMaster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uomId'] = uomId;
    map['uomName'] = uomName;
    map['uomDeleteFlag'] = uomDeleteFlag;
    map['uomUpdateDate'] = uomUpdateDate;
    map['uomAddDate'] = uomAddDate;
    map['deletedDate'] = deletedDate;
    map['userId'] = userId;
    map['unitId'] = unitId;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedBy'] = deletedBy;
    map['listUomMaster'] = listUomMaster;
    return map;
  }

}

class TaxMaster {
  TaxMaster({
      this.taxId, 
      this.taxName, 
      this.createdBy, 
      this.taxRate, 
      this.type, 
      this.taxDeleteFlag, 
      this.taxUpdateDate, 
      this.taxAddDate, 
      this.deletedDate, 
      this.userId, 
      this.unitId, 
      this.updatedBy, 
      this.deletedBy, 
      this.lsttaxmaster, 
      this.idAsString,});

  TaxMaster.fromJson(dynamic json) {
    taxId = json['taxId'];
    taxName = json['taxName'];
    createdBy = json['createdBy'];
    taxRate = json['taxRate'];
    type = json['type'];
    taxDeleteFlag = json['taxDeleteFlag'];
    taxUpdateDate = json['taxUpdateDate'];
    taxAddDate = json['taxAddDate'];
    deletedDate = json['deletedDate'];
    userId = json['userId'];
    unitId = json['unitId'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    lsttaxmaster = json['lsttaxmaster'];
    idAsString = json['idAsString'];
  }
  int? taxId;
  dynamic taxName;
  dynamic createdBy;
  double? taxRate;
  dynamic type;
  dynamic taxDeleteFlag;
  dynamic taxUpdateDate;
  dynamic taxAddDate;
  dynamic deletedDate;
  int? userId;
  dynamic unitId;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic lsttaxmaster;
  String? idAsString;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['taxId'] = taxId;
    map['taxName'] = taxName;
    map['createdBy'] = createdBy;
    map['taxRate'] = taxRate;
    map['type'] = type;
    map['taxDeleteFlag'] = taxDeleteFlag;
    map['taxUpdateDate'] = taxUpdateDate;
    map['taxAddDate'] = taxAddDate;
    map['deletedDate'] = deletedDate;
    map['userId'] = userId;
    map['unitId'] = unitId;
    map['updatedBy'] = updatedBy;
    map['deletedBy'] = deletedBy;
    map['lsttaxmaster'] = lsttaxmaster;
    map['idAsString'] = idAsString;
    return map;
  }

}

class CategoryMaster {
  CategoryMaster({
      this.catId, 
      this.catName, 
      this.catDeleteFlag, 
      this.categoryAddDate, 
      this.catUpdateDate, 
      this.deletedDate, 
      this.userId, 
      this.unitId, 
      this.createdBy, 
      this.updatedBy, 
      this.deletedBy,});

  CategoryMaster.fromJson(dynamic json) {
    catId = json['catId'];
    catName = json['catName'];
    catDeleteFlag = json['catDeleteFlag'];
    categoryAddDate = json['categoryAddDate'];
    catUpdateDate = json['catUpdateDate'];
    deletedDate = json['deletedDate'];
    userId = json['userId'];
    unitId = json['unitId'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
  }
  int? catId;
  String? catName;
  dynamic catDeleteFlag;
  dynamic categoryAddDate;
  dynamic catUpdateDate;
  dynamic deletedDate;
  int? userId;
  dynamic unitId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['catId'] = catId;
    map['catName'] = catName;
    map['catDeleteFlag'] = catDeleteFlag;
    map['categoryAddDate'] = categoryAddDate;
    map['catUpdateDate'] = catUpdateDate;
    map['deletedDate'] = deletedDate;
    map['userId'] = userId;
    map['unitId'] = unitId;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['deletedBy'] = deletedBy;
    return map;
  }

}

class PackingMaster {
  PackingMaster({
      this.packId, 
      this.packType, 
      this.packDeleteFlag, 
      this.packUpdateDate, 
      this.pakAddDate,});

  PackingMaster.fromJson(dynamic json) {
    packId = json['packId'];
    packType = json['packType'];
    packDeleteFlag = json['packDeleteFlag'];
    packUpdateDate = json['packUpdateDate'];
    pakAddDate = json['pakAddDate'];
  }
  int? packId;
  String? packType;
  dynamic packDeleteFlag;
  dynamic packUpdateDate;
  dynamic pakAddDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['packId'] = packId;
    map['packType'] = packType;
    map['packDeleteFlag'] = packDeleteFlag;
    map['packUpdateDate'] = packUpdateDate;
    map['pakAddDate'] = pakAddDate;
    return map;
  }

}

class CompanyMaster {
  CompanyMaster({
      this.compId, 
      this.compName, 
      this.compShortName, 
      this.compDeleteFlag, 
      this.compAddDate, 
      this.compUpdateDate,});

  CompanyMaster.fromJson(dynamic json) {
    compId = json['compId'];
    compName = json['compName'];
    compShortName = json['compShortName'];
    compDeleteFlag = json['compDeleteFlag'];
    compAddDate = json['compAddDate'];
    compUpdateDate = json['compUpdateDate'];
  }
  int? compId;
  String? compName;
  dynamic compShortName;
  dynamic compDeleteFlag;
  dynamic compAddDate;
  dynamic compUpdateDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['compId'] = compId;
    map['compName'] = compName;
    map['compShortName'] = compShortName;
    map['compDeleteFlag'] = compDeleteFlag;
    map['compAddDate'] = compAddDate;
    map['compUpdateDate'] = compUpdateDate;
    return map;
  }

}