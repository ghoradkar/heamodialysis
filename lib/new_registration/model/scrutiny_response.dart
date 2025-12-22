class ScrutinyResponse {
  final String status;
  final String message;
  final ScrutinyDetails? details;

  ScrutinyResponse({
    required this.status,
    required this.message,
    this.details,
  });

  factory ScrutinyResponse.fromJson(Map<String, dynamic> json) {
    return ScrutinyResponse(
      status: json['status'],
      message: json['message'],
      details: json['details'] != null
          ? ScrutinyDetails.fromJson(json['details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'details': details?.toJson(),
    };
  }
}

class ScrutinyDetails {
  final String isServiceDefineOrNot;
  final String isScrutinyDefineOrNot;
  final String isQuestionsDefineOrNot;

  ScrutinyDetails({
    required this.isServiceDefineOrNot,
    required this.isScrutinyDefineOrNot,
    required this.isQuestionsDefineOrNot,
  });

  factory ScrutinyDetails.fromJson(Map<String, dynamic> json) {
    return ScrutinyDetails(
      isServiceDefineOrNot: json['isServiceDefineOrNot'],
      isScrutinyDefineOrNot: json['isScrutinyDefineOrNot'],
      isQuestionsDefineOrNot: json['isQuestionsDefineOrNot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isServiceDefineOrNot': isServiceDefineOrNot,
      'isScrutinyDefineOrNot': isScrutinyDefineOrNot,
      'isQuestionsDefineOrNot': isQuestionsDefineOrNot,
    };
  }
}
