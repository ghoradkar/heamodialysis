class TotalInvoiceAmountModel {
  TotalInvoiceAmountModel({
    this.totalInvoiceAmount,
    this.months,
  });

  factory TotalInvoiceAmountModel.fromJson(Map<String, dynamic> json) {
    return TotalInvoiceAmountModel(
      totalInvoiceAmount: json['totalInvoiceAmount']?.toString(),  // Convert to String
      months: json['months'],
    );
  }

  String? totalInvoiceAmount;
  String? months;

  Map<String, dynamic> toJson() {
    return {
      'totalInvoiceAmount': totalInvoiceAmount,
      'months': months,
    };
  }
}
