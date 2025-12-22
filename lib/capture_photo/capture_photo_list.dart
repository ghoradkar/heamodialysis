import 'dart:io';

import 'package:camera/camera.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/capture_photo/capture_photo.dart';
import 'package:heamodialysis/capture_photo/capture_photo_controller.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/controller/new_registration_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_popup.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/file_viewer.dart';

import '../widgets/cust_toast.dart';
import '../widgets/custom_shimmer_loader.dart';

class CapturePhotoList extends StatefulWidget {
  final PatientData? patientData;
  final CameraDescription camera;

  const CapturePhotoList(
      {super.key, this.patientData, required this.camera});

  @override
  State<CapturePhotoList> createState() => _CapturePhotoListState();
}

class _CapturePhotoListState extends State<CapturePhotoList> {
  final CapturePhotoController capturePhotoController =
      Get.put(CapturePhotoController());

  final NewRegistrationController newRegistrationController =
  Get.find<NewRegistrationController>();

  bool hasInternet = true;

  @override
  void initState() {
    checkInternetAndLoadData();

    super.initState();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    capturePhotoController.update();
    if (hasInternet) {
      await capturePhotoController
          .getCapturedPhotoList(widget.patientData?.patientId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Capture Photo',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
        actions: [
          InkWell(
            onTap: () async{
              // Get the list of available cameras
              final cameras = await availableCameras();

              // Optionally select a default camera (e.g., front camera)
              final defaultCamera = cameras.firstWhere(
                    (camera) => camera.lensDirection == CameraLensDirection.front,
              );

              // Navigate to the CapturePhoto screen, passing the list of cameras
              Get.to(() => CapturePhoto(
                cameras: cameras, // Pass all available cameras
                camera: defaultCamera, // Initial camera (front)
                callBack: () {
                  pickImageFromCamera();
                },
              ));
              // Get.to(() => CapturePhoto(
              //       patientData: widget.patientData,
              //       camera: widget.camera,
              //     ));
            },
            child: Container(
              height: 36,
              padding: const EdgeInsets.only(left: 4, right: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    AppColor.primaryBackgroundColor,
                    AppColor.secondaryColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/camera.png",
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const CustomText(
                    text: "Take Photo",
                    fontSize: 12,
                    fontFam: "Lato",
                    fontWeight: FontWeight.normal,
                    textColor: Colors.white,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      body: GetBuilder<CapturePhotoController>(
        init: CapturePhotoController(),
        builder: (controller) {
          return hasInternet
              ? controller.isLoading
                  ?  Center(child: buildShimmerLoader())
                  : (capturePhotoController.capturedPhotoListModel?.data ==
                              null ||
                          capturePhotoController
                              .capturedPhotoListModel!.data!.isEmpty)
                      ? Center(
                          child: Image.asset(
                            "assets/capture-photo-guid.png",
                            fit: BoxFit.contain,
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            childAspectRatio: 1,
                          ),
                          itemCount: capturePhotoController
                                  .capturedPhotoListModel?.data?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffF8F8F8),
                                  border:
                                      Border.all(color: AppColor.borderColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: Colors.white,width: 2),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        // "assets/profile-placeholder.png",
                                        ApiConstants.imageBaseUrl +
                                            capturePhotoController
                                                .capturedPhotoListModel!
                                                .data![index]
                                                .filePath!,
                                      
                                      ),
                                    ),
                                  ).paddingOnly(top: 10),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColor.primaryBackgroundColor,
                                            AppColor.secondaryColor
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomCenter,
                                        )),
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => ImageViewer(
                                                  fileUrl: ApiConstants
                                                          .imageBaseUrl +
                                                      capturePhotoController
                                                          .capturedPhotoListModel!
                                                          .data![index]
                                                          .filePath!, patientName: widget.patientData?.searchParam ?? "",
                                                ));
                                          },
                                          child: const Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          height: 22,
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            CustomPopup.showConfirmationDialog(
                                                () {
                                              Get.back();
                                            }, () {
                                              Get.back();
                                            }, () async {
                                              var isDeleted =
                                                  await capturePhotoController
                                                      .deletePhoto(
                                                          capturePhotoController
                                                              .capturedPhotoListModel!
                                                              .data![index]
                                                              .id
                                                              .toString());
                                              if (isDeleted) {
                                                Get.back();
                                                capturePhotoController
                                                    .getCapturedPhotoList(widget
                                                        .patientData?.patientId);
                                              }
                                            },
                                                "Delete Photo",
                                                "Are you sure you want to delete this photo?",
                                                "assets/delete-photo.png");
                                          },
                                          child: const Icon(
                                            Icons.delete_outline_sharp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ).paddingOnly(
                                left: 10, right: 10, top: 10, bottom: 10);
                          },
                        )
              : InternetIssue(
                  onRetryPressed: () {
                    checkInternetAndLoadData();
                  },
                );
        },
      ),
    );
  }

  pickImageFromCamera() async {
    if (capturePhotoController.userProfilePhoto.file != null) {
      final file = File(capturePhotoController.userProfilePhoto.file!.path);
      final fileSize = await file.length();

      // Check if file size exceeds 500 KB
      if (fileSize > 500 * 1024) {
        // Show message to the user
        CustomMessage.toast("Upload photo below 500KB");

        // Reset the selected image to null
        newRegistrationController.image = null;
        newRegistrationController.userProfilePhoto.file = null;
        newRegistrationController.userProfilePhoto.isSelected = false;
      } else {
        // Proceed with setting the image
        newRegistrationController.image = file;
        newRegistrationController.userProfilePhoto.file = file;
        newRegistrationController.userProfilePhoto.isSelected = true;
      }

      setState(() {}); // Update UI
    } else {
      debugPrint('No image captured.');
    }
  }


// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: const CustomText(
//         text: 'Capture Photo',
//         fontSize: 20.0,
//         fontFam: 'Lato',
//         fontWeight: FontWeight.w400,
//         textColor: Colors.black,
//         textAlign: TextAlign.start,
//       ),
//       actions: [
//         InkWell(
//           onTap: () {
//             Get.to(() => CapturePhoto(
//                   patientData: widget.patientData,
//                   camera: widget.camera,
//                 ));
//           },
//           child: Container(
//               height: 36,
//               padding: const EdgeInsets.only(left: 4, right: 4),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColor.primaryBackgroundColor,
//                     AppColor.secondaryColor
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     "assets/camera.png",
//                     color: Colors.white,
//                   ),
//                   const SizedBox(
//                     width: 6,
//                   ),
//                   const CustomText(
//                       text: "Take Photo",
//                       fontSize: 12,
//                       fontFam: "Lato",
//                       fontWeight: FontWeight.normal,
//                       textColor: Colors.white,
//                       textAlign: TextAlign.start),
//                 ],
//               )),
//         ),
//         const SizedBox(
//           width: 4,
//         ),
//       ],
//     ),
//     body: GetBuilder<CapturePhotoController>(
//         init: CapturePhotoController(),
//         builder: (controller) {
//           return hasInternet
//               ? controller.isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 5 / 6,
//                       ),
//                       itemCount: capturePhotoController
//                           .capturedPhotoListModel?.data?.length,
//                       itemBuilder: (context, index) {
//                         if (capturePhotoController
//                                     .capturedPhotoListModel?.data ==
//                                 null ||
//                             capturePhotoController
//                                 .capturedPhotoListModel!.data!.isEmpty) {
//                           // Show placeholder widget when data is null or empty
//                           return Image.asset(
//                               "assets/capture-photo-guid.png"); // Replace with your placeholder widget
//                         } else {
//                           return Text("iuiuikujb");
//                         }
//                       })
//               : InternetIssue(
//                   onRetryPressed: () {
//                     checkInternetAndLoadData();
//                   },
//                 );
//         }),
//   );
// }
}
