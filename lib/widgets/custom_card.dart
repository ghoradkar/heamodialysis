import 'package:flutter/material.dart';

Widget  patientDetailsCard(
    String label,
    String details, {
      TextStyle? labelStyle,
      TextStyle? detailsStyle,
      bool showStatus = false,
      String? status,
      Color? statusColor
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label : ",
              style: labelStyle ?? AppTextStyles.label,
            ),
            TextSpan(
              text: details,
              style: detailsStyle ?? AppTextStyles.details,
            ),

          ],
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      // Optional status badge aligned to bottom-right
      if (showStatus && status != null)
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color:statusColor ?? Color(0xFF0E9981F),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              status,
              style: AppTextStyles.status,
              textAlign: TextAlign.center,
            ),
          ),
        ),
    ],
  );
}



class AppTextStyles {

  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontFamily: "Lato",
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.9,
    letterSpacing: 0,
    color: Color(0xFF000000),
  );


  static const TextStyle details = TextStyle(
    fontSize: 12,
    fontFamily: "Lato",
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.9,
    letterSpacing: 0,
    color: Color(0xFF484846),
  );
  static const TextStyle status = TextStyle(
    fontSize: 12,
    fontFamily: "Lato",
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}
