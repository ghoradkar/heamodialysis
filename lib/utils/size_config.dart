import 'package:flutter/widgets.dart';

class SizeConfig {
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier = 0;
  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      debugPrint("Orientation == 1");
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 750) {
        isMobilePortrait = true;
      }
    } else {
      debugPrint("Orientation == 2");
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    debugPrint("Orientation >>> == $orientation");
    debugPrint("imageSizeMultiplier == $_screenWidth");
    debugPrint("_screenWidth == $_screenWidth");
    debugPrint("_screenHeight == $_screenHeight");
    debugPrint("_blockWidth == $_blockWidth");
    debugPrint("_blockHeight == $_blockHeight");
    debugPrint("isPortrait == $isPortrait");
    debugPrint("isMobilePortrait == $isMobilePortrait");
  }
}