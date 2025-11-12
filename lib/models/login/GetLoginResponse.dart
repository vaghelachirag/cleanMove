import 'dart:convert';

GetLoginResponse getLoginResponseFromJson(String str) => GetLoginResponse.fromJson(json.decode(str));



String getLoginResponseToJson(GetLoginResponse data) => json.encode(data.toJson());

class GetLoginResponse {
  GetLoginData data;
  bool success;
  String message;

  GetLoginResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory GetLoginResponse.fromJson(Map<String, dynamic> json) => GetLoginResponse(
    data: GetLoginData.fromJson(json["Data"]),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data.toJson(),
    "Success": success,
    "Message": message,
  };
}

class GetLoginData {
  int userId;
  String firstName;
  String lastName;
  String userName;
  String email;
  int roleId;
  int commonId;
  int companyId;
  String token;

  GetLoginData({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.roleId,
    required this.commonId,
    required this.companyId,
    required this.token
  });

  factory GetLoginData.fromJson(Map<String, dynamic> json) => GetLoginData(
    userId: json["UserId"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    userName: json["UserName"],
    email: json["Email"],
    roleId: json["RoleId"],
    commonId: json["CommonId"],
    companyId: json["CompanyId"],
    token: json["Token"]
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "FirstName": firstName,
    "LastName": lastName,
    "UserName": userName,
    "Email": email,
    "RoleId": roleId,
    "CommonId": commonId,
    "CompanyId": companyId,
    "Token": token,
  };


}
