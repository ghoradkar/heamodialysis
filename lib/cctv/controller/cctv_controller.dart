// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:heamodialysis/cctv/model/institude_wise_cctv.dart';
// import 'package:heamodialysis/new_registration/model/state/state_data.dart';
// import 'package:heamodialysis/new_registration/model/state/state_model.dart';
// import 'package:heamodialysis/utils/api_names.dart';
// import 'package:heamodialysis/utils/api_urls.dart';
// import 'package:heamodialysis/utils/network_call.dart';
// import 'package:http/io_client.dart';
//
// class CctvController extends GetxController {
//   bool hasInternet = true;
//   bool isLoading = false;
//   IOClient ioClient = IOClient(ByPassCert().httpClient);
//
//   StateModel? stateModel;
//
//   String? selectedStateVal;
//
//   StateData? selectedStateObj;
//
//   DateTime? selectedFromDate;
//
//   String? formattedFromDate;
//
//   List<InstitudeWiseCctv>? institudeWiseCctv;
//
//   ///uncomment for api list
//   // List<CctvCameraList>? cctvList;
//   List<String> cctvList = [
//     "rtsp://admin:labadmin%40123@117.212.159.94:554/unicast/c1/s1/live",
//     "rtsp://admin:labadmin%40123@117.212.159.94:554/unicast/c2/s1/live",
//     "rtsp://admin:labadmin%40123@117.212.159.94:554/unicast/c3/s1/live",
//     "rtsp://admin:labadmin%40123@117.212.159.94:554/unicast/c4/s1/live"
//
//     // "rtsp://admin:labadmin%40123@117.212.159.94:554/c1/b1749407400/e1749493800/replay"
//     // rtsp://admin:labadmin%40123@117.212.159.94:554/c1/b1749407400/e1749493800/replay
//   ];
//
//   //clinic links
//   // "rtsp://admin:lab%401234@61.0.43.177:554/unicast/c1/s1/live",
//   // "rtsp://admin:lab%401234@61.0.43.177:554/unicast/c4/s1/live",
//   // "rtsp://admin:lab%401234@61.0.43.177:554/c4/b1749407400/e1749493800/replay"
//
//   List<String> list = [];
//
//   List<String>? rtspLinks;
//
//   Future<bool> getStateList() async {
//     isLoading = true;
//
//     final uri = Uri.parse(ApiConstants.baseUrl + ApiNames.getStateList);
//
//     // String jsonbody = json.encode(body);
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//     };
//
//     debugPrint(uri.path);
//     // print(body);
//
//     final response = await ioClient.get(uri, headers: headers);
//     debugPrint(response.statusCode.toString());
//     debugPrint("response.body : ${response.body}");
//
//     if (response.statusCode == 200) {
//       isLoading = false;
//       //getDeviceDetails
//       final data = json.decode(response.body);
//       stateModel = StateModel.fromJson(data);
//
//       update();
//       return true;
//     } else if (response.statusCode == 401) {
//       isLoading = false;
//
//       update();
//
//       return false;
//     } else {
//       isLoading = false;
//
//       throw Exception('Failed getting getViralStatueList');
//     }
//   }
//
//   getInstitudeWiseCctvList(stateId, divId, districtId, talukaId, instId) async {
//     isLoading = true;
//
//     final uri = Uri.parse(
//         "${ApiConstants.ip}${ApiNames.getInstitutesByFilters}?stateId=$stateId&divId=$divId&districtId=$districtId&talukaId=$talukaId&instId=$instId");
//
//     // String jsonbody = json.encode(body);
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//     };
//
//     debugPrint(uri.path);
//     // print(body);
//
//     final response = await ioClient.post(uri, headers: headers);
//     debugPrint(response.statusCode.toString());
//     debugPrint("response.body : ${response.body}");
//
//     if (response.statusCode == 200) {
//       isLoading = false;
//
//       List<dynamic> data = json.decode(response.body);
//
//       institudeWiseCctv =
//           data.map((json) => InstitudeWiseCctv.fromJson(json)).toList();
//       update();
//     } else {
//       isLoading = false;
//
//       throw Exception('Failed getting getInstitudeWiseCctvList');
//     }
//   }
//
//   getCctvList(String? stateId, String? divId, String? districtId,
//       String? talukaId, String? instId) async {
//     isLoading = true;
//
//     final uri = Uri.parse(
//         "${ApiConstants.ip}${ApiNames.getCctvConfiguration}?stateId=$stateId&divId=$divId&districtId=$districtId&talukaId=$talukaId&instId=$instId");
//
//     // String jsonbody = json.encode(body);
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//     };
//
//     debugPrint(uri.path);
//     // print(body);
//
//     final response = await ioClient.post(uri, headers: headers);
//     debugPrint(response.statusCode.toString());
//     debugPrint("response.body : ${response.body}");
//
//     if (response.statusCode == 200) {
//       isLoading = false;
//
//       // List<dynamic> data = json.decode(response.body);
//
//       ///uncomment for api list
//       // cctvList = data.map((json) => CctvCameraList.fromJson(json)).toList();
//
//       // rtspLinks = data
//       //     .map((map) => map.values.first.toString())
//       //     .toList();
//       update();
//     } else {
//       isLoading = false;
//       update();
//
//       throw Exception('Failed getting getInstitudeWiseCctvList');
//     }
//   }
// }
