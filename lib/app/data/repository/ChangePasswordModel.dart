// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) =>
    ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) =>
    json.encode(data.toJson());

class ChangePasswordModel {
  ChangePasswordModel({
    this.cancelOrderResult,
  });

  CancelOrderResult cancelOrderResult;

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordModel(
        cancelOrderResult:
            CancelOrderResult.fromJson(json["CancelOrderResult"]),
      );

  Map<String, dynamic> toJson() => {
        "CancelOrderResult": cancelOrderResult.toJson(),
      };
}

class CancelOrderResult {
  CancelOrderResult({
    this.errorCode,
    this.hasError,
    this.messages,
    this.orderId,
  });

  int errorCode;
  bool hasError;
  List<dynamic> messages;
  int orderId;

  factory CancelOrderResult.fromJson(Map<String, dynamic> json) =>
      CancelOrderResult(
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        messages: List<dynamic>.from(json["Messages"].map((x) => x)),
        orderId: json["OrderID"],
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "HasError": hasError,
        "Messages": List<dynamic>.from(messages.map((x) => x)),
        "OrderID": orderId,
      };
}
