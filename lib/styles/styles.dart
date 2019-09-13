import 'package:flutter/material.dart';

final primaryDark = const Color(0xFF0081F6);
final primaryLight = const Color(0xFF44A6FF);

final blueShadow = const Color(0xFF44A6FF).withOpacity(0.20);
final border = const Color(0xFFE4E7F1);

//--------------------------------- screen height & width ----------------------------------

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

//.................................. SfProTextSemibold ....................................

TextStyle buttonWhiteTextSS() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Colors.white,
    fontFamily: 'SfProTextSemibold',
  );
}

//.................................. SfProTextRegular ....................................

TextStyle textWhiteTextSR() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.white,
    height: 1.0,
    fontFamily: 'SfProTextRegular',
  );
}

TextStyle textPrimaryTextSR() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: primaryDark,
    letterSpacing: 1.0,
    height: 1.0,
    fontFamily: 'SfProTextRegular',
  );
}

//.................................. AcuminProBold ....................................

TextStyle titleWhiteTextAB() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 28.0,
    color: Colors.white,
    fontFamily: 'AcuminProBold',
  );
}

TextStyle titleBlackTextAB() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 28.0,
    color: Colors.black,
    fontFamily: 'AcuminProBold',
  );
}

//.................................. AcuminProRegular ....................................

TextStyle textWhiteTextAR() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.white.withOpacity(0.84),
    letterSpacing: 1.0,
    height: 1.0,
    fontFamily: 'AcuminProRegular',
  );
}

TextStyle textLightWhiteTextAR() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.white.withOpacity(0.70),
    letterSpacing: 1.0,
    height: 1.0,
    fontFamily: 'AcuminProRegular',
  );
}

TextStyle textLightBlackTextAR() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.black.withOpacity(0.70),
    height: 1.0,
    fontFamily: 'AcuminProRegular',
  );
}

TextStyle subTitleLightBlackTextAR() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.black.withOpacity(0.70),
    height: 1.0,
    fontFamily: 'AcuminProRegular',
  );
}

TextStyle subTitleBlackTextAR() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.black,
    height: 1.0,
    fontFamily: 'AcuminProRegular',
  );
}

TextStyle subtitleWhiteTextAR() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.white.withOpacity(0.84),
    letterSpacing: 1.0,
    height: 1.0,
    fontFamily: 'AcuminProRegular',
  );
}

TextStyle subtitlePrimaryTextAR() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: primaryDark,
    letterSpacing: 1.0,
    height: 1.0,
    fontFamily: 'AcuminProRegular',
  );
}