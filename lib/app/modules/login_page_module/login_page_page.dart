import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/data/repository/GetAllBranchModel.dart';
import 'package:untitled/app/modules/home_module/home_page.dart';
import 'package:untitled/app/modules/login_page_module/login_page_controller.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/main.dart';

import '../../../forgotPassword.dart';
import '../../../l10n.dart';
import '../../../registration.dart';

class LoginPagePage extends GetView<LoginPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isBranchLoading.value == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                decoration: new BoxDecoration(color: Colors.white),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GetBuilder<LoginPageController>(
                                  builder: (logic) {
                                return PopupMenuButton(
                                  child: ListTile(
                                    title: Text(
                                      "${GetStorageProvider().getLanguage()}",
                                      maxLines: 1,
                                      textAlign: TextAlign.end,
                                    ),
                                    trailing: Icon(
                                        Icons.keyboard_arrow_down_outlined),
                                  ),
                                  onSelected: (String val) => controller
                                      .changeSelectedLanguage(context, val),
                                  initialValue: controller.selectedLanguage,
                                  itemBuilder: (BuildContext context) => [
                                    const PopupMenuItem<String>(
                                        value: 'en', child: Text('English')),
                                    const PopupMenuItem<String>(
                                        value: 'hi', child: Text('हिंदी')),
                                    const PopupMenuItem<String>(
                                        value: 'gu', child: Text('ગુજરાતી')),
                                  ],
                                );
                              }),
                            ),
                            Spacer(),
                            Expanded(
                              child: ListTile(
                                onTap: () => GetStorage().erase().then(
                                      (value) => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => HomePage(),
                                        ),
                                      ),
                                    ),
                                trailing: Text(
                                  skip(language),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: getProximaNova(),
                                    fontWeight: FontWeight.w700,
                                    color: getMyAppColor(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                            child: Image.asset(
                              "assets/icon/wellsun_ebusiness.png",
                              height: 120,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                child: Text(
                                  gettingStarted(language),
                                  style: TextStyle(
                                      fontFamily: getProximaNova(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 3,
                                width: 25,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                  child: Text(
                                    '',
                                  ),
                                ),
                              ),
                              Container(
                                height: 3,
                                width: 20,
                                color: getLineColor(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Text(
                                    '',
                                  ),
                                ),
                              )
                            ],
                          ),
                          getTextField(
                              username(language),
                              controller.emailController,
                              "assets/icon/ic_email.png"),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFEEF1F8),
                                  borderRadius: BorderRadius.circular(13)),
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                  ),
                                  Image.asset(
                                    "assets/icon/ic_password.png",
                                    width: 25,
                                  ),
                                  Container(
                                    height: 25,
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    color: Color(0xFF979797),
                                    width: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        style: TextStyle(
                                          fontFamily: getProximaNova(),
                                          fontSize: 16,
                                        ),
                                        controller:
                                            controller.passwordController,
                                        decoration: InputDecoration(
                                          hintText: password(language),
                                          filled: true,
                                          fillColor: Color(0xFFEEF1F8),
                                          focusColor: Color(0xFFEEF1F8),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            borderSide: new BorderSide(
                                              color: Color(0xFFEEF1F8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            borderSide: new BorderSide(
                                              color: Color(0xFFEEF1F8),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            borderSide: new BorderSide(
                                              color: Color(0xFFEEF1F8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //DropDown
                          GetBuilder<LoginPageController>(
                            builder: (logic) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFEEF1F8),
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          child: DropdownButton<LstBranch>(
                                            value: logic.lstBranch,
                                            onChanged: (LstBranch value) =>
                                                logic.refreshDropDown(value),
                                            isExpanded: true,
                                            underline: SizedBox(height: 0),
                                            hint: new Text(
                                              selectBranch(language),
                                              style: TextStyle(
                                                fontFamily: getProximaNova(),
                                                fontSize: 16,
                                              ),
                                            ),
                                            style: TextStyle(
                                                fontFamily: getProximaNova(),
                                                fontSize: 16,
                                                color: Colors.black),
                                            items: controller.branchModel
                                                .getAllBranchResult.lstBranch
                                                .map((LstBranch value) {
                                              return DropdownMenuItem<
                                                  LstBranch>(
                                                value: value,
                                                child: new Text(
                                                  value.branchName,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        getProximaNova(),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ForgotPasswordPage(language: language),
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                                child: Text(
                                  forgotPwd(language),
                                  style: TextStyle(
                                    fontFamily: getProximaNova(),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFF777777),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: getMyAppColor(),
                                borderRadius: BorderRadius.circular(13)),
                            child: Obx(
                              () => controller.isLoginLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : TextButton(
                                      onPressed: () => controller.loginUser(),
                                      child: Text(
                                        login(language),
                                        style: TextStyle(
                                            fontFamily: getProximaNova(),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          // TextButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (_) => RegistrationPage(
                          //           language: language,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         notAUser(language) + ' ',
                          //         style: TextStyle(
                          //             fontFamily: getProximaNova(),
                          //             fontWeight: FontWeight.w400,
                          //             fontSize: 16,
                          //             color: Colors.black),
                          //       ),
                          //       Text(
                          //         registerNow(language),
                          //         style: TextStyle(
                          //           fontFamily: getProximaNova(),
                          //           fontWeight: FontWeight.w700,
                          //           fontSize: 15,
                          //           color: getMyAppColor(),
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
