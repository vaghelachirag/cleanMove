
import 'dart:convert';

ResetPasswordResponseModal resetPasswordResponseModalFromJson(String str) => ResetPasswordResponseModal.fromJson(json.decode(str));

String resetPasswordResponseModalToJson(ResetPasswordResponseModal data) => json.encode(data.toJson());

class ResetPasswordResponseModal {
  bool success;
  String message;

  ResetPasswordResponseModal({
    required this.success,
    required this.message,
  });

  factory ResetPasswordResponseModal.fromJson(Map<String, dynamic> json) => ResetPasswordResponseModal(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
