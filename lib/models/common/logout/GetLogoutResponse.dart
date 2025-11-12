import 'dart:convert';

GetLogoutResponse getLogoutResponseFromJson(String str) => GetLogoutResponse.fromJson(json.decode(str));

String getLogoutResponseToJson(GetLogoutResponse data) => json.encode(data.toJson());

class GetLogoutResponse {
  bool? success;
  String? message;

  GetLogoutResponse({
    this.success,
    this.message,
  });

  factory GetLogoutResponse.fromJson(Map<String, dynamic> json) => GetLogoutResponse(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
