import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/capture_photo/capture_photo_controller.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class CapturePhoto extends StatefulWidget {
  final List<CameraDescription> cameras; // Accept list of cameras
  final CameraDescription camera; // The initial camera to use
  final Function? callBack;
  final PatientData? patientData;

  const CapturePhoto({
    super.key,
    required this.cameras,
    required this.camera,
    this.callBack, this.patientData,
  });

  @override
  State<CapturePhoto> createState() => _CapturePhotoState();
}

class _CapturePhotoState extends State<CapturePhoto> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription currentCamera;
  var userData;
  final CapturePhotoController capturePhotoController =
      Get.put(CapturePhotoController());
  @override
  void initState() {
    super.initState();
    currentCamera = widget.camera; // Set the initial camera
    _initializeCameraController(currentCamera);
    getUserData();

  }

  void _initializeCameraController(CameraDescription cameraDescription) {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  void _switchCamera() {
    final nextCamera = widget.cameras.firstWhere(
          (camera) => camera.lensDirection != currentCamera.lensDirection,
    );
    setState(() {
      currentCamera = nextCamera;
      _initializeCameraController(currentCamera);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Photo'),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset('assets/arrow-left.png'),
        ),
        actions: [
          IconButton(
            onPressed: _switchCamera,
            icon: const Icon(Icons.switch_camera),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                CameraPreview(_controller),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    try {
                      await _initializeControllerFuture;
                      final image = await _controller.takePicture();
                      File file = File(image.path);
                      if (!context.mounted) return;
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(
                            imagePath: image.path,
                            callB: () {


                              var unitId = int.parse(userData['unitId'].toString());
                            var userId = userData['ui'];
                            capturePhotoController.saveCapturedPhotoModel
                                .unitId = unitId.toString();
                            capturePhotoController.saveCapturedPhotoModel
                                .userId = userId.toString();
                            capturePhotoController
                                    .saveCapturedPhotoModel.patientId =
                                widget.patientData?.patientId.toString();
                            capturePhotoController.userProfilePhoto.isSelected =
                                true;
                            capturePhotoController.userProfilePhoto.file = file;
                            if (widget.patientData != null) {
                              capturePhotoController.saveCapturedPhoto();
                            }
                            Get.back();
                            Get.back();
                           widget.callBack!();

                              // widget.callBack!();
                              // Get.back();
                            },
                          ),
                        ),
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.primaryBackgroundColor,
                          AppColor.secondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}


// import 'dart:io';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:heamodialysis/capture_photo/capture_photo_controller.dart';
// import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
// import 'package:heamodialysis/utils/color_constants.dart';
// import 'package:heamodialysis/utils/shared_pref_constants.dart';
// import 'package:heamodialysis/utils/shared_preference.dart';
// import 'package:heamodialysis/widgets/custom_text.dart';
//
// class CapturePhoto extends StatefulWidget {
//   final CameraDescription camera;
//   final PatientData? patientData;
//   final Function? callBack;
//
//   const CapturePhoto({
//     super.key,
//     this.patientData,
//     required this.camera, this.callBack,
//   });
//
//   @override
//   State<CapturePhoto> createState() => _CapturePhotoState();
// }
//
// class _CapturePhotoState extends State<CapturePhoto> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   final CapturePhotoController capturePhotoController =
//       Get.put(CapturePhotoController());
//
//   var userData;
//
//   @override
//   void initState() {
//     getUserData();
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.medium,
//     );
//     _initializeControllerFuture = _controller.initialize();
//     super.initState();
//   }
//
//   Future<void> getUserData() async {
//     userData = await SharedPref().read(const SharedPrefConstant().kUserData);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text('Capture Photo'),
//           leading: InkWell(
//               onTap: () {
//                 Get.back();
//               },
//               child: Image.asset('assets/arrow-left.png'))),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Column(children: [
//               CameraPreview(_controller),
//               const SizedBox(
//                 height: 30,
//               ),
//               InkWell(
//                 onTap: () async {
//                   try {
//                     await _initializeControllerFuture;
//                     final image = await _controller.takePicture();
//                     File file = File(image.path);
//                     if (!context.mounted) return;
//                     await Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => DisplayPictureScreen(
//                           imagePath: image.path,
//                           callB: () {
//                             var unitId = int.parse(userData['unitId']);
//                             var userId = userData['ui'];
//                             capturePhotoController.saveCapturedPhotoModel
//                                 .unitId = unitId.toString();
//                             capturePhotoController.saveCapturedPhotoModel
//                                 .userId = userId.toString();
//                             capturePhotoController
//                                     .saveCapturedPhotoModel.patientId =
//                                 widget.patientData?.patientId.toString();
//                             capturePhotoController.userProfilePhoto.isSelected =
//                                 true;
//                             capturePhotoController.userProfilePhoto.file = file;
//                             if (widget.patientData != null) {
//                               capturePhotoController.saveCapturedPhoto();
//                             }
//                             Get.back();
//                             Get.back();
//                            widget.callBack!();
//                           },
//                         ),
//                       ),
//                     );
//                   } catch (e) {
//                     debugPrint(e.toString());
//                   }
//                 },
//                 child: Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColor.primaryBackgroundColor,
//                           AppColor.secondaryColor
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: const Icon(
//                     Icons.camera_alt_outlined,
//                     color: Colors.white,
//                     size: 40,
//                   ),
//                 ),
//               )
//             ]);
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
//
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final Function callB;

  const DisplayPictureScreen(
      {super.key, required this.imagePath, required this.callB});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const CustomText(
            text: 'Back',
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
              child: Image.asset('assets/arrow-left.png'))),
      body: Column(
        children: [
          Image.file(File(imagePath)),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              callB();
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.primaryBackgroundColor,
                      AppColor.secondaryColor
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
