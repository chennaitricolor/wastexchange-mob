import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/utils/app_colors.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);

  static const IconThemeData iconTheme =
      IconThemeData(color: AppTheme.dark_grey);

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle body = TextStyle(
    // h6 -> title
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 18,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle bodyThin = TextStyle(
    // h6 -> title
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.normal,
    fontSize: 18,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle titleWhite = TextStyle(
    // h6 -> title
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: nearlyWhite,
  );

  static const TextStyle navigationItem = TextStyle(
    // h6 -> title
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.18,
    color: dark_grey,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle subtitleWhite = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: nearlyWhite,
  );

  static const TextStyle subtitleGreen = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: AppColors.green,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body3 = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 13,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextStyle buttonTitle = TextStyle(
    // Caption -> caption
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: white, // was lightText
  );

  static const TextStyle hintText = TextStyle(
    // body1 -> body2
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: lightText,
  );
}
