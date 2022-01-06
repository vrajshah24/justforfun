import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:untitled/app/translations/gu_IN/gu_in_translation.dart';
import 'package:untitled/app/translations/hi_IN/hi_in_translation.dart';

import '../../app/translations/en_US/en_us_translations.dart';

class AppTranslation extends Translations {
  static Locale get locale => Get.deviceLocale;
  static final fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> keys = {
    'en': enUs,
    'gu': guIn,
    'hi': hiIn,
  };
}
