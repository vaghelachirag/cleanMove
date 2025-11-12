import 'dart:convert';

import 'GetRoutePassengerListDetail.dart';

GetRoutePassengerListResponse getRoutePassengerListResponseFromJson(String str) => GetRoutePassengerListResponse.fromJson(json.decode(str));

String getRoutePassengerListResponseToJson(GetRoutePassengerListResponse data) => json.encode(data.toJson());

class GetRoutePassengerListResponse {
  List<GetRoutePassengerListDetail> ? data;
  bool? success;
  dynamic?  message;

  GetRoutePassengerListResponse({
    this.data,
    this.success,
    this.message,
  });

  factory GetRoutePassengerListResponse.fromJson(Map<String, dynamic> json) => GetRoutePassengerListResponse(
    data: List<GetRoutePassengerListDetail>.from(json["Data"].map((x) => GetRoutePassengerListDetail.fromJson(x))),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "Success": success,
    "Message": message,
  };
}
