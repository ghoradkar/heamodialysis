class MedicationMethod {
  final int lookupDetId;
  final String lookupDetValue;
  final String lookupDetDescEn;
  final String lookupDetParentName;

  MedicationMethod({
    required this.lookupDetId,
    required this.lookupDetValue,
    required this.lookupDetDescEn,
    required this.lookupDetParentName,
  });

  factory MedicationMethod.fromJson(Map<String, dynamic> json) {
    return MedicationMethod(
      lookupDetId: json['lookupDetId'] ?? 0,
      lookupDetValue: json['lookupDetValue'] ?? '',
      lookupDetDescEn: json['lookupDetDescEn'] ?? '',
      lookupDetParentName: json['lookupDetParentName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lookupDetId': lookupDetId,
      'lookupDetValue': lookupDetValue,
      'lookupDetDescEn': lookupDetDescEn,
      'lookupDetParentName': lookupDetParentName,
    };
  }

  @override
  String toString() {
    return '$lookupDetDescEn ($lookupDetValue)';
  }
}
