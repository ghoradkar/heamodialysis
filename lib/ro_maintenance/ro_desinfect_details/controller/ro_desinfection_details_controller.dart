import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/new_registration/model/institute/Institute_list.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/add_ro_disinfect_req_model/add_ro_disinfect_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/disinfect_type/disinfect_type_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_by_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/done_by_model/done_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/get_machine_name_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/ro_disinfection_doc.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/ro_maint_details/ro_maintenance_details_model.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/repository/ro_desinfection_details_repository.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screen/add_edit_ro_desinfec_details.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screen/ro_disinfection_details.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

class RoDesinfectionDetailsController extends GetxController {
  final RoDesinfectionDetailsRepository _repository =
      RoDesinfectionDetailsRepository();

  bool isLoading = false;
  RoMaintenanceDetailsModel? roMaintenanceDetailsModel;
  SearchRegisteredPatientModel? searchByModel;
  TextEditingController valueController = TextEditingController();
  TextEditingController inspectionDateController = TextEditingController();
  TextEditingController nextInspecDateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  InstituteDataModel? dropDownValue;

  // List<ProLi>? proList;
  InstituteList? instituteList;
  DisinfectTypeModel? disinfectTypeModel;
  GetMachineNameModel? getMachineNameModel;
  AddRoDisinfectModel? addRoDisinfectModel = AddRoDisinfectModel();
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

  getInstituteList() async {
    isLoading = true;
    update();

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

  Future<bool> deleteDesinfectionDet(id, unitId) async {
    isLoading = true;

    try {
      final responseBody = await _repository.deleteDesinfectionDet(id);
      isLoading = false;
      CustomMessage.toast(responseBody);
      update();

      getRoMaintenanceDetAndSearchList(unitId, "");

      return true;
    } on ApiException {
      isLoading = false;
      update();
      throw Exception('Failed getting captcha');
    }
  }

  addEditRoDisinfectDetails() async {
    String? insD = addRoDisinfectModel?.inspectionDate?.replaceAll("/", "-");
    String? nextInsD =
        addRoDisinfectModel?.nextInspectionDate?.replaceAll("/", "-");
    isLoading = true;
    update();

    try {
      List<String?> selectedDocIds =
          uploadImage.where((e) => e.isSelected).map((e) => e.ids).toList();
      List<String?> enteredDocName =
          uploadImage.where((e) => e.isSelected).map((e) => e.docName).toList();

      String docIdString = selectedDocIds.whereType<String>().join(',');
      String docNameString = enteredDocName.whereType<String>().join(',');

      final finalResp = await _repository.addEditRoDisinfectDetails(
        data: {
          "roDisinfectionDetailsId": addRoDisinfectModel?.roDisinfectionDetailsId,
          "roMachineMasterId": addRoDisinfectModel?.roMachineMasterId,
          "lookupDetId": addRoDisinfectModel?.lookupDetId,
          "nextInspectionDate": nextInsD,
          "comments": addRoDisinfectModel?.comments,
          "doneBy": addRoDisinfectModel?.doneBy,
          "inspectionDate": insD,
          "createdBy": addRoDisinfectModel?.createdBy ?? 1,
          "unitId": addRoDisinfectModel?.unitId
        },
        docIdString: docIdString,
        docNameString: docNameString,
        selectedFiles: uploadImage.where((e) => e.isSelected).toList(),
      );

      if (finalResp.statusCode == 200) {
        var data = jsonDecode(finalResp.body);

        if (data['status'] == "Success") {
          isLoading = false;

          CustomMessage.toast(l10n.roSavedSuccessfully);
          initialInsti = null;
          uploadImage.clear();

          initialMachine = null;
          initialDisinfect = null;
          initialDoneBy = null;
          nextInspecDateController.text = "";
          inspectionDateController.text = "";
          commentController.text = "";
          Get.off(const RoDisinfectionDetails());
        } else {
          isLoading = false;
          update();
          CustomMessage.toast(l10n.regUploadFailed);
        }
      } else {
        isLoading = false;
        update();
        CustomMessage.toast(l10n.regUploadFailed);
      }
    } catch (error) {
      isLoading = false;
      debugPrint(error.toString());
    }
    update();
  }

  getDisinfecUsed() async {
    isLoading = true;

    try {
      disinfectTypeModel = await _repository.getDisinfecUsed();
      isLoading = false;

      return instituteList;
    } on ApiException catch (e) {
      isLoading = false;
      if (e.statusCode != 401) {
        throw Exception('Failed getting getDisinfectionDet');
      }
    }

    update();
  }

  getRODisinfectionDoc(roMachineId) async {
    isLoading = true;

    try {
      roDisinfecDocList = await _repository.getRODisinfectionDoc(roMachineId);
      isLoading = false;

      if (roDisinfecDocList.isNotEmpty) {
        RoDisinfectionDoc? file = (roDisinfecDocList.length == 1
            ? roDisinfecDocList.first
            : roDisinfecDocList.last);

        uploadImage[0].isSelected = true;
        uploadImage[0].isView = true;
        uploadImage[0].ids = file.roDisId.toString();
        uploadImage[0].file = File(ApiConstants.imageBaseUrl1 + file.docpath!);
      }
    } on ApiException catch (e) {
      isLoading = false;
      debugPrint(e.body);
    }
    update();
  }

  getRoMaintenanceDetAndSearchList(unitId, machineName) async {
    isLoading = true;
    update();

    try {
      roMaintenanceDetailsModel = await _repository
          .getRoMaintenanceDetAndSearchList(unitId, machineName);
      isLoading = false;

      update();
    } on ApiException catch (e) {
      isLoading = false;
      update();
      if (e.statusCode != 401) {
        throw Exception('Failed getting getRoMaintenanceDetAndSearchList');
      }
    }
  }
}
