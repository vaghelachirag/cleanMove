import 'dart:convert';

class GetRoutePassengerListDetail {
  int ? routeId;
  int ? employeeId;
  int ? routePickUpId;
  String? firstName;
  String? lastName;
  String? pickUpName;
  bool? isPassengerInside;

  GetRoutePassengerListDetail({
    this.routeId,
    this.employeeId,
    this.routePickUpId,
    this.firstName,
    this.lastName,
    this.pickUpName,
  });

  factory GetRoutePassengerListDetail.fromJson(Map<String, dynamic> json) => GetRoutePassengerListDetail(
    routeId: json["RouteId"],
    employeeId: json["EmployeeId"],
    routePickUpId: json["RoutePickUpId"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    pickUpName: json["PickUpName"],
  );

  Map<String, dynamic> toJson() => {
    "RouteId": routeId,
    "EmployeeId": employeeId,
    "RoutePickUpId": routePickUpId,
    "FirstName": firstName,
    "LastName": lastName,
    "PickUpName": pickUpName,
  };
}
