import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/modules/account_settings_module/account_settings_page.dart';
import 'package:untitled/app/modules/company_profile_module/company_profile_page.dart';
import 'package:untitled/app/modules/contact_us_module/contact_us_page.dart';
import 'package:untitled/app/modules/home_module/home_page.dart';
import 'package:untitled/app/modules/login_page_module/login_page_bindings.dart';
import 'package:untitled/app/modules/login_page_module/login_page_page.dart';
import 'package:untitled/app/modules/order_listing_module/order_listing_page.dart';
import 'package:untitled/app/modules/products_module/products_bindings.dart';
import 'package:untitled/app/modules/products_module/products_page.dart';
import 'package:untitled/app/modules/registration_module/registration_page.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screens/ProfileScreen.dart';

Drawer sideDrawerPage(BuildContext context) {
  return GetStorageProvider().isUserLogin() == false
      ? Drawer(
          child: Container(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () => Get.offAll(
                    () => LoginPagePage(),
                    binding: LoginPageBinding(),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 70, 0, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, Login Here',
                              style: TextStyle(
                                fontFamily: getProximaNova(),
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                //Home
                ListTile(
                  onTap: () {
                    Get.back();
                    Get.to(() => HomePage());
                  },
                  leading: Image.asset(
                    "assets/icon/ic_home_menu.png",
                    height: 25,
                  ),
                  title: Text(home(language),
                      style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start),
                ),
                //Product
                ListTile(
                  leading: Image.asset(
                    "assets/icon/ic_product_menu.png",
                    height: 25,
                  ),
                  onTap: () {
                    Get.back();
                    Get.to(
                      () => ProductsPage(),
                      binding: ProductsBinding(),
                    );
                  },
                  title: Text(
                    products(language),
                    style: TextStyle(
                        fontFamily: getProximaNova(),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                ),
                CommonUtility().getDivider(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    return Get.to(() => CompanyProfilePage());
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                        child: Image.asset(
                          "assets/icon/ic_info_men.png",
                          height: 25,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(companyProfile(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    return Get.to(() => ContactUsPage());
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                        child: Image.asset(
                          "assets/icon/ic_settings_menu.png",
                          height: 25,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(contactUs(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      : Drawer(
          child: Container(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(language: language),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 70, 0, 10),
                        child: Container(
                          child: Center(
                            child: Image.asset(
                              "assets/icon/ic_profile.png",
                              fit: BoxFit.cover,
                              height: 60,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 70, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(GetStorage().read("Name"),
                                  style: TextStyle(
                                      fontFamily: getProximaNova(),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.left),
                              Text(
                                  '${GetStorageProvider().getDataByName(GetStorageProvider.MOBILE)}',
                                  style: TextStyle(
                                      fontFamily: getProximaNova(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              Text(edit(language),
                                  style: TextStyle(
                                      fontFamily: getProximaNova(),
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.back();
                    Get.to(() => HomePage());
                  },
                  leading: Image.asset(
                    "assets/icon/ic_home_menu.png",
                    height: 25,
                  ),
                  title: Text(home(language),
                      style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start),
                ),
                //Product
                ListTile(
                  leading: Image.asset(
                    "assets/icon/ic_product_menu.png",
                    height: 25,
                  ),
                  onTap: () {
                    Get.back();
                    Get.to(
                      () => ProductsPage(),
                      binding: ProductsBinding(),
                    );
                  },
                  title: Text(
                    products(language),
                    style: TextStyle(
                        fontFamily: getProximaNova(),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start,
                  ),
                ),
                //Order
                ListTile(
                  onTap: () {
                    Get.back();
                    Get.to(() => OrderListingPage());
                  },
                  leading: Image.asset(
                    "assets/icon/ic_bag_menu.png",
                    height: 25,
                  ),
                  title: Text(orders(language),
                      style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start),
                ),
                //Registrations
                ListTile(
                  title: Text(registrations(language),
                      style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start),
                  leading: Image.asset(
                    "assets/icon/ic_user_menu.png",
                    height: 25,
                  ),
                  onTap: () {
                    Get.back();
                    Get.to(() => RegistrationPage());
                  },
                ),
                CommonUtility().getDivider(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.to(() => AccountSettingsPage());
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                        child: Image.asset(
                          "assets/icon/ic_settings_menu.png",
                          height: 25,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(accountSettings(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => CompanyProfilePage()),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                        child: Image.asset(
                          "assets/icon/ic_info_men.png",
                          height: 25,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(14),
                              child: Text(companyProfile(language),
                                  style: TextStyle(
                                      fontFamily: getProximaNova(),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.start)))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => ContactUsPage()),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                        child: Image.asset(
                          "assets/icon/ic_settings_menu.png",
                          height: 25,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(contactUs(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start),
                        ),
                      ),
                    ],
                  ),
                ),
                CommonUtility().getDivider(),
                ListTile(
                  onTap: () {
                    final box = GetStorage();
                    box.erase();
                    Get.offAll(
                      () => LoginPagePage(),
                      binding: LoginPageBinding(),
                    );
                  },
                  leading: Image.asset(
                    "assets/icon/ic_logout_menu.png",
                    height: 25,
                  ),
                  title: Text(logout(language),
                      style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start),
                ),
              ],
            ),
          ),
        );
}
