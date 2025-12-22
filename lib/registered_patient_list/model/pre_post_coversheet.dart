class PrePostCoversheet {
  final int id1;
  final int id2;
  final String date1;
  final String date2;
  final String name;



   PrePostCoversheet( {
    required this.id1,
    required this.id2,
    required this.date1,
    required this.date2,
    required this.name,
     this.srNo
  });

  final int? srNo;

  // Factory method to create an instance from a JSON array
  factory PrePostCoversheet.fromJson(List<dynamic> json) {
    return PrePostCoversheet(
      id1: json[0] as int,
      id2: json[1] as int,
      date1: json[2] as String,
      date2: json[3] as String,
      name: json[4] as String,
    );
  }

  // Method to convert an instance to JSON array
  List<dynamic> toJson() {
    return [
      id1,
      id2,
      date1,
      date2,
      name,
    ];
  }
}
