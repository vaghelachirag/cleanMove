import 'dart:convert';

GetForgotPasswordResponse getForgotPasswordResponseFromJson(String str) => GetForgotPasswordResponse.fromJson(json.decode(str));

String getForgotPasswordResponseToJson(GetForgotPasswordResponse data) => json.encode(data.toJson());

class GetForgotPasswordResponse {
  bool success;
  String message;

  GetForgotPasswordResponse({
    required this.success,
    required this.message,
  });

  factory GetForgotPasswordResponse.fromJson(Map<String, dynamic> json) => GetForgotPasswordResponse(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
