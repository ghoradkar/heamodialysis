import 'package:intl/intl.dart';

class PendingFeedbackTreatment {
  final int treatmentId;
  final String treatmentDate;

  const PendingFeedbackTreatment({
    required this.treatmentId,
    required this.treatmentDate,
  });

  String get formattedTreatmentDate {
    final date = DateTime.tryParse(treatmentDate);
    if (date == null) return treatmentDate;
    return DateFormat('dd-MM-yyyy').format(date.toLocal());
  }

  factory PendingFeedbackTreatment.fromJson(Map<String, dynamic> json) {
    return PendingFeedbackTreatment(
      treatmentId: json['treatmentId'] as int,
      treatmentDate: json['treatmentDate'] as String? ?? '',
    );
  }
}
