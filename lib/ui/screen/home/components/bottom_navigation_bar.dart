import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigatorWidget extends StatelessWidget {
  const BottomNavigatorWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.femaleGender = false,
  });

  final bool femaleGender;
  final int currentIndex;
  final ValueSetter<int?> onTap;

  BottomNavigationBarItem _buildItem({required String label, required index}) {
    final color = index == currentIndex
        ? femaleGender
            ? kPrimaryColorFemale
            : kPrimaryColor
        : kMenuGray;
    return BottomNavigationBarItem(
      icon: getSvgImage(index == currentIndex ? '$label${'_select'}' : label,
          color: color, boxFit: BoxFit.fitHeight),
      backgroundColor: femaleGender
          ? kPrimaryBackgroundColorFemale
          : kPrimaryBackgroundColor,
      label: label.tr,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _buildItem(label: 'search', index: 0),
        _buildItem(label: 'message', index: 1),
        _buildItem(label: 'call', index: 2),
        _buildItem(label: 'my_page', index: 3),
      ],
      type: BottomNavigationBarType.fixed,
      backgroundColor: femaleGender ? kPrimaryBackgroundColorFemale : kMenuBk,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: femaleGender ? kPrimaryColorFemale : kPrimaryColor,
      unselectedItemColor: kMenuGray,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: tNormalTextStyle.copyWith(
        color: femaleGender ? kPrimaryColorFemale : kPrimaryColor,
      ),
      unselectedLabelStyle: tNormalTextStyle.copyWith(color: kMenuGray),
    );
  }
}
