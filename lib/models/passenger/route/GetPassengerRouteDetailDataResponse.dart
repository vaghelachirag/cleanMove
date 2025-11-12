import 'dart:convert';


class GetPassengerRouteDetailDataResponse {
  int? routeId;
  String? routeName;
  String? routeCode;
  String? startingPoint;
  String? endingPoint;
  String? startLocationLatLng;
  String? endLocationLatLng;
  String? startTime;
  String? endTime;
  int? vehicleId;
  int? driverId;
  int? passengerId;
  String? passengerName;
  String? employeeCode;
  int? routePickUpId;
  int? pickUpOrder;
  String? latitude;
  String? longitude;
  String? pickUpName;
  String? driverName;
  String? vehiclePlateNo;
  int? dailyRouteId;

  GetPassengerRouteDetailDataResponse({
    this.routeId,
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
    this.passengerId,
    this.passengerName,
    this.employeeCode,
    this.routePickUpId,
    this.pickUpOrder,
    this.latitude,
    this.longitude,
    this.pickUpName,
    this.driverName,
    this.vehiclePlateNo,
    this.dailyRouteId,
  });

  factory GetPassengerRouteDetailDataResponse.fromJson(Map<String, dynamic> json) => GetPassengerRouteDetailDataResponse(
    routeId: json["RouteId"],
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
    passengerId: json["PassengerId"],
    passengerName: json["PassengerName"],
    employeeCode: json["EmployeeCode"],
    routePickUpId: json["RoutePickUpId"],
    pickUpOrder: json["PickUpOrder"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    pickUpName: json["PickUpName"],
    driverName: json["DriverName"],
    vehiclePlateNo: json["VehiclePlateNo"],
    dailyRouteId: json["DailyRouteId"],
  );

  Map<String, dynamic> toJson() => {
    "RouteId": routeId,
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
    "PassengerId": passengerId,
    "PassengerName": passengerName,
    "EmployeeCode": employeeCode,
    "RoutePickUpId": routePickUpId,
    "PickUpOrder": pickUpOrder,
    "Latitude": latitude,
    "Longitude": longitude,
    "PickUpName": pickUpName,
    "DriverName": driverName,
    "VehiclePlateNo": vehiclePlateNo,
    "DailyRouteId": dailyRouteId,
  };
}
