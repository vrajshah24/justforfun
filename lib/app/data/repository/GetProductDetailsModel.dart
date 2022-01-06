// To parse this JSON data, do
//
//     final getProductDetailsModel = getProductDetailsModelFromJson(jsonString);

import 'dart:convert';

GetProductDetailsModel getProductDetailsModelFromJson(String str) =>
    GetProductDetailsModel.fromJson(json.decode(str));

String getProductDetailsModelToJson(GetProductDetailsModel data) =>
    json.encode(data.toJson());

class GetProductDetailsModel {
  GetProductDetailsModel({
    this.getProductDetailsResult,
  });

  GetProductDetailsResult getProductDetailsResult;

  factory GetProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetProductDetailsModel(
        getProductDetailsResult:
            GetProductDetailsResult.fromJson(json["GetProductDetailsResult"]),
      );

  Map<String, dynamic> toJson() => {
        "GetProductDetailsResult": getProductDetailsResult.toJson(),
      };
}

class GetProductDetailsResult {
  GetProductDetailsResult({
    this.errorCode,
    this.hasError,
    this.messages,
    this.mProduct,
  });

  int errorCode;
  bool hasError;
  List<dynamic> messages;
  MProduct mProduct;

  factory GetProductDetailsResult.fromJson(Map<String, dynamic> json) =>
      GetProductDetailsResult(
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        messages: List<dynamic>.from(json["Messages"].map((x) => x)),
        mProduct: MProduct.fromJson(json["mProduct"]),
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "HasError": hasError,
        "Messages": List<dynamic>.from(messages.map((x) => x)),
        "mProduct": mProduct.toJson(),
      };
}

class MProduct {
  MProduct({
    this.cBrouPath,
    this.cHsnNo,
    this.cMfg,
    this.cName,
    this.cPath,
    this.nCode,
    this.nDp,
    this.nMrp,
    this.nMinStock,
    this.nOpStock,
    this.nPack,
    this.nType,
    this.nUnit,
  });

  String cBrouPath;
  String cHsnNo;
  String cMfg;
  String cName;
  String cPath;
  int nCode;
  int nDp;
  int nMrp;
  int nMinStock;
  int nOpStock;
  int nPack;
  int nType;
  int nUnit;

  factory MProduct.fromJson(Map<String, dynamic> json) => MProduct(
        cBrouPath: json["cBrouPath"],
        cHsnNo: json["cHSNNo"],
        cMfg: json["cMfg"],
        cName: json["cName"],
        cPath: json["cPath"],
        nCode: json["nCode"],
        nDp: json["nDP"],
        nMrp: json["nMRP"],
        nMinStock: json["nMinStock"],
        nOpStock: json["nOpStock"],
        nPack: json["nPack"],
        nType: json["nType"],
        nUnit: json["nUnit"],
      );

  Map<String, dynamic> toJson() => {
        "cBrouPath": cBrouPath,
        "cHSNNo": cHsnNo,
        "cMfg": cMfg,
        "cName": cName,
        "cPath": cPath,
        "nCode": nCode,
        "nDP": nDp,
        "nMRP": nMrp,
        "nMinStock": nMinStock,
        "nOpStock": nOpStock,
        "nPack": nPack,
        "nType": nType,
        "nUnit": nUnit,
      };
}
