class SlotData {
  SlotData({
      this.unitId, 
      this.unitName, 
      this.slotId, 
      this.lookupDetId, 
      this.slotFromTime, 
      this.slotToTime, 
      this.effectiveFromDate, 
      this.effectiveToDate, 
      this.status, 
      this.createdDate, 
      this.createdBy, 
      this.updatedDate, 
      this.updatedBy, 
      this.macId, 
      this.ipAddress, 
      this.deviceFrom,
      this.effFromDate, 
      this.effToDate, 
      this.lookupDetDescEn, 
      this.list,});

  SlotData.fromJson(dynamic json) {
    unitId = json['unitId'];
    unitName = json['unitName'];
    slotId = json['slotId'];
    lookupDetId = json['lookupDetId'];
    slotFromTime = json['slotFromTime'];
    slotToTime = json['slotToTime'];
    effectiveFromDate = json['effectiveFromDate'];
    effectiveToDate = json['effectiveToDate'];
    status = json['status'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    slotFromTime = json['slot_From_Time'];
    slotToTime = json['slot_To_Time'];
    effFromDate = json['eff_From_date'];
    effToDate = json['eff_To_Date'];
    lookupDetDescEn = json['lookupDetDescEn'];
    list = json['list'];
  }
  dynamic unitId;
  dynamic unitName;
  int? slotId;
  dynamic lookupDetId;
  dynamic slotFromTime;
  dynamic slotToTime;
  dynamic effectiveFromDate;
  dynamic effectiveToDate;
  dynamic status;
  dynamic createdDate;
  dynamic createdBy;
  dynamic updatedDate;
  dynamic updatedBy;
  dynamic macId;
  dynamic ipAddress;
  dynamic deviceFrom;
  dynamic effFromDate;
  dynamic effToDate;
  dynamic lookupDetDescEn;
  dynamic list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitId'] = unitId;
    map['unitName'] = unitName;
    map['slotId'] = slotId;
    map['lookupDetId'] = lookupDetId;
    map['slotFromTime'] = slotFromTime;
    map['slotToTime'] = slotToTime;
    map['effectiveFromDate'] = effectiveFromDate;
    map['effectiveToDate'] = effectiveToDate;
    map['status'] = status;
    map['createdDate'] = createdDate;
    map['createdBy'] = createdBy;
    map['updatedDate'] = updatedDate;
    map['updatedBy'] = updatedBy;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    map['slot_From_Time'] = slotFromTime;
    map['slot_To_Time'] = slotToTime;
    map['eff_From_date'] = effFromDate;
    map['eff_To_Date'] = effToDate;
    map['lookupDetDescEn'] = lookupDetDescEn;
    map['list'] = list;
    return map;
  }

}