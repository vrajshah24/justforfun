import 'package:get/get.dart';
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/modules/home_module/home_page.dart';
import 'package:untitled/app/modules/login_page_module/login_page_page.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    GetStorageProvider().getLanguage();
    Future.delayed(Duration(seconds: 1));
    GetStorageProvider().isUserLogin() == true
        ? Get.to(() => HomePage())
        : Get.to(() => LoginPagePage());
    super.onReady();
  }
}
