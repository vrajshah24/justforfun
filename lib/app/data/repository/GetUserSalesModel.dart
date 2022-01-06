// To parse this JSON data, do
//
//     final getUserSalesModel = getUserSalesModelFromJson(jsonString);

import 'dart:convert';

GetUserSalesModel getUserSalesModelFromJson(String str) =>
    GetUserSalesModel.fromJson(json.decode(str));

String getUserSalesModelToJson(GetUserSalesModel data) =>
    json.encode(data.toJson());

class GetUserSalesModel {
  GetUserSalesModel({
    this.getUserSalesResult,
  });

  GetUserSalesResult getUserSalesResult;

  factory GetUserSalesModel.fromJson(Map<String, dynamic> json) =>
      GetUserSalesModel(
        getUserSalesResult:
            GetUserSalesResult.fromJson(json["GetUserSalesResult"]),
      );

  Map<String, dynamic> toJson() => {
        "GetUserSalesResult": getUserSalesResult.toJson(),
      };
}

class GetUserSalesResult {
  GetUserSalesResult({
    this.errorCode,
    this.hasError,
    this.messages,
    this.lstMaterial,
  });

  int errorCode;
  bool hasError;
  List<dynamic> messages;
  List<LstMaterial> lstMaterial;

  factory GetUserSalesResult.fromJson(Map<String, dynamic> json) =>
      GetUserSalesResult(
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        messages: List<dynamic>.from(json["Messages"].map((x) => x)),
        lstMaterial: List<LstMaterial>.from(
            json["lstMaterial"].map((x) => LstMaterial.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "HasError": hasError,
        "Messages": List<dynamic>.from(messages.map((x) => x)),
        "lstMaterial": List<dynamic>.from(lstMaterial.map((x) => x.toJson())),
      };
}

class LstMaterial {
  LstMaterial({
    this.cBillNo,
    this.cNote,
    this.lstSalesDetail,
    this.nAcyear,
    this.nCode,
    this.nDis,
    this.nGross,
    this.nNet,
    this.nPayVerify,
    this.nSrAgencyCode,
    this.nStatus,
    this.strDate,
    this.strPaymentDate,
  });

  int cBillNo;
  String cNote;
  List<LstSalesDetail> lstSalesDetail;
  int nAcyear;
  int nCode;
  int nDis;
  int nGross;
  int nNet;
  int nPayVerify;
  int nSrAgencyCode;
  int nStatus;
  String strDate;
  String strPaymentDate;

  factory LstMaterial.fromJson(Map<String, dynamic> json) => LstMaterial(
        cBillNo: json["cBillNo"],
        cNote: json["cNote"],
        lstSalesDetail: List<LstSalesDetail>.from(
            json["lstSalesDetail"].map((x) => LstSalesDetail.fromJson(x))),
        nAcyear: json["nAcyear"],
        nCode: json["nCode"],
        nDis: json["nDis"],
        nGross: json["nGross"],
        nNet: json["nNet"],
        nPayVerify: json["nPayVerify"],
        nSrAgencyCode: json["nSrAgencyCode"],
        nStatus: json["nStatus"],
        strDate: json["strDate"],
        strPaymentDate: json["strPaymentDate"],
      );

  Map<String, dynamic> toJson() => {
        "cBillNo": cBillNo,
        "cNote": cNote,
        "lstSalesDetail":
            List<dynamic>.from(lstSalesDetail.map((x) => x.toJson())),
        "nAcyear": nAcyear,
        "nCode": nCode,
        "nDis": nDis,
        "nGross": nGross,
        "nNet": nNet,
        "nPayVerify": nPayVerify,
        "nSrAgencyCode": nSrAgencyCode,
        "nStatus": nStatus,
        "strDate": strDate,
        "strPaymentDate": strPaymentDate,
      };
}

class LstSalesDetail {
  LstSalesDetail({
    this.cName,
    this.cPath,
    this.nCode,
    this.nGross,
    this.nItemCode,
    this.nMrp,
    this.nQty,
  });

  String cName;
  String cPath;
  int nCode;
  int nGross;
  int nItemCode;
  int nMrp;
  int nQty;

  factory LstSalesDetail.fromJson(Map<String, dynamic> json) => LstSalesDetail(
        cName: json["cName"],
        cPath: json["cPath"],
        nCode: json["nCode"],
        nGross: json["nGross"],
        nItemCode: json["nItemCode"],
        nMrp: json["nMRP"],
        nQty: json["nQty"],
      );

  Map<String, dynamic> toJson() => {
        "cName": cName,
        "cPath": cPath,
        "nCode": nCode,
        "nGross": nGross,
        "nItemCode": nItemCode,
        "nMRP": nMrp,
        "nQty": nQty,
      };
}
