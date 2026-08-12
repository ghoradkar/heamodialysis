import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/book_appointment/model/bedAvailable/bed_available_model.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/registered_patient_list/screens/registered_patient_list.dart';
import 'package:heamodialysis/schedular/schedular_controller/schedular_controller.dart';
import 'package:heamodialysis/schedular/screens/schedular_list.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';

// import 'package:http/http.dart' as http;

import '../model/slot/slot_list_model.dart';

class BookAppointmentController extends GetxController {
  bool isLoading = false;
  String? selectInstitute;
  String? selectedDateSendReq;

  SlotListModel? slotListModel;
  BedAvailableModel? bedAvailableModel;
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  Future<bool> getSlotList(unitId, pId, date) async {
    isLoading = true;
    update();

    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    String formattedDate =
        DateFormat("dd-MMM-yyyy").format(parsedDate).toUpperCase();

    final uri = Uri.parse(ApiConstants.oldBaseUrl + ApiNames.getSlotList);

    final Map<String, dynamic> body = {
      "unitId": unitId,
      "pId": pId,
      "date": formattedDate
    };

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
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      slotListModel = SlotListModel.fromJson(data);
      update();

      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;
      update();

      return false;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting id proof');
    }
  }

  getBedList(unitId, slotId, date, patientId) async {
    isLoading = true;
    update();

    final uri =
        Uri.parse(ApiConstants.oldBaseUrl + ApiNames.getAvailableBedList);

    final Map<String, dynamic> body = {
      "unitId": unitId,
      "slotId": slotId,
      "date": date,
      "patientId": patientId,
      "slotFlag": "Y"
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // print(body);
    debugPrint("map : $jsonbody");

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(response.body);
      bedAvailableModel = BedAvailableModel.fromJson(data);
      update();
    } else {
      isLoading = false;

      debugPrint('Failed getting id proof');
      update();
    }
  }

  Future<bool> bookAppointment(unitId, slotId, date, slotMapDetId, patientId,
      treatId, userId, isFromSchedular,
      {SchedularController? schedularController,
      String? visiteDate,
      PatientData? patientData,
      bool? iron,
      bool? epo}) async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.bookBedApi);

    final Map<String, dynamic> body = {
      "unitId": unitId,
      "slotMapDetId": slotMapDetId,
      "date": date,
      "pId": patientId,
      "userId": userId,
      "tId": treatId
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(jsonbody);

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      final data = json.decode(response.body);
      CustomMessage.toast(data['status']);
      if (isFromSchedular) {
        await schedularController!.updateVisitorEntry(
            patientData,
            schedularController.selectedSchemeObj?.lookupDetId,
            schedularController.caseNumber.text,
            schedularController.claimNumber.text,
            schedularController.ipNumber.text,
            schedularController.enrollNo.text,
            schedularController.preAuthApprovalDateController.text,
            schedularController.visitorTime,
            visiteDate,
            userId,
            unitId.toString(),
            schedularController.fromDateController.text,
            schedularController.toDateController.text,
            iron,
            epo);

        Get.to((const SchedularListScreen()));
      } else {
        Get.to((const RegisteredPatientList()));
      }
      update();

      return true;
    } else if (response.statusCode == 401) {
      isLoading = false;
      CustomMessage.toast("Booked fail");

      update();

      return false;
    } else {
      isLoading = false;
      CustomMessage.toast("Booked fail");

      update();

      throw Exception('Failed Booking');
    }
  }
}
