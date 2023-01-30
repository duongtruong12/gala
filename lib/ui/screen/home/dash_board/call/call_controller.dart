import 'package:base_flutter/model/female_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:get/get.dart';

class CallController extends GetxController {
  static CallController get to => Get.find();
  final list = <FemaleModel>[].obs;
  Rxn<bool> edit = Rxn<bool>();

  @override
  void onInit() {
    super.onInit();
    _installList();
  }

  Future<void> _installList() async {
    await Future.delayed(const Duration(seconds: 1));
    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 25,
      "point": 10000,
      "avatar": listImage[r.nextInt(listImage.length)],
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar": listImage[r.nextInt(listImage.length)],
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 25,
      "point": 10000,
      "avatar": listImage[r.nextInt(listImage.length)],
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar": listImage[r.nextInt(listImage.length)],
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 25,
      "point": 10000,
      "avatar": listImage[r.nextInt(listImage.length)],
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar": listImage[r.nextInt(listImage.length)],
    }));
  }

  Future<void> switchSelectMood() async {
    if (edit.value == true) {
      onPressedBack();
    } else {
      Get.toNamed(Routes.selectMood, id: RouteId.call);
    }
  }

  void onSwitchFemaleDetail(int id) {
    Get.toNamed(Routes.femaleProfile,
        parameters: {'id': '$id'}, arguments: true);
  }

  void onPressedBack() {
    Get.back(id: RouteId.call);
  }

  void setEdit(bool edit) {
    this.edit.value = edit;
  }
}
