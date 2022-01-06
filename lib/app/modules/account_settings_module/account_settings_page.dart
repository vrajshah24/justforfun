import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/modules/account_settings_module/account_settings_controller.dart';
import 'package:untitled/app/modules/change_password_module/change_password_page.dart';
import 'package:untitled/app/modules/languageBottomSheet.dart';
import 'package:untitled/app/modules/side_drawer_module/side_drawer_page.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/main.dart';

class AccountSettingsPage extends GetView<AccountSettingsController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: sideDrawerPage(context),
      body: Stack(children: [
        ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => Get.to(() => ChangePasswordPage()),
                leading: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                title: Text(
                  changePassword(language),
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // subtitle: Text(GetStorageProvider().getLanguage()),
              ),
            ),
            Divider(color: getBorderColor()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(
                  Icons.translate,
                  color: Colors.black,
                ),
                title: Text(
                  changeLanguage(language),
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(GetStorageProvider().getLanguage()),
                onTap: () => Get.bottomSheet(
                  LanguageBottomSheet(),
                  isScrollControlled: false,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                ),
              ),
            ),
          ],
        ),
        CommonUtility()
            .getBottomMenu(context, accountSettings(language), _scaffoldKey)
      ]),
    );
  }
}
