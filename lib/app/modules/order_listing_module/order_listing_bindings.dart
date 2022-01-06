import 'package:get/get.dart';
import 'package:untitled/app/modules/order_listing_module/order_listing_controller.dart';

class OrderListingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderListingController());
  }
}
