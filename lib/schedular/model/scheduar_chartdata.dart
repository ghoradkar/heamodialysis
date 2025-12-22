class ScheduarChartData {
  ScheduarChartData({
      this.date, 
      this.bedmachineSlotMapDetId, 
      this.bedAllocationDate, 
      this.patientName, 
      this.patientId, 
      this.lookupDetValue, 
      this.slotFromTime, 
      this.slotToTime, 
      this.mapDetId, 
      this.machineName, 
      this.treatmentId, 
      this.machineSerialNumber,});

  ScheduarChartData.fromJson(dynamic json) {
    date = json['date'];
    bedmachineSlotMapDetId = json['bedmachineSlotMapDetId'];
    bedAllocationDate = json['bedAllocationDate'];
    patientName = json['patientName'];
    patientId = json['patientId'];
    lookupDetValue = json['lookupDetValue'];
    slotFromTime = json['slotFromTime'];
    slotToTime = json['slotToTime'];
    mapDetId = json['mapDetId'];
    machineName = json['machineName'];
    treatmentId = json['treatmentId'];
    machineSerialNumber = json['machineSerialNumber'];
  }
  String? date;
  String? bedmachineSlotMapDetId;
  String? bedAllocationDate;
  String? patientName;
  String? patientId;
  String? lookupDetValue;
  String? slotFromTime;
  String? slotToTime;
  String? mapDetId;
  String? machineName;
  String? treatmentId;
  String? machineSerialNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['bedmachineSlotMapDetId'] = bedmachineSlotMapDetId;
    map['bedAllocationDate'] = bedAllocationDate;
    map['patientName'] = patientName;
    map['patientId'] = patientId;
    map['lookupDetValue'] = lookupDetValue;
    map['slotFromTime'] = slotFromTime;
    map['slotToTime'] = slotToTime;
    map['mapDetId'] = mapDetId;
    map['machineName'] = machineName;
    map['treatmentId'] = treatmentId;
    map['machineSerialNumber'] = machineSerialNumber;
    return map;
  }

}