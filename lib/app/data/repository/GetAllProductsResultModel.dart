// To parse this JSON data, do
//
//     final getAllProductsResultModel = getAllProductsResultModelFromJson(jsonString);

import 'dart:convert';

GetAllProductsResultModel getAllProductsResultModelFromJson(String str) =>
    GetAllProductsResultModel.fromJson(json.decode(str));

String getAllProductsResultModelToJson(GetAllProductsResultModel data) =>
    json.encode(data.toJson());

class GetAllProductsResultModel {
  GetAllProductsResultModel({
    this.getAllProductsResult,
  });

  GetAllProductsResult getAllProductsResult;

  factory GetAllProductsResultModel.fromJson(Map<String, dynamic> json) =>
      GetAllProductsResultModel(
        getAllProductsResult:
            GetAllProductsResult.fromJson(json["GetAllProductsResult"]),
      );

  Map<String, dynamic> toJson() => {
        "GetAllProductsResult": getAllProductsResult.toJson(),
      };
}

class GetAllProductsResult {
  GetAllProductsResult({
    this.errorCode,
    this.hasError,
    this.messages,
    this.lstProduct,
  });

  int errorCode;
  bool hasError;
  List<dynamic> messages;
  List<LstProduct> lstProduct;

  factory GetAllProductsResult.fromJson(Map<String, dynamic> json) =>
      GetAllProductsResult(
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        messages: List<dynamic>.from(json["Messages"].map((x) => x)),
        lstProduct: List<LstProduct>.from(
            json["lstProduct"].map((x) => LstProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "HasError": hasError,
        "Messages": List<dynamic>.from(messages.map((x) => x)),
        "lstProduct": List<dynamic>.from(lstProduct.map((x) => x.toJson())),
      };
}

class LstProduct {
  LstProduct({
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

  factory LstProduct.fromJson(Map<String, dynamic> json) => LstProduct(
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
