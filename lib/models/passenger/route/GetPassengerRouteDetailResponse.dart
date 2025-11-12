import 'dart:convert';

import 'GetPassengerRouteDetailDataResponse.dart';

GetPassengerRouteDetailResponse getPassengerRouteDetailResponseFromJson(String str) => GetPassengerRouteDetailResponse.fromJson(json.decode(str));

String getPassengerRouteDetailResponseToJson(GetPassengerRouteDetailResponse data) => json.encode(data.toJson());

class GetPassengerRouteDetailResponse {
  bool? success;
  String? message;
  GetPassengerRouteDetailDataResponse? data;

  GetPassengerRouteDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GetPassengerRouteDetailResponse.fromJson(Map<String, dynamic> json) => GetPassengerRouteDetailResponse(
    success: json["Success"],
    message: json["Message"],
    data: GetPassengerRouteDetailDataResponse.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Data": data!.toJson(),
  };
}