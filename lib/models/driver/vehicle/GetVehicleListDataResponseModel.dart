class GetVehicleDataResponseModel {
  int? vehicleId;
  String? vehiclePlateNo;
  String? vehiclePrefix;
  String? vehicleCategoryName;
  String? vehicleOperationName;
  String? operatingCategoryName;
  double? consumption;
  String? chassisMakeName;
  String? chassisModel;
  double? height;
  double? length;
  int? grossWeight;
  String? euroTechnologyName;
  String? co2Emission;
  String? accessibility;
  String? lift;
  int? noOfSeats;
  int? seat;
  String? busBody;
  String?  vehicleImagePath;


  GetVehicleDataResponseModel({
  this.vehicleId,
  this.vehiclePlateNo,
  this.vehiclePrefix,
  this.vehicleCategoryName,
  this.vehicleOperationName,
  this.operatingCategoryName,
  this.consumption,
  this.chassisMakeName,
  this.chassisModel,
  this.height,
  this.length,
  this.grossWeight,
  this.euroTechnologyName,
  this.co2Emission,
  this.accessibility,
  this.lift,
  this.noOfSeats,
  this.seat,
  this.busBody,
 this.vehicleImagePath,
  });

  factory GetVehicleDataResponseModel.fromJson(Map<String, dynamic> json) => GetVehicleDataResponseModel(
  vehicleId: json["VehicleId"],
  vehiclePlateNo: json["VehiclePlateNo"],
  vehiclePrefix: json["VehiclePrefix"],
  vehicleCategoryName: json["VehicleCategoryName"],
  vehicleOperationName: json["VehicleOperationName"],
  operatingCategoryName: json["OperatingCategoryName"],
  consumption: json["Consumption"].toDouble(),
  chassisMakeName: json["ChassisMakeName"],
  chassisModel: json["ChassisModel"],
  height: json["Height"].toDouble(),
  length: json["Length"].toDouble(),
  grossWeight: json["GrossWeight"],
  euroTechnologyName: json["EuroTechnologyName"],
  co2Emission: json["Co2Emission"],
  accessibility: json["Accessibility"],
  lift: json["Lift"],
  noOfSeats: json["NoOfSeats"],
  seat: json["Seat"],
  busBody: json["BusBody"],
  vehicleImagePath: json["VehicleImagePath"],
  );

  Map<String, dynamic> toJson() => {
  "VehicleId": vehicleId,
  "VehiclePlateNo": vehiclePlateNo,
  "VehiclePrefix": vehiclePrefix,
  "VehicleCategoryName": vehicleCategoryName,
  "VehicleOperationName": vehicleOperationName,
  "OperatingCategoryName": operatingCategoryName,
  "Consumption": consumption,
  "ChassisMakeName": chassisMakeName,
  "ChassisModel": chassisModel,
  "Height": height,
  "Length": length,
  "GrossWeight": grossWeight,
  "EuroTechnologyName": euroTechnologyName,
  "Co2Emission": co2Emission,
  "Accessibility": accessibility,
  "Lift": lift,
  "NoOfSeats": noOfSeats,
  "Seat": seat,
  "BusBody": busBody,
  "VehicleImagePath": vehicleImagePath,
  };
}



