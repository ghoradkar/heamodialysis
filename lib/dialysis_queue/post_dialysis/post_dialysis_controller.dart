import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/common_dropdown_post_dialysis_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/current_weight_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/patient_details_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/save_request_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/start_date_and_time.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/post_dialysis_list_model.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/post_dialysis_screen.dart';
import 'package:heamodialysis/nephro_desk_patient_list/screen/edit_nephro/tabs/choose_package.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';

class PostDialysisController extends GetxController {
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
  IOClient ioClient = IOClient(ByPassCert().httpClient);
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
    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.searchByDropDownListApi);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      searchByModel = SearchRegisteredPatientModel.fromJson(data);

      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
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

    // if (weight != null &&
    //     finalUfv != null &&
    //     duration != null &&
    //     duration > 0) {
    double finalUfvInML = finalUfv * 1000;

    // Correct formula
    double ufv = finalUfvInML / (duration! * weight);

    if (ufv.isFinite) {
      urfController.text = ufv.toStringAsFixed(2);
    } else {
      // Set to empty string for safety/clarity if calculation fails
      urfController.text = '';
    }
    // }
  }

  // void calculateUFV() {
  //   double? weight = double.tryParse(weightController.text);
  //   double? finalUfv = double.tryParse(finalUFVController.text);
  //   double? duration = double.tryParse(durationController.text);
  //
  //   if (weight != null && finalUfv != null && duration != null && duration > 0) {
  //     double finalUfvInML = finalUfv * 1000;
  //
  //     // Correct formula
  //     double ufv = finalUfvInML / (duration * weight);
  //
  //     if (ufv.isFinite) {
  //       urfController.text = ufv.toStringAsFixed(2);
  //     } else {
  //       urfController.text = '';
  //     }
  //   } else {
  //     urfController.text = '';
  //     urfController.text = '';
  //   }
  // }

  Future<bool> getValueToSetInHeprinUsedField(patientId, treatmentId) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getSpecialDialysis}?patientId=$patientId&treatmentId=$treatmentId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      var value = response.body;
      if (value == 'HFD') {
        heparinController.text = '0';
      }
      update();
      return true;
    } else if (response.statusCode == 401) {
      update();

      return false;
    } else {
      throw Exception('Failed getting search By list');
    }
  }

  getPostDialysisList(String type, String input, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        // ApiConstants.oldBaseUrl + ApiConstants.getPostDiaList
        ApiConstants.baseUrl + ApiNames.getPostDiaList);

    final Map<String, dynamic> body = {
      "unitId": unitId,
      "type": type,
      "input2": 0,
      "category": ""
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      if (data['status'] == 'Success') {
        postDialysisListModel = PostDialysisListModel.fromJson(data);
        update();
      } else {
        isLoading = false;

        status = data['status'];
        postDialysisListModel = null;
        update();
      }
    } else {
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
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.savePostDai);

    String jsonbody = json.encode(saveRequestModel);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint("Full URL: $uri");

    // Full JSON body — chunked to avoid debugPrint truncation
    debugPrint("===== API REQUEST BODY START =====");
    const int chunkSize = 800;
    for (int i = 0; i < jsonbody.length; i += chunkSize) {
      debugPrint(jsonbody.substring(i,
          i + chunkSize > jsonbody.length ? jsonbody.length : i + chunkSize));
    }
    debugPrint("===== API REQUEST BODY END =====");

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      isSaving = false;
      update();
      //getDeviceDetails
      final data = json.decode(response.body);
      if (data['status'] == 'Success') {
        CustomPopup.showSuccessDialog(() {
          Get.off(const PostDialysisScreen());
        }, "Data Saved", "Data saved successfully");
      } else {
        isLoading = false;
        status = data['status'];
        CustomMessage.toast("Save Failed");
      }
    } else {
      isLoading = false;
      isSaving = false;
      update();
      throw Exception('Failed search');
    }
  }

  Future<void> getStartTime(String patientId, String treatmentId) async {
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}${ApiNames.getPostFlag}?patientId=$patientId&treatmentId=$treatmentId",
    );

    var request = http.Request('POST', uri);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      startTimeAndDate = await response.stream.bytesToString();
      debugPrint(startTimeAndDate);

      if (startTimeAndDate != null) {
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
    } else {
      debugPrint(response.reasonPhrase);
    }
  }

  Future<void> getStopDateAndTimeAndWeight(
      String patientId, String treatmentId) async {
    isLoading = true;
    update();

    var url = Uri.parse('${ApiConstants.baseUrl}${ApiNames.getPostFlag}');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = json.encode({
      "patientId": patientId,
      "treatmentId": treatmentId,
    });

    var request = http.Request('GET', url);
    request.headers.addAll(headers);
    request.body = body;

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final data = json.decode(responseString);

        if (data['status'] == 'Success') {
          startDateAndTime = StartDateAndTime.fromJson(data);
        } else {
          status = data['status'];
        }
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.reasonPhrase}');
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
      // Get.defaultDialog(
      //   title: 'Invalid Input',
      //   middleText: 'Please ensure both inputs are valid numbers.',
      //   confirm: ElevatedButton(
      //     onPressed: () => Get.back(),
      //     child: const Text('OK'),
      //   ),
      // );
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
    final uri = Uri.parse(
        // ApiConstants.baseUrl + ApiConstants.searchRegisteredPatientApi
        ApiConstants.baseUrl + ApiNames.getPreWeight);

    final Map<String, dynamic> body = {
      "patientId": patientId,
      "treatmentId": treatmentId
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      //getDeviceDetails
      final data = json.decode(response.body);
      if (data['status'] == 'Success') {
        currentWeightModel = CurrentWeightModel.fromJson(data);
      } else {
        isLoading = false;

        status = data['status'];
      }
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getEpoBrand(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      epoBrandList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      update();
    } else {
      throw Exception('Failed getting getEpoBrand');
    }
  }

  getWeekDays(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      weekDaysList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      update();
    } else {
      throw Exception('Failed getting getWeekDays');
    }
  }

  getEpoDose(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      epoDoseList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      update();
    } else {
      throw Exception('Failed getting getEpoDose');
    }
  }

  getEpoFrequency(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      epoFreqList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      update();
    } else {
      throw Exception('Failed getting getEpoFrequency');
    }
  }

  getEpoRoute(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      epoRouteList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      update();
    } else {
      throw Exception('Failed getting getEpoRoute');
    }
  }

  getIronPrep(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      ironPrepList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      update();
    } else {
      throw Exception('Failed getting getIronPrep');
    }
  }

  getIronDose(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      ironDoseList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      update();
    } else {
      throw Exception('Failed getting getIronDose');
    }
  }

  getIronFreq(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      ironFreqList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      update();
    } else {
      throw Exception('Failed getting getIronFreq');
    }
  }

  getIronRoute(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      ironRouteList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      update();
    } else {
      throw Exception('Failed getting getIronRoute');
    }
  }

  getIronProtocol(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      ironProtoColList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      update();
    } else {
      throw Exception('Failed getting getIronProtocol');
    }
  }

  getYesNoEpo(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      getYesNoEpoList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();
      final yesItem = getYesNoEpoList!.firstWhere(
        (e) => e.lookupDetDescEn.toLowerCase() == "no",
        orElse: () => getYesNoEpoList!.first,
      );

      epoAdministeredId = yesItem;
      update();
    } else {
      throw Exception('Failed getting getIronProtocol');
    }
  }

  getYesNoIron(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      getYesNoIronList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      final yesItem = getYesNoIronList!.firstWhere(
        (e) => e.lookupDetDescEn.toLowerCase() == "no",
        orElse: () => getYesNoIronList!.first,
      );

      ironSucroseId = yesItem;

      update();
    } else {
      throw Exception('Failed getting getIronProtocol');
    }
  }

  getYesNoBloodTrans(String shortCode) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl + ApiNames.getPostDropdownList}?shortCode=$shortCode");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      getYesNoBloodList = jsonData
          .map((item) => CommonDropDownPostDialysisModel.fromJson(item))
          .toList();

      final yesItem = getYesNoBloodList!.firstWhere(
        (e) => e.lookupDetDescEn.toLowerCase() == "no",
        orElse: () => getYesNoBloodList!.first,
      );

      bloodTransId = yesItem;

      update();
    } else {
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
