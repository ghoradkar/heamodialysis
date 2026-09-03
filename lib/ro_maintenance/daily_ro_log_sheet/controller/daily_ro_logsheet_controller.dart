import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/GetRoDetById.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/daily_ro_log_sheet_save_model.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/model/daily_ro_logsheet_model.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/repository/daily_ro_logsheet_repository.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/screen/add_edit_daily_ro_logsheet.dart';
import 'package:heamodialysis/ro_maintenance/daily_ro_log_sheet/screen/daily_ro_logsheet_list.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_type_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_by_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/get_machine_name_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/ro_disinfection_doc.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screen/add_edit_ro_desinfec_details.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

class DailyRoLogSheetController extends GetxController {
  final DailyRoLogSheetRepository _repository = DailyRoLogSheetRepository();

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

  List<RoDisinfectionDoc> roDisinfecDocList = [];

  addEditDailyRoLogSheet() async {
    isLoading = true;
    update();

    try {
      final data =
          await _repository.addEditDailyRoLogSheet(addDailyRoLogSheetModel);

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

        CustomMessage.toast("Saved Successfully");

        Get.off(const DailyRoLogSheetScreen());
      }
    } on ApiException {
      isLoading = false;
      update();
      CustomMessage.toast('Saved Failed');
    } catch (error) {
      isLoading = false;
      debugPrint(error.toString());
    }
    update();
  }

  getInstituteList() async {
    isLoading = true;
    update();

    try {
      instituteList = await _repository.getInstituteList();
      isLoading = false;
    } on ApiException {
      isLoading = false;
      throw Exception('Failed getting InstituteList');
    }

    update();
  }

  getDailyRoLogSheetAndSearchList(String date, String unitId) async {
    isLoading = true;
    update();

    try {
      roMaintenanceDetailsModel = await _repository
          .getDailyRoLogSheetAndSearchList(date, unitId);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      debugPrint('failed getDailyRoLogSheetAndSearchList');
    }
  }

  getRoById(int id) async {
    isLoading = true;
    update();

    try {
      roDet = await _repository.getRoById(id);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
      debugPrint('failed getRoById');
    }
  }
}
