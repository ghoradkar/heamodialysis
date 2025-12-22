class BatchNoListModel {
  BatchNoListModel({
      this.batchNumber,});

  BatchNoListModel.fromJson(dynamic json) {
    batchNumber = json['batchNumber'];
  }
  String? batchNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['batchNumber'] = batchNumber;
    return map;
  }

}