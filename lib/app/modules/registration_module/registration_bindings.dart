import 'package:get/get.dart';
import 'package:untitled/app/modules/registration_module/registration_controller.dart';

class RegistrationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistrationController());
  }
}
