import 'dart:convert';

ChangePasswordRequestModel changePasswordRequestModelFromJson(String str) => ChangePasswordRequestModel.fromJson(json.decode(str));

String changePasswordRequestModelToJson(ChangePasswordRequestModel data) => json.encode(data.toJson());

class ChangePasswordRequestModel {
  String oldPassword;
  String newPassword;
  String confirmNewPassword;

  ChangePasswordRequestModel({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) => ChangePasswordRequestModel(
    oldPassword: json["OldPassword"],
    newPassword: json["NewPassword"],
    confirmNewPassword: json["ConfirmNewPassword"],
  );

  Map<String, dynamic> toJson() => {
    "OldPassword": oldPassword,
    "NewPassword": newPassword,
    "ConfirmNewPassword": confirmNewPassword,
  };
}
