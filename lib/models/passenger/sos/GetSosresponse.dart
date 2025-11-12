import 'dart:convert';

GetSosResponse getSosResponseFromJson(String str) => GetSosResponse.fromJson(json.decode(str));

String getSosResponseToJson(GetSosResponse data) => json.encode(data.toJson());

class GetSosResponse {
  bool success;
  String message;

  GetSosResponse({
    required this.success,
    required this.message,
  });

  factory GetSosResponse.fromJson(Map<String, dynamic> json) => GetSosResponse(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
