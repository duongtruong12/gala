import 'dart:async';

import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class SearchCallController extends GetxController {
  static SearchCallController get to => Get.find();

  final list = <Ticket>[].obs;
  int page = 1;
  StreamSubscription? streamSubscription;
  bool? canPop;
  late DateTime date;

  @override
  void onInit() {
    super.onInit();
    canPop = Get.arguments;
    final params = Get.parameters;
    if (params['date'] != null) {
      final millisecond = int.parse('${params['date']}');
      date = DateTime.fromMillisecondsSinceEpoch(millisecond);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        getData();
      });
    } else {
      Get.offAllNamed(Routes.home);
    }
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
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
    streamSubscription = fireStoreProvider.listenerListTicker(
        futureData: true,
        dateTime: date,
        status: TicketStatus.created.name,
        valueChanged: (QuerySnapshot<Map<String, dynamic>> listDoc) {
          list.clear();
          if (listDoc.docs.isNotEmpty) {
            for (var value in listDoc.docs) {
              try {
                final messageModel = Ticket.fromJson(value.data());
                list.add(messageModel);
              } catch (e) {
                logger.e(e);
              }
            }
          }
          list.refresh();
        },
        page: page);
  }

  void onPressedBack() {
    if (canPop == true) {
      Get.back();
    } else {
      Get.offAndToNamed(Routes.home);
    }
  }
}
