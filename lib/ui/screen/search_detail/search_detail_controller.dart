import 'package:base_flutter/components/custom_bottom_sheet.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDetailController extends GetxController {
  static SearchDetailController get to => Get.find();
  final address = Rxn<String>();
  final birthPlace = Rxn<String>();
  final height = Rxn<int>();
  final age = Rxn<int>();
  final searchState = false.obs;
  final list = <UserModel>[].obs;
  final isEmpty = false.obs;
  DocumentSnapshot? lastDoc;

  Future<void> showInput(
      {required String type,
      required String label,
      bool numeric = false,
      required String? initText}) async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInput(
            numeric: numeric,
            nullable: true,
            myValueSetter: (str) async {
              if (type == 'address') {
                address.value = str;
              } else if (type == 'birthPlace') {
                birthPlace.value = str;
              } else if (type == 'height') {
                height.value = str != null ? int.parse(str) : null;
              } else {
                age.value = str != null ? int.parse(str) : null;
              }
            },
            validate: (str) {
              return numeric ? Validate.numberValidate(str, label) : null;
            },
            label: label,
            initText: initText,
          );
        });
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
        height: height.value,
        age: age.value,
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
