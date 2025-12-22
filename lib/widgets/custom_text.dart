import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final String fontFam;
  final Color textColor;

  const CustomText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.fontFam = 'Lato',
      required this.fontWeight,
      required this.textColor,
      required this.textAlign}
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: "Lato",
          fontWeight: fontWeight,
          color: textColor),
      textAlign: textAlign,
    );
  }
}
