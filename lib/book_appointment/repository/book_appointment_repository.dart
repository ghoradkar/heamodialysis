import 'dart:convert';

import 'package:heamodialysis/book_appointment/model/bedAvailable/bed_available_model.dart';
import 'package:heamodialysis/book_appointment/model/slot/slot_list_model.dart';
import 'package:heamodialysis/utils/api_client.dart';
import 'package:heamodialysis/utils/api_names.dart';
import 'package:heamodialysis/utils/api_urls.dart';

class BookAppointmentRepository {
  Future<SlotListModel> getSlotList({
    required unitId,
    required pId,
    required String formattedDate,
  }) async {
    final response = await ApiClient().post(
      ApiConstants.oldBaseUrl + ApiNames.getSlotList,
      body: {"unitId": unitId, "pId": pId, "date": formattedDate},
    );

    if (response.statusCode == 200) {
      return SlotListModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<BedAvailableModel> getBedList({
    required unitId,
    required slotId,
    required date,
    required patientId,
  }) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.getAvailableBedList,
      body: {
        "unitId": unitId,
        "slotId": slotId,
        "date": date?.toString().replaceAll('/', '-'),
        "patientId": patientId,
        "slotFlag": "Y"
      },
    );

    if (response.statusCode == 200) {
      return BedAvailableModel.fromJson(json.decode(response.body));
    }
    throw ApiException(response.statusCode, response.body);
  }

  Future<Map<String, dynamic>> bookAppointment({
    required unitId,
    required slotMapDetId,
    required date,
    required patientId,
    required userId,
    required treatId,
  }) async {
    final response = await ApiClient().post(
      ApiConstants.baseUrl + ApiNames.bookBedApi,
      body: {
        "unitId": unitId,
        "slotMapDetId": slotMapDetId,
        "date": date,
        "pId": patientId,
        "userId": userId,
        "tId": treatId
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw ApiException(response.statusCode, response.body);
  }
}
