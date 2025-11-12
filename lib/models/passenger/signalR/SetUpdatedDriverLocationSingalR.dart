import 'dart:convert';

List<GetDriverUpdatedLocationSignalR> getDriverUpdatedLocationSignalRFromJson(String str) => List<GetDriverUpdatedLocationSignalR>.from(json.decode(str).map((x) => GetDriverUpdatedLocationSignalR.fromJson(x)));

String getDriverUpdatedLocationSignalRToJson(List<GetDriverUpdatedLocationSignalR> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDriverUpdatedLocationSignalR {
  double ? lat;
  double ? lng;

  GetDriverUpdatedLocationSignalR({
    this.lat,
    this.lng,
  });

  factory GetDriverUpdatedLocationSignalR.fromJson(Map<String, dynamic> json) => GetDriverUpdatedLocationSignalR(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
