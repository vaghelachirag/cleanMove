/*
import 'dart:convert';

import 'GetDriverReportData.dart';

GetDriverReportMenuResponse getDriverReportMenuResponseFromJson(String str) => GetDriverReportMenuResponse.fromJson(json.decode(str));

String getDriverReportMenuResponseToJson(GetDriverReportMenuResponse data) => json.encode(data.toJson());

class GetDriverReportMenuResponse {
  List<GetDriverReportData>? data;
  bool? success;
  String? message;

  GetDriverReportMenuResponse({
    this.data,
    this.success,
    this.message,
  });

  factory GetDriverReportMenuResponse.fromJson(Map<String, dynamic> json) => GetDriverReportMenuResponse(
    data: List<GetDriverReportData>.from(json["Data"].map((x) => GetDriverReportData.fromJson(x))),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "Success": success,
    "Message": message,
  };
}*/
// To parse this JSON data, do
//
//     final resetPasswordRequestModal = resetPasswordRequestModalFromJson(jsonString);

// To parse this JSON data, do
//
//     final getDriverReportMenuResponse = getDriverReportMenuResponseFromJson(jsonString);

import 'dart:convert';

GetDriverReportMenuResponse getDriverReportMenuResponseFromJson(String str) => GetDriverReportMenuResponse.fromJson(json.decode(str));

String getDriverReportMenuResponseToJson(GetDriverReportMenuResponse data) => json.encode(data.toJson());

class GetDriverReportMenuResponse {
  List<Datum>? data;
  bool? success;
  String? message;

  GetDriverReportMenuResponse({
    this.data,
    this.success,
    this.message,
  });

  factory GetDriverReportMenuResponse.fromJson(Map<String, dynamic> json) => GetDriverReportMenuResponse(
    data: json["Data"] == null ? [] : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "Success": success,
    "Message": message,
  };
}

class Datum {
  int? reportId;
  String? reportText;
  int? driverReportCategoryId;
  String? categoryName;
  bool? isSelected;

  Datum({
    this.reportId,
    this.reportText,
    this.driverReportCategoryId,
    this.categoryName,
    this.isSelected =  false,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    reportId: json["ReportId"],
    reportText: json["ReportText"],
    driverReportCategoryId: json["DriverReportCategoryId"],
    categoryName: categoryNameValues.map[json["CategoryName"]]!,
    isSelected: json["isSelected"],
  );

  Map<String, dynamic> toJson() => {
    "ReportId": reportId,
    "ReportText": reportText,
    "DriverReportCategoryId": driverReportCategoryId,
    "CategoryName": categoryNameValues.reverse[categoryName],
    "isSelected": isSelected,
  };
}

/*enum CategoryName {
  DETOURS_REPORT,
  MECHANICAL_ISSUE_REPORT
}*/

/*final categoryNameValues = EnumValues({
  "Detours report": CategoryName.DETOURS_REPORT,
  "Mechanical issue report": CategoryName.MECHANICAL_ISSUE_REPORT
});*/
final categoryNameValues = EnumValues({
  "Detours report": "DETOURS_REPORT",
  "Mechanical issue report": "MECHANICAL_ISSUE_REPORT"
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
