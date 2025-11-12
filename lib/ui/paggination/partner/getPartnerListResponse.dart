
import 'dart:convert';

GetPartnerListResponse getPartnerListResponseFromJson(String str) => GetPartnerListResponse.fromJson(json.decode(str));

String getPartnerListResponseToJson(GetPartnerListResponse data) => json.encode(data.toJson());

class GetPartnerListResponse {
  List<GetPartnerListData> data;
  bool success;
  String message;

  GetPartnerListResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory GetPartnerListResponse.fromJson(Map<String, dynamic> json) => GetPartnerListResponse(
    data: List<GetPartnerListData>.from(json["Data"].map((x) => GetPartnerListData.fromJson(x))),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    "Success": success,
    "Message": message,
  };
}

class GetPartnerListData {
  int partnerId;
  String firstName;
  String lastName;
  String email;

  GetPartnerListData({
    required this.partnerId,
    required this.firstName,
    required this.lastName,
    required this.email,

  });

  factory GetPartnerListData.fromJson(Map<String, dynamic> json) => GetPartnerListData(
    partnerId: json["PartnerId"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    email: json["Email"]
  );

  Map<String, dynamic> toJson() => {
    "PartnerId": partnerId,
    "FirstName": firstName,
    "LastName": lastName,
    "Email": email
  };
}
