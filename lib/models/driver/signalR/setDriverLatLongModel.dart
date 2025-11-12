import 'dart:convert';

List<SetDriverLatLongModel> setUpdateDriverLocationModelFromJson(String str) => List<SetDriverLatLongModel>.from(json.decode(str).map((x) => SetDriverLatLongModel.fromJson(x)));

String setUpdateDriverLocationModelToJson(List<SetDriverLatLongModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SetDriverLatLongModel {
  double? lat;
  double? lng;

  SetDriverLatLongModel({
    this.lat,
    this.lng,
  });

  factory SetDriverLatLongModel.fromJson(Map<String, dynamic> json) => SetDriverLatLongModel(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
