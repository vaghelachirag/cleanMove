import 'dart:convert';

SetUpdateDriverLocationModel setUpdateDriverLocationModelFromJson(String str) => SetUpdateDriverLocationModel.fromJson(json.decode(str));

String setUpdateDriverLocationModelToJson(SetUpdateDriverLocationModel data) => json.encode(data.toJson());

class SetUpdateDriverLocationModel {
  int? dailyRouteId;
  int? routeId;
  String? routeTrackData;
  int? createdBy;

  SetUpdateDriverLocationModel({
    this.dailyRouteId,
    this.routeId,
    this.routeTrackData,
    this.createdBy,
  });

  factory SetUpdateDriverLocationModel.fromJson(Map<String, dynamic> json) => SetUpdateDriverLocationModel(
    dailyRouteId: json["DailyRouteId"],
    routeId: json["RouteId"],
    routeTrackData: json["RouteTrackData"],
    createdBy: json["CreatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "DailyRouteId": dailyRouteId,
    "RouteId": routeId,
    "RouteTrackData": routeTrackData,
    "CreatedBy": createdBy,
  };
}
