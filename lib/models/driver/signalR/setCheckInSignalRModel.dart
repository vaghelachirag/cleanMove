import 'dart:convert';

SetCheckInSignalRModel setCheckInSignalRModelFromJson(String str) => SetCheckInSignalRModel.fromJson(json.decode(str));

String setCheckInSignalRModelToJson(SetCheckInSignalRModel data) => json.encode(data.toJson());

class SetCheckInSignalRModel {
  int? passengerId;
  bool? checkIn;
  int? routeId;

  SetCheckInSignalRModel({
    this.passengerId,
    this.checkIn,
    this.routeId,
  });

  factory SetCheckInSignalRModel.fromJson(Map<String, dynamic> json) => SetCheckInSignalRModel(
    passengerId: json["passengerId"],
    checkIn: json["checkIn"],
    routeId: json["routeId"],
  );

  Map<String, dynamic> toJson() => {
    "passengerId": passengerId,
    "checkIn": checkIn,
    "routeId": routeId,
  };
}
