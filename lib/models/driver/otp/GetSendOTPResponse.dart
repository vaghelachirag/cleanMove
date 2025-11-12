
import 'dart:convert';

import 'GetSendOTPDataResponse.dart';

GetSendOTPResponse getVehicleListResponseFromJson(String str) => GetSendOTPResponse.fromJson(json.decode(str));

String getVehicleListResponseToJson(GetSendOTPResponse data) => json.encode(data.toJson());

class GetSendOTPResponse {
  GetSendOTPDataResponse data;
  bool success;
  dynamic message;

  GetSendOTPResponse({
    required this.data,
    required this.success,
    this.message,
  });

  factory GetSendOTPResponse.fromJson(Map<String, dynamic> json) => GetSendOTPResponse(
    data: GetSendOTPDataResponse.fromJson(json["Data"]),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data.toJson(),
    "Success": success,
    "Message": message,
  };
}
