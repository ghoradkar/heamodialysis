class DashboardShortCodeModel {
  final List<String> departments;

  DashboardShortCodeModel({required this.departments});

  factory DashboardShortCodeModel.fromJson(List<dynamic> json) {
    return DashboardShortCodeModel(
      departments: List<String>.from(json),
    );
  }

  List<String> toJson() {
    return departments;
  }
}
