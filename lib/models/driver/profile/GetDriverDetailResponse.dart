// To parse this JSON data, do
//
//     final getDriverDetailResponse = getDriverDetailResponseFromJson(jsonString);

import 'dart:convert';

GetDriverDetailResponse getDriverDetailResponseFromJson(String str) => GetDriverDetailResponse.fromJson(json.decode(str));

String getDriverDetailResponseToJson(GetDriverDetailResponse data) => json.encode(data.toJson());

class GetDriverDetailResponse {
  final List<GetDriverDetail> ? data;
  final bool ? success;
  final String ? message;

  GetDriverDetailResponse({
    this.data,
    this.success,
    this.message,
  });

  factory GetDriverDetailResponse.fromJson(Map<String, dynamic> json) => GetDriverDetailResponse(
    data: List<GetDriverDetail>.from(json["Data"].map((x) => GetDriverDetail.fromJson(x))),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "Success": success,
    "Message": message,
  };
}

class GetDriverDetail {
  final int ? driverId;
  final String ? driverName;
  final String ? firstName;
  final String ? lastName;
  final String ? whatsappNo;
  final String?  emailAddress;
  final String? zipCode;
  final String? street;
  final String? neighborhood;
  final String? city;
  final dynamic? state;
  final String? rg;
  final String? cpf;
  final String? driverLicenseNo;
  final DateTime? issuedDate;
  final dynamic? strIssuedDate;
  final DateTime? expiringDate;
  final dynamic? strExpiringDate;
  final DateTime? toxicology;
  final dynamic? strToxicology;
  final String? journey;
  final String? daysOfWork;
  final bool? isBusStaysInGarage;
  final int? industryId;
  final int? companyId;
  final bool ?isActive;
  final int? createdBy;
  final int? totalRecords;

  GetDriverDetail({
    this.driverId,
    this.driverName,
    this.firstName,
    this.lastName,
    this.whatsappNo,
    this.emailAddress,
    this.zipCode,
    this.street,
    this.neighborhood,
    this.city,
    this.state,
    this.rg,
    this.cpf,
    this.driverLicenseNo,
    this.issuedDate,
    this.strIssuedDate,
    this.expiringDate,
    this.strExpiringDate,
    this.toxicology,
    this.strToxicology,
    this.journey,
    this.daysOfWork,
    this.isBusStaysInGarage,
    this.industryId,
    this.companyId,
    this.isActive,
    this.createdBy,
    this.totalRecords,
  });

  factory GetDriverDetail.fromJson(Map<String, dynamic> json) => GetDriverDetail(
    driverId: json["DriverId"],
    driverName: json["DriverName"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    whatsappNo: json["WhatsappNo"],
    emailAddress: json["EmailAddress"],
    zipCode: json["ZipCode"],
    street: json["Street"],
    neighborhood: json["Neighborhood"],
    city: json["City"],
    state: json["State"],
    rg: json["RG"],
    cpf: json["CPF"],
    driverLicenseNo: json["DriverLicenseNo"],
    issuedDate: DateTime.parse(json["IssuedDate"]),
    strIssuedDate: json["StrIssuedDate"],
    expiringDate: DateTime.parse(json["ExpiringDate"]),
    strExpiringDate: json["StrExpiringDate"],
    toxicology: DateTime.parse(json["Toxicology"]),
    strToxicology: json["StrToxicology"],
    journey: json["Journey"],
    daysOfWork: json["DaysOfWork"],
    isBusStaysInGarage: json["IsBusStaysInGarage"],
    industryId: json["IndustryId"],
    companyId: json["CompanyId"],
    isActive: json["IsActive"],
    createdBy: json["CreatedBy"],
    totalRecords: json["TotalRecords"],
  );

  Map<String, dynamic> toJson() => {
    "DriverId": driverId,
    "DriverName": driverName,
    "FirstName": firstName,
    "LastName": lastName,
    "WhatsappNo": whatsappNo,
    "EmailAddress": emailAddress,
    "ZipCode": zipCode,
    "Street": street,
    "Neighborhood": neighborhood,
    "City": city,
    "State": state,
    "RG": rg,
    "CPF": cpf,
    "DriverLicenseNo": driverLicenseNo,
    "IssuedDate": issuedDate.toString(),
    "StrIssuedDate": strIssuedDate,
    "ExpiringDate": expiringDate.toString(),
    "StrExpiringDate": strExpiringDate,
    "Toxicology": toxicology.toString(),
    "StrToxicology": strToxicology,
    "Journey": journey,
    "DaysOfWork": daysOfWork,
    "IsBusStaysInGarage": isBusStaysInGarage,
    "IndustryId": industryId,
    "CompanyId": companyId,
    "IsActive": isActive,
    "CreatedBy": createdBy,
    "TotalRecords": totalRecords,
  };
}
