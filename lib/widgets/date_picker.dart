import 'package:flutter/material.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:intl/intl.dart';

class DatePickerHelper {
  static Future<DateTime?> selectDate(BuildContext context,
      {DateTime? initialDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1700),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.secondaryColor,
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: AppColor.secondaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return picked;
  }

  String getCurrentTime24Hour() {
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('HH:mm:ss'); // 24-hour format
    return formatter.format(now);
  }

  // static Future selectTime(BuildContext context) async {
  //   TimeOfDay selectedTime = TimeOfDay.now();
  //    final TimeOfDay? picked = await showTimePicker(
  //      context: context,
  //      initialTime: selectedTime,
  //    );
  //    if (picked != null && picked != selectedTime) {
  //
  //        selectedTime = picked;
  //    }
  //
  //    final now = DateTime.now();
  //    final dt = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
  //    final formattedTime = "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";
  //    return formattedTime;
  //
  //  }

  static Future<String?> selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      selectedTime = picked;

      // Format the time as "HH:mm"
      final formattedTime =
          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";

      return formattedTime;
    }

    return null;
  }

  static Future<String?> selectTimeWithSeconds(BuildContext context) async {
    int hour = TimeOfDay.now().hour;
    int minute = TimeOfDay.now().minute;
    int second = DateTime.now().second;

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Select Time",
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),
            textAlign: TextAlign.center,
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _timePickerColumn(
                  label: "HH",
                  value: hour,
                  max: 24,
                  onChanged: (v) {
                    hour = v!;
                    (context as Element).markNeedsBuild();
                  },
                ),
                _divider(),
                _timePickerColumn(
                  label: "MM",
                  value: minute,
                  max: 60,
                  onChanged: (v) {
                    minute = v!;
                    (context as Element).markNeedsBuild();
                  },
                ),
                _divider(),
                _timePickerColumn(
                  label: "SS",
                  value: second,
                  max: 60,
                  onChanged: (v) {
                    second = v!;
                    (context as Element).markNeedsBuild();
                  },
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child:  Text(
                "Cancel",
                style: TextStyle(color: AppColor.primaryBackgroundColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                final formatted = "${hour.toString().padLeft(2, '0')}:"
                    "${minute.toString().padLeft(2, '0')}:"
                    "${second.toString().padLeft(2, '0')}";

                Navigator.pop(context, formatted);
              },
              child:  Text("OK",style: TextStyle(color: AppColor.primaryBackgroundColor),),
            ),
          ],
        );
      },
    );
  }

  static Widget _timePickerColumn({
    required String label,
    required int value,
    required int max,
    required Function(int?) onChanged,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: DropdownButton<int>(
            value: value,
            underline: Container(),
            isDense: true,
            style: const TextStyle(fontSize: 16),
            items: List.generate(
              max,
                  (i) => DropdownMenuItem(
                value: i,
                child: Text(
                  i.toString().padLeft(2, '0'),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  static Widget _divider() => const Text(
    ":",
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );

  static Future<String?> selectTimeWithAmPm(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      final now = DateTime.now();

      // Convert TimeOfDay to full DateTime to include seconds
      final selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
        now.second, // capture current seconds (or set as 0 if needed)
      );

      // Format to 12-hour time with seconds and lowercase am/pm
      final formattedTime =
      DateFormat("h:mm:ss a").format(selectedDateTime).toLowerCase();

      return formattedTime;
    }

    return null;
  }
}
