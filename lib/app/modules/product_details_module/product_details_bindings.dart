import 'package:get/get.dart';
import 'package:untitled/app/modules/product_details_module/product_details_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ProductDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailsController());
  }
}
