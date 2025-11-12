import 'dart:convert';

import 'package:shaligram_transport_app/models/driver/vehicle/GetVehicleListDataResponseModel.dart';

GetVehicleListResponse getVehicleListResponseFromJson(String str) => GetVehicleListResponse.fromJson(json.decode(str));

String getVehicleListResponseToJson(GetVehicleListResponse data) => json.encode(data.toJson());

class GetVehicleListResponse {
  List<GetVehicleDataResponseModel> data;
  bool success;
  dynamic message;

  GetVehicleListResponse({
    required this.data,
    required this.success,
    this.message,
  });

  factory GetVehicleListResponse.fromJson(Map<String, dynamic> json) => GetVehicleListResponse(
    data: List<GetVehicleDataResponseModel>.from(json["Data"].map((x) => GetVehicleDataResponseModel.fromJson(x))),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    "Success": success,
    "Message": message,
  };
}