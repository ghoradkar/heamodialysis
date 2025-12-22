class DashInfoData {
  final int? patientId;
  final String? fName;
  final String? lName;
  final String? mobileNo;
  final String? abhNo;
  final int? schemeId;
  final String? unitName;
  final int? unitId;
  final int? dischargeCount;
  final int? abhaRegCount;
  final String? districtName;
  final int? machineCount;
  final String? commertialDate;
  final int? totalPatRegister;
  final int? totalsession;
  final int? totalEvent;
  final int? patientAdded;

  DashInfoData( {
     this.patientId,
     this.fName,
     this.lName,
     this.mobileNo,
     this.abhNo,
    this.schemeId,
    this.unitName,
    this.unitId,
    this.dischargeCount,
    this.abhaRegCount,
    this.districtName,
    this.machineCount,
    this.commertialDate,
    this.totalPatRegister,
    this.totalsession,
    this.totalEvent,
    this.patientAdded
  });

  // Factory method to create Patient instance from JSON
  factory DashInfoData.fromJson(Map<String, dynamic> json) {
    return DashInfoData(
      patientId: json['patientId'],
      fName: json['fName'],
      lName: json['lName'],
      mobileNo: json['mobileNo'],
      abhNo: json['abhNo'],
      schemeId: json['schemeId'],
      unitName: json['unitName'],
      unitId: json['unitId'],
      dischargeCount: json['dischargeCount'],
      abhaRegCount: json['abhaRegCount'],
      districtName: json['districtName'],
      machineCount: json['machineCount'],
      commertialDate: json['commertialDate'],
      totalPatRegister: json['totalPatRegister'],
      totalsession: json['totalsession'],
      totalEvent: json['totalEvent'],
      patientAdded: json['patientAdded'],
    );
  }

  // Method to convert Patient instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'fName': fName,
      'lName': lName,
      'mobileNo': mobileNo,
      'abhNo': abhNo,
      'schemeId': schemeId,
      'unitName': unitName,
      'unitId': unitId,
      'dischargeCount': dischargeCount,
      'abhaRegCount': abhaRegCount,
      'districtName': districtName,
      'machineCount': machineCount,
      'commertialDate': commertialDate,
      'totalPatRegister': totalPatRegister,
      'totalsession': totalsession,
      'totalEvent': totalEvent,
      'patientAdded': patientAdded
    };
  }

  // Method to combine fName and lName
  String get fullName => '$fName $lName';
}
