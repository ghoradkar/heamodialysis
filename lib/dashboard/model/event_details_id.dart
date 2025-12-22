class EventDetailsId {
  EventDetailsId({
      this.eventName, 
      this.eventCount,});

  EventDetailsId.fromJson(dynamic json) {
    eventName = json['eventName'];
    eventCount = json['eventCount'];
  }
  String? eventName;
  int? eventCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventName'] = eventName;
    map['eventCount'] = eventCount;
    return map;
  }

}