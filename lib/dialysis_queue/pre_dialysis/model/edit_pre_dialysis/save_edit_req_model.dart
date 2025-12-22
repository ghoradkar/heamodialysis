class SaveEditReqModel {
  SaveEditReqModel({
      this.patientId, 
      this.treatmentId, 
      this.lookupDetIdShemeAdopt, 
      this.mjpjaycaseNumber, 
      this.mjpjayclaimNumber, 
      this.mjpjayIPNumber, 
      this.enrollNo, 
      this.preAuthapdate,});

  SaveEditReqModel.fromJson(dynamic json) {
    patientId = json['patientId'];
    treatmentId = json['treatmentId'];
    lookupDetIdShemeAdopt = json['LookupDetIdShemeAdopt'];
    mjpjaycaseNumber = json['mjpjaycaseNumber'];
    mjpjayclaimNumber = json['mjpjayclaimNumber'];
    mjpjayIPNumber = json['mjpjayIPNumber'];
    enrollNo = json['enrollNo'];
    preAuthapdate = json['preAuthapdate'];
  }
  String? patientId;
  String? treatmentId;
  int? lookupDetIdShemeAdopt;
  String? mjpjaycaseNumber;
  String? mjpjayclaimNumber;
  String? mjpjayIPNumber;
  String? enrollNo;
  String? preAuthapdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientId'] = patientId;
    map['treatmentId'] = treatmentId;
    map['LookupDetIdShemeAdopt'] = lookupDetIdShemeAdopt;
    map['mjpjaycaseNumber'] = mjpjaycaseNumber;
    map['mjpjayclaimNumber'] = mjpjayclaimNumber;
    map['mjpjayIPNumber'] = mjpjayIPNumber;
    map['enrollNo'] = enrollNo;
    map['preAuthapdate'] = preAuthapdate;
    return map;
  }

}