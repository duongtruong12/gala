import 'dart:async';

import 'package:base_flutter/model/message_group_model.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageDetailController extends GetxController {
  static MessageDetailController get to => Get.find();

  bool? canPop;
  bool scrollDown = false;
  final expanded = false.obs;
  final model = Rxn<MessageGroupModel>();
  final list = <MessageModel>[].obs;
  final mapCountTime = <String, CountTimeModel>{}.obs;
  final scrollController = ScrollController();
  StreamSubscription? streamSubscription;
  StreamSubscription? streamSubscriptionMessageGroup;
  StreamSubscription? streamSubscriptionCountTime;
  int page = 1;
  dynamic id;
  Ticket? ticket;

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
    streamSubscriptionCountTime?.cancel();
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
        getTicketDetail();
      },
    );

    getData();
    getCountTime();
  }

  bool messageGroupEnd() {
    return mapCountTime.values
        .toList()
        .every((element) => element.endDate != null);
  }

  Future<void> getTicketDetail() async {
    if (ticket != null) {
      return;
    }
    if (model.value?.ticketId != null) {
      ticket = await fireStoreProvider.getTicketDetail(
          id: model.value?.ticketId, source: Source.cache);
    }
  }

  void getCountTime() {
    streamSubscriptionCountTime?.cancel();
    streamSubscriptionCountTime = fireStoreProvider.listenerCountTimeTicket(
        valueChanged: (listDoc) async {
          mapCountTime.clear();
          if (listDoc.docs.isNotEmpty) {
            for (var value in listDoc.docs) {
              try {
                final model = CountTimeModel.fromJson(value.data());
                mapCountTime.putIfAbsent(model.id!, () => model);
              } catch (e) {
                logger.e(e);
              }
            }
          }
        },
        messageGroupId: id);
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
              list.insert(0, messageModel);
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

  void switchExpanded() {
    expanded.value = !expanded.value;
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

  void pause() {
    streamSubscription?.pause();
    streamSubscriptionMessageGroup?.pause();
    streamSubscriptionCountTime?.pause();
  }

  void resume() {
    streamSubscription?.resume();
    streamSubscriptionMessageGroup?.resume();
    streamSubscriptionCountTime?.resume();
  }

  Future<void> switchDetailTicket(String? ticketId) async {
    pause();
    await Get.toNamed(Routes.ticketDetail,
        parameters: {'id': '$ticketId'}, arguments: true);
    resume();
  }

  void onSwitchUserDetail(String? id) {
    pause();
    Get.toNamed(Routes.userDetail, parameters: {'id': '$id'}, arguments: true);
    resume();
  }

  Future<void> countTicketTime() async {
    final model = mapCountTime[user.value?.id];
    if (model == null) {
      return;
    }
    if (model.startDate == null) {
      await fireStoreProvider.startCountTimeTicket(messageGroupId: id);
    } else {
      if (ticket == null || mapCountTime[user.value?.id] == null) return;
      await fireStoreProvider
          .endCountTimeTicket(
              messageGroupId: id,
              model: mapCountTime[user.value?.id],
              ticket: ticket)
          .then((value) async {
        mapCountTime[user.value?.id]?.endDate = DateTime.now();
        if (messageGroupEnd() && ticket?.status == TicketStatus.done.name) {
          await fireStoreProvider.closeTicket(
              messageGroupId: id, ticket: ticket);
        }
      });
    }
  }
}
