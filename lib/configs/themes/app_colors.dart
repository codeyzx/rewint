import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quizzle/configs/configs.dart';

// rewint theme
Color colorMain = HexColor('#251ABE');

TextStyle pageTitle = GoogleFonts.openSans(
  color: Colors.white,
  fontSize: 24.sp,
  fontWeight: FontWeight.w700,
);

TextStyle categoryTitle = GoogleFonts.openSans(
  color: colorMain,
  fontSize: 15.sp,
  fontWeight: FontWeight.w600,
);

TextStyle modeTitle = GoogleFonts.openSans(
  color: HexColor('#000349'),
  fontSize: 24.sp,
  fontWeight: FontWeight.w600,
);

TextStyle questionNumber = GoogleFonts.openSans(
  color: Colors.white,
  fontSize: 36.sp,
  fontWeight: FontWeight.w600,
);

TextStyle questionTxt = GoogleFonts.openSans(
  color: HexColor('#000349'),
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
);

TextStyle subquestionTxt = GoogleFonts.openSans(
  color: HexColor('#000349'),
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
);

TextStyle profileName = GoogleFonts.openSans(
  color: Colors.white,
  fontSize: 16.sp,
  fontWeight: FontWeight.w700,
);

TextStyle profileSubTitle = GoogleFonts.openSans(
  color: HexColor('#686868'),
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
);

TextStyle profileTotalPoint = GoogleFonts.openSans(
  color: Colors.white,
  fontSize: 16.sp,
  fontWeight: FontWeight.w700,
);

TextStyle profileHelp = GoogleFonts.openSans(
  color: HexColor('#686868'),
  fontSize: 10.sp,
  fontWeight: FontWeight.w400,
);

TextStyle profileComm = GoogleFonts.openSans(
  color: HexColor('#848484'),
  fontSize: 10.sp,
  fontWeight: FontWeight.w400,
);

TextStyle profileAchievNum = GoogleFonts.openSans(
  color: Colors.black,
  fontSize: 32.sp,
  fontWeight: FontWeight.w700,
);

TextStyle profileAchievName = GoogleFonts.openSans(
  color: HexColor('#676767'),
  fontSize: 12.sp,
  fontWeight: FontWeight.w400,
);

TextStyle sliverTitle = GoogleFonts.openSans(
  color: Colors.black,
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
);

TextStyle videoTitle = GoogleFonts.openSans(
  color: Colors.black,
  fontSize: 12.sp,
  fontWeight: FontWeight.w600,
);

TextStyle videoDuration = GoogleFonts.openSans(
  color: HexColor('#666666'),
  fontSize: 9.sp,
  fontWeight: FontWeight.w400,
);

TextStyle videoCost = GoogleFonts.openSans(
  color: Colors.white,
  fontSize: 9.sp,
  fontWeight: FontWeight.w600,
);

TextStyle appName = GoogleFonts.openSans(
  color: Colors.white,
  fontSize: 36.sp,
  fontWeight: FontWeight.w700,
  letterSpacing: 2,
);

TextStyle navSelected = GoogleFonts.openSans(
  color: colorMain,
  fontSize: 14.sp,
  fontWeight: FontWeight.w600,
  letterSpacing: 1,
);

TextStyle navUnSelected = GoogleFonts.openSans(
  color: HexColor('#8D8D8D'),
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  letterSpacing: 1,
);




const kOnSurfaceTextColor = Colors.white;
const kCorrectAnswerColor = Color.fromARGB(255, 0, 188, 100);
const kWrongAnswerColor = Color.fromARGB(255, 230, 24, 24);
const kNotAnswerColor = Color.fromARGB(255, 120, 50, 80);

// main gradient pattern for light theme
const mainGradientLT = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      kPrimayLightColorLT,
      kPrimayColorLT,
    ]);

// main gradient pattern for Dark theme
const mainGradientDT = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      kPrimayLightColorDT,
      kPrimayColorDT,
    ]);

LinearGradient mainGradient(BuildContext context) =>
    UIParameters.isDarkMode(context) ? mainGradientDT : mainGradientLT;

Color customScaffoldColor(BuildContext context) =>
    UIParameters.isDarkMode(context)
        ? const Color.fromARGB(255, 14, 20, 44)
        : const Color.fromARGB(255, 240, 237, 255);

Color answerBorderColor(BuildContext context) =>
    UIParameters.isDarkMode(context)
        ? const Color.fromARGB(255, 20, 46, 158)
        : const Color.fromARGB(255, 221, 221, 221);

Color answerSelectedColor(BuildContext context) =>
    Theme.of(context).primaryColor;
