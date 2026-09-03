import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/common_dropdown_post_dialysis_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/current_weight_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/patient_details_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/save_request_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/start_date_and_time.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/post_dialysis_list_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/screen/post_dialysis_screen.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/repository/post_dialysis_repository.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/choose_package.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

class PostDialysisController extends GetxController {
  final PostDialysisRepository _repository = PostDialysisRepository();

  String? msg;
  SaveRequestModel saveRequestModel = SaveRequestModel();
  String? status;
  bool isRemarkVisiable = false;
  CustomRadioButtons epoAdmin = CustomRadioButtons.yes;
  CustomRadioButtons ironSource = CustomRadioButtons.yes;
  CustomRadioButtons bloodTrans = CustomRadioButtons.yes;

  PostDialysisListModel? postDialysisListModel;
  PatientDetailsModel? patientDetailsModel;
  StartDateAndTime? startDateAndTime;
  CurrentWeightModel? currentWeightModel;
  SearchRegisteredPatientModel? searchByModel;
  CheckBoxList? discardRem = CheckBoxList('Discard Dialyzer', false);
  TextEditingController valueController = TextEditingController();
  TextEditingController doubleTxtController1 = TextEditingController();
  TextEditingController doubleTxtController2 = TextEditingController();
  TextEditingController caseNarrationController = TextEditingController();
  TextEditingController rrfUrineController = TextEditingController();
  TextEditingController cbvController = TextEditingController();
  TextEditingController heparinController = TextEditingController();
  TextEditingController dialyticFlowController = TextEditingController();
  TextEditingController actualFiberController = TextEditingController();
  TextEditingController epoIndicator = TextEditingController();
  TextEditingController ironProtocolUsed = TextEditingController();
  TextEditingController bloodTransDate = TextEditingController();
  TextEditingController lastHgb = TextEditingController();
  TextEditingController ferritinLevel = TextEditingController();
  TextEditingController tsat = TextEditingController();
  TextEditingController discardedRemController = TextEditingController();
  TextEditingController finalKtVController = TextEditingController();
  TextEditingController urfController = TextEditingController();

  // TextEditingController discardedDialyzerController = TextEditingController();
  TextEditingController percentageFiberController = TextEditingController();
  TextEditingController oxygenLevel = TextEditingController();
  TextEditingController pulseLevel = TextEditingController();
  TextEditingController temperaturController = TextEditingController();
  TextEditingController durationRemark = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController currentWeightController = TextEditingController();
  TextEditingController finalUFVController = TextEditingController();
  TextEditingController venousPressureController = TextEditingController();
  TextEditingController bloodFlowController = TextEditingController();
  TextEditingController respRateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController epoStartDate = TextEditingController();
  TextEditingController ironStartDate = TextEditingController();
  TextEditingController volume = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController stopTimeController = TextEditingController();
  TextEditingController stopDateController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  String? startTime;
  bool isLoading = false;
  bool isSaving = false;
  String? selectedDurationRem;
  String? selectedEPOBrand;
  String? selectedIronPrep;
  String? selectedEpoDose;
  String? selectedIronDose;
  String? selectedEpoFreq;
  String? selectedIronFreq;
  String? selectedEpoRoute;
  String? selectedIronRoute;
  String? selectedIronProtocol;
  String? isoFormattedStopDate;

  String? startTimeAndDate;

  List<CommonDropDownPostDialysisModel>? epoBrandList;
  List<CommonDropDownPostDialysisModel>? weekDaysList;
  List<CommonDropDownPostDialysisModel>? epoDoseList;
  List<CommonDropDownPostDialysisModel>? epoFreqList;
  List<CommonDropDownPostDialysisModel>? epoRouteList;
  List<CommonDropDownPostDialysisModel>? ironPrepList;
  List<CommonDropDownPostDialysisModel>? ironDoseList;
  List<CommonDropDownPostDialysisModel>? ironFreqList;
  List<CommonDropDownPostDialysisModel>? ironRouteList;
  List<CommonDropDownPostDialysisModel>? ironProtoColList;
  List<CommonDropDownPostDialysisModel>? getYesNoEpoList;
  List<CommonDropDownPostDialysisModel>? getYesNoIronList;
  List<CommonDropDownPostDialysisModel>? getYesNoBloodList;
  String? selectedEpoAdminDays;
  CommonDropDownPostDialysisModel? epoAdministeredId;
  CommonDropDownPostDialysisModel? ironSucroseId;
  CommonDropDownPostDialysisModel? bloodTransId;

  String? selectedIronAdminDays;

  Future<bool> searchByDropDownList() async {
    try {
      searchByModel = await _repository.searchByDropDownList();
      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting search By list');
    }
  }

  void calculateUFV() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double finalUfv = double.tryParse(finalUFVController.text) ?? 0;

    // --- New Logic to extract and parse the hour ---
    String durationString = durationController.text;
    double? duration;

