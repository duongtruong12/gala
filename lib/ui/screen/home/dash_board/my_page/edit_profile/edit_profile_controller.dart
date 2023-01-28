import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();
  final listImage = <XFile>[].obs;
  RxBool hideYourAge = false.obs;

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
}
