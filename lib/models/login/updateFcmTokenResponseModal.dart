
import 'dart:convert';

UpdateFcmTokenResponseModal updateFcmTokenResponseModalFromJson(String str) => UpdateFcmTokenResponseModal.fromJson(json.decode(str));

String updateFcmTokenResponseModalToJson(UpdateFcmTokenResponseModal data) => json.encode(data.toJson());

class UpdateFcmTokenResponseModal {
  bool success;
  String message;

  UpdateFcmTokenResponseModal({
    required this.success,
    required this.message,
  });

  factory UpdateFcmTokenResponseModal.fromJson(Map<String, dynamic> json) => UpdateFcmTokenResponseModal(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
