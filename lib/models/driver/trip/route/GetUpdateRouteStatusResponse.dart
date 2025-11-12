import 'dart:convert';

GetUpdateRouteStatusResponse getUpdateRouteStatusResponseFromJson(String str) => GetUpdateRouteStatusResponse.fromJson(json.decode(str));

String getUpdateRouteStatusResponseToJson(GetUpdateRouteStatusResponse data) => json.encode(data.toJson());

class GetUpdateRouteStatusResponse {
  bool? success;
  String? message;

  GetUpdateRouteStatusResponse({
    this.success,
    this.message,
  });

  factory GetUpdateRouteStatusResponse.fromJson(Map<String, dynamic> json) => GetUpdateRouteStatusResponse(
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
  };
}
