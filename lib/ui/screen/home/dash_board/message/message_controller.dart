import 'dart:async';

import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  static MessageController get to => Get.find();

  final list = <MessageGroupModel>[].obs;
  final listBase = <MessageGroupModel>[];
  StreamSubscription? streamSubscription;
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) => getData());
  }

  Future<void> onRefresh(int index) async {
    page = 1;
    await getData();
  }

  Future<void> onScrollDown(int index) async {
    page = index;
    await getData();
  }

  bool checkEmpty() {
    return (page * kPagingSize) > list.length;
  }

  Future<void> getData() async {
    streamSubscription?.cancel();
    streamSubscription = fireStoreProvider.listenerMessageGroup(
        page: page,
        valueChanged: (listDoc) {
          list.clear();
          listBase.clear();
          if (listDoc.docs.isNotEmpty) {
            for (var value in listDoc.docs) {
              try {
                final messageModel = MessageGroupModel.fromJson(value.data());
                listBase.add(messageModel);
              } catch (e) {
                logger.e(e);
              }
            }
            list.addAll(listBase);
          }
          unread.value = checkListNotSeen();
          if (unread.value > 0) {
            changeAppName(label: 'Claha (${unread.value})');
            updateIcon('assets/favicon_red.png');
          } else {
            changeAppName(label: 'Claha');
            updateIcon('assets/favicon.png');
          }
        });

    list.refresh();
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }

  int checkListNotSeen() {
    return listBase.where((element) => element.userNotSeen() == true).length;
  }

  Future<void> onSwitchMessageDetail(String? id) async {
    // streamSubscription?.pause();
    await Get.toNamed(Routes.messageDetail,
        arguments: true, parameters: {'id': id ?? ''});
    // streamSubscription?.resume();
  }

  void onChanged(String str) {
    list.clear();
    if (str.isEmpty) {
      list.addAll(listBase);
      return;
    }
    for (var element in listBase) {
      if (element.title?.toLowerCase().contains(str.toLowerCase()) == true ||
          element.lastMessage?.content
                  ?.toLowerCase()
                  .contains(str.toLowerCase()) ==
              true) {
        list.add(element);
      }
    }
  }
}
