// To parse this JSON data, do
//
//     final resetPasswordRequestModal = resetPasswordRequestModalFromJson(jsonString);

import 'dart:convert';

ResetPasswordRequestModal resetPasswordRequestModalFromJson(String str) => ResetPasswordRequestModal.fromJson(json.decode(str));

String resetPasswordRequestModalToJson(ResetPasswordRequestModal data) => json.encode(data.toJson());

class ResetPasswordRequestModal {
  String? email;
  String? resetPasswordToken;
  String? password;

  ResetPasswordRequestModal({
    this.email,
    this.resetPasswordToken,
    this.password,
  });

  factory ResetPasswordRequestModal.fromJson(Map<String, dynamic> json) => ResetPasswordRequestModal(
    email: json["Email"],
    resetPasswordToken: json["ResetPasswordToken"],
    password: json["Password"],
  );

  Map<String, dynamic> toJson() => {
    "Email": email,
    "ResetPasswordToken": resetPasswordToken,
    "Password": password,
  };
}
