// To parse this JSON data, do
//
//     final saveDeviceInfoRequestModal = saveDeviceInfoRequestModalFromJson(jsonString);

import 'dart:convert';

SaveDeviceInfoRequestModal saveDeviceInfoRequestModalFromJson(String str) => SaveDeviceInfoRequestModal.fromJson(json.decode(str));

String saveDeviceInfoRequestModalToJson(SaveDeviceInfoRequestModal data) => json.encode(data.toJson());

class SaveDeviceInfoRequestModal {
  int? userId;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  int? roleId;
  int? companyId;
  int? industryId;
  String? preferredLanguage;
  String? token;
  String? fcmToken;
  String? deviceType;
  String? deviceId;
  String? deviceOs;
  String? deviceModel;
  String? appVersion;

  SaveDeviceInfoRequestModal({
    this.userId,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.roleId,
    this.companyId,
    this.industryId,
    this.preferredLanguage,
    this.token,
    this.fcmToken,
    this.deviceType,
    this.deviceId,
    this.deviceOs,
    this.deviceModel,
    this.appVersion,
  });

  factory SaveDeviceInfoRequestModal.fromJson(Map<String, dynamic> json) => SaveDeviceInfoRequestModal(
    userId: json["UserId"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    userName: json["UserName"],
    email: json["Email"],
    roleId: json["RoleId"],
    companyId: json["CompanyId"],
    industryId: json["IndustryId"],
    preferredLanguage: json["PreferredLanguage"],
    token: json["Token"],
    fcmToken: json["FCMToken"],
    deviceType: json["DeviceType"],
    deviceId: json["DeviceId"],
    deviceOs: json["DeviceOS"],
    deviceModel: json["DeviceModel"],
    appVersion: json["AppVersion"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "FirstName": firstName,
    "LastName": lastName,
    "UserName": userName,
    "Email": email,
    "RoleId": roleId,
    "CompanyId": companyId,
    "IndustryId": industryId,
    "PreferredLanguage": preferredLanguage,
    "Token": token,
    "FCMToken": fcmToken,
    "DeviceType": deviceType,
    "DeviceId": deviceId,
    "DeviceOS": deviceOs,
    "DeviceModel": deviceModel,
    "AppVersion": appVersion,
  };
}
