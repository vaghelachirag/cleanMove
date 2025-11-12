
import 'dart:convert';

GetSaveDriverReport getSaveDriverReportFromJson(String str) => GetSaveDriverReport.fromJson(json.decode(str));

String getSaveDriverReportToJson(GetSaveDriverReport data) => json.encode(data.toJson());

class GetSaveDriverReport {
  bool success;
  String message;

  GetSaveDriverReport({
    required this.success,
    required this.message,
  });

  factory GetSaveDriverReport.fromJson(Map<String, dynamic> json) => GetSaveDriverReport(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}

// To parse this JSON data, do
//
//     final getSaveDriverReport = getSaveDriverReportFromJson(jsonString);

