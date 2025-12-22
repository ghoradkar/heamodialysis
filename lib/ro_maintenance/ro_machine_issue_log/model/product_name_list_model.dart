class ProductNameListModel {
  ProductNameListModel({
      this.itemId, 
      this.itemName,});

  ProductNameListModel.fromJson(dynamic json) {
    itemId = json['itemId'];
    itemName = json['itemName'];
  }
  int? itemId;
  String? itemName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['itemId'] = itemId;
    map['itemName'] = itemName;
    return map;
  }

}