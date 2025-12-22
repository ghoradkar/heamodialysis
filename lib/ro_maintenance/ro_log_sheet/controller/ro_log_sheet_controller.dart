import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_by_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/get_machine_name_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/add_ro_log_sheet_request_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/befor_after_hardness_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/get_back_wash_and_rinse_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/initial_value_edit_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/post_carbon_chlorid_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/raw_water_tds_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/return_loop_range_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/ro_log_sheet_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/ro_water_conductivity_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/ro_water_tds_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/sand_filter_pre_post_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/model/softner_available_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/screens/ro_log_sheet_list.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/add_machine_issue_req_model/add_edit_machine_issue_log_req.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/problem_resolve/problem_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/problem_resolve/problem_resolved_model.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:http/io_client.dart';

class RoLogSheetController extends GetxController {
  bool isLoading = false;
  InstituteDataModel? dropDownValue;


  String? selectedRange;
  String? selectedRange2;
  String? selectedRange3;
  String? selectedRange4;
  String? selectedRange5;
  String? selectedRange6;
  String? errorMessage;
  String? errorMessage1;
  String? errorMessage3;
  String? errorMessage4;
  String? errorMessage5;
  String? errorMessage6;

  InstituteList? instituteList;
  AddRoLogSheetRequestModel addRoLogSheetRequestModel =
      AddRoLogSheetRequestModel();
  SandFilterPrePostModel? sandFilterPrePostModel;
  SoftnerAvailableModel? softnerAvailableModel;
  RawWaterTdsModel? rawWaterTdsModel;
  RoWaterConductivityModel? roWaterConductivityModel;
  ReturnLoopRangeModel? returnLoopRangeModel;
  RoWaterTdsModel? roWaterTdsModel;
  PostCarbonChloridModel? postCarbonChloridModel;
  BeforAfterHardnessModel? beforAfterHardnessModel;
  GetBackWashAndRinseModel? getBackWashAndRinseModel;

  TextEditingController valueController = TextEditingController();
  AddEditMachineIssueLogReq? addEditMachineIssueLogReq =
      AddEditMachineIssueLogReq();

  RoLogSheetModel? roLogSheetModel;

  GetMachineNameModel? getMachineNameModel;
  ProblemResolvedModel? problemResolvedModel;
  InstituteDataModel? selectedInsti;

  String? initialInsti;

  MachineData? selectedMachine;
  String? initialMachine;
  String? initialProblemSolved;
  ProblemData? selectedProblem;

  TextEditingController fromDateController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  // TextEditingController instituteName = TextEditingController();
  TextEditingController difference = TextEditingController();

  // TextEditingController differenceCarbon = TextEditingController();
  TextEditingController value = TextEditingController();
  TextEditingController value1 = TextEditingController();
  TextEditingController preMembranePressure = TextEditingController();
  TextEditingController difference1 = TextEditingController();
  TextEditingController lph = TextEditingController();
  TextEditingController rejectedPressure = TextEditingController();

  // TextEditingController differenceSoftner = TextEditingController();
  // TextEditingController timeController = TextEditingController();
  TextEditingController commentsHardnessSotnerController =
      TextEditingController();
  TextEditingController commentsReturnLoopController = TextEditingController();
  TextEditingController commentsCarbonChlorideController =
      TextEditingController();
  TextEditingController commentsRoWaterController = TextEditingController();
  TextEditingController valuePsiController = TextEditingController();
  TextEditingController rejectedFlow = TextEditingController();
  TextEditingController commentsCarbonChlorideController1 =
      TextEditingController();
  TextEditingController commentsAfterRegiHardnessController =
      TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController softnerCommentsController = TextEditingController();

  bool rwpFirstCheckBox = false;
  bool rwpSecondCheckBox = false;

  bool hppFirstCheckBox = false;
  bool hppSecondCheckBox = false;

  bool tpFirstCheckBox = false;
  bool tpSecondCheckBox = false;

  bool uvLampFirstCheckBox = false;
  bool uvLampSecondCheckBox = false;

  DoneByModel? doneByModel;
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  InitialValueEditModel? initialValueEditModel;

