class SlotTimeModel {
  SlotTimeModel({
      this.slotId, 
      this.slotTimes,});

  SlotTimeModel.fromJson(dynamic json) {
    slotId = json['slotId'];
    slotTimes = json['slotTimes'];
  }
  int? slotId;
  String? slotTimes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slotId'] = slotId;
    map['slotTimes'] = slotTimes;
    return map;
  }

}