import 'dart:convert';

class HdChartListModel {
  final int patientId;
  final String centerPatientId;
  final String fName;
  final String mobile;
  final String gender;
  final int age;
  final int ageMonths;
  final int ageDays;
  final int talukaId;
  final int townId;
  final int districtId;
  final int divisionId;
  final int stateId;
  final int countryId;
  final int areaCode;
  final int unitId;
  final int userId;
  final String deleted;
  final String organDonarFlag;
  final String imageName;
  final String aadharImageName;
  final String blockFlag;
  final String blockNarration1;
  final String blockNarration2;
  final String blockNarration3;
  final String blockUserName1;
  final String blockUserName2;
  final String blockUserName3;
  final int blockUserId1;
  final int blockUserId2;
  final int blockUserId3;
  final int relationId;
  final int pertalukaId;
  final int pertownId;
  final int perdistrictId;
  final int perstateId;
  final int perDivisionId;
  final int percountryId;
  final int perareaCode;
  final String oldPatientId;
  final int maritalStatusId;
  final int nationalityId;
  final int religionId;
  final int languageId;
  final int bloodGroupId;
  final int identityProofId;
  final int annualIncomeId;
  final String occupation;
  final String education;
  final String ivfTreatFlag;
  final String healthId;
  final String healthIdNumber;
  final String legacyUHIDNumber;
  final int departmentId;
  final int patientStatus;
  final int treatmentId;
  final String dialysisSupportType;
  final String procedureType;
  final int count;
  final String dialysisDate;
  final int patientHdChartId;
  final int hdChartTreatCount;

  HdChartListModel({
    required this.patientId,
    required this.centerPatientId,
    required this.fName,
    required this.mobile,
    required this.gender,
    required this.age,
    required this.ageMonths,
    required this.ageDays,
    required this.talukaId,
    required this.townId,
    required this.districtId,
    required this.divisionId,
    required this.stateId,
    required this.countryId,
    required this.areaCode,
    required this.unitId,
    required this.userId,
    required this.deleted,
    required this.organDonarFlag,
    required this.imageName,
    required this.aadharImageName,
    required this.blockFlag,
    required this.blockNarration1,
    required this.blockNarration2,
    required this.blockNarration3,
    required this.blockUserName1,
    required this.blockUserName2,
    required this.blockUserName3,
    required this.blockUserId1,
    required this.blockUserId2,
    required this.blockUserId3,
    required this.relationId,
    required this.pertalukaId,
    required this.pertownId,
    required this.perdistrictId,
    required this.perstateId,
    required this.perDivisionId,
    required this.percountryId,
    required this.perareaCode,
    required this.oldPatientId,
    required this.maritalStatusId,
    required this.nationalityId,
    required this.religionId,
    required this.languageId,
    required this.bloodGroupId,
    required this.identityProofId,
    required this.annualIncomeId,
    required this.occupation,
    required this.education,
    required this.ivfTreatFlag,
    required this.healthId,
    required this.healthIdNumber,
    required this.legacyUHIDNumber,
    required this.departmentId,
    required this.patientStatus,
    required this.treatmentId,
    required this.dialysisSupportType,
    required this.procedureType,
    required this.count,
    required this.dialysisDate,
    required this.patientHdChartId,
    required this.hdChartTreatCount,
  });

