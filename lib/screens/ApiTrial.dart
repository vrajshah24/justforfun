// To parse this JSON data, do
//
//     final apiTrial = apiTrialFromJson(jsonString);

import 'dart:convert';

ApiTrial apiTrialFromJson(String str) => ApiTrial.fromJson(json.decode(str));

String apiTrialToJson(ApiTrial data) => json.encode(data.toJson());

class ApiTrial {
  ApiTrial({
    this.registerAgencyResult,
  });

  RegisterAgencyResult registerAgencyResult;

  factory ApiTrial.fromJson(Map<String, dynamic> json) => ApiTrial(
        registerAgencyResult:
            RegisterAgencyResult.fromJson(json["RegisterAgencyResult"]),
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
  List<dynamic> messages;
  int agencyId;

  factory RegisterAgencyResult.fromJson(Map<String, dynamic> json) =>
      RegisterAgencyResult(
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        messages: List<dynamic>.from(json["Messages"].map((x) => x)),
        agencyId: json["AgencyID"],
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "HasError": hasError,
        "Messages": List<dynamic>.from(messages.map((x) => x)),
        "AgencyID": agencyId,
      };
}
