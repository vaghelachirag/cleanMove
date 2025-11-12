import 'dart:convert';

GetPassengerCheckInResponse getPassengerCheckInResponseFromJson(String str) => GetPassengerCheckInResponse.fromJson(json.decode(str));

String getPassengerCheckInResponseToJson(GetPassengerCheckInResponse data) => json.encode(data.toJson());

class GetPassengerCheckInResponse {
  bool? success;
  String? message;

  GetPassengerCheckInResponse({
    this.success,
    this.message,
  });

  factory GetPassengerCheckInResponse.fromJson(Map<String, dynamic> json) => GetPassengerCheckInResponse(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