    // Expecting format "HH:mm:ss"
    if (durationString.isNotEmpty && durationString.contains(':')) {
      try {
        // Split the string by ':'
        List<String> parts = durationString.split(':');
        // The first part is the hour (HH)
        if (parts.isNotEmpty) {
          duration = double.tryParse(parts[0]);
        }
      } catch (e) {
        // Handle parsing error if necessary
        duration = null;
      }
    }

    double finalUfvInML = finalUfv * 1000;

    // Correct formula
    double ufv = finalUfvInML / (duration! * weight);

    if (ufv.isFinite) {
      urfController.text = ufv.toStringAsFixed(2);
    } else {
      // Set to empty string for safety/clarity if calculation fails
      urfController.text = '';
    }
  }

  Future<bool> getValueToSetInHeprinUsedField(patientId, treatmentId) async {
    try {
      final value = await _repository.getValueToSetInHeprinUsedField(
          patientId, treatmentId);
      if (value == 'HFD') {
        heparinController.text = '0';
      }
      update();
      return true;
    } on ApiException catch (e) {
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting search By list');
    }
  }

  getPostDialysisList(String type, String input, unitId) async {
    isLoading = true;

    try {
      final data =
          await _repository.getPostDialysisList(type, input, unitId);
      isLoading = false;

      if (data['status'] == 'Success') {
        postDialysisListModel = PostDialysisListModel.fromJson(data);
        update();
      } else {
        isLoading = false;

        status = data['status'];
        postDialysisListModel = null;
        update();
      }
    } on ApiException {
      isLoading = false;
      postDialysisListModel = null;
      update();

      throw Exception('Failed search');
    }
    update();
  }

  saveEditPostDialysis() async {
    isLoading = true;
    update();

    try {
      final data = await _repository.saveEditPostDialysis(saveRequestModel);
      isLoading = false;
      isSaving = false;
      update();

      if (data['status'] == 'Success') {
        CustomPopup.showSuccessDialog(() {
          Get.off(const PostDialysisScreen());
        }, "Data Saved", "Data saved successfully");
      } else {
        isLoading = false;
        status = data['status'];
        CustomMessage.toast("Save Failed");
      }
    } on ApiException {
      isLoading = false;
      isSaving = false;
      update();
      throw Exception('Failed search');
    }
  }

  Future<void> getStartTime(String patientId, String treatmentId) async {
    startTimeAndDate =
        await _repository.getStartTime(patientId, treatmentId);
    if (startTimeAndDate == null) return;

    debugPrint(startTimeAndDate);

    List<String> parts = startTimeAndDate!.split("#");

    if (parts.length >= 5) {
      String timeStr = parts[3]; // "08:30:57"
      String dateStr = parts[4]; // "2025-08-04"

      try {
        // Combine date and time into one string
        String combined = "$dateStr $timeStr";

        DateTime parsedDateTime =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(combined);

        String formattedDate =
            DateFormat("dd/MM/yyyy").format(parsedDateTime);
        String formattedTime =
            DateFormat("HH:mm:ss").format(parsedDateTime); // 24-hour format

        startTime = formattedTime;

        // Assign to controllers
        startDateController.text = formattedDate;
        startTimeController.text = formattedTime;

        debugPrint("Formatted Date: $formattedDate");
        debugPrint("Formatted Time: $formattedTime");
      } catch (e) {
        debugPrint("Date parsing error: $e");
      }
    } else {
      debugPrint("Invalid format");
    }
  }

  Future<void> getStopDateAndTimeAndWeight(
      String patientId, String treatmentId) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.getStopDateAndTimeAndWeight(
          patientId, treatmentId);

      if (data != null) {
        if (data['status'] == 'Success') {
          startDateAndTime = StartDateAndTime.fromJson(data);
        } else {
          status = data['status'];
        }
      }
    } catch (e) {
      debugPrint('Exception: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void calculatePercentage(String partText, String totalController) {
    String actualFB = totalController.split('#').last;
    double? part = double.tryParse(partText);
    double? total = double.tryParse(actualFB);

    if (part == null || total == null) {
      debugPrint("Invalid Input");
      debugPrint("Please ensure both inputs are valid numbers.");
      return;
    }

    if (total == 0) {
      debugPrint("Total cannot be zero.");
      return;
    }

    if (part > total) {
      Get.defaultDialog(
        title: 'Invalid Input',
        middleText:
            'The actual fiber bundle value cannot be greater than the expected fiber bundle.',
        confirm: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text('OK'),
        ),
      );

      // Clear the input fields
      actualFiberController.clear();
      percentageFiberController.clear();
      return;
    }

    double percentage = (part / total) * 100;
    percentageFiberController.text =
        percentage.toStringAsFixed(2); // example of setting result
  }

  getCurrentWeight(String patientId, String treatmentId) async {
    isLoading = true;

    try {
      final data = await _repository.getCurrentWeight(patientId, treatmentId);
      isLoading = false;

      if (data['status'] == 'Success') {
        currentWeightModel = CurrentWeightModel.fromJson(data);
      } else {
        isLoading = false;

        status = data['status'];
      }
    } on ApiException catch (e) {
      isLoading = false;

      if (e.statusCode == 401) {
        status = "Something went wrong";
      } else {
        throw Exception('Failed search');
      }
    }
    update();
  }

  getEpoBrand(String shortCode) async {
    try {
      epoBrandList = await _repository.getDropdownList(shortCode);
      update();
    } on ApiException {
      throw Exception('Failed getting getEpoBrand');
    }
  }

  getWeekDays(String shortCode) async {
    try {
      weekDaysList = await _repository.getDropdownList(shortCode);
      update();
    } on ApiException {
      throw Exception('Failed getting getWeekDays');
    }
  }

  getEpoDose(String shortCode) async {
    try {
      epoDoseList = await _repository.getDropdownList(shortCode);
      update();
    } on ApiException {
      throw Exception('Failed getting getEpoDose');
    }
  }

  getEpoFrequency(String shortCode) async {
    try {
      epoFreqList = await _repository.getDropdownList(shortCode);
      update();
    } on ApiException {
      throw Exception('Failed getting getEpoFrequency');
    }
  }

  getEpoRoute(String shortCode) async {
    try {
      epoRouteList = await _repository.getDropdownList(shortCode);
      update();
    } on ApiException {
      throw Exception('Failed getting getEpoRoute');
    }
  }

  getIronPrep(String shortCode) async {
    try {
      ironPrepList = await _repository.getDropdownList(shortCode);
      update();
    } on ApiException {
      throw Exception('Failed getting getIronPrep');
    }
  }

  getIronDose(String shortCode) async {
    try {
      ironDoseList = await _repository.getDropdownList(shortCode);
      update();
    } on ApiException {
      throw Exception('Failed getting getIronDose');
    }
  }

  getIronFreq(String shortCode) async {
    try {
      ironFreqList = await _repository.getDropdownList(shortCode);
      update();
    } on ApiException {
      throw Exception('Failed getting getIronFreq');
    }
  }

  getIronRoute(String shortCode) async {
    try {
      ironRouteList = await _repository.getDropdownList(shortCode);
      update();
    } on ApiException {
      throw Exception('Failed getting getIronRoute');
    }
  }

  getIronProtocol(String shortCode) async {
    try {
      ironProtoColList = await _repository.getDropdownList(shortCode);
      update();
    } on ApiException {
      throw Exception('Failed getting getIronProtocol');
    }
  }

  getYesNoEpo(String shortCode) async {
    try {
      getYesNoEpoList = await _repository.getDropdownList(shortCode);
      final yesItem = getYesNoEpoList!.firstWhere(
        (e) => e.lookupDetDescEn.toLowerCase() == "no",
        orElse: () => getYesNoEpoList!.first,
      );

      epoAdministeredId = yesItem;
      update();
    } on ApiException {
      throw Exception('Failed getting getIronProtocol');
    }
  }

  getYesNoIron(String shortCode) async {
    try {
      getYesNoIronList = await _repository.getDropdownList(shortCode);

      final yesItem = getYesNoIronList!.firstWhere(
        (e) => e.lookupDetDescEn.toLowerCase() == "no",
        orElse: () => getYesNoIronList!.first,
      );

      ironSucroseId = yesItem;

      update();
    } on ApiException {
      throw Exception('Failed getting getIronProtocol');
    }
  }

  getYesNoBloodTrans(String shortCode) async {
    try {
      getYesNoBloodList = await _repository.getDropdownList(shortCode);

      final yesItem = getYesNoBloodList!.firstWhere(
        (e) => e.lookupDetDescEn.toLowerCase() == "no",
        orElse: () => getYesNoBloodList!.first,
      );

      bloodTransId = yesItem;

      update();
    } on ApiException {
      throw Exception('Failed getting getIronProtocol');
    }
  }

  refreshUi() {
    update();
  }

  bool isEpoYesSelected() {
    if (epoAdministeredId == null || getYesNoEpoList == null) return false;

    // Find the "Yes" option in the list
    final yesOption = getYesNoEpoList!.firstWhereOrNull(
        (item) => item.lookupDetDescEn.toLowerCase().contains('yes'));

    return yesOption != null &&
        epoAdministeredId?.lookupDetId == yesOption.lookupDetId;
  }

  // Helper method to check if "Yes" is selected for Iron
  bool isIronYesSelected() {
    if (ironSucroseId == null || getYesNoIronList == null) return false;

    final yesOption = getYesNoIronList!.firstWhereOrNull(
        (item) => item.lookupDetDescEn.toLowerCase().contains('yes'));

    return yesOption != null &&
        ironSucroseId?.lookupDetId == yesOption.lookupDetId;
  }

  // Helper method to check if "Yes" is selected for Blood Transfusion
  bool isBloodTransYesSelected() {
    if (bloodTransId == null || getYesNoBloodList == null) return false;

    final yesOption = getYesNoBloodList!.firstWhereOrNull(
        (item) => item.lookupDetDescEn.toLowerCase().contains('yes'));

    return yesOption != null &&
        bloodTransId?.lookupDetId == yesOption.lookupDetId;
  }
}
