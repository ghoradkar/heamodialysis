class AddSchedularResponse {
  AddSchedularResponse({
      this.bedAllocationDate, 
      this.slotAllocated, 
      this.patientName, 
      this.unitName, 
      this.patientId, 
      this.unitId, 
      this.slotId, 
      this.unitAddress,});

  AddSchedularResponse.fromJson(dynamic json) {
    bedAllocationDate = json['bedAllocationDate'];
    slotAllocated = json['slotAllocated'];
    patientName = json['patientName'];
    unitName = json['unitName'];
    patientId = json['patientId'];
    unitId = json['unitId'];
    slotId = json['slotId'];
    unitAddress = json['unitAddress'];
  }
  String? bedAllocationDate;
  String? slotAllocated;
  String? patientName;
  String? unitName;
  String? patientId;
  String? unitId;
  String? slotId;
  String? unitAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bedAllocationDate'] = bedAllocationDate;
    map['slotAllocated'] = slotAllocated;
    map['patientName'] = patientName;
    map['unitName'] = unitName;
    map['patientId'] = patientId;
    map['unitId'] = unitId;
    map['slotId'] = slotId;
    map['unitAddress'] = unitAddress;
    return map;
  }

}