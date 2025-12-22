class ChoosePackageListModel {
  ChoosePackageListModel({
    this.message,
    this.data,
    this.statusCode,
    this.parsedData,
  });

  String? message;
  String? data; // Stringified JSON array
  String? statusCode;
  List<LabInvestigationPackage>? parsedData; // Parsed data as a list

  ChoosePackageListModel.fromJson(dynamic json) {
    message = json['Message'];
    data = json['data'];
    statusCode = json['statusCode'];
    parsedData = []; // Initialized for further parsing
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Message'] = message;
    map['data'] = data;
    map['statusCode'] = statusCode;
    return map;
  }
}

class LabInvestigationPackage {
  LabInvestigationPackage({
    this.labInvestigationPackageId,
    this.packageName,
  });

  int? labInvestigationPackageId;
  String? packageName;
  bool isSelected = false;

  LabInvestigationPackage.fromJson(dynamic json) {
    labInvestigationPackageId = json['labInvestigationPackageId'];
    packageName = json['packageName'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['labInvestigationPackageId'] = labInvestigationPackageId;
    map['packageName'] = packageName;
    return map;
  }
}
