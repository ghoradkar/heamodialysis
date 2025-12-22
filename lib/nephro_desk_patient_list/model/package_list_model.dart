class PackageListModel {
  PackageListModel({
      this.labInvestigationPackageId, 
      this.unitId, 
      this.packageName, 
      this.lookupFreqTest, 
      this.fromdate, 
      this.toDate, 
      this.status, 
      this.createdBy, 
      this.createdDate, 
      this.updatedBy, 
      this.updatedDate, 
      this.subServId, 
      this.frequencyTestDesc, 
      this.labInvestigationPackageDetId, 
      this.testName, 
      this.serivceId,});

  PackageListModel.fromJson(dynamic json) {
    labInvestigationPackageId = json['labInvestigationPackageId'];
    unitId = json['unitId'];
    packageName = json['packageName'];
    lookupFreqTest = json['lookupFreqTest'];
    fromdate = json['fromdate'];
    toDate = json['toDate'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    subServId = json['subServId'];
    frequencyTestDesc = json['frequencyTestDesc'];
    labInvestigationPackageDetId = json['labInvestigationPackageDetId'];
    testName = json['testName'];
    serivceId = json['serivceId'];
  }
  bool isSelected = false;
  int? labInvestigationPackageId;
  dynamic unitId;
  String? packageName;
  dynamic lookupFreqTest;
  String? fromdate;
  String? toDate;
  dynamic status;
  dynamic createdBy;
  dynamic createdDate;
  dynamic updatedBy;
  dynamic updatedDate;
  dynamic subServId;
  String? frequencyTestDesc;
  dynamic labInvestigationPackageDetId;
  dynamic testName;
  dynamic serivceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['labInvestigationPackageId'] = labInvestigationPackageId;
    map['unitId'] = unitId;
    map['packageName'] = packageName;
    map['lookupFreqTest'] = lookupFreqTest;
    map['fromdate'] = fromdate;
    map['toDate'] = toDate;
    map['status'] = status;
    map['createdBy'] = createdBy;
    map['createdDate'] = createdDate;
    map['updatedBy'] = updatedBy;
    map['updatedDate'] = updatedDate;
    map['subServId'] = subServId;
    map['frequencyTestDesc'] = frequencyTestDesc;
    map['labInvestigationPackageDetId'] = labInvestigationPackageDetId;
    map['testName'] = testName;
    map['serivceId'] = serivceId;
    return map;
  }

}