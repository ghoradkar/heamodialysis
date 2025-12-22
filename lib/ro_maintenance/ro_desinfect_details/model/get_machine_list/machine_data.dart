import 'unit_master_dto.dart';

class MachineData {
  MachineData({
      this.roMachineMasterId, 
      this.machineName, 
      this.machineSerialNumber, 
      this.modelNumber, 
      this.roCapacity, 
      this.material, 
      this.voltage, 
      this.installationDate, 
      this.status, 
      this.createdDate, 
      this.createdBy, 
      this.updatedDate, 
      this.updatedBy, 
      this.macId, 
      this.ipAddress, 
      this.deviceFrom, 
      this.unitMasterDto, 
      this.proLi, 
      this.count, 
      this.machineNameList,});

  MachineData.fromJson(dynamic json) {
    roMachineMasterId = json['roMachineMasterId'];
    machineName = json['machineName'];
    machineSerialNumber = json['machineSerialNumber'];
    modelNumber = json['modelNumber'];
    roCapacity = json['roCapacity'];
    material = json['material'];
    voltage = json['voltage'];
    installationDate = json['installationDate'];
    status = json['status'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    unitMasterDto = json['unitMasterDto'] != null ? UnitMasterDto.fromJson(json['unitMasterDto']) : null;
    proLi = json['proLi'];
    count = json['count'];
    machineNameList = json['machineNameList'];
  }
  int? roMachineMasterId;
  String? machineName;
  String? machineSerialNumber;
  String? modelNumber;
  int? roCapacity;
  String? material;
  int? voltage;
  String? installationDate;
  int? status;
  String? createdDate;
  int? createdBy;
  dynamic updatedDate;
  dynamic updatedBy;
  dynamic macId;
  dynamic ipAddress;
  dynamic deviceFrom;
  UnitMasterDto? unitMasterDto;
  dynamic proLi;
  dynamic count;
  dynamic machineNameList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roMachineMasterId'] = roMachineMasterId;
    map['machineName'] = machineName;
    map['machineSerialNumber'] = machineSerialNumber;
    map['modelNumber'] = modelNumber;
    map['roCapacity'] = roCapacity;
    map['material'] = material;
    map['voltage'] = voltage;
    map['installationDate'] = installationDate;
    map['status'] = status;
    map['createdDate'] = createdDate;
    map['createdBy'] = createdBy;
    map['updatedDate'] = updatedDate;
    map['updatedBy'] = updatedBy;
    map['macId'] = macId;
    map['ipAddress'] = ipAddress;
    map['deviceFrom'] = deviceFrom;
    if (unitMasterDto != null) {
      map['unitMasterDto'] = unitMasterDto?.toJson();
    }
    map['proLi'] = proLi;
    map['count'] = count;
    map['machineNameList'] = machineNameList;
    return map;
  }

}