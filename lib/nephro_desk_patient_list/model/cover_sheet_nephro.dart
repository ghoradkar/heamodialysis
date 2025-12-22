class CoverSheetNephroModel {
  CoverSheetNephroModel({
    this.laboratoryInvestigationList,
    this.temperatureTrendAnalysisList,
    this.bloodPressureTrendAnalysisList,
    this.weightTrendAnalysisList,
    this.dietList,
    this.oxygenLevelTrendAnalysisList,
    this.prescriptionList,
    this.prePostEventInvList,
    this.pulseTrendAnalysisList,
  });

  CoverSheetNephroModel.fromJson(dynamic json) {
    if (json['laboratoryInvestigationList'] != null) {
      laboratoryInvestigationList = [];
      json['laboratoryInvestigationList'].forEach((v) {
        laboratoryInvestigationList
            ?.add(LaboratoryInvestigationList.fromJson(v));
      });
    }
    if (json['Temperature TrendAnalysisList'] != null) {
      temperatureTrendAnalysisList = [];
      json['Temperature TrendAnalysisList'].forEach((v) {
        temperatureTrendAnalysisList
            ?.add(TemperatureTrendAnalysisList.fromJson(v));
      });
    }
    if (json['Blood Pressure TrendAnalysisList'] != null) {
      bloodPressureTrendAnalysisList = [];
      json['Blood Pressure TrendAnalysisList'].forEach((v) {
        bloodPressureTrendAnalysisList
            ?.add(BloodPressureTrendAnalysisList.fromJson(v));
      });
    }
    if (json['Weight TrendAnalysisList'] != null) {
      weightTrendAnalysisList = [];
      json['Weight TrendAnalysisList'].forEach((v) {
        weightTrendAnalysisList?.add(WeightTrendAnalysisList.fromJson(v));
      });
    }
    if (json['dietList'] != null) {
      dietList = [];
      json['dietList'].forEach((v) {
        dietList?.add(DietList.fromJson(v));
      });
    }
    if (json['Oxygen Level TrendAnalysisList'] != null) {
      oxygenLevelTrendAnalysisList = [];
      json['Oxygen Level TrendAnalysisList'].forEach((v) {
        oxygenLevelTrendAnalysisList
            ?.add(OxygenLevelTrendAnalysisList.fromJson(v));
      });
    }
    if (json['prescriptionList'] != null) {
      prescriptionList = [];
      json['prescriptionList'].forEach((v) {
        prescriptionList?.add(PrescriptionList.fromJson(v));
      });
    }
    if (json['prePostEventInvList'] != null) {
      prePostEventInvList = [];
      json['prePostEventInvList'].forEach((v) {
        prePostEventInvList?.add(PrePostEventInvList.fromJson(v));
      });
    }
    if (json['Pulse TrendAnalysisList'] != null) {
      pulseTrendAnalysisList = [];
      json['Pulse TrendAnalysisList'].forEach((v) {
        pulseTrendAnalysisList?.add(PulseTrendAnalysisList.fromJson(v));
      });
    }
  }

  List<LaboratoryInvestigationList>? laboratoryInvestigationList;
  List<TemperatureTrendAnalysisList>? temperatureTrendAnalysisList;
  List<BloodPressureTrendAnalysisList>? bloodPressureTrendAnalysisList;
  List<WeightTrendAnalysisList>? weightTrendAnalysisList;
  List<DietList>? dietList;
  List<OxygenLevelTrendAnalysisList>? oxygenLevelTrendAnalysisList;
  List<PrescriptionList>? prescriptionList;
  List<PrePostEventInvList>? prePostEventInvList;
  List<PulseTrendAnalysisList>? pulseTrendAnalysisList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (laboratoryInvestigationList != null) {
      map['laboratoryInvestigationList'] =
          laboratoryInvestigationList?.map((v) => v.toJson()).toList();
    }
    if (temperatureTrendAnalysisList != null) {
      map['Temperature TrendAnalysisList'] =
          temperatureTrendAnalysisList?.map((v) => v.toJson()).toList();
    }
    if (bloodPressureTrendAnalysisList != null) {
      map['Blood Pressure TrendAnalysisList'] =
          bloodPressureTrendAnalysisList?.map((v) => v.toJson()).toList();
    }
    if (weightTrendAnalysisList != null) {
      map['Weight TrendAnalysisList'] =
          weightTrendAnalysisList?.map((v) => v.toJson()).toList();
    }
    if (dietList != null) {
      map['dietList'] = dietList?.map((v) => v.toJson()).toList();
    }
    if (oxygenLevelTrendAnalysisList != null) {
      map['Oxygen Level TrendAnalysisList'] =
          oxygenLevelTrendAnalysisList?.map((v) => v.toJson()).toList();
    }
    if (prescriptionList != null) {
      map['prescriptionList'] =
          prescriptionList?.map((v) => v.toJson()).toList();
    }
    if (prePostEventInvList != null) {
      map['prePostEventInvList'] =
          prePostEventInvList?.map((v) => v.toJson()).toList();
    }
    if (pulseTrendAnalysisList != null) {
      map['Pulse TrendAnalysisList'] =
          pulseTrendAnalysisList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PulseTrendAnalysisList {
  PulseTrendAnalysisList({
    this.preDialysisStartDate,
    this.postDialysisStopDate,
    this.patientId,
    this.postPulse,
    this.prePulse,
    this.preDialysisStartTime,
    this.postDialysisStopTime,
    this.treatmentId,
  });

  PulseTrendAnalysisList.fromJson(dynamic json) {
    preDialysisStartDate = json['preDialysisStartDate'];
    postDialysisStopDate = json['postDialysisStopDate'];
    patientId = json['patientId'];
    postPulse = json['postPulse'];
    prePulse = json['prePulse'];
    preDialysisStartTime = json['preDialysisStartTime'];
    postDialysisStopTime = json['postDialysisStopTime'];
    treatmentId = json['treatmentId'];
  }

  String? preDialysisStartDate;
  String? postDialysisStopDate;
  String? patientId;
  String? postPulse;
  String? prePulse;
  String? preDialysisStartTime;
  String? postDialysisStopTime;
  String? treatmentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['preDialysisStartDate'] = preDialysisStartDate;
    map['postDialysisStopDate'] = postDialysisStopDate;
    map['patientId'] = patientId;
    map['postPulse'] = postPulse;
    map['prePulse'] = prePulse;
    map['preDialysisStartTime'] = preDialysisStartTime;
    map['postDialysisStopTime'] = postDialysisStopTime;
    map['treatmentId'] = treatmentId;
    return map;
  }
}

class PrePostEventInvList {
  PrePostEventInvList({
    this.createdDate,
    this.patientId,
    this.dischargeDate,
    this.dialysisName,
    this.treatmentId,
  });

  PrePostEventInvList.fromJson(dynamic json) {
    createdDate = json['createdDate'];
    patientId = json['patientId'];
    dischargeDate = json['dischargeDate'];
    dialysisName = json['dialysisName'];
    treatmentId = json['treatmentId'];
  }

  String? createdDate;
  String? patientId;
  String? dischargeDate;
  String? dialysisName;
  String? treatmentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdDate'] = createdDate;
    map['patientId'] = patientId;
    map['dischargeDate'] = dischargeDate;
    map['dialysisName'] = dialysisName;
    map['treatmentId'] = treatmentId;
    return map;
  }
}

