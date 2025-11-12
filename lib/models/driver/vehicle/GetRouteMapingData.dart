import 'dart:convert';
class GetRouteMappingData {
  int ? routeId;
  int ? dailyRouteId;
  String ? routeName;
  String ? routeCode;
  String ?startingPoint;
  String ?endingPoint;
  String ? startLocationLatLng;
  String? endLocationLatLng;
  String? startTime;
  String? endTime;
  int? vehicleId;
  int? driverId;
  int? totalPickupPoint;
  int? totalPassengers;

  GetRouteMappingData({
    this.routeId,
    this.dailyRouteId,
    this.routeName,
    this.routeCode,
    this.startingPoint,
    this.endingPoint,
    this.startLocationLatLng,
    this.endLocationLatLng,
    this.startTime,
    this.endTime,
    this.vehicleId,
    this.driverId,
    this.totalPickupPoint,
    this.totalPassengers,
  });

  factory GetRouteMappingData.fromJson(Map<String, dynamic> json) => GetRouteMappingData(
    routeId: json["RouteId"],
    dailyRouteId: json["DailyRouteId"],
    routeName: json["RouteName"],
    routeCode: json["RouteCode"],
    startingPoint: json["StartingPoint"],
    endingPoint: json["EndingPoint"],
    startLocationLatLng: json["StartLocationLatLng"],
    endLocationLatLng: json["EndLocationLatLng"],
    startTime: json["StartTime"],
    endTime: json["EndTime"],
    vehicleId: json["VehicleId"],
    driverId: json["DriverId"],
    totalPickupPoint: json["TotalPickupPoint"],
    totalPassengers: json["TotalPassengers"],
  );

  Map<String, dynamic> toJson() => {
    "RouteId": routeId,
    "DailyRouteId": dailyRouteId,
    "RouteName": routeName,
    "RouteCode": routeCode,
    "StartingPoint": startingPoint,
    "EndingPoint": endingPoint,
    "StartLocationLatLng": startLocationLatLng,
    "EndLocationLatLng": endLocationLatLng,
    "StartTime": startTime,
    "EndTime": endTime,
    "VehicleId": vehicleId,
    "DriverId": driverId,
    "TotalPickupPoint": totalPickupPoint,
    "TotalPassengers": totalPassengers,
  };
}
