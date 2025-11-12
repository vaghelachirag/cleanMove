
import 'dart:convert';

import 'GetDriverLatLongDataFromServer.dart';

GetDriverLatLongFromServer getDriverLatLongFromServerFromJson(String str) => GetDriverLatLongFromServer.fromJson(json.decode(str));

String getDriverLatLongFromServerToJson(GetDriverLatLongFromServer data) => json.encode(data.toJson());

class GetDriverLatLongFromServer {
  GetDriverLatLongDatFromServer ? data;
  bool ? success;
  String ? message;

  GetDriverLatLongFromServer({
    this.data,
    this.success,
    this.message,
  });

  factory GetDriverLatLongFromServer.fromJson(Map<String, dynamic> json) => GetDriverLatLongFromServer(
    data: GetDriverLatLongDatFromServer.fromJson(json["data"]),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "success": success,
    "message": message,
  };
}