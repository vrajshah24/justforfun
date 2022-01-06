import 'package:get/get.dart';
import 'package:untitled/app/modules/company_profile_module/company_profile_controller.dart';

class CompanyProfileBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CompanyProfileController());
}
