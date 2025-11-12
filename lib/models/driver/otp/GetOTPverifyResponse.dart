import 'dart:convert';

import 'GetOTPVerifyDataResponse.dart';

GetVerifyOtpResponse getVerifyOtpResponseFromJson(String str) => GetVerifyOtpResponse.fromJson(json.decode(str));

String getVerifyOtpResponseToJson(GetVerifyOtpResponse data) => json.encode(data.toJson());

class GetVerifyOtpResponse {
  GetOTPVerifyDataResponse data;
  bool success;
  dynamic message;

  GetVerifyOtpResponse({
    required this.data,
    required this.success,
    this.message,
  });

  factory GetVerifyOtpResponse.fromJson(Map<String, dynamic> json) => GetVerifyOtpResponse(
    data: GetOTPVerifyDataResponse.fromJson(json["Data"]),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data.toJson(),
    "Success": success,
    "Message": message,
  };
}
