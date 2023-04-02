import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const primaryClr = bluishClr;
const Color white = Colors.white;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Colors.grey.shade800;

class Themes {

  static final light = ThemeData(
  primaryColor: primaryClr,
  brightness: Brightness.light
  );

  static final dark =  ThemeData(
  primaryColor: darkGreyClr,
  brightness: Brightness.dark
  );
}
TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey
      )
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black
      )
  );
}

