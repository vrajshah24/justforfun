// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderModel placeOrderModelFromJson(String str) =>
    PlaceOrderModel.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderModel data) =>
    json.encode(data.toJson());

class PlaceOrderModel {
  PlaceOrderModel({
    this.placeOrderResult,
  });

  PlaceOrderResult placeOrderResult;

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) =>
      PlaceOrderModel(
        placeOrderResult: PlaceOrderResult.fromJson(json["PlaceOrderResult"]),
      );

  Map<String, dynamic> toJson() => {
        "PlaceOrderResult": placeOrderResult.toJson(),
      };
}

class PlaceOrderResult {
  PlaceOrderResult({
    this.errorCode,
    this.hasError,
    this.messages,
    this.orderId,
  });

  int errorCode;
  bool hasError;
  List<dynamic> messages;
  int orderId;

  factory PlaceOrderResult.fromJson(Map<String, dynamic> json) =>
      PlaceOrderResult(
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
