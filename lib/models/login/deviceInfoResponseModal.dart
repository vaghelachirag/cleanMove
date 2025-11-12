
import 'dart:convert';

SaveDeviceInfoResponseModal saveDeviceInfoResponseModalFromJson(String str) => SaveDeviceInfoResponseModal.fromJson(json.decode(str));

String saveDeviceInfoResponseModalToJson(SaveDeviceInfoResponseModal data) => json.encode(data.toJson());

class SaveDeviceInfoResponseModal {
  bool success;
  String message;

  SaveDeviceInfoResponseModal({
    required this.success,
    required this.message,
  });

  factory SaveDeviceInfoResponseModal.fromJson(Map<String, dynamic> json) => SaveDeviceInfoResponseModal(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
