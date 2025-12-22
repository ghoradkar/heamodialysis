class BedData {
  BedData({
      this.slotId, 
      this.slotFromTime, 
      this.slotToTime, 
      this.bedNo, 
      this.machineName, 
      this.bedMachineSlotMapDetId, 
      this.bedTypeSpGenFlag, 
      this.bedAvailbilityFlag,});

  BedData.fromJson(dynamic json) {
    slotId = json['slotId'];
    slotFromTime = json['slotFromTime'];
    slotToTime = json['slotToTime'];
    bedNo = json['bedNo'];
    machineName = json['machineName'];
    bedMachineSlotMapDetId = json['bedMachineSlotMapDetId'];
    bedTypeSpGenFlag = json['bedTypeSpGenFlag'];
    bedAvailbilityFlag = json['bedAvailbilityFlag'];
  }
  int? slotId;
  dynamic slotFromTime;
  dynamic slotToTime;
  String? bedNo;
  dynamic machineName;
  int? bedMachineSlotMapDetId;
  String? bedTypeSpGenFlag;
  String? bedAvailbilityFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slotId'] = slotId;
    map['slotFromTime'] = slotFromTime;
    map['slotToTime'] = slotToTime;
    map['bedNo'] = bedNo;
    map['machineName'] = machineName;
    map['bedMachineSlotMapDetId'] = bedMachineSlotMapDetId;
    map['bedTypeSpGenFlag'] = bedTypeSpGenFlag;
    map['bedAvailbilityFlag'] = bedAvailbilityFlag;
    return map;
  }

}