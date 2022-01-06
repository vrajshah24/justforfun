import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/main.dart';

class GetStorageProvider {
  static const String LANGUAGE = 'Language';
  static const String IS_LOGIN = 'is_login';
  static const String MOBILE = 'Mobile';
  static const String USER_NAME = 'Username';

  void setLanguage(language) => GetStorage().write(LANGUAGE, language);

  String getLanguageCode() {
    var string = !GetUtils.isNullOrBlank(GetStorage().read(LANGUAGE))
        ? GetStorage().read(LANGUAGE)
        : "en";
    printInfo(info: "getLanguageCode--->$string");

    return string;
  }

  String getLanguage() {
    var LanguageSelcted = "English";
    String data = getLanguageCode();
    if (data == "en") {
      LanguageSelcted = "English";
    } else if (data == "hi") {
      LanguageSelcted = "हिंदी";
    } else if (data == "gu") {
      LanguageSelcted = "ગુજરાતી";
    }
    language = LanguageSelcted;
    printInfo(info: "getLanguage--->$LanguageSelcted");
    return LanguageSelcted;
  }

  bool isUserLogin() {
    return !GetUtils.isNullOrBlank(GetStorage().read(IS_LOGIN)) ? true : false;
  }

  String getDataByName(String key) =>
      !GetUtils.isNullOrBlank(GetStorage().read(key))
          ? GetStorage().read(key)
          : "";
  int getDataByIntName(String key) =>
      !GetUtils.isNullOrBlank(GetStorage().read(key))
          ? GetStorage().read(key)
          : -1;
}
