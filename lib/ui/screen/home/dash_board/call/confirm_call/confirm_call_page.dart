import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/components/chip_item_select.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'confirm_call_controller.dart';

class ConfirmCall extends GetView<ConfirmCallController> {
  const ConfirmCall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: ConfirmCallMobilePage(controller: controller),
      desktop: ConfirmCallMobilePage(controller: controller),
    ));
  }
}

class ConfirmCallMobilePage extends StatelessWidget {
  const ConfirmCallMobilePage({super.key, required this.controller});

  final ConfirmCallController controller;

  Widget _buildReservationItem(
      {required String label, required String? content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getSvgImage('ic_$label'),
                const SizedBox(width: 4),
                Text(
                  label.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Text(
            ': ${content ?? ''}',
            style: tButtonWhiteTextStyle.copyWith(
                fontSize: 12, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _buildEdit({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: tButtonWhiteTextStyle.copyWith(fontSize: 12),
          ),
          const SizedBox(width: kSmallPadding),
          getSvgImage('ic_arrow_right', color: kPrimaryColor)
        ],
      ),
    );
  }

  Widget _buildReservationDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'reservation_detail'.tr,
          style: tButtonWhiteTextStyle.copyWith(
              fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: kSmallPadding),
        Obx(() {
          return _buildReservationItem(
              label: 'start_time',
              content: controller.ticket.value.startTimeAfter?.tr);
        }),
        Obx(() {
          return _buildReservationItem(
              label: 'required_time',
              content: controller.ticket.value.durationDate?.tr);
        }),
        Obx(() {
          return _buildReservationItem(
              label: 'meeting_place',
              content: controller.ticket.value.stateName);
        }),
        Obx(() {
          return _buildReservationItem(
              label: 'number_people',
              content:
                  '${controller.ticket.value.numberPeople ?? 0}${'people'.tr}');
        }),
        const SizedBox(height: kSmallPadding),
        _buildEdit(
            label: 'edit_reservation_detail'.tr,
            onTap: controller.onSwitchReservation),
        const SizedBox(height: kSmallPadding),
        const Divider(),
      ],
    );
  }

  Widget _buildTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'today_mood'.tr,
          style: tButtonWhiteTextStyle.copyWith(
              fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: controller.ticket.value.tagInformation
                  .map((e) => ChipItemSelect(
                        value: e,
                        label: e,
                      ))
                  .toList(),
            ),
          );
        }),
        _buildEdit(label: 'edit_tag'.tr, onTap: controller.onSwitchEditTag),
        const SizedBox(height: kSmallPadding),
        const Divider(),
      ],
    );
  }

  Widget _buildPrice() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'total'.tr,
              style: tButtonWhiteTextStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w500),
            )),
            Obx(() {
              return Text(
                formatCurrency(controller.ticket.value.calculateTotalPrice()),
                style: tButtonWhiteTextStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w500),
              );
            })
          ],
        ),
        const SizedBox(height: kDefaultPadding),
        Text(
          'extension_price'.tr,
          style: tButtonWhiteTextStyle.copyWith(fontSize: 10),
        )
      ],
    );
  }

  Widget _buildBody() {
    List<Widget> _listWidget = [
      Text(
        'confirm_call'.tr,
        style: tButtonWhiteTextStyle.copyWith(fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: kDefaultPadding),
      _buildReservationDetail(),
      const SizedBox(height: kSmallPadding),
      _buildTags(),
      const SizedBox(height: kDefaultPadding),
      _buildPrice(),
      const SizedBox(height: kDefaultPadding),
      CustomButton(
          onPressed: () async {
            controller.onConfirm();
          },
          borderRadius: 4,
          widget: Text(
            'confirm_booking'.tr,
            style: tNormalTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          )),
      const SizedBox(height: kDefaultPadding),
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(kDefaultPadding),
      itemCount: _listWidget.length,
      itemBuilder: (BuildContext context, int index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        title: Text('call_cast'.tr),
        leadingWidth: 100,
        leading: backButtonText(callback: controller.onPressedBack),
      ),
      body: _buildBody(),
    );
  }
}
