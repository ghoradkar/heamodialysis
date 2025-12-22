import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/GetRoDetById.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/daily_ro_log_sheet_save_model.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/daily_ro_logsheet_model.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/screens/add_edit_daily_ro_logsheet.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/screens/daily_ro_logsheet_list.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_type_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_by_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/get_machine_name_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/ro_disinfection_doc.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screens/add_edit_ro_desinfec_details.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

// import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class DailyRoLogSheetController extends GetxController {
  bool isLoading = false;
  List<DailyRoLogSheetModel>? roMaintenanceDetailsModel;
  List<GetRoDetById>? roDet;
  SearchRegisteredPatientModel? searchByModel;
  TextEditingController valueController = TextEditingController();
  TextEditingController inspectionDateController = TextEditingController();
  TextEditingController nextInspecDateController = TextEditingController();
  TextEditingController rawWaterTDS = TextEditingController();
  TextEditingController postSoftnerTDS = TextEditingController();
  TextEditingController postMembraneTDS = TextEditingController();
  TextEditingController postMixbedTDS = TextEditingController();
  TextEditingController loopLineTDS = TextEditingController();
  TextEditingController postSoftnerHardness = TextEditingController();
  TextEditingController carbonChlorine = TextEditingController();
  TextEditingController rejectFlow = TextEditingController();
  TextEditingController productPermeateFlow = TextEditingController();

  InstituteDataModel? dropDownValue;
  List<RadioDet>? backwashDone = [
    RadioDet(
      "Yes",
      "1",
    ),
    RadioDet(
      "No",
      "2",
    )
  ];
  RadioDet? selectedbackWash;

  List<RadioDet>? rinseDone = [
    RadioDet(
      "Yes",
      "1",
    ),
    RadioDet(
      "No",
      "2",
    )
  ];
  RadioDet? selectedRinseWash;

  // List<ProLi>? proList;
  InstituteList? instituteList;
  DisinfectTypeModel? disinfectTypeModel;
  GetMachineNameModel? getMachineNameModel;
  DailyRoLogSheetSaveModel? addDailyRoLogSheetModel =
      DailyRoLogSheetSaveModel();
  DoneByModel? doneByModel;
  InstituteDataModel? selectedInsti;
  String? initialInsti;

  MachineData? selectedMachine;
  String? initialMachine;
  DoneByData? selectedDoneBy;
  String? initialDoneBy;
  DisinfectData? selectedDisinfect;
  String? initialDisinfect;

  List<ROFileDetails> uploadImage = [];

  // ROFileDetails(
  // name: 'Image Upload', key: 'files', isSelected: false, isReq: false)

  IOClient ioClient = IOClient(ByPassCert().httpClient);

  List<RoDisinfectionDoc> roDisinfecDocList = [];

  addEditDailyRoLogSheet() async {
    // String? insD = addDailyRoLogSheetModel?.inspectionDate?.replaceAll("/", "-");
    // String? nextInsD =
    //     addDailyRoLogSheetModel?.nextInspectionDate?.replaceAll("/", "-");
    isLoading = true;
    update();

    try {
      Uri uri = Uri.parse(ApiConstants.baseUrl + ApiNames.saveLogSheet);

      var body = json.encode(addDailyRoLogSheetModel);

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      final response = await ioClient.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body); // Use the response body here

        if (data == 1 || data == 2) {
          isLoading = false;
          update();
          rawWaterTDS.text = "";
          postSoftnerTDS.text = "";
          postMembraneTDS.text = "";
          postMixbedTDS.text = "";
          loopLineTDS.text = "";
          postSoftnerHardness.text = "";
          carbonChlorine.text = "";
          rejectFlow.text = "";
          productPermeateFlow.text = "";
          debugPrint(response.body);

          CustomMessage.toast("Saved Successfully");

          Get.off(const DailyRoLogSheetScreen());
        }
      } else {
        isLoading = false;
        update();
        CustomMessage.toast('Saved Failed');
      }
    } catch (error) {
      isLoading = false;
      debugPrint(error.toString());
    }
    update();
  }

  getInstituteList() async {
    isLoading = true;
    update();

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
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      instituteList = InstituteList.fromJson(data);
    } else {
      isLoading = false;

      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getDailyRoLogSheetAndSearchList(String date, String unitId) async {
    isLoading = true;
    update();
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getRoAllData}?date=$date&unitId=$unitId");

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
      List<dynamic> data = json.decode(response.body);

      roMaintenanceDetailsModel =
          data.map((json) => DailyRoLogSheetModel.fromJson(json)).toList();
      isLoading = false;

      update();
    } else {
      isLoading = false;

      debugPrint('failed getDailyRoLogSheetAndSearchList');
    }
  }

  getRoById(int id) async {
    isLoading = true;
    update();
    final uri =
        Uri.parse("${ApiConstants.baseUrl}${ApiNames.getRoAllDataById}?id=$id");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);

    final response = await ioClient.get(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      roDet = data.map((json) => GetRoDetById.fromJson(json)).toList();
      isLoading = false;

      update();
    } else {
      isLoading = false;

      debugPrint('failed getRoById');
    }
  }
}
