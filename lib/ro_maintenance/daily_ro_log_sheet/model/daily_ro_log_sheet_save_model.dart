class DailyRoLogSheetSaveModel {
  int? dailyRoPlantLogId;
  int? unitId;
  String? machineName;
  int? roPlantDate;
  int? machineId;
  int? userId;
  List<RoLogSheetPlantDetList>? roLogSheetPlantDetList;

  DailyRoLogSheetSaveModel({
    this.dailyRoPlantLogId,
    this.unitId,
    this.machineName,
    this.roPlantDate,
    this.machineId,
    this.userId,
    this.roLogSheetPlantDetList,
  });

  factory DailyRoLogSheetSaveModel.fromJson(Map<String, dynamic> json) {
    return DailyRoLogSheetSaveModel(
      dailyRoPlantLogId: json['dailyRoPlantLogId'],
      unitId: json['unitId'],
      machineName: json['machineName'],
      roPlantDate: json['roPlantDate'],
      machineId: json['machineId'],
      userId: json['userId'],
      roLogSheetPlantDetList: json['roLogSheetPlantDetList'] != null
          ? (json['roLogSheetPlantDetList'] as List)
          .map((e) => RoLogSheetPlantDetList.fromJson(e))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dailyRoPlantLogId': dailyRoPlantLogId,
      'unitId': unitId,
      'machineName': machineName,
      'roPlantDate': roPlantDate,
      'machineId': machineId,
      'userId': userId,
      'roLogSheetPlantDetList':
      roLogSheetPlantDetList?.map((e) => e.toJson()).toList(),
    };
  }
}

class RoLogSheetPlantDetList {
  String? parameter;
  String? units;
  String? values;
  int? roLogSheetDetId;

  RoLogSheetPlantDetList({
    this.parameter,
    this.units,
    this.values,
    this.roLogSheetDetId,
  });

  factory RoLogSheetPlantDetList.fromJson(Map<String, dynamic> json) {
    return RoLogSheetPlantDetList(
      parameter: json['parameter'],
      units: json['units'],
      values: json['values'],
      roLogSheetDetId: json['roLogSheetDetId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parameter': parameter,
      'units': units,
      'values': values,
      'roLogSheetDetId': roLogSheetDetId,
    };
  }
}