class PrescriptionList {
  PrescriptionList({
    this.prescriptionData,
  });

  PrescriptionList.fromJson(dynamic json) {
    prescriptionData = json['prescriptionData'];
  }

  String? prescriptionData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prescriptionData'] = prescriptionData;
    return map;
  }
}

class OxygenLevelTrendAnalysisList {
  OxygenLevelTrendAnalysisList({
    this.preDialysisOxygen,
    this.preDialysisStartDate,
    this.postDialysisStopDate,
    this.patientId,
    this.preDialysisStartTime,
    this.postDialysisStopTime,
    this.treatmentId,
  });

  OxygenLevelTrendAnalysisList.fromJson(dynamic json) {
    preDialysisOxygen = json[''];
    preDialysisStartDate = json['preDialysisStartDate'];
    postDialysisStopDate = json['postDialysisStopDate'];
    patientId = json['patientId'];
    preDialysisStartTime = json['preDialysisStartTime'];
    postDialysisStopTime = json['postDialysisStopTime'];
    treatmentId = json['treatmentId'];
  }

  String? preDialysisOxygen;
  String? preDialysisStartDate;
  String? postDialysisStopDate;
  String? patientId;
  String? preDialysisStartTime;
  String? postDialysisStopTime;
  String? treatmentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[''] = preDialysisOxygen;
    map['preDialysisStartDate'] = preDialysisStartDate;
    map['postDialysisStopDate'] = postDialysisStopDate;
    map['patientId'] = patientId;
    map['preDialysisStartTime'] = preDialysisStartTime;
    map['postDialysisStopTime'] = postDialysisStopTime;
    map['treatmentId'] = treatmentId;
    return map;
  }
}

class DietList {
  DietList({
    this.fromDate,
    this.templateName,
    this.dietMasterId,
    this.createdBy,
    this.toDate,
    this.fullName,
  });

  DietList.fromJson(dynamic json) {
    fromDate = json['fromDate'];
    templateName = json['templateName'];
    dietMasterId = json['dietMasterId'];
    createdBy = json['createdBy'];
    toDate = json['toDate'];
    fullName = json['fullName'];
  }

  String? fromDate;
  String? templateName;
  String? dietMasterId;
  String? createdBy;
  String? toDate;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fromDate'] = fromDate;
    map['templateName'] = templateName;
    map['dietMasterId'] = dietMasterId;
    map['createdBy'] = createdBy;
    map['toDate'] = toDate;
    map['fullName'] = fullName;
    return map;
  }
}

