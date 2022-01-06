import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/change_password_module/change_password_controller.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/main.dart';

class ChangePasswordPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ChangePasswordController controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Obx(() {
        return Stack(
          children: [
            controller.loadingApi.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      controller.getTextField(
                        oldPassword(language),
                        controller.oldPasswordController,
                        "",
                      ),
                      controller.getTextField(
                        newPassword(language),
                        controller.newPasswordController,
                        "",
                      ),
                      //
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              color: getMyAppColor(),
                              borderRadius: BorderRadius.circular(13)),
                          child: TextButton(
                            onPressed: () => controller.changePasswordApi(),
                            child: Text(
                              save(language),
                              style: TextStyle(
                                fontFamily: getProximaNova(),
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            CommonUtility().getBottomMenu(
              context,
              changePassword(language),
              _scaffoldKey,
              showBack: true,
            )
          ],
        );
      }),
    );
  }
}
