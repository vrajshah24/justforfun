import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/registration_module/registration_controller.dart';
import 'package:untitled/app/modules/side_drawer_module/side_drawer_page.dart';
import 'package:untitled/app/modules/stepper_register_user_module/stepper_register_user_page.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screens/OrdersPage.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationController controller = Get.put(RegistrationController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: sideDrawerPage(context),
      body: Container(
        child: Obx(
          () => Stack(
            children: [
              controller.isLoading.value == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller
                          .getMyUsersModel.getMyUsersResult.lstMyUsers.isEmpty
                      ? Text("no data")
                      : Container(
                          child: ListView.builder(
                            itemCount: controller.getMyUsersModel
                                .getMyUsersResult.lstMyUsers.length,
                            padding: EdgeInsets.fromLTRB(25, 115, 25, 25),
                            itemBuilder: (BuildContext context, int index) =>
                                Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (position) => MyOrdersPage(
                                          title: "Orders",
                                          language: language,
                                          username: controller
                                              .getMyUsersModel
                                              .getMyUsersResult
                                              .lstMyUsers[index]
                                              .cEnrollNo,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 20, 0, 10),
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
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 20, 0, 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    controller
                                                        .getMyUsersModel
                                                        .getMyUsersResult
                                                        .lstMyUsers[index]
                                                        .cName
                                                        .split(" ")[0],
                                                    style: TextStyle(
                                                        fontFamily:
                                                            getProximaNova(),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                    textAlign: TextAlign.start),
                                                Text(
                                                    controller
                                                            .getMyUsersModel
                                                            .getMyUsersResult
                                                            .lstMyUsers[index]
                                                            .cType +
                                                        " " +
                                                        controller
                                                            .getMyUsersModel
                                                            .getMyUsersResult
                                                            .lstMyUsers[index]
                                                            .cEnrollNo,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            getProximaNova(),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    textAlign: TextAlign.start),
                                                Text(
                                                    '+91 ' +
                                                        controller
                                                            .getMyUsersModel
                                                            .getMyUsersResult
                                                            .lstMyUsers[index]
                                                            .cMobile,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            getProximaNova(),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    textAlign: TextAlign.start),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Image.asset(
                                            "assets/icon/ic_arrow_down.png",
                                            height: 8,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                getDividerOnly(1)
                              ],
                            ),
                          ),
                        ),
              CommonUtility()
                  .getBottomMenu(context, registerUser(language), _scaffoldKey),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: getMyAppColor(),
                            borderRadius: BorderRadius.circular(13)),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextButton(
                            onPressed: () =>
                                Get.to(() => StepperRegisterUserPage()),
                            child: Text(
                              registerUser(language),
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
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
