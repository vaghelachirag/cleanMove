
import 'dart:convert';

ForgotPasswordRequestModel getLoginResponseFromJson(String str) => ForgotPasswordRequestModel.fromJson(json.decode(str));

String getLoginResponseToJson(ForgotPasswordRequestModel data) => json.encode(data.toJson());

class ForgotPasswordRequestModel {
  String email;

  ForgotPasswordRequestModel({
    required this.email,
  });

  factory ForgotPasswordRequestModel.fromJson(Map<String, dynamic> json) => ForgotPasswordRequestModel(
    email: json["Email"],
  );

  Map<String, dynamic> toJson() => {
    "Email": email,
  };
}
