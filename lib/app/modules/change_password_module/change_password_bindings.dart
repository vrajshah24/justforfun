import 'package:get/get.dart';
import 'package:untitled/app/modules/change_password_module/change_password_controller.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}
