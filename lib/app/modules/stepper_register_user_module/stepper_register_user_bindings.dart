import 'package:get/get.dart';
import 'package:untitled/app/modules/stepper_register_user_module/stepper_register_user_controller.dart';

class StepperRegisterUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StepperRegisterUserController());
  }
}
