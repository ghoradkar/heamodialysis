import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final String fontFam;
  final Color textColor;

  /// Optional line / overflow control. Defaults keep the original behaviour
  /// (wrap freely, no clipping) so existing call sites are unaffected. Pass
  /// `maxLines` + `overflow: TextOverflow.ellipsis` where the text sits in a
  /// bounded box - important now that bilingual "EN / FR" strings are ~2x
  /// wider.
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  const CustomText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.fontFam = 'Lato',
      required this.fontWeight,
      required this.textColor,
      required this.textAlign,
      this.maxLines,
      this.overflow,
      this.softWrap});

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
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
