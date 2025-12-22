class DialysisEventDetaislModel {
  DialysisEventDetaislModel({
      this.unitId, 
      this.patientId, 
      this.treatmentId, 
      this.bedNo, 
      this.machineNo, 
      this.machineName, 
      this.dateOfAdminssion, 
      this.gender, 
      this.nephrologistName, 
      this.relativeName, 
      this.relativeNo, 
      this.unitName, 
      this.patientName, 
      this.weight, 
      this.height, 
      this.heightInch, 
      this.doctorName, 
      this.age, 
      this.bloodGroup, 
      this.viralLocalStatus, 
      this.patientNo, 
      this.regDate, 
      this.primaryNephroName, 
      this.filePath,
      this.fullPath,
      this.bmi,

  });

  DialysisEventDetaislModel.fromJson(dynamic json) {
    unitId = json['unitId'];
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    bedNo = json['bedNo'];
    machineNo = json['machineNo'];
    machineName = json['machineName'];
    dateOfAdminssion = json['dateOfAdminssion'];
    gender = json['gender'];
    nephrologistName = json['nephrologistName'];
    relativeName = json['relativeName'];
    relativeNo = json['relativeNo'];
    unitName = json['unitName'];
    patientName = json['patientName'];
    weight = json['weight'];
    height = json['height'];
    heightInch = json['heightInch'];
    doctorName = json['doctorName'];
    age = json['age'];
    bloodGroup = json['bloodGroup'];
    viralLocalStatus = json['viralLocalStatus'];
    patientNo = json['patientNo'];
    regDate = json['regDate'];
    primaryNephroName = json['primaryNephroName'];
    filePath = json['filePath'];
    fullPath = json['fullPath'];
    bmi = json['bmi'];
  }
  int? unitId;
  int? patientId;
  int? treatmentId;
  String? bedNo;
  String? machineNo;
  String? machineName;
  String? dateOfAdminssion;
  String? gender;
  String? nephrologistName;
  String? relativeName;
  String? relativeNo;
  String? unitName;
  String? patientName;
  double? weight;
  double? height;
  double? heightInch;
  String? doctorName;
  int? age;
  String? bloodGroup;
  String? viralLocalStatus;
  String? patientNo;
  String? regDate;
  String? primaryNephroName;
  String? filePath;
  String? fullPath;
  double? bmi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitId'] = unitId;
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['bedNo'] = bedNo;
    map['machineNo'] = machineNo;
    map['machineName'] = machineName;
    map['dateOfAdminssion'] = dateOfAdminssion;
    map['gender'] = gender;
    map['nephrologistName'] = nephrologistName;
    map['relativeName'] = relativeName;
    map['relativeNo'] = relativeNo;
    map['unitName'] = unitName;
    map['patientName'] = patientName;
    map['weight'] = weight;
    map['height'] = height;
    map['heightInch'] = heightInch;
    map['doctorName'] = doctorName;
    map['age'] = age;
    map['bloodGroup'] = bloodGroup;
    map['viralLocalStatus'] = viralLocalStatus;
    map['patientNo'] = patientNo;
    map['regDate'] = regDate;
    map['primaryNephroName'] = primaryNephroName;
    map['filePath'] = filePath;
    map['fullPath'] = fullPath;
    map['bmi'] = bmi;
    return map;
  }

}