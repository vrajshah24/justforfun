import '../../app/modules/change_password_module/change_password_page.dart';
import '../../app/modules/change_password_module/change_password_bindings.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/product_details_module/product_details_page.dart';

import '../../app/modules/account_settings_module/account_settings_bindings.dart';
import '../../app/modules/account_settings_module/account_settings_page.dart';
import '../../app/modules/company_profile_module/company_profile_bindings.dart';
import '../../app/modules/company_profile_module/company_profile_page.dart';
import '../../app/modules/contact_us_module/contact_us_bindings.dart';
import '../../app/modules/contact_us_module/contact_us_page.dart';
import '../../app/modules/home_module/home_bindings.dart';
import '../../app/modules/home_module/home_page.dart';
import '../../app/modules/login_page_module/login_page_bindings.dart';
import '../../app/modules/login_page_module/login_page_page.dart';
import '../../app/modules/order_listing_module/order_listing_bindings.dart';
import '../../app/modules/order_listing_module/order_listing_page.dart';
import '../../app/modules/order_page_module/order_page_bindings.dart';
import '../../app/modules/order_page_module/order_page_page.dart';
import '../../app/modules/product_details_module/product_details_bindings.dart';
import '../../app/modules/products_module/products_bindings.dart';
import '../../app/modules/products_module/products_page.dart';
import '../../app/modules/registration_module/registration_bindings.dart';
import '../../app/modules/registration_module/registration_page.dart';
import '../../app/modules/splash_module/splash_bindings.dart';
import '../../app/modules/splash_module/splash_page.dart';
import '../../app/modules/stepper_register_user_module/stepper_register_user_bindings.dart';
import '../../app/modules/stepper_register_user_module/stepper_register_user_page.dart';

part './app_routes.dart';
/**
 * GetX Generator - fb.com/htngu.99
 * */

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => LoginPagePage(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ORDER_PAGE,
      page: () => OrderPagePage(),
      binding: OrderPageBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_DETAILS,
      page: () => ProductDetailsPage(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.CONTACT_US,
      page: () => ContactUsPage(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: Routes.COMPANY_PROFILE,
      page: () => CompanyProfilePage(),
      binding: CompanyProfileBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTS,
      page: () => ProductsPage(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: Routes.ORDER_LISTING,
      page: () => OrderListingPage(),
      binding: OrderListingBinding(),
    ),
    GetPage(
      name: Routes.REGISTRATION,
      page: () => RegistrationPage(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNT_SETTINGS,
      page: () => AccountSettingsPage(),
      binding: AccountSettingsBinding(),
    ),
    GetPage(
      name: Routes.STEPPER_REGISTER_USER,
      page: () => StepperRegisterUserPage(),
      binding: StepperRegisterUserBinding(),
    ),
    GetPage(
      name: Routes.CHANGE_PASSWORD,
      page: () => ChangePasswordPage(),
      binding: ChangePasswordBinding(),
    ),
  ];
}
