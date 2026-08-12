class DocumentSearchRequestModel {
  final String searchType;
  final String searchValue;
  final String fromDate;
  final String toDate;

  const DocumentSearchRequestModel({
    required this.searchType,
    required this.searchValue,
    required this.fromDate,
    required this.toDate,
  });

  Map<String, dynamic> toJson() => {
        'searchType': searchType,
        'searchValue': searchValue,
        'fromDate': fromDate,
        'toDate': toDate,
      };
}
