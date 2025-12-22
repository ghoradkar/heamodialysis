class RouteListModel {
  RouteListModel({
      this.routeId, 
      this.routename, 
      this.preparationId, 
      this.preparationName, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deleted, 
      this.deletedBy, 
      this.deletedDate, 
      this.unitId, 
      this.listroutemasters,});

  RouteListModel.fromJson(dynamic json) {
    routeId = json['route_id'];
    routename = json['routename'];
    preparationId = json['preparation_id'];
    preparationName = json['preparation_name'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deleted = json['deleted'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
    unitId = json['unitId'];
    if (json['listroutemasters'] != null) {
      listroutemasters = [];
      json['listroutemasters'].forEach((v) {
        listroutemasters?.add(Listroutemasters.fromJson(v));
      });
    }
  }
  int? routeId;
  dynamic routename;
  int? preparationId;
  dynamic preparationName;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdDate;
  dynamic updatedDate;
  String? deleted;
  dynamic deletedBy;
  dynamic deletedDate;
  dynamic unitId;
  List<Listroutemasters>? listroutemasters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['route_id'] = routeId;
    map['routename'] = routename;
    map['preparation_id'] = preparationId;
    map['preparation_name'] = preparationName;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deleted'] = deleted;
    map['deletedBy'] = deletedBy;
    map['deletedDate'] = deletedDate;
    map['unitId'] = unitId;
    if (listroutemasters != null) {
      map['listroutemasters'] = listroutemasters?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Listroutemasters {
  Listroutemasters({
      this.routeId, 
      this.routename, 
      this.preparationId, 
      this.preparationName, 
      this.createdBy, 
      this.updatedBy, 
      this.createdDate, 
      this.updatedDate, 
      this.deleted, 
      this.deletedBy, 
      this.deletedDate, 
      this.unitId, 
      this.listroutemasters,});

  Listroutemasters.fromJson(dynamic json) {
    routeId = json['route_id'];
    routename = json['routename'];
    preparationId = json['preparation_id'];
    preparationName = json['preparation_name'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deleted = json['deleted'];
    deletedBy = json['deletedBy'];
    deletedDate = json['deletedDate'];
    unitId = json['unitId'];
    listroutemasters = json['listroutemasters'];
  }
  int? routeId;
  String? routename;
  int? preparationId;
  String? preparationName;
  int? createdBy;
  dynamic updatedBy;
  String? createdDate;
  String? updatedDate;
  String? deleted;
  dynamic deletedBy;
  dynamic deletedDate;
  int? unitId;
  dynamic listroutemasters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['route_id'] = routeId;
    map['routename'] = routename;
    map['preparation_id'] = preparationId;
    map['preparation_name'] = preparationName;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    map['deleted'] = deleted;
    map['deletedBy'] = deletedBy;
    map['deletedDate'] = deletedDate;
    map['unitId'] = unitId;
    map['listroutemasters'] = listroutemasters;
    return map;
  }

}