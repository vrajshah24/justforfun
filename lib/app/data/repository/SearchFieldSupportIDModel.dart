// To parse this JSON data, do
//
//     final searchFieldSupportIdModel = searchFieldSupportIdModelFromJson(jsonString);

import 'dart:convert';

SearchFieldSupportIdModel searchFieldSupportIdModelFromJson(String str) =>
    SearchFieldSupportIdModel.fromJson(json.decode(str));

String searchFieldSupportIdModelToJson(SearchFieldSupportIdModel data) =>
    json.encode(data.toJson());

class SearchFieldSupportIdModel {
  SearchFieldSupportIdModel({
    this.searchFieldSupportIdResult,
  });

  SearchFieldSupportIdResult searchFieldSupportIdResult;

  factory SearchFieldSupportIdModel.fromJson(Map<String, dynamic> json) =>
      SearchFieldSupportIdModel(
        searchFieldSupportIdResult: SearchFieldSupportIdResult.fromJson(
            json["SearchFieldSupportIDResult"]),
      );

  Map<String, dynamic> toJson() => {
        "SearchFieldSupportIDResult": searchFieldSupportIdResult.toJson(),
      };
}

class SearchFieldSupportIdResult {
  SearchFieldSupportIdResult({
    this.errorCode,
    this.hasError,
    this.messages,
    this.lstFieldSupportId,
  });

  int errorCode;
  bool hasError;
  List<dynamic> messages;
  List<String> lstFieldSupportId;

  factory SearchFieldSupportIdResult.fromJson(Map<String, dynamic> json) =>
      SearchFieldSupportIdResult(
        errorCode: json["ErrorCode"],
        hasError: json["HasError"],
        messages: List<dynamic>.from(json["Messages"].map((x) => x)),
        lstFieldSupportId:
            List<String>.from(json["lstFieldSupportID"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "HasError": hasError,
        "Messages": List<dynamic>.from(messages.map((x) => x)),
        "lstFieldSupportID":
            List<dynamic>.from(lstFieldSupportId.map((x) => x)),
      };
}
