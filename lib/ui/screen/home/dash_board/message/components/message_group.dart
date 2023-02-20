import 'package:base_flutter/components/custom_circle_image.dart';
import 'package:base_flutter/components/custom_network_image.dart';
import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
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
    return await fireStoreProvider.getUserDetail(id: model.userIds[index]);
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
          applyTickets: []);
    }
    return await fireStoreProvider.getUserDetail(id: model.lastMessage?.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
        future: getUserModel(),
        builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
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
                    Text(
                      snapshot.data?.displayName ?? model.title ?? '',
                      style: tNormalTextStyle.copyWith(
                          color: getTextColorSecond(),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
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
                                color: kBorderColor, fontSize: 12),
                          );
                        })
                  ],
                )),
                const SizedBox(width: kDefaultPadding),
                Text(
                  formatDateTime(
                      date: model.lastUpdatedTime,
                      formatString: DateTimeFormatString.yyyyMMddhhMM),
                  style: tNormalTextStyle.copyWith(
                      fontSize: 8, color: getTextColorSecond()),
                )
              ],
            ),
          );
        });
  }
}
