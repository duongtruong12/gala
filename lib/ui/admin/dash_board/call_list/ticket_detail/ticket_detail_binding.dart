import 'package:get/get.dart';
import 'ticket_detail_controller.dart';

class TicketDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketDetailController>(
      () => TicketDetailController(),
    );
  }
}
