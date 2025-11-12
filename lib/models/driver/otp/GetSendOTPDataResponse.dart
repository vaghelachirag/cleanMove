import 'dart:convert';

class GetSendOTPDataResponse {
  String phoneNUmber;
  bool isOtpSent;
  String verificationSid;

  GetSendOTPDataResponse({
    required this.phoneNUmber,
    required this.isOtpSent,
    required this.verificationSid,
  });

  factory GetSendOTPDataResponse.fromJson(Map<String, dynamic> json) => GetSendOTPDataResponse(
    phoneNUmber: json["PhoneNUmber"],
    isOtpSent: json["IsOtpSent"],
    verificationSid: json["VerificationSid"],
  );

  Map<String, dynamic> toJson() => {
    "PhoneNUmber": phoneNUmber,
    "IsOtpSent": isOtpSent,
    "VerificationSid": verificationSid,
  };
}
