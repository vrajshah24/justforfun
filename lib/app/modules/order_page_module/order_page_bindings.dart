import 'package:get/get.dart';
import 'package:untitled/app/modules/order_page_module/order_page_controller.dart';

class OrderPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderPageController());
  }
}
