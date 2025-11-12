import 'dart:convert';

GetChangeAddressResponse getChangeAddressResponseFromJson(String str) => GetChangeAddressResponse.fromJson(json.decode(str));

String getChangeAddressResponseToJson(GetChangeAddressResponse data) => json.encode(data.toJson());

class GetChangeAddressResponse {
  final bool? success;
  final String? message;

  GetChangeAddressResponse({
    this.success,
    this.message,
  });

  factory GetChangeAddressResponse.fromJson(Map<String, dynamic> json) => GetChangeAddressResponse(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
