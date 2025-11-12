import 'dart:convert';

import 'package:shaligram_transport_app/models/passenger/notification/getPassengerNotificationDetail.dart';

GetPassengerNotificationResponse getPassengerNotificationResponseFromJson(String str) => GetPassengerNotificationResponse.fromJson(json.decode(str));

String getPassengerNotificationResponseToJson(GetPassengerNotificationResponse data) => json.encode(data.toJson());

class GetPassengerNotificationResponse {
  bool? success;
  String? message;
  List<NotificationList>? data;

  GetPassengerNotificationResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GetPassengerNotificationResponse.fromJson(Map<String, dynamic> json) => GetPassengerNotificationResponse(
    success: json["Success"],
    message: json["Message"],
    data: List<NotificationList>.from(json["Data"].map((x) => NotificationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
