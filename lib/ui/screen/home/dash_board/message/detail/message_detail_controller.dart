import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageDetailController extends GetxController {
  static MessageDetailController get to => Get.find();

  bool? canPop;
  Rxn<MessageGroupModel> model = Rxn<MessageGroupModel>();
  final list = <MessageModel>[].obs;
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    canPop = Get.arguments;
    final params = Get.parameters;
    if (params['id'] != null && params['id'] != '') {
      getGroupModel(params['id']);
    } else {
      onCallBack();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> getGroupModel(dynamic id) async {
    await Future.delayed(const Duration(seconds: 1));
    if (id == '管理人') {
      model.value = MessageGroupModel(
        id: '管理人',
        title: '管理人',
        messageGroupType: MessageGroupType.admin.name,
        avatar:
            'https://fastly.picsum.photos/id/22/4434/3729.jpg?hmac=fjZdkSMZJNFgsoDh8Qo5zdA_nSGUAWvKLyyqmEt2xs0',
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch),
        userIds: ['管理人', '管理'],
        lastMessage: MessageModel(
          content: '01/01(火) 20:00〜 @キャスト名',
          userId: '管理人',
          delete: false,
          createdTime: Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch),
          type: SendMessageType.text.name,
        ),
      );
    } else {
      model.value = MessageGroupModel(
        id: '管人',
        title: '01/01(火) 22:00〜 @キャスト名',
        messageGroupType: MessageGroupType.group.name,
        avatar:
            'https://fastly.picsum.photos/id/25/5000/3333.jpg?hmac=yCz9LeSs-i72Ru0YvvpsoECnCTxZjzGde805gWrAHkM',
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
      );
    }
    list.add(MessageModel(
      content: 'チャットグループを作りました',
      userId: '管理人',
      delete: false,
      createdTime: Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().add(const Duration(days: -1)).millisecondsSinceEpoch),
      type: SendMessageType.create.name,
    ));
    list.add(MessageModel(
      content: '〇〇〇〇が合流しました',
      userId: '管理人',
      delete: false,
      createdTime: Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().add(const Duration(days: -1)).millisecondsSinceEpoch),
      type: SendMessageType.create.name,
    ));
    list.add(MessageModel(
      content: 'こんにちわ',
      userId: '管理人',
      delete: false,
      createdTime: Timestamp.fromMillisecondsSinceEpoch(DateTime.now()
          .add(const Duration(minutes: -30))
          .millisecondsSinceEpoch),
      type: SendMessageType.text.name,
    ));
    list.add(MessageModel(
      content: 'こんにちわ',
      userId: 'me',
      delete: false,
      createdTime: Timestamp.fromMillisecondsSinceEpoch(DateTime.now()
          .add(const Duration(minutes: -10))
          .millisecondsSinceEpoch),
      type: SendMessageType.text.name,
    ));
    list.add(MessageModel(
      content: 'テキストが入ります。テキストが入ります。テキストが入ります。テキストが入ります。',
      userId: 'ユーザー名',
      delete: false,
      createdTime: Timestamp.fromMillisecondsSinceEpoch(DateTime.now()
          .add(const Duration(minutes: -8))
          .millisecondsSinceEpoch),
      type: SendMessageType.text.name,
    ));
    list.add(MessageModel(
      content: 'こんにちわ',
      userId: '管理人',
      delete: false,
      createdTime: Timestamp.fromMillisecondsSinceEpoch(DateTime.now()
          .add(const Duration(minutes: -9))
          .millisecondsSinceEpoch),
      type: SendMessageType.text.name,
    ));
    list.add(MessageModel(
      content: 'こんにちわ',
      userId: 'me',
      delete: false,
      createdTime: Timestamp.fromMillisecondsSinceEpoch(DateTime.now()
          .add(const Duration(minutes: -9))
          .millisecondsSinceEpoch),
      type: SendMessageType.text.name,
    ));
    list.add(MessageModel(
      content: 'テキストが入ります。テキストが入ります。テキストが入ります。テキストが入ります。',
      userId: '管理人',
      delete: false,
      createdTime: Timestamp.fromMillisecondsSinceEpoch(DateTime.now()
          .add(const Duration(minutes: -5))
          .millisecondsSinceEpoch),
      type: SendMessageType.text.name,
    ));
    list.add(MessageModel(
      content: 'テキストが入ります。テキストが入ります。テキストが入ります。テキストが入ります。',
      userId: '管理人',
      delete: false,
      createdTime: Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch),
      type: SendMessageType.text.name,
    ));
    if (model.value?.messageGroupType == MessageGroupType.group.name) {
      list.add(MessageModel(
        content: casterAccount.value ? '〇〇〇〇が解散しました' : '〇〇〇〇が解散しました\n消費ポイント：0P',
        userId: '管理人',
        delete: false,
        createdTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch),
        type: SendMessageType.leave.name,
      ));

      list.add(MessageModel(
        content: casterAccount.value ? '全員が解散しました' : '全員が解散しました\n消費ポイント：0P',
        userId: '管理人',
        delete: false,
        createdTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch),
        type: SendMessageType.disband.name,
      ));
    }
    await Future.delayed(const Duration(milliseconds: 100));
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void onCallBack() {
    if (canPop == true) {
      Get.back();
    } else {
      Get.offAndToNamed(Routes.home);
    }
  }
}
