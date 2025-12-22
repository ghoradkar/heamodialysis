class DailyRoLogSheetModel {
   int? machineId;
   String? roPlantDate;
   int? id;
 String? machineName;

  DailyRoLogSheetModel({
     this.machineId,
     this.roPlantDate,
     this.id,
     this.machineName,
  });

  factory DailyRoLogSheetModel.fromJson(Map<String, dynamic> json) {
    return DailyRoLogSheetModel(
      machineId: json['machineId'] ?? 0,
      roPlantDate: json['roPlantDate'] ?? '',
      id: json['id'] ?? 0,
      machineName: json['machineName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'machineId': machineId,
      'roPlantDate': roPlantDate,
      'id': id,
      'machineName': machineName,
    };
  }
}
