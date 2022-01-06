import 'package:get/get.dart';
import 'package:untitled/app/modules/splash_module/splash_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
