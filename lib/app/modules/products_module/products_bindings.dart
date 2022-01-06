import 'package:get/get.dart';
import 'package:untitled/app/modules/products_module/products_controller.dart';

class ProductsBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ProductsController());
}
