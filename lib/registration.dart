import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/app/modules/home_module/home_page.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/screens/ProductList.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key, this.title, this.language}) : super(key: key);

  final String title;
  final String language;

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    bool _saving = false;
    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    TextEditingController nameController = new TextEditingController();
    TextEditingController mobileNoController = new TextEditingController();

    void _saveUser(int Code, String Mobile, String Name, String Username,
        int StudentId, int UserType) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (Code != null) await prefs.setInt('Code', Code);
      if (Mobile != null) await prefs.setString('Mobile', Mobile);
      if (Name != null) await prefs.setString('Name', Name);
      if (Username != null) await prefs.setString('Username', Username);
      if (StudentId != null) await prefs.setInt('StudentID', StudentId);
      if (UserType != null) await prefs.setInt('UserType', UserType);
    }

    void loginUser(
        BuildContext context, String username, String password) async {
      var client = http.Client();
      print("starting");
      try {
        dynamic data = {
          'Username': "SNV4034",
          'Password': "9898949200",
        };
        print("post: " + jsonEncode(data));
        var uriResponse = await client.post(
            Uri.parse("http://app.snvschool.org/SchoolWS.svc/Login"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
            },
            body: jsonEncode(data));
        var result = jsonDecode(uriResponse.body)["LoginResult"];
        var HasError = result["HasError"];

        if (HasError) {
          var ErrorCode = result["ErrorCode"];
          var Message = result["Messages"];
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        } else {
          var objUser = result["objUser"];
          int Code = objUser['Code'];
          String Mobile = objUser['Mobile'];
          String Name = objUser['Name'];
          String Username = objUser['Username'];
          int StudentId = objUser['StudentID'];
          int UserType = objUser['UserType'];

          print("user : " + objUser.toString());
          print("Login Success " + Code.toString());

          _saveUser(Code, Mobile, Name, Username, StudentId, UserType);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomePage()));
        }
      } finally {
        client.close();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                        child: Text(
                          signUp(widget.language),
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
                        height: 2,
                        width: 25,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          child: Text(
                            '',
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 20,
                        color: getLineColor(),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            '',
                          ),
                        ),
                      ),
                    ],
                  ),
                  getTextField(
                    fullName(widget.language),
                    emailController,
                    "assets/icon/ic_fullname.png",
                  ),
                  getTextField(
                    mobileNo(widget.language),
                    passwordController,
                    "assets/icon/ic_mobile.png",
                  ),
                  getTextField(
                    emailId(widget.language),
                    nameController,
                    "assets/icon/ic_email.png",
                  ),
                  getTextField(
                    password(widget.language),
                    mobileNoController,
                    "assets/icon/ic_password.png",
                  ),
                  Padding(
                      padding: EdgeInsets.all(
                        30,
                      ),
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          color: getMyAppColor(),
                          borderRadius: BorderRadius.circular(
                            13,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            /*loginUser(context, emailController.text,
                                passwordController.text);*/
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MyHomePage(),
                              ),
                            );
                          },
                          child: Text(
                            CommonUtility().getCapitalizeString(
                                str: register(widget.language)),
                            style: TextStyle(
                                fontFamily: getProximaNova(),
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            alreadyAUser(widget.language) + ' ',
                            style: TextStyle(
                                fontFamily: getProximaNova(),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          Text(
                            CommonUtility().getCapitalizeString(
                                str: login(widget.language)),
                            style: TextStyle(
                                fontFamily: getProximaNova(),
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: getMyAppColor()),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ]),
          Container(
            height: 100,
            color: Colors.white,
            width: double.infinity,
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 50, right: 30, bottom: 30),
            height: 55,
            width: double.infinity,
            child: Stack(children: [
              Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Image.asset(
                      "assets/icon/ic_back.png",
                      width: 20,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  alignment: Alignment.centerLeft),
              Center(
                  child: Text(
                register(widget.language),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: getProximaNova(),
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.black),
              ))
            ]),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: getBorderColor()),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Padding getTextField(String hint, var controller, String icon) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: Container(
      decoration: BoxDecoration(
          color: Color(0xFFEEF1F8), borderRadius: BorderRadius.circular(13)),
      child: Row(children: [
        Container(
          width: 16,
        ),
        Image.asset(
          icon,
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
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: hint,
                        filled: true,
                        fillColor: Color(0xFFEEF1F8),
                        focusColor: Color(0xFFEEF1F8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide:
                                new BorderSide(color: Color(0xFFEEF1F8))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide:
                                new BorderSide(color: Color(0xFFEEF1F8))),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide:
                                new BorderSide(color: Color(0xFFEEF1F8)))))))
      ]),
    ),
  );
}
/*
Padding (String hint, var controller, String icon) {
  return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: GestureDetector(
        onTap: () {
          pickImage();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFEEF1F8),
              borderRadius: BorderRadius.circular(13)),
          child: Row(children: [
            Container(
              width: 16,
            ),
            Expanded(
                child: Container(
                    width: double.infinity,
                    child: TextFormField(
                        enabled: false,
                        style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontSize: 16,
                        ),
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: hint,
                            filled: true,
                            fillColor: Color(0xFFEEF1F8),
                            focusColor: Color(0xFFEEF1F8),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide:
                                    new BorderSide(color: Color(0xFFEEF1F8))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide:
                                    new BorderSide(color: Color(0xFFEEF1F8))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: new BorderSide(
                                    color: Color(0xFFEEF1F8)))))))
          ]),
        ),
      ));
}*/

typedef StringValue = String Function(String);

Padding getPopupButton(
    String hint, var controller, List<String> items1, StringValue callback) {
  var selectedItem = controller;

  print(controller.toString());
  print(items1.toString());
  return Padding(
    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: Container(
      decoration: BoxDecoration(
          color: Color(0xFFEEF1F8), borderRadius: BorderRadius.circular(13)),
      child: Row(children: [
        SizedBox(width: 16),
        Expanded(
            child: Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  value: selectedItem,
                  // borderRadius: BorderRadius.zero,
                  isExpanded: true,
                  underline: SizedBox(height: 0),
                  hint: new Text(
                    hint,
                    style: TextStyle(
                      fontFamily: getProximaNova(),
                      fontSize: 16,
                    ),
                  ),
                  style: TextStyle(
                      fontFamily: getProximaNova(),
                      fontSize: 16,
                      color: Colors.black),
                  items: items1.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: new Text(
                        value.toString(),
                        style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (selected) {
                    print(selected.toString());
                    selectedItem = selected.toString();
                    callback(selected.toString());
                  },
                ))),
        SizedBox(width: 10),
      ]),
    ),
  );
}