class WeightTrendAnalysisList {
  WeightTrendAnalysisList({
    this.preDialysisStartDate,
    this.postDialysisStopDate,
    this.patientId,
    this.postWeight,
    this.preDialysisStartTime,
    this.preWeight,
    this.postDialysisStopTime,
    this.treatmentId,
  });

  WeightTrendAnalysisList.fromJson(dynamic json) {
    preDialysisStartDate = json['preDialysisStartDate'];
    postDialysisStopDate = json['postDialysisStopDate'];
    patientId = json['patientId'];
    postWeight = json['postWeight'];
    preDialysisStartTime = json['preDialysisStartTime'];
    preWeight = json['preWeight'];
    postDialysisStopTime = json['postDialysisStopTime'];
    treatmentId = json['treatmentId'];
  }

  String? preDialysisStartDate;
  String? postDialysisStopDate;
  String? patientId;
  String? postWeight;
  String? preDialysisStartTime;
  String? preWeight;
  String? postDialysisStopTime;
  String? treatmentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['preDialysisStartDate'] = preDialysisStartDate;
    map['postDialysisStopDate'] = postDialysisStopDate;
    map['patientId'] = patientId;
    map['postWeight'] = postWeight;
    map['preDialysisStartTime'] = preDialysisStartTime;
    map['preWeight'] = preWeight;
    map['postDialysisStopTime'] = postDialysisStopTime;
    map['treatmentId'] = treatmentId;
    return map;
  }
}

class BloodPressureTrendAnalysisList {
  BloodPressureTrendAnalysisList({
    this.preDialysisStartDate,
    this.postDialysisStopDate,
    this.prebloodPressureHL,
    this.patientId,
    this.preDialysisStartTime,
    this.postbloodpressureLH,
    this.postDialysisStopTime,
    this.treatmentId,
  });

  BloodPressureTrendAnalysisList.fromJson(dynamic json) {
    preDialysisStartDate = json['preDialysisStartDate'];
    postDialysisStopDate = json['postDialysisStopDate'];
    prebloodPressureHL = json['prebloodPressureHL'];
    patientId = json['patientId'];
    preDialysisStartTime = json['preDialysisStartTime'];
    postbloodpressureLH = json['postbloodpressureLH'];
    postDialysisStopTime = json['postDialysisStopTime'];
    treatmentId = json['treatmentId'];
  }

  String? preDialysisStartDate;
  String? postDialysisStopDate;
  String? prebloodPressureHL;
  String? patientId;
  String? preDialysisStartTime;
  String? postbloodpressureLH;
  String? postDialysisStopTime;
  String? treatmentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['preDialysisStartDate'] = preDialysisStartDate;
    map['postDialysisStopDate'] = postDialysisStopDate;
    map['prebloodPressureHL'] = prebloodPressureHL;
    map['patientId'] = patientId;
    map['preDialysisStartTime'] = preDialysisStartTime;
    map['postbloodpressureLH'] = postbloodpressureLH;
    map['postDialysisStopTime'] = postDialysisStopTime;
    map['treatmentId'] = treatmentId;
    return map;
  }
}

class TemperatureTrendAnalysisList {
  TemperatureTrendAnalysisList({
    this.preDialysisStartDate,
    this.postDialysisStopDate,
    this.patientId,
    this.preDialysisStartTime,
    this.preTemperature,
    this.postDialysisStopTime,
    this.treatmentId,
    this.postTemperature,
  });

  TemperatureTrendAnalysisList.fromJson(dynamic json) {
    preDialysisStartDate = json['preDialysisStartDate'];
    postDialysisStopDate = json['postDialysisStopDate'];
    patientId = json['patientId'];
    preDialysisStartTime = json['preDialysisStartTime'];
    preTemperature = json['preTemperature'];
    postDialysisStopTime = json['postDialysisStopTime'];
    treatmentId = json['treatmentId'];
    postTemperature = json['postTemperature'];
  }

  String? preDialysisStartDate;
  String? postDialysisStopDate;
  String? patientId;
  String? preDialysisStartTime;
  String? preTemperature;
  String? postDialysisStopTime;
  String? treatmentId;
  String? postTemperature;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['preDialysisStartDate'] = preDialysisStartDate;
    map['postDialysisStopDate'] = postDialysisStopDate;
    map['patientId'] = patientId;
    map['preDialysisStartTime'] = preDialysisStartTime;
    map['preTemperature'] = preTemperature;
    map['postDialysisStopTime'] = postDialysisStopTime;
    map['treatmentId'] = treatmentId;
    map['postTemperature'] = postTemperature;
    return map;
  }
}

class LaboratoryInvestigationList {
  LaboratoryInvestigationList({
    this.dtoData,
  });

  LaboratoryInvestigationList.fromJson(dynamic json) {
    dtoData = json['dtoData'];
  }

  String? dtoData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dtoData'] = dtoData;
    return map;
  }
}