  getRoMachineIssueLogAndSearchList(unitId, fromDate, toDate) async {
    isLoading = true;

    final uri = Uri.parse(
        ApiConstants.baseUrl + ApiNames.getallROMachineLogSheetBySearch);
    var body = {"unitId": unitId, "fromDate": fromDate, "toDate": toDate};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      roLogSheetModel = RoLogSheetModel.fromJson(data);
      isLoading = false;

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      update();
    } else {
      isLoading = false;

      throw Exception('Failed getting getRoMaintenanceDetAndSearchList');
    }
  }

  Future<bool> deleteLogSheet(id, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.roMachineLogSheetDelete}?id=$id");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      // final data = json.decode(response.body);
      CustomMessage.toast(response.body);
      update();

      getRoMachineIssueLogAndSearchList(unitId,'','');

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  Future<bool> getInitialValueForEdit(id) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getROMachineLogNewById}?machId=$id");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      initialValueEditModel = InitialValueEditModel.fromJson(data);

      return true;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting captcha');
    }
  }

  getMachineList(unitId) async {
    isLoading = true;

    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.getMachineNameList);
    var body = {"unitId": unitId};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      getMachineNameModel = GetMachineNameModel.fromJson(data);
      isLoading = false;

      return getMachineNameModel;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getMachineNameList');
    }

    update();
  }

  getSandPrePost() async {
    isLoading = true;

    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.getSandFilterPrePost);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      sandFilterPrePostModel = SandFilterPrePostModel.fromJson(data);
      isLoading = false;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getSoftnerAvailable() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getSoftnerAvl);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      softnerAvailableModel = SoftnerAvailableModel.fromJson(data);
      isLoading = false;

      return instituteList;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getRawWaterTds() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getRawWaterTDS);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      rawWaterTdsModel = RawWaterTdsModel.fromJson(data);
      isLoading = false;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getRoWaterTds() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getROWaterTDS);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      roWaterTdsModel = RoWaterTdsModel.fromJson(data);
      isLoading = false;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getPostCarbonChloride() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getPostCarbonCl);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      postCarbonChloridModel = PostCarbonChloridModel.fromJson(data);
      isLoading = false;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getRoWaterConduct() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getROWaterCond);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      roWaterConductivityModel = RoWaterConductivityModel.fromJson(data);
      isLoading = false;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getReturnLoopRange() async {
    isLoading = true;

    final uri =
        Uri.parse(ApiConstants.oldBaseUrl + ApiNames.getReturnLoopP);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      returnLoopRangeModel = ReturnLoopRangeModel.fromJson(data);
      isLoading = false;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getBeforeAfterHardness() async {
    isLoading = true;

    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.getBeforeAfterRegHard);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      beforAfterHardnessModel = BeforAfterHardnessModel.fromJson(data);
      isLoading = false;

      return instituteList;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getBackwashRinse() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getBackWashRinse);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      getBackWashAndRinseModel = GetBackWashAndRinseModel.fromJson(data);
      isLoading = false;

      return instituteList;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getDoneByList(unitId) async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getUsersByUnit);
    var body = {"unitId": unitId};
    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      doneByModel = DoneByModel.fromJson(data);
      isLoading = false;

      return doneByModel;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getMachineNameList');
    }

    update();
  }

  addEditROLogSheet(isEdit) async {
    isLoading = true;
    update();
    var headers = {'Content-Type': 'application/json'};

    var response = await ioClient.post(
        Uri.parse(ApiConstants.oldBaseUrl + ApiNames.saveMachineLogsNew),
        body: json.encode(addRoLogSheetRequestModel),
        headers: headers);
    if (response.statusCode == 200) {
      isLoading = false;
      debugPrint(response.body);

      CustomMessage.toast("Saved Successfully");
      Get.off(const RoLogSheetList());
    } else {
      debugPrint(response.reasonPhrase);
      isLoading = false;
      CustomMessage.toast("Save Fail");
    }
    update();
  }

  void setFieldsBlank() {
    dateController.text = "";
    difference.text = "";
    commentsHardnessSotnerController.text = '';
    commentsAfterRegiHardnessController.text = '';
    commentsCarbonChlorideController.text = '';
    commentsRoWaterController.text = '';
    commentsReturnLoopController.text = '';
    valuePsiController.text = '';
    value.text = "";
    value1.text = '';
    difference1.text = "";
    preMembranePressure.text = '';
    rejectedPressure.text = '';
    rejectedFlow.text = '';
    lph.text = '';
    rwpFirstCheckBox = false;
    rwpSecondCheckBox = false;

    hppFirstCheckBox = false;
    hppSecondCheckBox = false;

    tpFirstCheckBox = false;
    tpSecondCheckBox = false;

    uvLampFirstCheckBox = false;
    uvLampSecondCheckBox = false;
  }

  getInstituteList() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getInstituteList);

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      //getDeviceDetails
      final data = json.decode(response.body);
      instituteList = InstituteList.fromJson(data);
      isLoading = false;

      return instituteList;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }
//
// getProblemResolvedList(unitId) async {
//   isLoading = true;
//
//   final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getProbResolved);
//   var body = {"unitId": unitId};
//   String jsonbody = json.encode(body);
//   Map<String, String> headers = {
//     "Content-Type": "application/json",
//   };
//
//   debugPrint(uri.path);
//   // print(body);
//
//   final response = await http.post(uri, headers: headers, body: jsonbody);
//   debugPrint(response.statusCode.toString());
//   debugPrint("response.body : ${response.body}");
//
//   if (response.statusCode == 200) {
//     //getDeviceDetails
//     final data = json.decode(response.body);
//     problemResolvedModel = ProblemResolvedModel.fromJson(data);
//     isLoading = false;
//
//     return getMachineNameModel;
//   } else if (response.statusCode == 401) {
//     isLoading = false;
//   } else {
//     isLoading = false;
//
//     throw Exception('Failed getting getMachineNameList');
//   }
//
//   update();
// }
}
