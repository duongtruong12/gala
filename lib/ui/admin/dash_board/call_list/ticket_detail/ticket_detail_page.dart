import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_button.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/components/chip_item_select.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/components/user_item.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ticket_detail_controller.dart';

class TicketDetailPage extends GetView<TicketDetailController> {
  const TicketDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: TicketDetailWebPage(controller: controller),
      desktop: TicketDetailWebPage(controller: controller),
    ));
  }
}

class TicketDetailWebPage extends StatelessWidget {
  const TicketDetailWebPage({super.key, required this.controller});

  final TicketDetailController controller;

  Widget _buildAvatar() {
    return Obx(() {
      return FutureBuilder<UserModel?>(
          future: fireStoreProvider.getUserDetail(
              id: controller.model.value?.createdUser, source: Source.cache),
          builder: (context, data) {
            final userData = data.data;
            return InkWell(
              onTap: () {
                controller
                    .onSwitchFemaleDetail(controller.model.value?.createdUser);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomCircleImage(
                      radius: 99,
                      image: CustomNetworkImage(
                        url: userData?.avatar,
                        fit: BoxFit.cover,
                        height: 155,
                        width: 155,
                      )),
                  const SizedBox(width: kDefaultPadding),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        userData?.getDisplayName() ?? '',
                        style: tButtonWhiteTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: kSmallPadding),
                      Text(
                        'confirm_call'.tr,
                        style: tButtonWhiteTextStyle.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    });
  }

  Widget _buildReservationItem(
      {required String label, required String? content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getSvgImage('ic_$label'),
                const SizedBox(width: 4),
                Text(
                  label.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Text(
            ': ${content ?? ''}',
            style: tButtonWhiteTextStyle.copyWith(fontWeight: FontWeight.w500),
          )
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
              fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: kSmallPadding),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return _buildReservationItem(
                  label: 'start_time',
                  content: controller.model.value?.startTimeAfter?.tr);
            }),
            const SizedBox(width: kDefaultPadding * 2),
            Obx(() {
              return _buildReservationItem(
                  label: 'required_time',
                  content: controller.model.value?.durationDate?.tr);
            }),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return _buildReservationItem(
                  label: 'meeting_place',
                  content: controller.model.value?.stateName);
            }),
            const SizedBox(width: kDefaultPadding * 2),
            Obx(() {
              return _buildReservationItem(
                  label: 'number_people',
                  content:
                      '${controller.model.value?.numberPeople ?? 0}${'people'.tr}');
            }),
          ],
        ),
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
              fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Obx(() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: controller.model.value!.tagInformation
                  .map((e) => ChipItemSelect(
                        value: e,
                        label: e,
                      ))
                  .toList(),
            ),
          );
        }),
        const Divider(),
      ],
    );
  }

  Widget _buildPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                formatCurrency(controller.model.value?.calculateTotalPrice()),
                style: tButtonWhiteTextStyle.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w500),
              );
            })
          ],
        ),
      ],
    );
  }

  Widget _buildListApprove() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'people_approve'.tr,
          style: tButtonWhiteTextStyle.copyWith(
              fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: kDefaultPadding),
        SizedBox(
          height: 163,
          child: Obx(() {
            List<Widget> list = <Widget>[];
            list.addAll(controller.model.value!.peopleApprove.map((e) {
              return FutureBuilder<UserModel?>(
                  future: fireStoreProvider.getUserDetail(
                      id: e, source: Source.cache),
                  builder: (context, data) {
                    final userData = data.data;
                    if (userData == null) {
                      return const SizedBox();
                    }
                    return UserItem(
                      model: userData,
                      onPressed: () {
                        controller.onSwitchMessageDetail(e);
                      },
                      showNickName: true,
                    );
                  });
            }).toList());

            if (controller.model.value!.peopleApprove.length <
                    controller.model.value!.numberPeople! &&
                controller.model.value?.status == TicketStatus.created.name) {
              list.add(InkWell(
                onTap: controller.showSelectUser,
                child: Container(
                  width: 134,
                  height: 163,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(kSmallPadding)),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                  ),
                ),
              ));
            }

            if (list.isEmpty) {
              return textEmpty();
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return list[index];
              },
            );
          }),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildListApply() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'people_apply'.tr,
            style: tButtonWhiteTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: kDefaultPadding),
          controller.model.value?.peopleApply.isNotEmpty != true
              ? textEmpty()
              : SizedBox(
                  height: 163,
                  child: Obx(() {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.model.value?.peopleApply.length,
                      itemBuilder: (BuildContext context, int index) {
                        final element =
                            controller.model.value?.peopleApply[index];
                        return FutureBuilder<UserModel?>(
                            future: fireStoreProvider.getUserDetail(
                                id: element, source: Source.cache),
                            builder: (context, data) {
                              final userData = data.data;
                              if (userData == null) {
                                return const SizedBox();
                              }
                              return UserItem(
                                model: userData,
                                onPressed: () {
                                  controller.onSwitchMessageDetail(element);
                                },
                                showNickName: true,
                              );
                            });
                      },
                    );
                  }),
                ),
          const Divider(),
        ],
      );
    });
  }

  Widget _buildButton() {
    if (controller.model.value == null ||
        controller.model.value?.status == TicketStatus.cancelled.name ||
        controller.model.value?.status == TicketStatus.finish.name ||
        controller.model.value?.status == TicketStatus.done.name) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
                onPressed: controller.cancelTicket,
                borderRadius: 4,
                color: kGrayColor,
                borderColor: kGrayColor,
                widget: Text(
                  'cancel'.tr,
                  style: tButtonWhiteTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                )),
          ),
          const SizedBox(width: kDefaultPadding),
          if (controller.model.value?.peopleApprove.length ==
              controller.model.value?.numberPeople)
            Expanded(
              child: CustomButton(
                  onPressed: controller.createTicket,
                  borderRadius: 4,
                  widget: Text(
                    'confirm'.tr,
                    style: tNormalTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  )),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      _buildAvatar(),
      const Divider(),
      const SizedBox(height: kSmallPadding),
      _buildReservationDetail(),
      const SizedBox(height: kSmallPadding),
      _buildTags(),
      const SizedBox(height: kDefaultPadding),
      _buildListApply(),
      const SizedBox(height: kDefaultPadding),
      _buildListApprove(),
      const SizedBox(height: kDefaultPadding),
      _buildPrice(),
    ];
    return Scaffold(
      appBar: appbarCustom(
        leading: backButtonText(callback: controller.onPressedBack),
        leadingWidth: 100,
        title: Obx(
          () {
            return Text(controller.model.value?.getTicketName() ?? '');
          },
        ),
      ),
      bottomNavigationBar: Obx(() {
        return _buildButton();
      }),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Obx(() {
          return controller.model.value == null
              ? const SizedBox()
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return list[index];
                  },
                );
        }),
      ),
    );
  }
}
