import 'package:intl/intl.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class PatientDocumentModel {
  final int patientId;
  final String patientName;
  final int treatmentId;
  final String treatmentDate;
  final String uploadDateTime;
  final String? fileUrl;

  const PatientDocumentModel({
    required this.patientId,
    required this.patientName,
    required this.treatmentId,
    required this.treatmentDate,
    required this.uploadDateTime,
    this.fileUrl,
  });

  bool get isUploaded => fileUrl != null && fileUrl!.isNotEmpty;

  String get fileName => isUploaded ? Uri.parse(fileUrl!).pathSegments.last : '';

  String get fullFileUrl => isUploaded
      ? ApiConstants.documentImageBaseUrl + fileUrl!.replaceAll(' ', '_')
      : '';

  String get formattedTreatmentDate {
    final date = DateTime.tryParse(treatmentDate);
    if (date == null) return treatmentDate;
    return DateFormat('dd-MM-yyyy').format(date.toLocal());
  }

  String get formattedUploadDateTime {
    if (uploadDateTime.isEmpty) return '';
    final date = DateTime.tryParse(uploadDateTime);
    if (date == null) return uploadDateTime;
    final localDate = date.toLocal();
    final datePart = DateFormat('d MMMM yyyy').format(localDate);
    final timePart = DateFormat('h.mm a').format(localDate).toLowerCase();
    return '$datePart | $timePart';
  }

  factory PatientDocumentModel.fromJson(Map<String, dynamic> json) {
    return PatientDocumentModel(
      patientId: json['patientId'] as int,
      patientName: json['patientName'] as String,
      treatmentId: json['treatmentId'] as int,
      treatmentDate: json['treatmentDate'] as String,
      uploadDateTime: json['uploadDateTime'] as String? ?? '',
      fileUrl: json['fileUrl'] as String?,
    );
  }
}
