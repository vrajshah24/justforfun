// To parse this JSON data, do
//
//     final getAllBranchModel = getAllBranchModelFromJson(jsonString);

import 'dart:convert';

GetAllBranchModel getAllBranchModelFromJson(String str) =>
    GetAllBranchModel.fromJson(json.decode(str));

String getAllBranchModelToJson(GetAllBranchModel data) =>
    json.encode(data.toJson());

class GetAllBranchModel {
  GetAllBranchModel({
    this.getAllBranchResult,
  });

  GetAllBranchResult getAllBranchResult;

  factory GetAllBranchModel.fromJson(Map<String, dynamic> json) =>
      GetAllBranchModel(
        getAllBranchResult:
            GetAllBranchResult.fromJson(json["GetAllBranchResult"]),
      );

  Map<String, dynamic> toJson() => {
        "GetAllBranchResult": getAllBranchResult.toJson(),
      };
}

class GetAllBranchResult {
  GetAllBranchResult({
    this.errorCode,
    this.hasError,
    this.messages,
    this.lstBranch,
  });

  int errorCode;
  bool hasError;
  List<dynamic> messages;
  List<LstBranch> lstBranch;

  factory GetAllBranchResult.fromJson(Map<String, dynamic> json) =>
      GetAllBranchResult(
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        messages: List<dynamic>.from(json["Messages"].map((x) => x)),
        lstBranch: List<LstBranch>.from(
            json["lstBranch"].map((x) => LstBranch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "HasError": hasError,
        "Messages": List<dynamic>.from(messages.map((x) => x)),
        "lstBranch": List<dynamic>.from(lstBranch.map((x) => x.toJson())),
      };
}

class LstBranch {
  LstBranch({
    this.address,
    this.branchId,
    this.branchName,
    this.city,
    this.companyCode,
    this.district,
    this.mobile,
    this.pincode,
  });

  dynamic address;
  int branchId;
  String branchName;
  dynamic city;
  int companyCode;
  dynamic district;
  dynamic mobile;
  dynamic pincode;

  factory LstBranch.fromJson(Map<String, dynamic> json) => LstBranch(
        address: json["Address"],
        branchId: json["BranchID"],
        branchName: json["BranchName"],
        city: json["City"],
        companyCode: json["CompanyCode"],
        district: json["District"],
        mobile: json["Mobile"],
        pincode: json["Pincode"],
      );

  Map<String, dynamic> toJson() => {
        "Address": address,
        "BranchID": branchId,
        "BranchName": branchName,
        "City": city,
        "CompanyCode": companyCode,
        "District": district,
        "Mobile": mobile,
        "Pincode": pincode,
      };
}
