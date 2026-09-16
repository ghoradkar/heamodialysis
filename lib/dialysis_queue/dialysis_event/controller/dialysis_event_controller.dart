import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/screen/dialysis_event_list.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/add_edit_dialysis_event_req.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_detaisl_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_list_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/incedent_type_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/patient_event_details.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/repository/dialysis_event_repository.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

class DialysisEventController extends GetxController {
  final DialysisEventRepository _repository = DialysisEventRepository();

  bool isLoading = false;
  List<AddEditDialysisEventReq> cardList = [];

  List<IncedentTypeModel> incidentList = [];
  List<DialysisEventListModel> dialysisEventList = [];
  List<DialysisEventDetaislModel> dialysisEventDetList = [];
  List<PatientEventDetails> dialysisPatientEventDetList = [];

  List<IncedentTypeModel> incidentSubTypeList = [];

  String? initialIncident;

  IncedentTypeModel? selectedIncident;
  IncedentTypeModel? selectedIncidentSub;

  String? initialIncidentSubType;

  List<DialysisEventListModel>? filteredDialysisEventList;

  getIncidentSubType(int? lookupId) async {
    isLoading = true;

    try {
      incidentSubTypeList = await _repository.getIncidentSubType(lookupId);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting captcha');
    }
  }

  getIncidentType() async {
    isLoading = true;

    try {
      incidentList = await _repository.getIncidentType();
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting captcha');
    }
  }

  getDialysisEventList(String inputValue, String startIndex, String callFrom,
      String searchType, String unitId) async {
    isLoading = true;

    try {
      dialysisEventList = await _repository.getDialysisEventList(
          inputValue, startIndex, callFrom, unitId);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting captcha');
    }
  }

  getEventPatientDetails(String treatmentId, String patientId) async {
    isLoading = true;

    try {
      dialysisEventDetList =
          await _repository.getEventPatientDetails(treatmentId, patientId);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
    }
  }

  getEventDetailsList(String patientId) async {
    isLoading = true;

    try {
      dialysisPatientEventDetList =
          await _repository.getEventDetailsList(patientId);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting captcha');
    }
  }

  saveDialysisEvent(userId, unitId) async {
    isLoading = true;

    try {
      final data =
          await _repository.saveDialysisEvent(cardList, userId, unitId);
      isLoading = false;
      CustomMessage.toast(data['return']);
      cardList.clear();
      Get.to(const DialysisEventList());
      update();
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting captcha');
    }
  }
}
