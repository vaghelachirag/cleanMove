// To parse this JSON data, do
//
//     final getSaveDriverReportResponse = getSaveDriverReportResponseFromJson(jsonString);

import 'dart:convert';

GetSaveDriverReportResponse getSaveDriverReportResponseFromJson(String str) => GetSaveDriverReportResponse.fromJson(json.decode(str));

String getSaveDriverReportResponseToJson(GetSaveDriverReportResponse data) => json.encode(data.toJson());

class GetSaveDriverReportResponse {
  int? driverReportId;
  String? reportId;
  DateTime? reportDate;
  int? dailyRouteId;
  int? routeId;
  int? driverId;
  int? companyId;
  DateTime? createdDate;
  int? createdBy;
  DateTime? updatedDate;
  int? updatedBy;
  bool? isDeleted;

  GetSaveDriverReportResponse({
    this.driverReportId,
    this.reportId,
    this.reportDate,
    this.dailyRouteId,
    this.routeId,
    this.driverId,
    this.companyId,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.isDeleted,
  });

  factory GetSaveDriverReportResponse.fromJson(Map<String, dynamic> json) => GetSaveDriverReportResponse(
    driverReportId: json["DriverReportId"],
    reportId: json["ReportId"],
    reportDate: DateTime.parse(json["ReportDate"]),
    dailyRouteId: json["DailyRouteId"],
    routeId: json["RouteId"],
    driverId: json["DriverId"],
    companyId: json["CompanyId"],
    createdDate: DateTime.parse(json["CreatedDate"]),
    createdBy: json["CreatedBy"],
    updatedDate: DateTime.parse(json["UpdatedDate"]),
    updatedBy: json["UpdatedBy"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "DriverReportId": driverReportId,
    "ReportId": reportId,
    "ReportDate": reportDate!.toIso8601String(),
    "DailyRouteId": dailyRouteId,
    "RouteId": routeId,
    "DriverId": driverId,
    "CompanyId": companyId,
    "CreatedDate": createdDate!.toIso8601String(),
    "CreatedBy": createdBy,
    "UpdatedDate": updatedDate?.toIso8601String(),
    "UpdatedBy": updatedBy,
    "IsDeleted": isDeleted,
  };
}
