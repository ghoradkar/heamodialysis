class SlotForSearch {
  SlotForSearch({
      this.slotTime, 
      this.slotId,});

  SlotForSearch.fromJson(dynamic json) {
    slotTime = json['slotTime'];
    slotId = json['slotId'];
  }
  String? slotTime;
  String? slotId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slotTime'] = slotTime;
    map['slotId'] = slotId;
    return map;
  }

}