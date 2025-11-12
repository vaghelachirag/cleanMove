import 'dart:convert';

GetDriverUpdatedLocationSignalR getDriverUpdatedLocationSignalRFromJson(String str) => GetDriverUpdatedLocationSignalR.fromJson(json.decode(str));

String getDriverUpdatedLocationSignalRToJson(GetDriverUpdatedLocationSignalR data) => json.encode(data.toJson());

class GetDriverUpdatedLocationSignalR {
  int? dailyRouteId;
  int? routeId;

  GetDriverUpdatedLocationSignalR({
    this.dailyRouteId,
    this.routeId,
  });

  factory GetDriverUpdatedLocationSignalR.fromJson(Map<String, dynamic> json) => GetDriverUpdatedLocationSignalR(
    dailyRouteId: json["DailyRouteId"],
    routeId: json["RouteId"],
  );

  Map<String, dynamic> toJson() => {
    "DailyRouteId": dailyRouteId,
    "RouteId": routeId,
  };
}
