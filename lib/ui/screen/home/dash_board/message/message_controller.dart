import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  static MessageController get to => Get.find();

  final list = <MessageGroupModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _installData();
  }

  void _installData() {
    list.add(
      MessageGroupModel(
        id: '管理人',
        title: '管理人',
        avatar: '',
        messageGroupType: MessageGroupType.admin.name,
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch),
        userIds: ['管理人', '管理', '管'],
        lastMessage: MessageModel(
          content: 'メッセージが届いています',
          userId: '管理人',
          delete: false,
          createdTime: Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch),
          type: SendMessageType.text.name,
        ),
      ),
    );
    list.add(
      MessageGroupModel(
        id: '管人',
        title: '01/01(火) 20:00〜 @キャスト名',
        messageGroupType: MessageGroupType.group.name,
        avatar: listImage[r.nextInt(listImage.length)],
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch),
        userIds: ['管理人', '管理', '管'],
        lastMessage: MessageModel(
          content: '01/01(火) 20:00〜 @キャスト名',
          userId: '管理人',
          delete: false,
          createdTime: Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch),
          type: SendMessageType.text.name,
        ),
      ),
    );
    list.add(
      MessageGroupModel(
        id: '管理',
        title: '01/01(火) 22:00〜 @キャスト名',
        messageGroupType: MessageGroupType.group.name,
        avatar: listImage[r.nextInt(listImage.length)],
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch),
        userIds: ['管理人', '管理', '管'],
        lastMessage: MessageModel(
          content: '〇〇〇〇が合流しました',
          userId: '管理人',
          delete: false,
          createdTime: Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch),
          type: SendMessageType.text.name,
        ),
      ),
    );
    list.add(
      MessageGroupModel(
        id: '管人',
        title: '02/05(火) 20:00〜 @キャスト名',
        messageGroupType: MessageGroupType.group.name,
        avatar: listImage[r.nextInt(listImage.length)],
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch),
        userIds: ['管理人', '管理', '管'],
        lastMessage: MessageModel(
          content: 'メッセージが届いています',
          userId: '管理人',
          delete: false,
          createdTime: Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch),
          type: SendMessageType.text.name,
        ),
      ),
    );
  }

  void onSwitchMessageDetail(String? id) {
    Get.toNamed(Routes.messageDetail,
        arguments: true, parameters: {'id': id ?? ''});
  }
}
