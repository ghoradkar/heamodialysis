import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screens/add_edit_ro_desinfec_details.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screens/ro_disinfection_details.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/network_call.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class RoDesinfectionDetailsController extends GetxController {
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

  IOClient ioClient = IOClient(ByPassCert().httpClient);

  List<RoDisinfectionDoc> roDisinfecDocList = [];


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

  Future<bool> deleteDesinfectionDet(id, unitId) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiNames.roMachineDisinfectionDelete}?id=$id");

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

      getRoMaintenanceDetAndSearchList(unitId, "");

      return true;
    } else {
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
      // Create the custom HttpClient from ByPassCert
      HttpClient httpClient = ByPassCert().httpClient;
      IOClient ioClient = IOClient(httpClient);

      Uri uri = Uri.parse(ApiConstants.baseUrl + ApiNames.saveRODisDet);

      var body = json.encode({
        "roDisinfectionDetailsId": addRoDisinfectModel?.roDisinfectionDetailsId,
        "roMachineMasterId": addRoDisinfectModel?.roMachineMasterId,
        "lookupDetId": addRoDisinfectModel?.lookupDetId,
        "nextInspectionDate": nextInsD,
        "comments": addRoDisinfectModel?.comments,
        "doneBy": addRoDisinfectModel?.doneBy,
        "inspectionDate": insD,
        "createdBy": addRoDisinfectModel?.createdBy ?? 1,
        "unitId": addRoDisinfectModel?.unitId
      });

      // Create a multipart request
      var request = http.MultipartRequest('POST', uri);

      List<String?> selectedDocIds =
          uploadImage.where((e) => e.isSelected).map((e) => e.ids).toList();
      List<String?> enteredDocName =
          uploadImage.where((e) => e.isSelected).map((e) => e.docName).toList();

      // Convert to comma-separated string, ignoring null ids
      String docIdString = selectedDocIds.whereType<String>().join(',');
      String docNameString = enteredDocName.whereType<String>().join(',');

      request.fields.addAll({'data': body});
      request.fields.addAll({'documentNames': docNameString});
      request.fields.addAll({'docId': docIdString});

      // Add headers
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      for (int i = 0; i < uploadImage.length; i++) {
        if (uploadImage[i].isSelected) {
          request.files.add(await http.MultipartFile.fromPath(
            uploadImage[i].key,
            uploadImage[i].file!.path,
          ));
        }
      }

      // Send the request using the custom IOClient
      http.StreamedResponse response = await ioClient.send(request);
      final finalResp = await http.Response.fromStream(response);

      if (finalResp.statusCode == 200) {
        var data = jsonDecode(finalResp.body); // Use the response body here

        if (data['status'] == "Success") {
          isLoading = false;
          debugPrint(finalResp
              .body); // Use finalResp.body instead of reading stream again

          CustomMessage.toast("Saved Successfully");
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
          CustomMessage.toast('Upload failed');
        }
      } else {
        isLoading = false;
        update();
        CustomMessage.toast('Upload failed');
      }
    } catch (error) {
      isLoading = false;
      debugPrint(error.toString());
    }
    update();
  }