  factory HdChartListModel.fromJson(Map<String, dynamic> json) {
    return HdChartListModel(
      patientId: json['patientId'],
      centerPatientId: json['centerPatientId'],
      fName: json['fName'],
      mobile: json['mobile'],
      gender: json['gender'],
      age: json['age'],
      ageMonths: json['ageMonths'],
      ageDays: json['ageDays'],
      talukaId: json['talukaId'],
      townId: json['townId'],
      districtId: json['districtId'],
      divisionId: json['divisionId'],
      stateId: json['stateId'],
      countryId: json['countryId'],
      areaCode: json['areaCode'],
      unitId: json['unitId'],
      userId: json['userId'],
      deleted: json['deleted'],
      organDonarFlag: json['organDonarFlag'],
      imageName: json['imageName'],
      aadharImageName: json['aadharImageName'],
      blockFlag: json['blockFlag'],
      blockNarration1: json['blockNarration1'],
      blockNarration2: json['blockNarration2'],
      blockNarration3: json['blockNarration3'],
      blockUserName1: json['blockUserName1'],
      blockUserName2: json['blockUserName2'],
      blockUserName3: json['blockUserName3'],
      blockUserId1: json['blockUserId1'],
      blockUserId2: json['blockUserId2'],
      blockUserId3: json['blockUserId3'],
      relationId: json['relationId'],
      pertalukaId: json['pertalukaId'],
      pertownId: json['pertownId'],
      perdistrictId: json['perdistrictId'],
      perstateId: json['perstateId'],
      perDivisionId: json['perDivisionId'],
      percountryId: json['percountryId'],
      perareaCode: json['perareaCode'],
      oldPatientId: json['oldPatientId'],
      maritalStatusId: json['maritalStatusId'],
      nationalityId: json['nationalityId'],
      religionId: json['religionId'],
      languageId: json['languageId'],
      bloodGroupId: json['bloodGroupId'],
      identityProofId: json['identityProofId'],
      annualIncomeId: json['annualIncomeId'],
      occupation: json['occupation'],
      education: json['education'],
      ivfTreatFlag: json['ivfTreatFlag'],
      healthId: json['healthId'],
      healthIdNumber: json['healthIdNumber'],
      legacyUHIDNumber: json['legacyUHIDNumber'],
      departmentId: json['departmentId'],
      patientStatus: json['patientStatus'],
      treatmentId: json['treatmentId'],
      dialysisSupportType: json['dialysisSupportType'],
      procedureType: json['procedureType'],
      count: json['count'],
      dialysisDate: json['dialysisDate'],
      patientHdChartId: json['patientHdChartId'],
      hdChartTreatCount: json['hdChartTreatCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "patientId": patientId,
      "centerPatientId": centerPatientId,
      "fName": fName,
      "mobile": mobile,
      "gender": gender,
      "age": age,
      "ageMonths": ageMonths,
      "ageDays": ageDays,
      "talukaId": talukaId,
      "townId": townId,
      "districtId": districtId,
      "divisionId": divisionId,
      "stateId": stateId,
      "countryId": countryId,
      "areaCode": areaCode,
      "unitId": unitId,
      "userId": userId,
      "deleted": deleted,
      "organDonarFlag": organDonarFlag,
      "imageName": imageName,
      "aadharImageName": aadharImageName,
      "blockFlag": blockFlag,
      "blockNarration1": blockNarration1,
      "blockNarration2": blockNarration2,
      "blockNarration3": blockNarration3,
      "blockUserName1": blockUserName1,
      "blockUserName2": blockUserName2,
      "blockUserName3": blockUserName3,
      "blockUserId1": blockUserId1,
      "blockUserId2": blockUserId2,
      "blockUserId3": blockUserId3,
      "relationId": relationId,
      "pertalukaId": pertalukaId,
      "pertownId": pertownId,
      "perdistrictId": perdistrictId,
      "perstateId": perstateId,
      "perDivisionId": perDivisionId,
      "percountryId": percountryId,
      "perareaCode": perareaCode,
      "oldPatientId": oldPatientId,
      "maritalStatusId": maritalStatusId,
      "nationalityId": nationalityId,
      "religionId": religionId,
      "languageId": languageId,
      "bloodGroupId": bloodGroupId,
      "identityProofId": identityProofId,
      "annualIncomeId": annualIncomeId,
      "occupation": occupation,
      "education": education,
      "ivfTreatFlag": ivfTreatFlag,
      "healthId": healthId,
      "healthIdNumber": healthIdNumber,
      "legacyUHIDNumber": legacyUHIDNumber,
      "departmentId": departmentId,
      "patientStatus": patientStatus,
      "treatmentId": treatmentId,
      "dialysisSupportType": dialysisSupportType,
      "procedureType": procedureType,
      "count": count,
      "dialysisDate": dialysisDate,
      "patientHdChartId": patientHdChartId,
      "hdChartTreatCount": hdChartTreatCount,
    };
  }

  static List<HdChartListModel> listFromJson(String str) {
    final jsonData = json.decode(str) as List;
    return jsonData.map((e) => HdChartListModel.fromJson(e)).toList();
  }
}
