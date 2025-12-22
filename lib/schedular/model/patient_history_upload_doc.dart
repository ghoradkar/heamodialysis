class PatientHistoryUploadDoc {
  final int? documentId;
  final String? doctorDeskFile;
  final String? remark;
  final String? createdBy;
  final String? updatedBy;
  final String? createdDate;
  final String? updatedDate;
  final String? deletedDate;
  final String? deletedBy;
  final int? unitId;
  final String? deleted;
  final dynamic treatmentDto;
  final dynamic patientRegistered;
  final dynamic lstDoctorDeskDocumentUploadDto;
  final int? userId;

  PatientHistoryUploadDoc({
    this.documentId,
    this.doctorDeskFile,
    this.remark,
    this.createdBy,
    this.updatedBy,
    this.createdDate,
    this.updatedDate,
    this.deletedDate,
    this.deletedBy,
    this.unitId,
    this.deleted,
    this.treatmentDto,
    this.patientRegistered,
    this.lstDoctorDeskDocumentUploadDto,
    this.userId,
  });

  factory PatientHistoryUploadDoc.fromJson(Map<String, dynamic> json) {
    return PatientHistoryUploadDoc(
      documentId: json['documentId'],
      doctorDeskFile: json['doctorDeskFile'],
      remark: json['remark'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      deletedDate: json['deletedDate'],
      deletedBy: json['deletedBy'],
      unitId: json['unitId'],
      deleted: json['deleted'],
      treatmentDto: json['treatmentDto'],
      patientRegistered: json['patientRegistered'],
      lstDoctorDeskDocumentUploadDto: json['lstDoctorDeskDocumentUploadDto'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentId': documentId,
      'doctorDeskFile': doctorDeskFile,
      'remark': remark,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'deletedDate': deletedDate,
      'deletedBy': deletedBy,
      'unitId': unitId,
      'deleted': deleted,
      'treatmentDto': treatmentDto,
      'patientRegistered': patientRegistered,
      'lstDoctorDeskDocumentUploadDto': lstDoctorDeskDocumentUploadDto,
      'userId': userId,
    };
  }
}
