import 'package:get/get.dart';
import 'package:untitled/app/modules/account_settings_module/account_settings_controller.dart';

class AccountSettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountSettingsController());
  }
}
