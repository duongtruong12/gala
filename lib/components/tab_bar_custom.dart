import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';

class TabBarCustom extends StatelessWidget {
  const TabBarCustom(
      {super.key,
      required this.controller,
      required this.tabs,
      this.padding = kDefaultPadding * 3});

  final TabController controller;
  final List<Widget> tabs;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black54,
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
              tabs: tabs),
        ),
      ),
    );
  }
}
