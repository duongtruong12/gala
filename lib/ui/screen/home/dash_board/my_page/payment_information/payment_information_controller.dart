import 'package:base_flutter/model/payment_model.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/payment_information/components/add_payment_dialog.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:get/get.dart';

class PaymentInformationController extends GetxController {
  static PaymentInformationController get to => Get.find();
  final model = Rxn<PaymentModel>();

  Future<void> showAddPaymentDialog() async {
    await showCustomDialog(widget: AddPaymentDialog(setter: (model) {
      Get.back();
      this.model.value = model;
    }));
  }
}
