import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/components/my_message/my_message_item.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/components/notification_message.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/components/other_message/message_item.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/components/ticket_create_message.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/detail/components/field_input.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/notification_border_message.dart';
import 'components/expanded_view.dart';
import 'message_detail_controller.dart';

class MessageDetailPage extends GetView<MessageDetailController> {
  const MessageDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Responsive(
        mobile: MessageMobilePage(controller: controller),
        desktop: MessageMobilePage(controller: controller),
      ),
    );
  }
}

class MessageMobilePage extends StatelessWidget {
  const MessageMobilePage({super.key, required this.controller});

  final MessageDetailController controller;

  Widget _buildGroupUser() {
    if (controller.model.value?.messageGroupType ==
        MessageGroupType.admin.name) {
      return const SizedBox();
    }
    return Column(
      children: [
        Container(
          color: casterAccount.value ? const Color(0xFFE6E6E6) : kPrimaryColor,
          padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
          height: 48,
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.model.value?.userIds.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FutureBuilder<UserModel?>(
                        future: fireStoreProvider.getUserDetail(
                            id: controller.model.value?.userIds[index],
                            source: Source.cache),
                        builder: (context, data) {
                          final userData = data.data;
                          return InkWell(
                            onTap: () {
                              controller.onSwitchUserDetail(
                                  controller.model.value?.userIds[index]);
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: kDefaultPadding),
                              height: 32,
                              width: 32,
                              child: CustomCircleImage(
                                  radius: 99,
                                  image: CustomNetworkImage(
                                    url: userData?.avatar,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          );
                        });
                  },
                ),
              ),
              InkWell(
                  onTap: controller.switchExpanded,
                  child: getSvgImage('ic_arrow_down')),
              const SizedBox(width: kDefaultPadding),
            ],
          ),
        ),
        Obx(() {
          return ExpandedView(
            ticketId: controller.model.value?.ticketId,
            expanded: controller.expanded.value,
            list: controller.mapCountTime.values.toList(),
            onPressed: controller.countTicketTime,
          );
        }),
      ],
    );
  }

  Widget _buildMessageList(context, i) {
    final model = controller.list[i];
    Widget dateWidget = const SizedBox();
    Widget item;
    if (i != 0 && i != controller.list.length - 1) {
      final previousModel = controller.list[i - 1];
      if (model.createdTime!.difference(previousModel.createdTime!).inHours >
          1) {
        dateWidget = Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: NotificationMessage(
              content: formatDateTime(
                  date: model.createdTime,
                  formatString: DateTimeFormatString.mmddeeee)),
        );
      }
    }

    if (model.userId == user.value?.id) {
      item = MyMessageItem(model: model);
    } else {
      item = MessageItem(model: model);
    }

    if (model.type == SendMessageType.join.name ||
        model.type == SendMessageType.create.name) {
      item = NotificationMessage(content: model.content);
    }

    if (model.type == SendMessageType.leave.name ||
        model.type == SendMessageType.disband.name) {
      item = NotificationBorderMessage(content: model.content);
    }

    if (model.type == SendMessageType.pointCost.name) {
      if (user.value?.typeAccount == TypeAccount.guest.name) {
        item = NotificationBorderMessage(content: model.content);
      } else {
        return const SizedBox();
      }
    }

    if (model.type == SendMessageType.createTicket.name) {
      item = TicketCreatedMessage(
        ticketId: model.ticketId,
        content: model.content,
        onSwitchDetail: () async {
          controller.switchDetailTicket(model.ticketId);
        },
      );
    }

    return Column(
      crossAxisAlignment: model.userId == 'me'
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      mainAxisAlignment: model.userId == 'me'
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [dateWidget, item, const SizedBox(height: kSmallPadding)],
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (controller.model.value?.userIds.contains(user.value?.id) != true) {
        return textEmpty(label: 'message_permission'.tr);
      }

      return controller.list.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildGroupUser(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.onRefresh(1);
                    },
                    child: ListView.builder(
                      controller: controller.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding, vertical: kSmallPadding),
                      itemBuilder: _buildMessageList,
                      itemCount: controller.list.length,
                    ),
                  ),
                )
              ],
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.onCallBack();
        return false;
      },
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appbarCustom(
              title: Obx(() {
                return Text(controller.model.value?.title ?? '');
              }),
              automaticallyImplyLeading: false,
              leadingWidth: 100,
              leading: backButtonText(callback: controller.onCallBack)),
          body: _buildBody(),
          bottomNavigationBar: Obx(() {
            return (controller.model.value?.userIds.contains(user.value?.id) ==
                            true &&
                        !controller.messageGroupEnd()) ||
                    controller.model.value?.messageGroupType ==
                        MessageGroupType.admin.name
                ? FieldInput(
                    onInput: controller.sendMessage,
                  )
                : const SizedBox();
          }),
        ),
      ),
    );
  }
}
