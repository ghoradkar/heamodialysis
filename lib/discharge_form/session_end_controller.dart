import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/discharge_form/session_end_list.dart';
import 'package:heamodialysis/discharge_form/model/checkbox_flag_discharge.dart';
import 'package:heamodialysis/discharge_form/model/discharge_list.dart';
import 'package:heamodialysis/discharge_form/model/discharge_patient_details.dart';
import 'package:heamodialysis/nephro_desk_patient_list/edit_nephro/tabs/choose_package.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SessionEndController extends GetxController {
  bool isLoading = true;
  List<String> typeList = [];

  // 🔹 Selected Type
  String? selectedType;

  // 🔹 Approval Status list
  List<String> approvalStatusList = ['Approved', 'Pending', 'Rejected'];

  // 🔹 Selected Approval Status
  String? selectedApprovalStatus;
  // 🔹 Loader
  bool isLoadingType = false;

  IOClient ioClient = IOClient(ByPassCert().httpClient);
  var pageSize = 10;

  // late PagingController<int, DischargeListModel> pagingController;
  bool hasInternet = true;

  List<DischargeListModel> dischargeList = [];
  DischargePatientDetails? dischargePatientDet;
  CheckBoxFlagDischarge? dischargeFlag;

  String dischargeFlagString = '';

  CheckBoxList? predialysis = CheckBoxList('Predialysis', true);
  CheckBoxList? postDialysis = CheckBoxList('Post Dialysis', true);
  CheckBoxList? event = CheckBoxList('Event', false);
  CheckBoxList? doctorDesk = CheckBoxList('Doctor Desk', true);
  CheckBoxList? nephroDesk = CheckBoxList('Nephrologist Desk', true);
  CheckBoxList? dietician = CheckBoxList('Dietician', false);
  CheckBoxList? termsCondition = CheckBoxList(
      'I have verified all dialysis stages and patient details', false);

  List<DischargeListModel>? filteredDialysisEventList;

  File? sessionEndReportFile;

  Future<List<DischargeListModel>> fetchDialysisEventListFromAPI(
    String? inputValue,
    int? startIndex,
    String? callFrom,
    String? searchType,
    int? unitId,
  ) async {
    isLoading = true;
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getPreDialysisQueueList}?inputValue=$inputValue&startIndex=$startIndex&callFrom=$callFrom&searchType=$searchType&unitId=$unitId");

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
      update();
      final List<dynamic> jsonData = json.decode(response.body);
      dischargeList =
          jsonData.map((item) => DischargeListModel.fromJson(item)).toList();
      return dischargeList;
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting fetchDialysisEventListFromAPI');
    }
  }

  // Future<void> getSessionReport(String patientId) async {
  //   isLoading = true;
  //   update();
  //
  //   try {
  //     var request = http.Request(
  //       'GET',
  //       Uri.parse(
  //         '${ApiConstants.ip + ApiConstants.sessionEndReport}?details=no&fromDate=&toDate=&treatmentId=&patientId=$patientId',
  //       ),
  //     );
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       Uint8List bytes = await response.stream.toBytes();
  //       final fileName =
  //           'session_report_${DateTime.now().millisecondsSinceEpoch}.pdf';
  //
  //       // ✅ Save in app's files directory (No permission required)
  //       final dir =
  //           await getExternalStorageDirectory(); // e.g., /storage/emulated/0/Android/data/<your_app>/files
  //       final file = File('${dir!.path}/$fileName');
  //       await file.writeAsBytes(bytes);
  //
  //       debugPrint('PDF saved at: ${file.path}');
  //
  //       // ✅ Optional: Open the file
  //       await OpenFile.open(file.path);
  //     } else {
  //       debugPrint("Failed to download report: ${response.reasonPhrase}");
  //     }
  //   } catch (e) {
  //     debugPrint("Error: $e");
  //   }
  //
  //   isLoading = false;
  //   update();
  // }

  Future<void> getSessionReport({
    required String patientId,
    required int treatmentId,
    required int userId,
    required int unitId,
  }) async {
    isLoading = true;
    update();

    try {
      final uri = Uri.parse(
        '${ApiConstants.ip + ApiNames.sessionEndReport}?details=no&fromDate=&toDate=&treatmentId=&patientId=$patientId',
      );

      final headers = {'Content-Type': 'application/json'};

      final request = http.Request('POST', uri);
      request.body = jsonEncode({
        "patientId": int.parse(patientId),
        "details": "no",
        "fromDate": "",
        "toDate": "",
        "treatmentId": treatmentId,
        "userId": userId,
        "unitId": unitId
      });
      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final bytes = await response.stream.toBytes();
        final fileName =
            'session_report_${DateTime.now().millisecondsSinceEpoch}.pdf';

        final dir =
            await getExternalStorageDirectory(); // e.g., /storage/emulated/0/Android/data/<your_app>/files
        sessionEndReportFile = File('${dir!.path}/$fileName');
        await sessionEndReportFile?.writeAsBytes(bytes);
      } else {
        debugPrint("❌ Failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
    }

    isLoading = false;
    update();
  }

  getPatientDetails(
    String? patientId,
  ) async {
    isLoading = true;

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getPatientRecordsbypatientId}?patientId=$patientId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;
      final jsonData = json.decode(response.body);
      dischargePatientDet = DischargePatientDetails.fromJson(jsonData);

      debugPrint(dischargePatientDet?.lName ?? "");
      update();
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getPatientDetails');
    }
  }

  saveDischarge(String? patientId, String? treatmentId, String? unitId,
      String? userId, dynamic userData) async {
    isLoading = true;
    // final uri =
    //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);

    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.saveDischarge}?patientId=$patientId&treatmentId=$treatmentId&unitId=$unitId&userId=$userId");

    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      await getSessionReport(
          patientId: patientId.toString(),
          treatmentId: int.parse(treatmentId!),
          userId: int.parse(userId!),
          unitId: int.parse(unitId!));
      await fetchDialysisEventListFromAPI(
        '',
        0,
        'EVE',
        '',
        int.parse(unitId),
      );
      isLoading = false;
      final data = jsonDecode(response.body);
      if (data['patientId'] != null) {
        update();
        CustomPopup.showConfirmationDialog(() {
          Get.off(SessionEndList(
            userData: userData,
          ));
        }, () {
          Get.off(SessionEndList(
            userData: userData,
          ));
        }, () async {
          Get.back();
          Get.back();
          debugPrint('✅ PDF saved at: ${sessionEndReportFile?.path}');
          await OpenFile.open(sessionEndReportFile?.path);
        }, "Print Report?", '', "assets/success-popup.png");
      }
    } else {
      isLoading = false;
      update();

      throw Exception('Failed getting getPatientDetails');
    }
  }

