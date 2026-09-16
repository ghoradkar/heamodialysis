import 'package:get/get.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/book_appointment/model/bedAvailable/bed_available_model.dart';
import 'package:heamodialysis/book_appointment/repository/book_appointment_repository.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/registered_patient_list/screen/registered_patient_list.dart';
import 'package:heamodialysis/schedular/controller/schedular_controller.dart';
import 'package:heamodialysis/schedular/screen/schedular_list.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/widgets/cust_toast.dart';
import 'package:intl/intl.dart';

import '../model/slot/slot_list_model.dart';

class BookAppointmentController extends GetxController {
  final BookAppointmentRepository _repository = BookAppointmentRepository();

  bool isLoading = false;
  String? selectInstitute;
  String? selectedDateSendReq;

  SlotListModel? slotListModel;
  BedAvailableModel? bedAvailableModel;

  Future<bool> getSlotList(unitId, pId, date) async {
    isLoading = true;
    update();

    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    String formattedDate =
        DateFormat("dd-MMM-yyyy").format(parsedDate).toUpperCase();

    try {
      slotListModel = await _repository.getSlotList(
          unitId: unitId, pId: pId, formattedDate: formattedDate);
      isLoading = false;
      update();
      return true;
    } on ApiException catch (e) {
      isLoading = false;
      update();
      if (e.statusCode == 401) return false;
      throw Exception('Failed getting id proof');
    }
  }

  getBedList(unitId, slotId, date, patientId) async {
    isLoading = true;
    update();

    try {
      bedAvailableModel = await _repository.getBedList(
          unitId: unitId, slotId: slotId, date: date, patientId: patientId);
      isLoading = false;
      update();
    } on ApiException {
      isLoading = false;
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

    try {
      final data = await _repository.bookAppointment(
        unitId: unitId,
        slotMapDetId: slotMapDetId,
        date: date,
        patientId: patientId,
        userId: userId,
        treatId: treatId,
      );

      isLoading = false;
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
    } on ApiException catch (e) {
      isLoading = false;
      CustomMessage.toast(l10n.bookBookingFailed);
      update();

      if (e.statusCode == 401) return false;
      throw Exception('Failed Booking');
    }
  }
}
