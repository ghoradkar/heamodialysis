class TempListModel {
  TempListModel({
      this.tempNameId, 
      this.selectTemplateType, 
      this.doctorSpecialization, 
      this.departmentId, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deleted, 
      this.deletedBy, 
      this.deletedDate, 
      this.unitId, 
      this.idpattemp, 
      this.tempname, 
      this.tempdata, 
      this.type, 
      this.specialization, 
      this.objectiveTempData, 
      this.pattemplist, 
      this.ioflg, 
      this.dietflag, 
      this.keyValueCKEditorArrayString, 
      this.date, 
      this.pid, 
      this.tid, 
      this.dischargeDate, 
      this.dischargeType,});

  TempListModel.fromJson(dynamic json) {
    tempNameId = json['tempNameId'];
    selectTemplateType = json['selectTemplateType'];
    doctorSpecialization = json['doctorSpecialization'];
    departmentId = json['departmentId'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deleted = json['deleted'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
    unitId = json['unitId'];
    idpattemp = json['idpattemp'];
    tempname = json['tempname'];
    tempdata = json['tempdata'];
    type = json['type'];
    specialization = json['specialization'];
    objectiveTempData = json['objectiveTempData'];
    if (json['pattemplist'] != null) {
      pattemplist = [];
      json['pattemplist'].forEach((v) {
        pattemplist?.add(Pattemplist.fromJson(v));
      });
    }
    ioflg = json['ioflg'];
    dietflag = json['dietflag'];
    keyValueCKEditorArrayString = json['keyValueCKEditorArrayString'];
    date = json['date'];
    pid = json['pid'];
    tid = json['tid'];
    dischargeDate = json['discharge_date'];
    dischargeType = json['discharge_type'];
  }
  dynamic tempNameId;
  dynamic selectTemplateType;
  dynamic doctorSpecialization;
  dynamic departmentId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  String? deleted;
  dynamic deletedBy;
  dynamic deletedDate;
  dynamic unitId;
  int? idpattemp;
  dynamic tempname;
  dynamic tempdata;
  String? type;
  String? specialization;
  dynamic objectiveTempData;
  List<Pattemplist>? pattemplist;
  dynamic ioflg;
  String? dietflag;
  dynamic keyValueCKEditorArrayString;
  dynamic date;
  dynamic pid;
  dynamic tid;
  dynamic dischargeDate;
  dynamic dischargeType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tempNameId'] = tempNameId;
    map['selectTemplateType'] = selectTemplateType;
    map['doctorSpecialization'] = doctorSpecialization;
    map['departmentId'] = departmentId;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deleted'] = deleted;
    map['deletedBy'] = deletedBy;
    map['deletedDate'] = deletedDate;
    map['unitId'] = unitId;
    map['idpattemp'] = idpattemp;
    map['tempname'] = tempname;
    map['tempdata'] = tempdata;
    map['type'] = type;
    map['specialization'] = specialization;
    map['objectiveTempData'] = objectiveTempData;
    if (pattemplist != null) {
      map['pattemplist'] = pattemplist?.map((v) => v.toJson()).toList();
    }
    map['ioflg'] = ioflg;
    map['dietflag'] = dietflag;
    map['keyValueCKEditorArrayString'] = keyValueCKEditorArrayString;
    map['date'] = date;
    map['pid'] = pid;
    map['tid'] = tid;
    map['discharge_date'] = dischargeDate;
    map['discharge_type'] = dischargeType;
    return map;
  }

}

class Pattemplist {
  Pattemplist({
      this.tempNameId, 
      this.selectTemplateType, 
      this.doctorSpecialization, 
      this.departmentId, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deleted, 
      this.deletedBy, 
      this.deletedDate, 
      this.unitId, 
      this.idpattemp, 
      this.tempname, 
      this.tempdata, 
      this.type, 
      this.specialization, 
      this.objectiveTempData, 
      this.pattemplist, 
      this.ioflg, 
      this.dietflag, 
      this.keyValueCKEditorArrayString, 
      this.date, 
      this.pid, 
      this.tid, 
      this.dischargeDate, 
      this.dischargeType,});

  Pattemplist.fromJson(dynamic json) {
    tempNameId = json['tempNameId'];
    selectTemplateType = json['selectTemplateType'];
    doctorSpecialization = json['doctorSpecialization'];
    departmentId = json['departmentId'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deleted = json['deleted'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
    unitId = json['unitId'];
    idpattemp = json['idpattemp'];
    tempname = json['tempname'];
    tempdata = json['tempdata'];
    type = json['type'];
    specialization = json['specialization'];
    objectiveTempData = json['objectiveTempData'];
    pattemplist = json['pattemplist'];
    ioflg = json['ioflg'];
    dietflag = json['dietflag'];
    keyValueCKEditorArrayString = json['keyValueCKEditorArrayString'];
    date = json['date'];
    pid = json['pid'];
    tid = json['tid'];
    dischargeDate = json['discharge_date'];
    dischargeType = json['discharge_type'];
  }
  int? tempNameId;
  String? selectTemplateType;
  String? doctorSpecialization;
  int? departmentId;
  int? createdBy;
  int? updatedBy;
  String? createdDate;
  String? updatedDate;
  String? deleted;
  dynamic deletedBy;
  dynamic deletedDate;
  int? unitId;
  int? idpattemp;
  String? tempname;
  String? tempdata;
  String? type;
  String? specialization;
  String? objectiveTempData;
  dynamic pattemplist;
  String? ioflg;
  String? dietflag;
  dynamic keyValueCKEditorArrayString;
  dynamic date;
  dynamic pid;
  dynamic tid;
  dynamic dischargeDate;
  dynamic dischargeType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tempNameId'] = tempNameId;
    map['selectTemplateType'] = selectTemplateType;
    map['doctorSpecialization'] = doctorSpecialization;
    map['departmentId'] = departmentId;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deleted'] = deleted;
    map['deletedBy'] = deletedBy;
    map['deletedDate'] = deletedDate;
    map['unitId'] = unitId;
    map['idpattemp'] = idpattemp;
    map['tempname'] = tempname;
    map['tempdata'] = tempdata;
    map['type'] = type;
    map['specialization'] = specialization;
    map['objectiveTempData'] = objectiveTempData;
    map['pattemplist'] = pattemplist;
    map['ioflg'] = ioflg;
    map['dietflag'] = dietflag;
    map['keyValueCKEditorArrayString'] = keyValueCKEditorArrayString;
    map['date'] = date;
    map['pid'] = pid;
    map['tid'] = tid;
    map['discharge_date'] = dischargeDate;
    map['discharge_type'] = dischargeType;
    return map;
  }

}