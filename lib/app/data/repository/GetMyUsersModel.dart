// To parse this JSON data, do
//
//     final getMyUsersModel = getMyUsersModelFromJson(jsonString);

import 'dart:convert';

GetMyUsersModel getMyUsersModelFromJson(String str) =>
    GetMyUsersModel.fromJson(json.decode(str));

String getMyUsersModelToJson(GetMyUsersModel data) =>
    json.encode(data.toJson());

class GetMyUsersModel {
  GetMyUsersModel({
    this.getMyUsersResult,
  });

  GetMyUsersResult getMyUsersResult;

  factory GetMyUsersModel.fromJson(Map<String, dynamic> json) =>
      GetMyUsersModel(
        getMyUsersResult: GetMyUsersResult.fromJson(json["GetMyUsersResult"]),
      );

  Map<String, dynamic> toJson() => {
        "GetMyUsersResult": getMyUsersResult.toJson(),
      };
}

class GetMyUsersResult {
  GetMyUsersResult({
    this.errorCode,
    this.hasError,
    this.messages,
    this.lstMyUsers,
  });

  int errorCode;
  bool hasError;
  List<dynamic> messages;
  List<LstMyUser> lstMyUsers;

  factory GetMyUsersResult.fromJson(Map<String, dynamic> json) =>
      GetMyUsersResult(
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        messages: List<dynamic>.from(json["Messages"].map((x) => x)),
        lstMyUsers: List<LstMyUser>.from(
            json["lstMyUsers"].map((x) => LstMyUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "HasError": hasError,
        "Messages": List<dynamic>.from(messages.map((x) => x)),
        "lstMyUsers": List<dynamic>.from(lstMyUsers.map((x) => x.toJson())),
      };
}

class LstMyUser {
  LstMyUser({
    this.cEnrollNo,
    this.cMobile,
    this.cName,
    this.cType,
    this.nCode,
  });

  String cEnrollNo;
  String cMobile;
  String cName;
  String cType;
  int nCode;

  factory LstMyUser.fromJson(Map<String, dynamic> json) => LstMyUser(
        cEnrollNo: json["cEnrollNo"],
        cMobile: json["cMobile"],
        cName: json["cName"],
        cType: json["cType"],
        nCode: json["nCode"],
      );

  Map<String, dynamic> toJson() => {
        "cEnrollNo": cEnrollNo,
        "cMobile": cMobile,
        "cName": cName,
        "cType": cType,
        "nCode": nCode,
      };
}
