import 'package:base_flutter/components/custom_input.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();
  final listImage = <XFile>[].obs;
  RxBool hideYourAge = false.obs;
  RxString nickname = ''.obs;
  RxString description = ''.obs;
  Rxn<String> placeToPlay = Rxn<String>();
  Rxn<DateTime> dateTime = Rxn<DateTime>();

  Future<void> selectImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      listImage.add(image);
    }
  }

  void swapImage() {
    if (listImage.length > 1) {
      final first = listImage[0];
      listImage.removeAt(0);
      listImage.add(first);
    }
  }

  void switchHideAge(bool? hideAge) {
    hideYourAge.value = hideAge ?? false;
  }

  String? validateNickName(String? str) {
    return Validate.emptyValidate(str: str, field: 'nick_name'.tr);
  }

  Future<void> showInputNickName() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInput(
            myValueSetter: (str) {
              nickname.value = str;
            },
            label: 'enter_nick_name'.tr,
            validate: validateNickName,
            initText: nickname.value,
          );
        });
  }

  Future<void> showPasswordChange() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInputPassword(
            myValueSetter: (str) {
              description.value = str;
            },
            label: 'description_enter'.tr,
          );
        });
  }

  Future<void> showDateBottom() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInputDate(
            myValueSetter: (date) {
              dateTime.value = date;
            },
            initDate: dateTime.value,
            label: 'select_date'.tr,
          );
        });
  }

  Future<void> showSelectCity() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInputCity(
            myValueSetter: (str) {
              placeToPlay.value = str;
            },
            label: 'please_select_label'.tr,
          );
        });
  }

  Future<void> showInputDescription() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInput(
            myValueSetter: (str) {
              description.value = str;
            },
            hint: 'description_hint'.tr,
            minLines: 8,
            label: 'description_enter'.tr,
            initText: description.value,
          );
        });
  }
}
