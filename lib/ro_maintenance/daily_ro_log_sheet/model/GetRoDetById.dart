class GetRoDetById {
  final int? machineId;
  final String? parameter;
  final String? values;
  final int? unitId;
  final String? roPlantDate;
  final int? detailId;
  final int? logId;
  final String? units;
  final String? machineName;

  GetRoDetById({
    this.machineId,
    this.parameter,
    this.values,
    this.unitId,
    this.roPlantDate,
    this.detailId,
    this.logId,
    this.units,
    this.machineName,
  });

  factory GetRoDetById.fromJson(Map<String, dynamic> json) {
    return GetRoDetById(
      machineId: json['machineId'],
      parameter: json['parameter'],
      values: json['values'],
      unitId: json['unitId'],
      roPlantDate: json['roPlantDate'],
      detailId: json['detailId'],
      logId: json['logId'],
      units: json['units'],
      machineName: json['machineName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'machineId': machineId,
      'parameter': parameter,
      'values': values,
      'unitId': unitId,
      'roPlantDate': roPlantDate,
      'detailId': detailId,
      'logId': logId,
      'units': units,
      'machineName': machineName,
    };
  }
}
