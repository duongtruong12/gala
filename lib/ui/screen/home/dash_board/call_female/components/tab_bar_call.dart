import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarCall extends StatelessWidget {
  const TabBarCall({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 3),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(kSmallPadding),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: TabBar(
              controller: controller,
              indicator: BoxDecoration(
                color: kPrimaryColorFemale,
                borderRadius: BorderRadius.circular(kSmallPadding),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              labelStyle: tNormalTextStyle.copyWith(color: kTextColorSecond),
              unselectedLabelStyle: tNormalTextStyle,
              unselectedLabelColor: kTextColorDark,
              labelColor: kTextColorSecond,
              tabs: [
                Tab(
                    text:
                        '${'today'.tr}(${formatDateTime(date: DateTime.now(), formatString: DateTimeFormatString.textBehindddMM)})'),
                Tab(text: 'next_day'.tr),
              ]),
        ),
      ),
    );
  }
}
