import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageGroupItem extends StatelessWidget {
  const MessageGroupItem({
    super.key,
    required this.model,
  });

  final MessageGroupModel model;

  Future<UserModel?> getUserModel() async {
    if (model.messageGroupType != MessageGroupType.admin.name ||
        user.value?.isAdminAccount() != true) {
      return null;
    }
    final index =
        model.userIds.indexWhere((element) => element != user.value?.id);
    if (index == -1) {
      return null;
    }
    return await fireStoreProvider.getUserDetail(
        id: model.userIds[index], source: Source.cache);
  }

  Future<UserModel?> getUserLastMessage() async {
    if (model.lastMessage?.type != SendMessageType.text.name ||
        model.lastMessage?.type != SendMessageType.image.name ||
        model.lastMessage?.type != SendMessageType.video.name) {
      return null;
    }
    if (model.lastMessage?.userId == user.value?.id) {
      return UserModel(
          previewImage: [],
          tagInformation: [],
          displayName: 'you'.tr,
          applyTickets: [],
          approveTickets: []);
    }
    return await fireStoreProvider.getUserDetail(
        id: model.lastMessage?.userId, source: Source.cache);
  }

  Widget _buildTicketStatus() {
    return FutureBuilder<Ticket?>(
        future: fireStoreProvider.getTicketDetail(id: model.ticketId),
        builder: (context, snapshot) {
          Widget getTextItem() {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator()));
            }
            String text = snapshot.data?.status == TicketStatus.done.name
                ? 'in_date'.tr
                : 'date_finish'.tr;
            return Text(
              text,
              style: tButtonWhiteTextStyle.copyWith(fontSize: 12),
            );
          }

          return Container(
            decoration: BoxDecoration(
                color: snapshot.data?.status == TicketStatus.done.name
                    ? kStatusGreen
                    : kStatusRed,
                borderRadius: const BorderRadius.all(Radius.circular(22))),
            padding: const EdgeInsets.symmetric(
                vertical: 4, horizontal: kSmallPadding),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: getTextItem(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
        future: getUserModel(),
        builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
          FontWeight font = FontWeight.bold;
          Color color = getTextColorSecond();
          //check if user read it
          if (model.seenMessage[user.value?.id] != null &&
              model.lastUpdatedTime != null &&
              model.seenMessage[user.value?.id]
                      ?.toDate()
                      .isAfter(model.lastUpdatedTime!) ==
                  true) {
            font = FontWeight.w500;
            color = kBorderColor;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomCircleImage(
                  radius: 99,
                  image: CustomNetworkImage(
                    url: snapshot.data?.avatar ?? model.avatar,
                    height: 50,
                    width: 50,
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            snapshot.data?.displayName ?? model.title ?? '',
                            style: tNormalTextStyle.copyWith(
                                color: getTextColorSecond(),
                                fontWeight: font,
                                fontSize: 16),
                          ),
                        ),
                        if (user.value?.typeAccount == TypeAccount.admin.name &&
                            model.ticketId != null) ...[
                          const SizedBox(width: kSmallPadding),
                          _buildTicketStatus(),
                        ]
                      ],
                    ),
                    const SizedBox(height: kSmallPadding),
                    FutureBuilder<UserModel?>(
                        future: getUserLastMessage(),
                        builder: (BuildContext context,
                            AsyncSnapshot<UserModel?> data) {
                          String content = model.lastMessage?.content ?? '';

                          if (data.data != null) {
                            content =
                                '${data.data?.displayName ?? ''}: ${model.lastMessage?.content ?? ''}';
                          }
                          return Text(
                            content,
                            maxLines: 2,
                            style: tNormalTextStyle.copyWith(
                                color: color, fontSize: 12, fontWeight: font),
                          );
                        })
                  ],
                )),
                const SizedBox(width: kDefaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatDateTime(
                          date: model.lastUpdatedTime,
                          formatString: DateTimeFormatString.yyyyMMddhhMM),
                      style: tNormalTextStyle.copyWith(
                          fontWeight: font,
                          fontSize: 8,
                          color: getTextColorSecond()),
                    ),
                    const SizedBox(height: kSmallPadding),
                    if (user.value?.typeAccount == TypeAccount.admin.name)
                      Text(
                        snapshot.data?.typeAccount == TypeAccount.guest.name
                            ? 'guest'.tr
                            : 'caster'.tr,
                        style: tNormalTextStyle.copyWith(
                            fontWeight: font,
                            fontSize: 8,
                            color: getTextColorSecond()),
                      )
                  ],
                )
              ],
            ),
          );
        });
  }
}
