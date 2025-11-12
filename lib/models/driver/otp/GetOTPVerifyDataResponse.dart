import 'dart:convert';

class GetOTPVerifyDataResponse {
  String phoneNumber;
  bool isVerify;

  GetOTPVerifyDataResponse({
    required this.phoneNumber,
    required this.isVerify,
  });

  factory GetOTPVerifyDataResponse.fromJson(Map<String, dynamic> json) => GetOTPVerifyDataResponse(
    phoneNumber: json["PhoneNumber"],
    isVerify: json["IsVerify"],
  );

  Map<String, dynamic> toJson() => {
    "PhoneNumber": phoneNumber,
    "IsVerify": isVerify,
  };
}
