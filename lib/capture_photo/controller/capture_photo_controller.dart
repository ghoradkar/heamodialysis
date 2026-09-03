import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/capture_photo/model/captured_photo_list_model.dart';
import 'package:heamodialysis/capture_photo/model/save_captured_photo_model.dart';
import 'package:heamodialysis/capture_photo/repository/capture_photo_repository.dart';
import 'package:heamodialysis/new_registration/screen/upload_document_tab.dart';
import 'package:heamodialysis/registered_patient_list/screen/registered_patient_list.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';

import '../model/delete_photo_model.dart';

class CapturePhotoController extends GetxController {
  final CapturePhotoRepository _repository = CapturePhotoRepository();

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
      final response = await _repository.saveCapturedPhoto(
        patientId: saveCapturedPhotoModel.patientId.toString(),
        unitId: saveCapturedPhotoModel.unitId.toString(),
        userId: saveCapturedPhotoModel.userId.toString(),
        fileFieldKey: userProfilePhoto.key,
        filePath: userProfilePhoto.file!.path,
      );

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

    capturedPhotoListModel = await _repository.getCapturedPhotoList(patientId);
    isLoading = false;
    update();
  }

  Future<bool> deletePhoto(String id) async {
    isLoading = true;

    try {
      deletePhotoModel = await _repository.deletePhoto(id);
      isLoading = false;
      if (deletePhotoModel != null) {
        CustomMessage.toast(deletePhotoModel?.status ?? "Deleted Successfully");
        update();
        return true;
      }
      update();
      return false;
    } catch (error) {
      isLoading = false;
      update();
      debugPrint('Error sending request: $error');
      return false;
    }
  }
}