//   addEditRoDisinfectDetails() async {
//     String? insD = addRoDisinfectModel?.inspectionDate?.replaceAll("/", "-");
//     String? nextInsD =
//         addRoDisinfectModel?.nextInspectionDate?.replaceAll("/", "-");
//     isLoading = true;
//     update();
//
//     try {
//       // Create the custom HttpClient from ByPassCert
//       HttpClient httpClient = ByPassCert().httpClient;
//       IOClient ioClient = IOClient(httpClient);
//
//       Uri uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.saveRODisDet);
//
//       var body = json.encode({
//         "roDisinfectionDetailsId": addRoDisinfectModel?.roDisinfectionDetailsId,
//         "roMachineMasterId": addRoDisinfectModel?.roMachineMasterId,
//         "lookupDetId": addRoDisinfectModel?.lookupDetId,
//         "nextInspectionDate": nextInsD,
//         "comments": addRoDisinfectModel?.comments,
//         "doneBy": addRoDisinfectModel?.doneBy,
//         "inspectionDate": insD,
//         "createdBy": addRoDisinfectModel?.createdBy ?? 1,
//         "unitId": addRoDisinfectModel?.unitId
//       });
//
//       // Create a multipart request
//       var request = http.MultipartRequest('POST', uri);
//
//       List<String?> selectedDocIds =
//           uploadImage.where((e) => e.isSelected).map((e) => e.ids).toList();
//
//       List<String?> enteredDocName =
//           uploadImage.where((e) => e.isSelected).map((e) => e.docName).toList();
//
// // Convert to comma-separated string, ignoring null ids
//       String docIdString = selectedDocIds.whereType<String>().join(',');
//       String docNameString = enteredDocName.whereType<String>().join(',');
//
//       request.fields.addAll({'data': body});
//       request.fields.addAll({'documentNames': docNameString});
//       request.fields.addAll({'docId': docIdString});
//
//       // Add headers
//       request.headers.addAll({
//         'Content-Type': 'multipart/form-data',
//       });
//
//       for (int i = 0; i < uploadImage.length; i++) {
//         if (uploadImage[i].isSelected) {
//           request.files.add(await http.MultipartFile.fromPath(
//             uploadImage[i].key,
//             uploadImage[i].file!.path,
//           ));
//         }
//       }
//
//       // Send the request using the custom IOClient
//       http.StreamedResponse response = await ioClient.send(request);
//       final finalResp = await http.Response.fromStream(response);
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(await response.stream.bytesToString());
//         if (data['status'] == "Success") {
//           isLoading = false;
//           debugPrint(await response.stream.bytesToString());
//
//           CustomMessage.toast("Saved Successfully");
//           initialInsti = null;
//           initialMachine = null;
//           initialDisinfect = null;
//           initialDoneBy = null;
//           nextInspecDateController.text = "";
//           inspectionDateController.text = "";
//           commentController.text = "";
//           Get.off(const RoDisinfectionDetails());
//         } else {
//           isLoading = false;
//           update();
//           CustomMessage.toast('Upload failed');
//         }
//       } else {
//         isLoading = false;
//         update();
//         CustomMessage.toast('Upload failed');
//       }
//     } catch (error) {
//       isLoading = false;
//       debugPrint(error.toString());
//     }
//     update();
//   }

  // addEditRoDisinfectDetails() async {
  //   String? insD = addRoDisinfectModel?.inspectionDate?.replaceAll("/", "-");
  //   String? nextInsD =
  //       addRoDisinfectModel?.nextInspectionDate?.replaceAll("/", "-");
  //   isLoading = true;
  //   update();
  //   var headers = {'Content-Type': 'application/json'};
  //   var body = json.encode({
  //     "roDisinfectionDetailsId": addRoDisinfectModel?.roDisinfectionDetailsId,
  //     "roMachineMasterId": addRoDisinfectModel?.roMachineMasterId,
  //     "lookupDetId": addRoDisinfectModel?.lookupDetId,
  //     "nextInspectionDate": nextInsD,
  //     "comments": addRoDisinfectModel?.comments,
  //     "doneBy": addRoDisinfectModel?.doneBy,
  //     "inspectionDate": insD,
  //     "createdBy": addRoDisinfectModel?.createdBy ?? 1,
  //     "unitId": addRoDisinfectModel?.unitId
  //   });
  //
  //   debugPrint(body);
  //
  //   var response = await ioClient.post(
  //       Uri.parse(ApiConstants.baseUrl + ApiConstants.saveRODisDet),
  //       body: body,
  //       headers: headers);
  //
  //   // http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     isLoading = false;
  //     debugPrint(response.body);
  //
  //     CustomMessage.toast("Saved Successfully");
  //     initialInsti = null;
  //     initialMachine = null;
  //     initialDisinfect = null;
  //     initialDoneBy = null;
  //     nextInspecDateController.text = "";
  //     inspectionDateController.text = "";
  //     commentController.text = "";
  //     Get.off(const RoDisinfectionDetails());
  //   } else {
  //     debugPrint(response.reasonPhrase);
  //     isLoading = false;
  //     CustomMessage.toast("Save Fail");
  //   }
  //   update();
  // }

  getDisinfecUsed() async {
    isLoading = true;

    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiNames.getDisinfectionDet);

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
      disinfectTypeModel = DisinfectTypeModel.fromJson(data);
      isLoading = false;

      return instituteList;
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed getting getDisinfectionDet');
    }

    update();
  }

  getRODisinfectionDoc(roMachineId) async {
    isLoading = true;

    var headers = {
      'Content-Type': 'application/json',
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiNames.getRoDisDocById}?Id=$roMachineId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await ioClient.send(request);

    if (response.statusCode == 200) {
      isLoading = false;

      List<dynamic> data = json.decode(await response.stream.bytesToString());
      roDisinfecDocList =
          data.map((json) => RoDisinfectionDoc.fromJson(json)).toList();

      if (roDisinfecDocList.isNotEmpty) {
        RoDisinfectionDoc? file = (roDisinfecDocList.length == 1
            ? roDisinfecDocList.first
            : roDisinfecDocList.last);

        uploadImage[0].isSelected = true;
        uploadImage[0].isView = true;
        uploadImage[0].ids = file.roDisId.toString();
        uploadImage[0].file = File(ApiConstants.imageBaseUrl1 + file.docpath!);
      }
    } else {
      isLoading = false;
      debugPrint(response.reasonPhrase);
    }
    update();
  }

  getRoMaintenanceDetAndSearchList(unitId, machineName) async {
    isLoading = true;
update();
    final uri = Uri.parse(
        ApiConstants.baseUrl + ApiNames.getallROMachineDisBySearch);
    var body = {"unitId": unitId, "input": machineName};
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
      roMaintenanceDetailsModel = RoMaintenanceDetailsModel.fromJson(data);
      // var innerProList =
      //     roMaintenanceDetailsModel?.data?.map((e) => e.proLi).toList();
      // proList = innerProList![0];
      // debugPrint(proList?.length.toString());
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
}
