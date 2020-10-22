import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static Color descText = HexColor('#829099');
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';
  static Color background = HexColor('#F6F7F9');
  static Color url = HexColor('#6FA0FB');
  static Color mainBackground = HexColor('#f6f9fb');

  static const Color subLightTextColor = Color(0xffc4c4c4);
  static const Color subTextColor = Color(0xff959595);
  static const Color primaryLightValue = Color(0xFF42464b);
  static Color actionColor = url;


  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle( // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle( // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle( // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle( // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle( // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle( // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle( // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

}

class MarkdownTheme {

  static const lagerTextSize = 26.0;
  static const bigTextSize = 22.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static TextStyle smallTextWhite = TextStyle(
    color: AppTheme.white,
    fontSize: duSetFontSize(smallTextSize),
  );

  static TextStyle smallText = TextStyle(
    color: AppTheme.white,
    fontSize: duSetFontSize(smallTextSize),
  );

  static TextStyle smallTextBold = TextStyle(
    color: AppTheme.darkText,
    fontSize: duSetFontSize(smallTextSize),
    fontWeight: FontWeight.bold,
  );

  static TextStyle smallSubLightText = TextStyle(
    color: AppTheme.subLightTextColor,
    fontSize: duSetFontSize(smallTextSize),
  );

  static TextStyle smallActionLightText = TextStyle(
    color: AppTheme.actionColor,
    fontSize: duSetFontSize(smallTextSize),
  );

  static TextStyle smallMiLightText = TextStyle(
    color: AppTheme.nearlyWhite,
    fontSize: duSetFontSize(smallTextSize),
  );

  static TextStyle smallSubText = TextStyle(
    color: AppTheme.subTextColor,
    fontSize: duSetFontSize(smallTextSize),
  );

  static TextStyle middleText = TextStyle(
    color: AppTheme.darkText,
    fontSize: duSetFontSize(middleTextWhiteSize),
  );

  static TextStyle middleTextWhite = TextStyle(
    color: AppTheme.white,
    fontSize: duSetFontSize(middleTextWhiteSize),
  );

  static TextStyle middleSubText = TextStyle(
    color: AppTheme.subTextColor,
    fontSize: duSetFontSize(middleTextWhiteSize),
  );

  static TextStyle middleSubLightText = TextStyle(
    color: AppTheme.subLightTextColor,
    fontSize: duSetFontSize(middleTextWhiteSize),
  );

  static TextStyle middleTextBold = TextStyle(
    color: AppTheme.darkText,
    fontSize: duSetFontSize(middleTextWhiteSize),
    fontWeight: FontWeight.bold,
  );

  static TextStyle middleTextWhiteBold = TextStyle(
    color: AppTheme.white,
    fontSize: duSetFontSize(middleTextWhiteSize),
    fontWeight: FontWeight.bold,
  );

  static TextStyle middleSubTextBold = TextStyle(
    color: AppTheme.subTextColor,
    fontSize: duSetFontSize(middleTextWhiteSize),
    fontWeight: FontWeight.bold,
  );

  static TextStyle normalText = TextStyle(
    color: AppTheme.darkText,
    fontSize: duSetFontSize(normalTextSize),
  );

  static TextStyle normalTextBold = TextStyle(
    color: AppTheme.darkText,
    fontSize: duSetFontSize(normalTextSize),
    fontWeight: FontWeight.bold,
  );

  static TextStyle normalSubText = TextStyle(
    color: AppTheme.subTextColor,
    fontSize: duSetFontSize(normalTextSize),
  );

  static TextStyle normalTextWhite = TextStyle(
    color: AppTheme.white,
    fontSize: duSetFontSize(normalTextSize),
  );

  static TextStyle normalTextMitWhiteBold = TextStyle(
    color: AppTheme.nearlyWhite,
    fontSize: duSetFontSize(normalTextSize),
    fontWeight: FontWeight.bold,
  );

  static TextStyle normalTextActionWhiteBold = TextStyle(
    color: AppTheme.actionColor,
    fontSize: duSetFontSize(normalTextSize),
    fontWeight: FontWeight.bold,
  );

  static TextStyle normalTextLight = TextStyle(
    color: AppTheme.primaryLightValue,
    fontSize: duSetFontSize(normalTextSize),
  );

  static TextStyle largeText = TextStyle(
    color: AppTheme.darkText,
    fontSize: duSetFontSize(bigTextSize),
  );

  static TextStyle largeTextBold = TextStyle(
    color: AppTheme.darkText,
    fontSize: duSetFontSize(bigTextSize),
    fontWeight: FontWeight.bold,
  );

  static TextStyle largeTextWhite = TextStyle(
    color: AppTheme.white,
    fontSize: duSetFontSize(bigTextSize),
  );

  static TextStyle largeTextWhiteBold = TextStyle(
    color: AppTheme.white,
    fontSize: duSetFontSize(lagerTextSize),
    fontWeight: FontWeight.bold,
  );

  static TextStyle largeLargeTextWhite = TextStyle(
    color: AppTheme.white,
    fontSize: duSetFontSize(lagerTextSize),
    fontWeight: FontWeight.bold,
  );

  static TextStyle largeLargeText = TextStyle(
    color: AppTheme.darkText,
    fontSize: duSetFontSize(lagerTextSize),
    fontWeight: FontWeight.bold,
  );
}
