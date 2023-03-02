import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class WebNavigator extends StatelessWidget {
  const WebNavigator({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueSetter<int?> onTap;

  Widget _buildItem({required String label, required index}) {
    final color = index == currentIndex ? kPrimaryColor : kMenuGray;
    return InkWell(
      onTap: () async {
        onTap(index);
      },
      child: Obx(() {
        return badges.Badge(
          badgeContent: Text(
            '${unread.value}',
            style: tButtonWhiteTextStyle.copyWith(fontSize: 8),
          ),
          showBadge: unread.value > 0 && index == 2,
          position: badges.BadgePosition.topEnd(),
          child: Padding(
              padding: const EdgeInsetsDirectional.all(kDefaultPadding),
              child: Text(
                label,
                style: tNormalTextStyle.copyWith(color: color),
              )),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: double.infinity,
      constraints: const BoxConstraints(maxWidth: 300),
      decoration: const BoxDecoration(
        color: kMenuBk,
        boxShadow: [
          BoxShadow(
            color: kBorderColor,
            offset: Offset(1, 0),
          )
        ],
      ),
      child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItem(label: 'caster_manager'.tr, index: 0),
              _buildItem(label: 'guest_manager'.tr, index: 1),
              _buildItem(label: 'chat_manager'.tr, index: 2),
              // _buildItem(label: 'payment_manager'.tr, index: 3),
              _buildItem(label: 'cast_payment_manager'.tr, index: 3),
              _buildItem(label: 'call_list'.tr, index: 4),
            ],
          )),
    );
  }
}
