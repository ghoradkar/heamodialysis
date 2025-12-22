class MachineCountModel {
  final String? machineName;
  final String? machineSerialNo;
  final String? machineId;
  final double? todayReading;
  final double? lastReading;
  final String? status;
  final String? createdBy;
  final String? updatedBy;
  final String? createdDate;
  final String? updatedDate;
  final String? unitId;
  final int? count;
  final String? dialysisCounterId;
  final String? unitName;
  final double? machineLastReading;
  final String? readingDate;
  final String? userId;

  MachineCountModel({
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

  factory MachineCountModel.fromJson(Map<String, dynamic> json) {
    return MachineCountModel(
      machineName: json['machineName'],
      machineSerialNo: json['machineSerialNo'],
      machineId: json['machineId'],
      todayReading: (json['today_reading'] as num?)?.toDouble(),
      lastReading: (json['last_reading'] as num?)?.toDouble(),
      status: json['status'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      unitId: json['unitId'],
      count: json['count'],
      dialysisCounterId: json['dialysisCounterId'],
      unitName: json['unitName'],
      machineLastReading: (json['machineLastReading'] as num?)?.toDouble(),
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

  static List<MachineCountModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MachineCountModel.fromJson(json)).toList();
  }
}
