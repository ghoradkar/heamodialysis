class AddMachineCounterListModel {
  String? machineName;
  String? machineSerialNo;
  int? machineId;
  dynamic todayReading;
  dynamic lastReading;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  dynamic unitId;
  dynamic count;
  dynamic dialysisCounterId;
  dynamic unitName;
  String? machineLastReading;
  dynamic readingDate;
  dynamic userId;

  AddMachineCounterListModel({
    this.machineName,
    this.machineSerialNo,
    this.machineId,
    this.todayReading,
    this.lastReading,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdDate,
    this.updatedDate,
    this.unitId,
    this.count,
    this.dialysisCounterId,
    this.unitName,
    this.machineLastReading,
    this.readingDate,
    this.userId,
  });

  factory AddMachineCounterListModel.fromJson(Map<String, dynamic> json) {
    return AddMachineCounterListModel(
      machineName: json['machineName'],
      machineSerialNo: json['machineSerialNo'],
      machineId: json['machineId'],
      todayReading: json['today_reading'],
      lastReading: json['last_reading'],
      status: json['status'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      unitId: json['unitId'],
      count: json['count'],
      dialysisCounterId: json['dialysisCounterId'],
      unitName: json['unitName'],
      machineLastReading: json['machineLastReading'],
      readingDate: json['readingDate'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'machineName': machineName,
      'machineSerialNo': machineSerialNo,
      'machineId': machineId,
      'today_reading': todayReading,
      'last_reading': lastReading,
      'status': status,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'unitId': unitId,
      'count': count,
      'dialysisCounterId': dialysisCounterId,
      'unitName': unitName,
      'machineLastReading': machineLastReading,
      'readingDate': readingDate,
      'userId': userId,
    };
  }
}
