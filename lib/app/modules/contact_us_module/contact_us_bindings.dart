import 'package:get/get.dart';
import 'package:untitled/app/modules/contact_us_module/contact_us_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ContactUsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController());
  }
}
