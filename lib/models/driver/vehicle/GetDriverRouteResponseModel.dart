import 'dart:convert';

import 'GetVehicleRouteDataModel.dart';


GetRouteResponseModel getRouteResponseModelFromJson(String str) => GetRouteResponseModel.fromJson(json.decode(str));

String getRouteResponseModelToJson(GetRouteResponseModel data) => json.encode(data.toJson());

class GetRouteResponseModel {
  bool? success;
  String? message;
  GetVehicleRouteDataModel? data;

  GetRouteResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetRouteResponseModel.fromJson(Map<String, dynamic> json) => GetRouteResponseModel(
    success: json["Success"],
    message: json["Message"],
    data: GetVehicleRouteDataModel.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Data": data?.toJson(),
  };
}
