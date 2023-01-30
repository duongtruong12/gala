import 'package:get/get.dart';
import 'transfer_information_controller.dart';

class TransferInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferInformationController>(
      () => TransferInformationController(),
    );
  }
}
