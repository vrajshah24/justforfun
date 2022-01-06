// To parse this JSON data, do
//
//     final cancelOrderModel = cancelOrderModelFromJson(jsonString);

import 'dart:convert';

CancelOrderModel cancelOrderModelFromJson(String str) =>
    CancelOrderModel.fromJson(json.decode(str));

String cancelOrderModelToJson(CancelOrderModel data) =>
    json.encode(data.toJson());

class CancelOrderModel {
  CancelOrderModel({
    this.cancelOrderResult,
  });

  CancelOrderResult cancelOrderResult;

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) =>
      CancelOrderModel(
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
