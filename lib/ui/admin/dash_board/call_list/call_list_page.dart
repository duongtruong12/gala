import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/ui/admin/dash_board/call_list/component/data_table_ticket.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'call_list_controller.dart';

class CallListPage extends GetView<CallListController> {
  const CallListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: CallListWebPage(controller: controller),
      desktop: CallListWebPage(controller: controller),
    ));
  }
}

class CallListWebPage extends StatelessWidget {
  const CallListWebPage({super.key, required this.controller});

  final CallListController controller;

  Widget _buildDropdown() {
    return Obx(() {
      return Container(
        height: 49,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(kSmallPadding)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              hint: Text('please_select'.tr,
                  style: tNormalTextStyle.copyWith(
                      fontSize: 12, color: kBorderColor)),
              isExpanded: true,
              value: controller.currentStatus.value,
              onChanged: controller.onChangeStatus,
              items: controller.listStatus.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    'ticket_$item'.tr,
                    style:
                        tButtonWhiteTextStyle.copyWith(color: kTextColorDark),
                  ),
                );
              }).toList()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'status'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: kDefaultPadding),
            _buildDropdown(),
            const SizedBox(height: kDefaultPadding),
            Expanded(
              child: Obx(() {
                return DataTableTicket(
                  list: controller.list.toList(),
                  onScrollDown: controller.onScrollDown,
                  isEmpty: controller.checkEmpty(),
                  onTapTicket: controller.switchTicket,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
