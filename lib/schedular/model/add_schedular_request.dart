class AddSchedularRequest {
  AddSchedularRequest(
      {this.unitId,
      this.patientId,
      this.bedAllocationDate,
      this.slotId,
      this.userId});

  AddSchedularRequest.fromJson(dynamic json) {
    unitId = json['unitId'];
    patientId = json['patientId'];
    bedAllocationDate = json['bedAllocationDate'];
    slotId = json['slotId'];
    userId = json['userId'];
  }

  int? unitId;
  String? bedAllocationDate;
  int? patientId;
  int? slotId;
  String? slot;
  int? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitId'] = unitId;
    map['patientId'] = patientId;
    map['bedAllocationDate'] = bedAllocationDate;
    map['slotId'] = slotId;
    map['userId'] = userId;
    return map;
  }
}
