class PrepListModel {
  PrepListModel({
      this.preparationId, 
      this.preparationName, 
      this.preparationDeleteFlag, 
      this.preparationUpdateDate, 
      this.preparationAddDate, 
      this.preparationQty, 
      this.listpreparationmaster,});

  PrepListModel.fromJson(dynamic json) {
    preparationId = json['preparationId'];
    preparationName = json['preparationName'];
    preparationDeleteFlag = json['preparationDeleteFlag'];
    preparationUpdateDate = json['preparationUpdateDate'];
    preparationAddDate = json['preparationAddDate'];
    preparationQty = json['preparationQty'];
    if (json['listpreparationmaster'] != null) {
      listpreparationmaster = [];
      json['listpreparationmaster'].forEach((v) {
        listpreparationmaster?.add(ListPreparationMaster.fromJson(v));
      });
    }
  }
  dynamic preparationId;
  dynamic preparationName;
  dynamic preparationDeleteFlag;
  dynamic preparationUpdateDate;
  dynamic preparationAddDate;
  String? preparationQty;
  List<ListPreparationMaster>? listpreparationmaster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['preparationId'] = preparationId;
    map['preparationName'] = preparationName;
    map['preparationDeleteFlag'] = preparationDeleteFlag;
    map['preparationUpdateDate'] = preparationUpdateDate;
    map['preparationAddDate'] = preparationAddDate;
    map['preparationQty'] = preparationQty;
    if (listpreparationmaster != null) {
      map['listpreparationmaster'] = listpreparationmaster?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ListPreparationMaster {
  ListPreparationMaster({
      this.preparationId, 
      this.preparationName, 
      this.preparationDeleteFlag, 
      this.preparationUpdateDate, 
      this.preparationAddDate, 
      this.preparationQty, 
      this.listpreparationmaster,});

  ListPreparationMaster.fromJson(dynamic json) {
    preparationId = json['preparationId'];
    preparationName = json['preparationName'];
    preparationDeleteFlag = json['preparationDeleteFlag'];
    preparationUpdateDate = json['preparationUpdateDate'];
    preparationAddDate = json['preparationAddDate'];
    preparationQty = json['preparationQty'];
    listpreparationmaster = json['listpreparationmaster'];
  }
  int? preparationId;
  String? preparationName;
  int? preparationDeleteFlag;
  String? preparationUpdateDate;
  String? preparationAddDate;
  String? preparationQty;
  dynamic listpreparationmaster;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['preparationId'] = preparationId;
    map['preparationName'] = preparationName;
    map['preparationDeleteFlag'] = preparationDeleteFlag;
    map['preparationUpdateDate'] = preparationUpdateDate;
    map['preparationAddDate'] = preparationAddDate;
    map['preparationQty'] = preparationQty;
    map['listpreparationmaster'] = listpreparationmaster;
    return map;
  }

}