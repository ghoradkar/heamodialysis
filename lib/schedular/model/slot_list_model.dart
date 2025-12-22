
class SlotListModel {
  SlotListModel({
      this.code, 
      this.status, 
      this.data,});

  SlotListModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SlotData.fromJson(v));
      });
    }
  }
  int? code;
  String? status;
  List<SlotData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


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
    this.list,
    this.districtName,
    this.lookupDetValue,
    this.slotTimes,});

  SlotData.fromJson(dynamic json) {
    unitId = json['unitId'];
    unitName = json['unitName'];
    slotId = json['slotId'];
    lookupDetId = json['lookupDetId'];
    slotFromTime = json['slot_From_Time'];
    slotToTime = json['slot_To_Time'];
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
    effFromDate = json['eff_From_date'];
    effToDate = json['eff_To_Date'];
    lookupDetDescEn = json['lookupDetDescEn'];
    list = json['list'];
    districtName = json['districtName'];
    lookupDetValue = json['lookupDetValue'];
    slotTimes = json['slotTimes'];
  }
  dynamic unitId;
  dynamic unitName;
  int? slotId;
  dynamic lookupDetId;
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
  String? slotFromTime;
  dynamic slotToTime;
  dynamic effFromDate;
  dynamic effToDate;
  dynamic lookupDetDescEn;
  dynamic list;
  dynamic districtName;
  dynamic lookupDetValue;
  dynamic slotTimes;

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
    map['districtName'] = districtName;
    map['lookupDetValue'] = lookupDetValue;
    map['slotTimes'] = slotTimes;
    return map;
  }

}