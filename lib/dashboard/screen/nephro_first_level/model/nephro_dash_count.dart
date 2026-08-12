class NephroDashCount {
  NephroDashCount({
      this.patientAdded, 
      this.currentDatePatient, 
      this.totalDialysisSession, 
      this.currentDateDialysisSession, 
      this.totalEvent, 
      this.currentDateEvent, 
      this.totalDialysisCnacel, 
      this.currentdialCancel, 
      this.totalPatinetVerification, 
      this.totalPendingVarification, 
      this.currentdateVerification, 
      this.currentdatependingverification,});

  NephroDashCount.fromJson(dynamic json) {
    patientAdded = json['patientAdded'];
    currentDatePatient = json['currentDatePatient'];
    totalDialysisSession = json['totalDialysisSession'];
    currentDateDialysisSession = json['currentDateDialysisSession'];
    totalEvent = json['totalEvent'];
    currentDateEvent = json['currentDateEvent'];
    totalDialysisCnacel = json['totalDialysisCnacel'];
    currentdialCancel = json['currentdialCancel'];
    totalPatinetVerification = json['totalPatinetVerification'];
    totalPendingVarification = json['totalPendingVarification'];
    currentdateVerification = json['currentdateVerification'];
    currentdatependingverification = json['currentdatependingverification'];
  }
  int? patientAdded;
  int? currentDatePatient;
  int? totalDialysisSession;
  int? currentDateDialysisSession;
  int? totalEvent;
  int? currentDateEvent;
  int? totalDialysisCnacel;
  int? currentdialCancel;
  int? totalPatinetVerification;
  int? totalPendingVarification;
  int? currentdateVerification;
  int? currentdatependingverification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patientAdded'] = patientAdded;
    map['currentDatePatient'] = currentDatePatient;
    map['totalDialysisSession'] = totalDialysisSession;
    map['currentDateDialysisSession'] = currentDateDialysisSession;
    map['totalEvent'] = totalEvent;
    map['currentDateEvent'] = currentDateEvent;
    map['totalDialysisCnacel'] = totalDialysisCnacel;
    map['currentdialCancel'] = currentdialCancel;
    map['totalPatinetVerification'] = totalPatinetVerification;
    map['totalPendingVarification'] = totalPendingVarification;
    map['currentdateVerification'] = currentdateVerification;
    map['currentdatependingverification'] = currentdatependingverification;
    return map;
  }

}