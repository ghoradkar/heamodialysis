class MedicineNameModel {
  MedicineNameModel({
      this.productId, 
      this.productName, 
      this.drugId, 
      this.drugName, 
      this.nutracalProduct, 
      this.lstPrescriptionGenericDTO,});

  MedicineNameModel.fromJson(dynamic json) {
    productId = json['productId'];
    productName = json['productName'];
    drugId = json['drugId'];
    drugName = json['drugName'];
    nutracalProduct = json['nutracalProduct'];
    if (json['lstPrescriptionGenericDTO'] != null) {
      lstPrescriptionGenericDTO = [];
      json['lstPrescriptionGenericDTO'].forEach((v) {
        lstPrescriptionGenericDTO?.add(LstPrescriptionGenericDto.fromJson(v));
      });
    }
  }
  dynamic productId;
  dynamic productName;
  dynamic drugId;
  dynamic drugName;
  dynamic nutracalProduct;
  List<LstPrescriptionGenericDto>? lstPrescriptionGenericDTO;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['productName'] = productName;
    map['drugId'] = drugId;
    map['drugName'] = drugName;
    map['nutracalProduct'] = nutracalProduct;
    if (lstPrescriptionGenericDTO != null) {
      map['lstPrescriptionGenericDTO'] = lstPrescriptionGenericDTO?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class LstPrescriptionGenericDto {
  LstPrescriptionGenericDto({
      this.productId, 
      this.productName, 
      this.drugId, 
      this.drugName, 
      this.nutracalProduct, 
      this.lstPrescriptionGenericDTO,});

  LstPrescriptionGenericDto.fromJson(dynamic json) {
    productId = json['productId'];
    productName = json['productName'];
    drugId = json['drugId'];
    drugName = json['drugName'];
    nutracalProduct = json['nutracalProduct'];
    lstPrescriptionGenericDTO = json['lstPrescriptionGenericDTO'];
  }
  int? productId;
  String? productName;
  int? drugId;
  String? drugName;
  int? nutracalProduct;
  dynamic lstPrescriptionGenericDTO;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['productName'] = productName;
    map['drugId'] = drugId;
    map['drugName'] = drugName;
    map['nutracalProduct'] = nutracalProduct;
    map['lstPrescriptionGenericDTO'] = lstPrescriptionGenericDTO;
    return map;
  }

}