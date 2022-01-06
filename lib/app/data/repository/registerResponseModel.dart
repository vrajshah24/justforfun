// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    this.registerAgencyResult,
  });

  RegisterAgencyResult registerAgencyResult;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
        registerAgencyResult: RegisterAgencyResult.fromJson(json["RegisterAgencyResult"]),
      );

  Map<String, dynamic> toJson() => {
        "RegisterAgencyResult": registerAgencyResult.toJson(),
      };
}

class RegisterAgencyResult {
  RegisterAgencyResult({
    this.errorCode,
    this.hasError,
    this.messages,
    this.agencyId,
  });

  int errorCode;
  bool hasError;
  List<String> messages;
  int agencyId;

  factory RegisterAgencyResult.fromJson(Map<String, dynamic> json) => RegisterAgencyResult(
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        messages: List<String>.from(json["Messages"].map((x) => x)),
        agencyId: json["AgencyID"],
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "HasError": hasError,
        "Messages": List<dynamic>.from(messages.map((x) => x)),
        "AgencyID": agencyId,
      };
}
