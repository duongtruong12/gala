import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/components/user_item.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'call_controller.dart';

class CallPage extends GetView<CallController> {
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: CallMobilePage(controller: controller),
      desktop: CallMobilePage(controller: controller),
    ));
  }
}

class CallMobilePage extends StatelessWidget {
  const CallMobilePage({super.key, required this.controller});

  final CallController controller;

  Widget _buildSelectArea() {
    return InkWell(
      onTap: controller.showSelectCity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                child: Text(
              'area'.tr,
              style: tNormalTextStyle.copyWith(
                  color: kTextColorSecond,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )),
            Obx(() {
              return Text(
                controller.ticket.value.cityName ?? 'unselected'.tr,
                style: tNormalTextStyle.copyWith(
                    color: kTextColorPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              );
            }),
            const SizedBox(width: 4),
            getSvgImage('ic_arrow_down', color: kTextColorPrimary)
          ]),
          const SizedBox(height: kSmallPadding),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildItemFilter({
    required String label,
    required String content,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: kSmallPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getSvgImage('ic_$label'),
              const SizedBox(width: kSmallPadding),
              Expanded(
                child: Text(
                  label.tr,
                  style: tNormalTextStyle.copyWith(
                      color: kTextColorSecond, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                content,
                style: tNormalTextStyle.copyWith(
                    color: kTextColorSecond, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 4),
              getSvgImage('ic_arrow_down', color: kTextColorPrimary)
            ],
          ),
          const SizedBox(height: kSmallPadding),
          const Divider()
        ],
      ),
    );
  }

  Widget _buildListFilter() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'call_cast'.tr,
            style: tNormalTextStyle.copyWith(
                color: kTextColorSecond, fontSize: 16),
          ),
          const SizedBox(height: kSmallPadding),
          _buildItemFilter(
              label: 'start_time',
              content:
                  controller.ticket.value.startTimeAfter?.tr ?? 'unselected'.tr,
              onPressed: controller.selectListStartTime),
          _buildItemFilter(
              label: 'meeting_place',
              content: controller.ticket.value.stateName ?? 'unselected'.tr,
              onPressed: controller.showSelectState),
          _buildItemFilter(
              label: 'number_people',
              content: controller.ticket.value.numberPeople != null
                  ? '${controller.ticket.value.numberPeople}${'people'.tr}'
                  : 'unselected'.tr,
              onPressed: controller.showInputMaxNumber),
          _buildItemFilter(
              label: 'required_time',
              content:
                  controller.ticket.value.durationDate?.tr ?? 'unselected'.tr,
              onPressed: controller.selectListDurationDate),
        ],
      );
    });
  }

  Widget _buildListGirl() {
    return SizedBox(
      height: 163,
      child: Obx(() {
        if (controller.list.isEmpty) {
          return const SizedBox(
            height: 32,
            width: 32,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.list.length,
          itemBuilder: (BuildContext context, int index) {
            final element = controller.list[index];
            return UserItem(
              model: element,
              onPressed: () {
                controller.onSwitchFemaleDetail(element.id);
              },
            );
          },
        );
      }),
    );
  }

  List<Widget> buildList() {
    return [
      _buildSelectArea(),
      const SizedBox(height: kDefaultPadding),
      _buildListFilter(),
      const SizedBox(height: kDefaultPadding),
      CustomButton(
          onPressed: controller.switchSelectMood,
          borderRadius: 4,
          widget: Text(
            'call_cast'.tr,
            style: tNormalTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          )),
      const SizedBox(height: kDefaultPadding * 2),
      _buildListGirl(),
    ];
  }

  Widget _buildBody() {
    final list = buildList();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(kDefaultPadding),
      itemBuilder: (BuildContext context, int index) {
        return list[index];
      },
      itemCount: list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        title: Text('call_cast'.tr),
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: Obx(() => controller.edit.value == true
            ? backButtonText(callback: controller.onPressedBack)
            : const SizedBox()),
      ),
      body: _buildBody(),
    );
  }
}
