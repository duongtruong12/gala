import 'package:base_flutter/components/custom_bottom_sheet.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDetailController extends GetxController {
  static SearchDetailController get to => Get.find();
  final address = Rxn<String>();
  final birthPlace = Rxn<String>();
  final listAge = <int>[].obs;
  final listHeight = <int>[].obs;
  final searchState = false.obs;
  final list = <UserModel>[].obs;
  final isEmpty = false.obs;
  DocumentSnapshot? lastDoc;

  Future<void> selectCity(
      {required String type,
      required String? initText,
      required String label}) async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInputCity(
            myValueSetter: (cityModel) async {
              if (type == 'address') {
                address.value = cityModel?.name;
              } else {
                birthPlace.value = cityModel?.name;
              }
            },
            label: label,
            init: initText,
          );
        });
  }

  Future<void> showSelectRange(
      {required String type,
      required String label,
      required String behindText,
      required int requiredMinValue,
      required int requiredMaxValue,
      required int? minValue,
      required int? maxValue}) async {
    final List<int>? list = await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return RangeSelector(
            label: label,
            minValue: minValue,
            maxValue: maxValue,
            requiredMinValue: requiredMinValue,
            requireMaxValue: requiredMaxValue,
            behindText: behindText,
          );
        });
    if (list != null && list.isNotEmpty == true) {
      if (type == 'height') {
        listHeight.clear();
        listHeight.addAll(list.toList());
      } else {
        listAge.clear();
        listAge.addAll(list.toList());
      }
    }
  }

  void onPressedBack() {
    if (searchState.value) {
      searchState.value = false;
      return;
    }

    if (Get.arguments == true) {
      Get.back();
    } else {
      Get.offAndToNamed(Routes.home);
    }
  }

  Future<void> getData() async {
    final listDoc = await fireStoreProvider.searchListUser(
        lastDocument: lastDoc,
        sort: casterAccount.value ? TypeAccount.guest : TypeAccount.caster,
        height: listHeight.toList(),
        age: listAge.toList(),
        address: address.value,
        birthPlace: birthPlace.value);
    if (listDoc.isNotEmpty) {
      lastDoc = listDoc.last;
      for (var value in listDoc) {
        try {
          if (value.data() != null) {
            final userModel = UserModel.fromJson(value.data()!);
            list.add(userModel);
          }
        } catch (e) {
          logger.e(e);
        }
      }
    } else {
      isEmpty.value = true;
    }
    list.refresh();
  }

  Future<void> onRefresh(int index) async {
    searchState.value = true;
    list.clear();
    lastDoc = null;
    isEmpty.value = false;
    await getData();
  }

  Future<void> onScrollDown(int i) async {
    await getData();
  }

  void onSwitchUserDetail(String? id) {
    Get.toNamed(Routes.userDetail, parameters: {'id': '$id'}, arguments: true);
  }
}
