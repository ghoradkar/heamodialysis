import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/capture_photo/model/captured_photo_list_model.dart';
import 'package:heamodialysis/capture_photo/model/save_captured_photo_model.dart';
import 'package:heamodialysis/new_registration/screens/upload_document_tab.dart';
import 'package:heamodialysis/registered_patient_list/screens/registered_patient_list.dart';
import 'package:heamodialysis/utils/api_names.dart';

import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:http/http.dart' as http;

import 'model/delete_photo_model.dart';

class CapturePhotoController extends GetxController {
  bool isLoading = false;
  SaveCapturedPhotoModel saveCapturedPhotoModel = SaveCapturedPhotoModel();
  FileDetails userProfilePhoto = FileDetails(
      name: 'savecapturedphoto',
      key: 'patientImage',
      isSelected: false,
      isReq: true);

  CapturedPhotoListModel? capturedPhotoListModel;

  DeletePhotoModel? deletePhotoModel;

  saveCapturedPhoto() async {
    isLoading = true;

    try {
      Uri uri =
          Uri.parse(ApiConstants.baseUrl + ApiNames.saveCapturedPhoto);

      http.MultipartRequest request = http.MultipartRequest('POST', uri);

      request.fields.addAll({
        'patientId': saveCapturedPhotoModel.patientId.toString(),
        'unitId': saveCapturedPhotoModel.unitId.toString(),
        'userId': saveCapturedPhotoModel.userId.toString(),
      });

      request.files.add(await http.MultipartFile.fromPath(
        userProfilePhoto.key,
        userProfilePhoto.file!.path,
      ));

      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        isLoading = false;
        CustomMessage.toast("Data saved successfully");
        Get.off(const RegisteredPatientList());
      } else {
        isLoading = false;
        CustomMessage.toast('Upload failed: ${response.reasonPhrase}');
      }
    } catch (error) {
      isLoading = false;
      debugPrint(error.toString());
    }
    update();
  }

  Future<void> getCapturedPhotoList(patientId) async {
    isLoading = true;

    final String url = ApiConstants.baseUrl + ApiNames.getCapturedPhotoList;

    // Create a client to send the request
    var client = http.Client();

    // Create a request object
    var request = http.Request('GET', Uri.parse(url));

    // Add headers if needed
    request.headers.addAll({
      'Content-Type': 'application/json',
    });

    // Set the request body
    request.body = jsonEncode({"patientId": patientId.toString()});

    // Send the request
    var response = await client.send(request);

    // Handle the response
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      debugPrint('Response body: $responseBody');
      isLoading = false;
      //getDeviceDetails
      final data = json.decode(responseBody);
      capturedPhotoListModel = CapturedPhotoListModel.fromJson(data);

      update();
    } else {
      isLoading = false;
      update();
      debugPrint('Request failed with status: ${response.statusCode}');
    }

    // Close the client
    client.close();
  }

  // getCapturedPhotoList(patientId) async {
  //   isLoading = true;
  //
  //   final uri =
  //       Uri.parse(ApiConstants.baseUrl + ApiConstants.getCapturedPhotoList);
  //   var body = {"patientId": patientId.toString()};
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
  //     isLoading = false;
  //     //getDeviceDetails
  //     final data = json.decode(response.body);
  //     capturedPhotoListModel = CapturedPhotoListModel.fromJson(data);
  //
  //     update();
  //   } else if (response.statusCode == 404) {
  //     isLoading = false;
  //     update();
  //   } else {
  //     isLoading = false;
  //     update();
  //     throw Exception('Failed getCapturedPhotoList');
  //   }
  // }

  Future<bool> deletePhoto(String id) async {
    isLoading = true;
    // var request = http.MultipartRequest(
    //     'POST',
    //     Uri.parse(
    //         "http://193.239.237.53:9999/disha-t2t-Apis/api/access/master/PatientCountData/patientData?unitId=$unitId"));

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${ApiConstants.baseUrl + ApiNames.deletedPhoto}?id=$id'));

    request.fields[id] = id;

    try {
      // Send the request
      final response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        isLoading = false;
        final data = json.decode(await response.stream.bytesToString());
        deletePhotoModel = DeletePhotoModel.fromJson(data);
        CustomMessage.toast(deletePhotoModel?.status ?? "Deleted Successfully");
        update();
        return true;
      } else {
        isLoading = false;
        update();
        debugPrint('Request failed with status code ${response.statusCode}');
        return false;
      }
    } catch (error) {
      isLoading = false;
      update();
      debugPrint('Error sending request: $error');
      return false;
    }
  }
}
