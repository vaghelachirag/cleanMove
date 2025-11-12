import 'dart:convert';

import 'package:shaligram_transport_app/models/driver/vehicle/GetRoutePickUpData.dart';

import 'GetRouteMapingData.dart';

class GetVehicleRouteDataModel {
  GetRouteMappingData  routeMapingData;
  List<GetRoutePickUpData> routePickUpDatas;

  GetVehicleRouteDataModel({
    required this.routeMapingData,
    required this.routePickUpDatas,
  });

  factory GetVehicleRouteDataModel.fromJson(Map<String, dynamic> json) => GetVehicleRouteDataModel(
    routeMapingData: GetRouteMappingData.fromJson(json["RouteMapingData"]),
    routePickUpDatas: List<GetRoutePickUpData>.from(json["RoutePickUpDatas"].map((x) => GetRoutePickUpData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "RouteMapingData": routeMapingData?.toJson(),
    "RoutePickUpDatas": List<dynamic>.from(routePickUpDatas.map((x) => x.toJson())),
  };
}
