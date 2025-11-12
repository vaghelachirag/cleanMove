
import 'dart:convert';

GetChangePasswordResponse getChangePasswordResponseFromJson(String str) => GetChangePasswordResponse.fromJson(json.decode(str));

String getChangePasswordResponseToJson(GetChangePasswordResponse data) => json.encode(data.toJson());

class GetChangePasswordResponse {
  bool success;
  String message;

  GetChangePasswordResponse({
    required this.success,
    required this.message,
  });

  factory GetChangePasswordResponse.fromJson(Map<String, dynamic> json) => GetChangePasswordResponse(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
