import 'dart:convert';

SetSosResponse setSosResponseFromJson(String str) => SetSosResponse.fromJson(json.decode(str));

String setSosResponseToJson(SetSosResponse data) => json.encode(data.toJson());

class SetSosResponse {
  int userId;
  String sosType;
  String sosDetails;
  String comment;
  String latitude;
  String longitude;
  int routeId;

  SetSosResponse({
    required this.userId,
    required this.sosType,
    required this.sosDetails,
    required this.comment,
    required this.latitude,
    required this.longitude,
    required this.routeId,
  });

  factory SetSosResponse.fromJson(Map<String, dynamic> json) => SetSosResponse(
    userId: json["UserId"],
    sosType: json["SOSType"],
    sosDetails: json["SOSDetails"],
    comment: json["Comment"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    routeId: json["RouteId"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "SOSType": sosType,
    "SOSDetails": sosDetails,
    "Comment": comment,
    "Latitude": latitude,
    "Longitude": longitude,
    "RouteId": routeId,
  };
}
