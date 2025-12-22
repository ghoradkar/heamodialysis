// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

ClinicalHistoryList clinicalHistoryListFromJson(String str) => ClinicalHistoryList.fromJson(json.decode(str));

String clinicalHistoryListToJson(ClinicalHistoryList data) => json.encode(data.toJson());

class ClinicalHistoryList {
    ClinicalHistoryList({
        required this.pastSurgicalHistory,
        required this.patientId,
        this.tobaccoConsumption,
         this.remark,
        required this.treatmentId,
         this.bloodGlucose,
         this.allergiesReactions,
         this.illicitDrug,
         this.lookupDetIdDiet,
         this.createdBy,
         this.specialInstructions,
         this.smoking,
         this.clinicalHistoryId,
         this.pulse,
         this.bloodPressureL,
         this.createdDatetime,
         this.updatedDateTime,
         this.bloodPressureH,
         this.alcoholConsumption,
         this.temperature,
         this.treatmentPlan,
         this.status,
    });

    String pastSurgicalHistory;
    int patientId;
    String? tobaccoConsumption;
    String? remark;
    int treatmentId;
    double? bloodGlucose;
    String? allergiesReactions;
    String? illicitDrug;
    int? lookupDetIdDiet;
    int? createdBy;
    String? specialInstructions;
    String? smoking;
    int? clinicalHistoryId;
    double? pulse;
    double? bloodPressureL;
    String? createdDatetime;
    String? updatedDateTime;
    double? bloodPressureH;
    String? alcoholConsumption;
    double? temperature;
    String? treatmentPlan;
    int? status;

    factory ClinicalHistoryList.fromJson(Map<dynamic, dynamic> json) => ClinicalHistoryList(
        pastSurgicalHistory: json["pastSurgicalHistory"],
        patientId: json["patientId"],
        tobaccoConsumption: json["tobaccoConsumption"],
        remark: json["remark"],
        treatmentId: json["treatmentId"],
        bloodGlucose: json["bloodGlucose"],
        allergiesReactions: json["allergiesReactions"],
        illicitDrug: json["illicitDrug"],
        lookupDetIdDiet: json["lookupDetIdDiet"],
        createdBy: json["createdBy"],
        specialInstructions: json["specialInstructions"],
        smoking: json["smoking"],
        clinicalHistoryId: json["clinicalHistoryId"],
        pulse: json["pulse"],
        bloodPressureL: json["bloodPressureL"],
        createdDatetime: json["createdDatetime"],
        updatedDateTime: json["updatedDatetime"],
        bloodPressureH: json["bloodPressureH"],
        alcoholConsumption: json["alcoholConsumption"],
        temperature: json["temperature"],
        treatmentPlan: json["treatmentPlan"],
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "pastSurgicalHistory": pastSurgicalHistory,
        "patientId": patientId,
        "tobaccoConsumption": tobaccoConsumption,
        "remark": remark,
        "treatmentId": treatmentId,
        "bloodGlucose": bloodGlucose,
        "allergiesReactions": allergiesReactions,
        "illicitDrug": illicitDrug,
        "lookupDetIdDiet": lookupDetIdDiet,
        "createdBy": createdBy,
        "specialInstructions": specialInstructions,
        "smoking": smoking,
        "clinicalHistoryId": clinicalHistoryId,
        "pulse": pulse,
        "bloodPressureL": bloodPressureL,
        "createdDatetime": createdDatetime,
        "updatedDatetime": updatedDateTime,
        "bloodPressureH": bloodPressureH,
        "alcoholConsumption": alcoholConsumption,
        "temperature": temperature,
        "treatmentPlan": treatmentPlan,
        "status": status,
    };
}
