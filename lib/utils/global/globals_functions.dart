import 'dart:io';

import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';
import 'globals_variable.dart';

showInfo(String message) {
  if (Get.context != null) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

showError(String message) {
  if (Get.context != null) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message,
            style: tNormalTextStyle.copyWith(color: Colors.white)),
        backgroundColor: kErrorColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

showCustomBottomSheet(Widget childWidget) {
  if (Get.context != null) {
    showModalBottomSheet<dynamic>(
        context: Get.context!,
        builder: (context) {
          return Card(
            elevation: 3.0,
            margin: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // 1st use min not max
                children: <Widget>[childWidget],
              ),
            ),
          );
        });
  }
}

Future<String?> getDownloadDirectory() async {
  try {
    final temp = await getTemporaryDirectory();
    String path = temp.path;
    final directories = Directory(path);
    if (!directories.existsSync()) {
      directories.createSync();
    }
    return path;
  } catch (e) {
    logger.e(e);
    return null;
  }
}

dismissKeyboard() {
  if (Get.context != null) {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }
}

Widget getLottieImage(String assetName,
    {BoxFit? boxFit, double? height, double? width}) {
  return Lottie.asset(
    'assets/lottie/$assetName.json',
    height: height,
    width: width,
    fit: boxFit ?? BoxFit.cover,
  );
}

void setStatusBarColor({Brightness brightness = Brightness.light}) {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: brightness));
}

Widget getSvgImage(String assetName,
    {BoxFit? boxFit, double? height, double? width, Color? color}) {
  return SvgPicture.asset(
    'assets/image/$assetName.svg',
    height: height,
    width: width,
    color: color,
    fit: boxFit ?? BoxFit.cover,
  );
}

Widget getPngImage(String assetName,
    {BoxFit? boxFit, double? height, double? width}) {
  return Image.asset(
    'assets/image/$assetName.png',
    height: height,
    width: width,
    fit: boxFit ?? BoxFit.cover,
  );
}

Widget buildEmptyList(String str) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Column(
          children: [
            SizedBox(height: setHeight(72)),
            getSvgImage('ic_building_empty'),
            SizedBox(height: setHeight(54)),
            Text(
              str,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: tNormalTextStyle.copyWith(color: kHintColor),
            )
          ],
        ),
      ),
    ],
  );
}

setHeight(num value) {
  return ScreenUtil().setHeight(value);
}

setWidth(num value) {
  return ScreenUtil().setWidth(value);
}

setSp(num value) {
  return ScreenUtil().setSp(value);
}

String formatDateTime({required DateTime date, required String formatString}) {
  try {
    return DateFormat(formatString).format(date);
  } catch (e) {
    return '$date';
  }
}

DateTime? convertStringToDateTime(
    {required String date, required String formatString}) {
  try {
    return DateFormat(DateTimeFormatString.yyyyMMdd).parse(date);
  } catch (e) {
    return null;
  }
}

String formatCurrency(num? number, {String symbol = CurrencySymbol.point}) {
  try {
    if (number != null && number != 0) {
      String currency =
          NumberFormat.currency(locale: "ja_JP", customPattern: "#,###")
              .format(number)
              .replaceAll('.', ',');
      return '$currency $symbol';
    } else {
      return '0 $symbol';
    }
  } catch (e) {
    logger.e(e);
    return '$number$symbol';
  }
}

bool isNumeric(dynamic s) {
  try {
    if (s == null) {
      return false;
    }
    return num.tryParse(s) != null;
  } catch (_) {
    return false;
  }
}

num convertStringToNumber(String? str) {
  num number = 0;
  try {
    if (str != null && str.isNotEmpty) {
      String result = str;
      if (str.length > 1) result = str.substring(0, str.indexOf('.'));
      number = num.parse(result.replaceAll(',', ''));
    }
    return number;
  } catch (e) {
    logger.e(e);
    return number;
  }
}

Uri? convertStringToUri(String url) {
  try {
    return Uri.parse(url);
  } catch (e) {
    logger.e(e);
    return null;
  }
}

openUrl(String? url) async {
  try {
    if (url != null && url.isNotEmpty) {
      if (await canLaunchUrl(Uri.parse(url))) {
        launchUrl(Uri.parse(url));
      }
    }
  } catch (e) {
    logger.e(e);
  }
}

Widget buildRowItem(Widget item1, Widget item2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Expanded(child: item1), item2],
  );
}

Widget buildRichText(String text1, String text2, {bool isBold = false}) {
  return RichText(
    maxLines: 2,
    text: TextSpan(children: [
      TextSpan(
        text: '$text1: ',
        style: tNormalTextStyle.copyWith(color: kHintColor),
      ),
      TextSpan(
          text: text2,
          style: isBold
              ? tNormalTextStyle.copyWith(fontWeight: FontWeight.bold)
              : tNormalTextStyle.copyWith()),
    ]),
  );
}

Widget buildCard({required List<Widget> children}) {
  return Card(
      margin: EdgeInsets.only(bottom: setHeight(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ));
}

Widget buildEmptyText(String emptyText) {
  return Text(
    sprintf('error_empty_list'.tr, [emptyText]),
    style: tNormalTextStyle.copyWith(color: kHintColor),
  );
}
