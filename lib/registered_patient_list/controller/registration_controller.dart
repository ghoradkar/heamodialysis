import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/already_registered_patient.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_dropdown_list_model.dart';
import 'package:heamodialysis/registered_patient_list/repository/registration_repository.dart';
import 'package:heamodialysis/utils/api_client.dart';

class RegistrationController extends GetxController {
  final RegistrationRepository _repository = RegistrationRepository();

  String? msg;

  String? status;

  String? scrutinyType;

  String? approvalStat;

  AlreadyRegisteredPatient? alreadyRegisteredPatient;

  SearchRegisteredPatientModel? searchByModel;

  AlreadyRegisteredPatient? searchedPatientResultModel;
  TextEditingController valueController = TextEditingController();

  bool isLoading = false;

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

  checkScrutinyApproval(patientId) async {
    isLoading = true;
    update();

    try {
      final data = await _repository.checkScrutinyApproval(patientId);
      scrutinyType = data['UserType'];
      approvalStat = data['ApprovalStatus'];
    } catch (e) {
      debugPrint("Error in checkScrutinyApproval: $e");
      rethrow;
    } finally {
      isLoading = false;
      update();
    }
  }


  searchRegisteredPatient(String type, String input, unitId, String sId) async {
    isLoading = true;
    update();

    try {
      final data =
          await _repository.searchRegisteredPatient(type, input, unitId, sId);
      valueController.text = "";
      if (data['status'] == 'Success') {
        alreadyRegisteredPatient = AlreadyRegisteredPatient.fromJson(data);
        print("response of registered user : ${alreadyRegisteredPatient!.data!.length}");
        print("response of registered user : ${data}");
        print("response of registered user : ${alreadyRegisteredPatient!.data![0].patientId}");
      } else {
        status = data['status'];
      }
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        status = "Something went wrong";
      } else {
        debugPrint("Error in searchRegisteredPatient: $e");
        rethrow;
      }
    } catch (e) {
      debugPrint("Error in searchRegisteredPatient: $e");
      rethrow;
    } finally {
      isLoading = false;
      update();
    }
  }

  refreshUi() {
    update();
  }
}
