// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.loginResult,
  });

  LoginResult loginResult;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        loginResult: LoginResult.fromJson(json["LoginResult"]),
      );

  Map<String, dynamic> toJson() => {
        "LoginResult": loginResult.toJson(),
      };
}

class LoginResult {
  LoginResult({
    this.errorCode,
    this.hasError,
    this.messages,
    this.objUser,
  });

  int errorCode;
  bool hasError;
  List<dynamic> messages;
  ObjUser objUser;

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        messages: List<dynamic>.from(json["Messages"].map((x) => x)),
        objUser: ObjUser.fromJson(json["objUser"]),
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "HasError": hasError,
        "Messages": List<dynamic>.from(messages.map((x) => x)),
        "objUser": objUser.toJson(),
      };
}

class ObjUser {
  ObjUser({
    this.code,
    this.mobile,
    this.name,
    this.studentId,
    this.userType,
    this.username,
  });

  int code;
  dynamic mobile;
  String name;
  int studentId;
  int userType;
  String username;

  factory ObjUser.fromJson(Map<String, dynamic> json) => ObjUser(
        code: json["Code"],
        mobile: json["Mobile"],
        name: json["Name"],
        studentId: json["StudentID"],
        userType: json["UserType"],
        username: json["Username"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Mobile": mobile,
        "Name": name,
        "StudentID": studentId,
        "UserType": userType,
        "Username": username,
      };
}
