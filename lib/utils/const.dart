import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFBCA674);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kTextColorPrimary = Color(0xFFBBA478);
const kTextColorSecond = Colors.white;
const kTextColorDark = Color(0xFF2F2F2F);
const kTextColorDarkLight = Color(0xFF787878);
const kGrayColor = Color(0xFF707070);
const kBorderColor = Color(0xFF999999);
const kDividerColor = Color(0xFFDEDEDE);
const kTextFieldBackground = Color(0xFFBFBFBF);
const kErrorColor = Colors.red;
const kHintColor = Colors.grey;
const kDisableColor = Colors.grey;
const kMenuGray = Color(0xFF95989A);
const kMenuBk = Color(0xFF141414);
const kPrimaryBackgroundColor = Color(0xFF000000);
const kGradient1 = Color(0xFFC89749);
const kGradient2 = Color(0xFFFFEE9D);
const kGradient3 = Color(0xFFDEAC55);
const kGradient4 = Color(0xFFEFC978);
const kGradient5 = Color(0xFFFDDD90);
const kGradient6 = Color(0xFFDFB156);
const kGradient7 = Color(0xFFFCF6B2);
const kGradient8 = Color(0xFFCE9F47);
const kButtonBackground = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: [0.0, 0.1, 0.3, 0.4, 0.5, 0.8, 0.9, 1.0],
  colors: [
    kGradient1,
    kGradient2,
    kGradient3,
    kGradient4,
    kGradient5,
    kGradient6,
    kGradient7,
    kGradient8
  ],
);

const double kSmallPadding = 8.0;
const double kDefaultPadding = 16.0;
const double kMediumTextSize = 16.0;
const double kNormalTextSize = 14.0;

const tNormalTextStyle = TextStyle(
    fontSize: kNormalTextSize, color: kTextColorDark, fontFamily: 'NotoSansJP');
const tButtonWhiteTextStyle = TextStyle(
    color: kTextColorSecond,
    fontSize: kMediumTextSize,
    fontFamily: 'NotoSansJP');

const defaultBorder =
    UnderlineInputBorder(borderSide: BorderSide(color: kBorderColor, width: 1));
const errorBorder =
    UnderlineInputBorder(borderSide: BorderSide(color: kErrorColor, width: 1));
const radiusBorder = BorderRadius.all(Radius.circular(2.0));

const defaultBorderRounded = OutlineInputBorder(
    borderRadius: radiusBorder,
    borderSide: BorderSide(color: kTextFieldBackground));
const focusedBorderRounded = OutlineInputBorder(
    borderRadius: radiusBorder, borderSide: BorderSide(color: kPrimaryColor));
const errorBorderRounded = OutlineInputBorder(
    borderRadius: radiusBorder, borderSide: BorderSide(color: kErrorColor));

ThemeData tThemeData = ThemeData(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: Colors.transparent,
  textTheme: const TextTheme(bodyText1: tNormalTextStyle),
  fontFamily: 'NotoSansJP',
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return kPrimaryColor;
        }
        return Colors.white;
      },
    ),
    trackColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return kPrimaryColor.withOpacity(0.57);
        }
        return Colors.white;
      },
    ),
  ),
  dividerTheme: const DividerThemeData(
      thickness: 0.5, space: kDefaultPadding, color: kDividerColor),
  chipTheme: ChipThemeData(
    elevation: 3,
    backgroundColor: kPrimaryColor,
    labelStyle:
        tNormalTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
  ),
  inputDecorationTheme: InputDecorationTheme(
    iconColor: kPrimaryColor,
    prefixIconColor: kPrimaryColor,
    errorStyle: tNormalTextStyle.copyWith(color: Colors.red),
    labelStyle: tNormalTextStyle.copyWith(fontSize: 12),
    contentPadding: EdgeInsets.zero,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorBorder: errorBorder,
    enabledBorder: defaultBorder,
    border: defaultBorder,
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: kPrimaryColor, primary: kPrimaryColor),
);
