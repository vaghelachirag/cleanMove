import 'dart:convert';

class GetRoutePickUpData {
  int ? routePickUpId;
  int? pickUpOrder;
  String? latitude;
  String? longitude;
  String? pickUpName;

  GetRoutePickUpData({
    this.routePickUpId,
    this.pickUpOrder,
    this.latitude,
    this.longitude,
    this.pickUpName,
  });

  factory GetRoutePickUpData.fromJson(Map<String, dynamic> json) => GetRoutePickUpData(
    routePickUpId: json["RoutePickUpId"],
    pickUpOrder: json["PickUpOrder"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    pickUpName: json["PickUpName"],
  );

  Map<String, dynamic> toJson() => {
    "RoutePickUpId": routePickUpId,
    "PickUpOrder": pickUpOrder,
    "Latitude": latitude,
    "Longitude": longitude,
    "PickUpName": pickUpName,
  };
}
