import 'dart:convert';

ClinicalHistoryTableData clinicalHistoryTableDataFromJson(String str) =>
    ClinicalHistoryTableData.fromJson(json.decode(str));

String clinicalHistoryTableDataToJson(ClinicalHistoryTableData data) =>
    json.encode(data.toJson());

class ClinicalHistoryTableData {
  ClinicalHistoryTableData({
    this.historyId,
    this.templateId,
    this.chiefComplaints,
    this.pastSurgicalHistory,
    this.temperature,
    this.pulse,
    this.createdDateTime,
    this.createdBy,
    this.unitId,
    this.userId,
    required this.patientId,
    this.treatmentId,
    this.smokingCurrentStatus,
    this.tobaccoCurentStatus,
    this.listCliniComorBean,
  });

  int? historyId;
  int? templateId;
  String? chiefComplaints;
  String? pastSurgicalHistory;
  String? temperature;
  String? pulse;
  String? createdDateTime;
  int? createdBy;
  int? unitId;
  int? userId;
  int patientId;
  int? treatmentId;
  int? smokingCurrentStatus;
  int? tobaccoCurentStatus;
  List<ListCliniComorBean>? listCliniComorBean;

  factory ClinicalHistoryTableData.fromJson(Map<String, dynamic> json) =>
      ClinicalHistoryTableData(
        historyId: json["historyId"],
        templateId: json["templateId"],
        chiefComplaints: json["chiefComplaints"],
        pastSurgicalHistory: json["pastSurgicalHistory"],
        temperature: json["temperature"],
        pulse: json["pulse"],
        createdDateTime: json["createdDateTime"],
        createdBy: json["createdBy"],
        unitId: json["unitId"],
        userId: json["userId"],
        patientId: json["patientId"] is String
            ? int.parse(json["patientId"])
            : json["patientId"],
        treatmentId: json["treatmentId"],
        smokingCurrentStatus: json["smokingCurrentStatus"],
        tobaccoCurentStatus: json["tobaccoCurentStatus"],
        listCliniComorBean: json["listCliniComorBean"] != null
            ? List<ListCliniComorBean>.from(json["listCliniComorBean"]
            .map((x) => ListCliniComorBean.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "historyId": historyId,
    "templateId": templateId,
    "chiefComplaints": chiefComplaints,
    "pastSurgicalHistory": pastSurgicalHistory,
    "temperature": temperature,
    "pulse": pulse,
    "createdDateTime": createdDateTime,
    "createdBy": createdBy,
    "unitId": unitId,
    "userId": userId,
    "patientId": patientId,
    "treatmentId": treatmentId,
    "smokingCurrentStatus": smokingCurrentStatus,
    "tobaccoCurentStatus": tobaccoCurentStatus,
    "listCliniComorBean": listCliniComorBean != null
        ? List<dynamic>.from(listCliniComorBean!.map((x) => x.toJson()))
        : [],
  };
}

class ListCliniComorBean {
  ListCliniComorBean({
    required this.clinicalComorbiditiesId,
    required this.patientId,
    required this.treatmentId,
    required this.comorbidities,
    this.durationYear,
    required this.comorFlag,
    required this.status,
    required this.createdBy,
    required this.createdDatetime,
    this.lookupDetIdComorbidities,
    this.multiRelaId,
  });

  int clinicalComorbiditiesId;
  int patientId;
  int treatmentId;
  String comorbidities;
  double? durationYear;
  String comorFlag;
  int status;
  int createdBy;
  String createdDatetime;
  int? lookupDetIdComorbidities;
  List<int>? multiRelaId;

  factory ListCliniComorBean.fromJson(Map<String, dynamic> json) =>
      ListCliniComorBean(
        clinicalComorbiditiesId: json["clinicalComorbiditiesId"],
        patientId: json["patientId"],
        treatmentId: json["treatmentId"],
        comorbidities: json["comorbidities"],
        durationYear: json["durationYear"] != null
            ? (json["durationYear"] is int
            ? (json["durationYear"] as int).toDouble()
            : double.tryParse(json["durationYear"].toString()))
            : null,
        comorFlag: json["comorFlag"],
        status: json["status"],
        createdBy: json["createdBy"],
        createdDatetime: json["createdDatetime"],
        lookupDetIdComorbidities: json["lookupDetIdComorbidities"],
        multiRelaId: json["multiRelaId"] != null
            ? List<int>.from(json["multiRelaId"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "clinicalComorbiditiesId": clinicalComorbiditiesId,
    "patientId": patientId,
    "treatmentId": treatmentId,
    "comorbidities": comorbidities,
    "durationYear": durationYear,
    "comorFlag": comorFlag,
    "status": status,
    "createdBy": createdBy,
    "createdDatetime": createdDatetime,
    "lookupDetIdComorbidities": lookupDetIdComorbidities,
    "multiRelaId": multiRelaId ?? [],
  };
}


// // YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation
//
// import 'dart:convert';
//
// ClinicalHistoryTableData clinicalHistoryTableDataFromJson(String str) =>
//     ClinicalHistoryTableData.fromJson(json.decode(str));
//
// String clinicalHistoryTableDataToJson(ClinicalHistoryTableData data) =>
//     json.encode(data.toJson());
//
// class ClinicalHistoryTableData {
//   ClinicalHistoryTableData({
//     this.pastSurgicalHistory,
//     this.createdBy,
//     required this.patientId,
//     this.historyId,
//     this.listCliniComorBean,
//     this.pulse,
//     this.createdDateTime,
//     this.unitId,
//     this.templateId,
//     this.userId,
//     this.treatmentId,
//   });
//
//   String? pastSurgicalHistory;
//   int? createdBy;
//   int patientId;
//   int? historyId;
//   List<ListCliniComorBean>? listCliniComorBean;
//   String? pulse;
//   String? createdDateTime;
//   int? unitId;
//   int? templateId;
//   int? userId;
//   int? treatmentId;
//
//   factory ClinicalHistoryTableData.fromJson(Map<dynamic, dynamic> json) =>
//       ClinicalHistoryTableData(
//         pastSurgicalHistory: json["pastSurgicalHistory"],
//         createdBy: json["createdBy"],
//         patientId: json["patientId"] is String
//             ? int.parse(json["patientId"])
//             : json["patientId"],
//         historyId: json["historyId"],
//         listCliniComorBean: List<ListCliniComorBean>.from(
//             json["listCliniComorBean"]
//                 .map((x) => ListCliniComorBean.fromJson(x))),
//         pulse: json["pulse"],
//         createdDateTime: json["createdDateTime"],
//         unitId: json["unitId"],
//         templateId: json["templateId"],
//         userId: json["userId"],
//         treatmentId: json["treatmentId"],
//       );
//
//   Map<dynamic, dynamic> toJson() => {
//         "pastSurgicalHistory": pastSurgicalHistory,
//         "createdBy": createdBy,
//         "patientId": patientId,
//         "historyId": historyId,
//         "listCliniComorBean": listCliniComorBean != null
//             ? List<dynamic>.from(listCliniComorBean!.map((x) => x.toJson()))
//             : [],
//         "pulse": pulse,
//         "createdDateTime": createdDateTime,
//         "unitId": unitId,
//         "templateId": templateId,
//         "userId": userId,
//         "treatmentId": treatmentId,
//       };
// }
//
// class ListCliniComorBean {
//   ListCliniComorBean({
//     required this.lookupDetIdComorbidities,
//     required this.comorFlag,
//     required this.comorbidities,
//     required this.durationYear,
//     required this.clinicalComorbiditiesId,
//     required this.patientId,
//     required this.createdBy,
//     required this.createdDatetime,
//     required this.treatmentId,
//     required this.status,
//     required this.multiRelaId,
//   });
//
//   int lookupDetIdComorbidities;
//   String comorFlag;
//   String comorbidities;
//   double? durationYear;
//   int clinicalComorbiditiesId;
//   int patientId;
//   int createdBy;
//   String createdDatetime;
//   int treatmentId;
//   int status;
//   List<int>? multiRelaId;
//
//   factory ListCliniComorBean.fromJson(Map<dynamic, dynamic> json) =>
//       ListCliniComorBean(
//         lookupDetIdComorbidities: json["lookupDetIdComorbidities"],
//         comorFlag: json["comorFlag"],
//         comorbidities: json["comorbidities"],
//         durationYear: json["durationYear"],
//         clinicalComorbiditiesId: json["clinicalComorbiditiesId"],
//         patientId: json["patientId"],
//         createdBy: json["createdBy"],
//         createdDatetime: json["createdDatetime"],
//         treatmentId: json["treatmentId"],
//         status: json["status"],
//         multiRelaId: json["multiRelaId"],
//       );
//
//   Map<dynamic, dynamic> toJson() => {
//         "lookupDetIdComorbidities": lookupDetIdComorbidities,
//         "comorFlag": comorFlag,
//         "comorbidities": comorbidities,
//         "durationYear": durationYear,
//         "clinicalComorbiditiesId": clinicalComorbiditiesId,
//         "patientId": patientId,
//         "createdBy": createdBy,
//         "createdDatetime": createdDatetime,
//         "treatmentId": treatmentId,
//         "status": status,
//         "multiRelaId": multiRelaId,
//       };
// }
