import 'dart:async';

import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageDetailController extends GetxController {
  static MessageDetailController get to => Get.find();

  bool? canPop;
  bool scrollDown = false;
  final model = Rxn<MessageGroupModel>();
  final list = <MessageModel>[].obs;
  final scrollController = ScrollController();
  StreamSubscription? streamSubscription;
  StreamSubscription? streamSubscriptionMessageGroup;
  int page = 1;
  dynamic id;

  @override
  void onInit() {
    super.onInit();
    canPop = Get.arguments;
    final params = Get.parameters;
    if (params['id'] != null && params['id'] != '') {
      id = params['id'];
      getGroupModel();
      addScrollListener();
    } else {
      onCallBack();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    streamSubscription?.cancel();
    streamSubscriptionMessageGroup?.cancel();
    super.onClose();
  }

  Future<void> onRefresh(int index) async {
    page = 1;
    getData();
  }

  bool checkEmpty() {
    return list.length > page * kPagingSize;
  }

  Future<void> getGroupModel() async {
    streamSubscriptionMessageGroup?.cancel();

    streamSubscriptionMessageGroup =
        fireStoreProvider.listenerSingleMessageGroup(
      id: id,
      valueSetter: (MessageGroupModel value) {
        model.value = value;
      },
    );

    getData();
  }

  void getData() {
    streamSubscription?.cancel();
    streamSubscription = fireStoreProvider.listenerMessagesCollection(
      id: id,
      page: page,
      valueChanged: (listDoc) async {
        list.clear();
        if (listDoc.docs.isNotEmpty) {
          for (var value in listDoc.docs) {
            try {
              final messageModel = MessageModel.fromJson(value.data());
              list.add(messageModel);
            } catch (e) {
              logger.e(e);
            }
          }
          if (scrollDown) {
            scrollDown = false;
            return;
          }
          await Future.delayed(const Duration(milliseconds: 100));
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      },
    );
  }

  void onCallBack() {
    if (canPop == true) {
      Get.back();
    } else {
      Get.offAndToNamed(user.value?.isAdminAccount() == true
          ? Routes.homeAdmin
          : Routes.home);
    }
  }

  Future<void> sendMessage(String str) async {
    if (model.value?.id == null || str.isEmpty) {
      return;
    }
    await fireStoreProvider.sendMessage(
        content: str,
        messageGroupId: model.value!.id!,
        type: SendMessageType.text);
  }

  void addScrollListener() {
    scrollController.addListener(() {
      if (checkEmpty()) {
        return;
      }
      if (scrollController.position.pixels == 0) {
        page++;
        scrollDown = true;
        getData();
      }
    });
  }
}
