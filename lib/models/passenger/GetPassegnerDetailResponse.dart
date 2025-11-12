import 'dart:convert';

GetPassengerDetailResponse getPassengerDetailResponseFromJson(String str) => GetPassengerDetailResponse.fromJson(json.decode(str));

String getPassengerDetailResponseToJson(GetPassengerDetailResponse data) => json.encode(data.toJson());

class GetPassengerDetailResponse {
  Data data;
  bool success;
  String message;

  GetPassengerDetailResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory GetPassengerDetailResponse.fromJson(Map<String, dynamic> json) => GetPassengerDetailResponse(
    data: Data.fromJson(json["Data"]),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data.toJson(),
    "Success": success,
    "Message": message,
  };
}

class Data {
  int ? userId;
  int? passengerId;
  String ?firstName;
  String ?lastName;
  String? whatsappNo;
  String? emailAddress;
  String? zipCode;
  String? street;
  String? city;
  String? shiftStartTime;
  String? shiftEndTime;
  String? workJourney;
  String? workPlace;
  String? workingRule;
  String? travellingRule;
  bool? wheelchair;
  String? daysOfWork;
  int? industryId;
  int? companyId;
  bool? isPassenger;
  bool? isActive;
  int? createdBy;
  int? totalRecords;
  String?address;

  Data({
     this.userId,
     this.passengerId,
     this.firstName,
     this.lastName,
     this.whatsappNo,
     this.emailAddress,
     this.zipCode,
     this.street,
     this.city,
     this.shiftStartTime,
     this.shiftEndTime,
     this.workJourney,
     this.workPlace,
     this.workingRule,
     this.travellingRule,
     this.wheelchair,
     this.daysOfWork,
     this.industryId,
     this.companyId,
     this.isPassenger,
     this.isActive,
     this.createdBy,
     this.totalRecords,
     this.address,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["UserId"],
    passengerId: json["PassengerId"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    whatsappNo: json["WhatsappNo"],
    emailAddress: json["EmailAddress"],
    zipCode: json["ZipCode"],
    street: json["Street"],
    city: json["City"],
    shiftStartTime: json["ShiftStartTime"],
    shiftEndTime: json["ShiftEndTime"],
    workJourney: json["WorkJourney"],
    workPlace: json["WorkPlace"],
    workingRule: json["WorkingRule"],
    travellingRule: json["TravellingRule"],
    wheelchair: json["Wheelchair"],
    daysOfWork: json["DaysOfWork"],
    industryId: json["IndustryId"],
    companyId: json["CompanyId"],
    isPassenger: json["IsPassenger"],
    isActive: json["IsActive"],
    createdBy: json["CreatedBy"],
    totalRecords: json["TotalRecords"],
    address: json["Address"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "PassengerId": passengerId,
    "FirstName": firstName,
    "LastName": lastName,
    "WhatsappNo": whatsappNo,
    "EmailAddress": emailAddress,
    "ZipCode": zipCode,
    "Street": street,
    "City": city,
    "ShiftStartTime": shiftStartTime,
    "ShiftEndTime": shiftEndTime,
    "WorkJourney": workJourney,
    "WorkPlace": workPlace,
    "WorkingRule": workingRule,
    "TravellingRule": travellingRule,
    "Wheelchair": wheelchair,
    "DaysOfWork": daysOfWork,
    "IndustryId": industryId,
    "CompanyId": companyId,
    "IsPassenger": isPassenger,
    "IsActive": isActive,
    "CreatedBy": createdBy,
    "TotalRecords": totalRecords,
    "Address": address,
  };
}
