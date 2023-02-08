import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      child: Padding(
          padding: const EdgeInsetsDirectional.all(kDefaultPadding),
          child: Text(
            label,
            style: tNormalTextStyle.copyWith(color: color),
          )),
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
              _buildItem(
                  label: 'caster_manager'.tr,
                  index: RouteIdAdmin.casterManager),
              _buildItem(
                  label: 'guest_manager'.tr, index: RouteIdAdmin.guestManager),
              _buildItem(
                  label: 'chat_manager'.tr, index: RouteIdAdmin.chatManager),
              _buildItem(
                  label: 'payment_manager'.tr,
                  index: RouteIdAdmin.paymentManager),
              _buildItem(
                  label: 'cast_payment_manager'.tr,
                  index: RouteIdAdmin.castPaymentManager),
              _buildItem(label: 'call_list'.tr, index: RouteIdAdmin.callList),
            ],
          )),
    );
  }
}
