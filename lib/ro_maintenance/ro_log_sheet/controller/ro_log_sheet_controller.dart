import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
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
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/repository/ro_log_sheet_repository.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/screen/ro_log_sheet_list.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/add_machine_issue_req_model/add_edit_machine_issue_log_req.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/problem_resolve/problem_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/problem_resolve/problem_resolved_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

class RoLogSheetController extends GetxController {
  final RoLogSheetRepository _repository = RoLogSheetRepository();

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

  InitialValueEditModel? initialValueEditModel;

  getRoMachineIssueLogAndSearchList(unitId, fromDate, toDate) async {
    isLoading = true;

    try {
      roLogSheetModel = await _repository
          .getRoMachineIssueLogAndSearchList(unitId, fromDate, toDate);
      isLoading = false;

      update();
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode == 401) {
        update();
      } else {
        throw Exception('Failed getting getRoMaintenanceDetAndSearchList');
      }
    }
  }

  Future<bool> deleteLogSheet(id, unitId) async {
    isLoading = true;

    try {
      final responseBody = await _repository.deleteLogSheet(id);
      isLoading = false;
      CustomMessage.toast(responseBody);
      update();

      getRoMachineIssueLogAndSearchList(unitId, '', '');

      return true;
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting captcha');
    }
  }

  Future<bool> getInitialValueForEdit(id) async {
    isLoading = true;

    try {
      initialValueEditModel = await _repository.getInitialValueForEdit(id);
      isLoading = false;
      return true;
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting captcha');
    }
  }

  getMachineList(unitId) async {
    isLoading = true;

    try {
      getMachineNameModel = await _repository.getMachineList(unitId);
      isLoading = false;
      return getMachineNameModel;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting getMachineNameList');
      }
    }

    update();
  }

  getSandPrePost() async {
    isLoading = true;

    try {
      sandFilterPrePostModel = await _repository.getSandPrePost();
      isLoading = false;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  getSoftnerAvailable() async {
    isLoading = true;

    try {
      softnerAvailableModel = await _repository.getSoftnerAvailable();
      isLoading = false;

      return instituteList;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  getRawWaterTds() async {
    isLoading = true;

    try {
      rawWaterTdsModel = await _repository.getRawWaterTds();
      isLoading = false;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  getRoWaterTds() async {
    isLoading = true;

    try {
      roWaterTdsModel = await _repository.getRoWaterTds();
      isLoading = false;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  getPostCarbonChloride() async {
    isLoading = true;

    try {
      postCarbonChloridModel = await _repository.getPostCarbonChloride();
      isLoading = false;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  getRoWaterConduct() async {
    isLoading = true;

    try {
      roWaterConductivityModel = await _repository.getRoWaterConduct();
      isLoading = false;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  getReturnLoopRange() async {
    isLoading = true;

    try {
      returnLoopRangeModel = await _repository.getReturnLoopRange();
      isLoading = false;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  getBeforeAfterHardness() async {
    isLoading = true;

    try {
      beforAfterHardnessModel = await _repository.getBeforeAfterHardness();
      isLoading = false;

      return instituteList;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  getBackwashRinse() async {
    isLoading = true;

    try {
      getBackWashAndRinseModel = await _repository.getBackwashRinse();
      isLoading = false;

      return instituteList;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }

  getDoneByList(unitId) async {
    isLoading = true;

    try {
      doneByModel = await _repository.getDoneByList(unitId);
      isLoading = false;
      return doneByModel;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting getMachineNameList');
      }
    }

    update();
  }

  addEditROLogSheet(isEdit) async {
    isLoading = true;
    update();

    try {
      final responseBody =
          await _repository.addEditROLogSheet(addRoLogSheetRequestModel);
      isLoading = false;
      debugPrint(responseBody);

      CustomMessage.toast(l10n.roSavedSuccessfully);
      Get.off(const RoLogSheetList());
    } on ApiException catch (e) {
      debugPrint(e.body);
      isLoading = false;
      CustomMessage.toast(l10n.roSaveFailed);
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

    try {
      instituteList = await _repository.getInstituteList();
      isLoading = false;
      return instituteList;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting InstituteList');
      }
    }

    update();
  }
}