// getPostFlag(
//   String? patientId,
//   String? treatmentId,
// ) async {
//   isLoading = true;
//   // final uri =
//   //     Uri.parse(ApiConstants.baseUrl4 + ApiConstants.getCentralDashboarCount);
//
//   final uri = Uri.parse(
//       "${ApiConstants.baseUrl}${ApiConstants.getPostFlag}?patientId=$patientId&treatmentId=$treatmentId");
//
//   Map<String, String> headers = {
//     "Content-Type": "application/json",
//   };
//
//   debugPrint(uri.path);
//
//   final response = await ioClient.post(uri, headers: headers);
//   debugPrint(response.statusCode.toString());
//   debugPrint("response.body : ${response.body}");
//
//   if (response.statusCode == 200) {
//     isLoading = false;
//     dischargeFlagString = response.body;
//     // final jsonData = json.decode(response.body);
//     // dischargeFlag = CheckBoxFlagDischarge.fromJson(jsonData);
//     // debugPrint(dischargePatientDet?.lName ?? "");
//     update();
//   } else {
//     isLoading = false;
//     update();
//
//     throw Exception('Failed getting getPatientDetails');
//   }
// }

  Future<void> getPostFlag(String patientId, String treatmentId) async {
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.getPostFlag}?patientId=$patientId&treatmentId=$treatmentId");

    var request = http.Request('POST', uri);

    // var request = http.Request(
    //     'POST',
    //     Uri.parse(
    //         'http://210.89.42.122:8080/Hemodialysis-Apis/api/mobile/getPostFlag?patientId=858&treatmentId=16602'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      dischargeFlagString = await response.stream.bytesToString();
      debugPrint(dischargeFlagString);
    } else {
      debugPrint(response.reasonPhrase);
    }

    // isLoading = true;
    // update();
    //
    // final url = Uri.parse(
    //   'http://210.89.42.122:8080/Hemodialysis-Apis/api/mobile/getPostFlag?patientId=$patientId&treatmentId=$treatmentId',
    // );
    //
    // try {
    //   final request = http.Request('POST', url);
    //
    //   // ONLY THIS FIX: Set Postman's User-Agent
    //   request.headers['User-Agent'] = 'PostmanRuntime/7.44.1';
    //
    //   final response = await request.send();
    //
    //   if (response.statusCode == 200) {
    //     final body = await response.stream.bytesToString();
    //     dischargeFlagString = body;
    //     print('✅ Success: $body');
    //   } else {
    //     print('❌ Error: ${response.statusCode} - ${response.reasonPhrase}');
    //   }
    // } catch (e) {
    //   print('❌ Exception: $e');
    // }
    //
    // isLoading = false;
    // update();
  }
}
