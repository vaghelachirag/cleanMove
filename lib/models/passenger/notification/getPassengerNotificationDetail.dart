/*
import 'dart:convert';

class GetPassengerNotificationDetail {
  int ? passengerNotificationId;
  String? notificationTitle;
  String ? notificationMessage;
  int? employeeId;
  bool? isRead;
  bool? isDiscard;
  bool? isActive;
  bool? isDelete;
  int? createdBy;
  DateTime? createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  GetPassengerNotificationDetail({
    this.passengerNotificationId,
    this.notificationTitle,
    this.notificationMessage,
    this.employeeId,
    this.isRead,
    this.isDiscard,
    this.isActive,
    this.isDelete,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory GetPassengerNotificationDetail.fromJson(Map<String, dynamic> json) => GetPassengerNotificationDetail(
    passengerNotificationId: json["PassengerNotificationId"],
    notificationTitle: json["NotificationTitle"],
    notificationMessage: json["NotificationMessage"],
    employeeId: json["EmployeeId"],
    isRead: json["IsRead"],
    isDiscard: json["IsDiscard"],
    isActive: json["IsActive"],
    isDelete: json["IsDelete"],
    createdBy: json["CreatedBy"],
    createdDate: DateTime.parse(json["CreatedDate"]),
    updatedBy: json["UpdatedBy"],
    updatedDate: DateTime.parse(json["UpdatedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "PassengerNotificationId": passengerNotificationId,
    "NotificationTitle": notificationTitle,
    "NotificationMessage": notificationMessage,
    "EmployeeId": employeeId,
    "IsRead": isRead,
    "IsDiscard": isDiscard,
    "IsActive": isActive,
    "IsDelete": isDelete,
    "CreatedBy": createdBy,
    "CreatedDate": createdDate!.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedDate": updatedDate!.toIso8601String(),
  };
}
*/
// To parse this JSON data, do
//
//     final passengerNotificationDetail = passengerNotificationDetailFromJson(jsonString);

import 'dart:convert';

PassengerNotificationDetail passengerNotificationDetailFromJson(String str) => PassengerNotificationDetail.fromJson(json.decode(str));

String passengerNotificationDetailToJson(PassengerNotificationDetail data) => json.encode(data.toJson());

class PassengerNotificationDetail {
  List<NotificationList>? data;
  bool? success;
  String? message;

  PassengerNotificationDetail({
    this.data,
    this.success,
    this.message,
  });

  factory PassengerNotificationDetail.fromJson(Map<String, dynamic> json) => PassengerNotificationDetail(
    data: json["Data"] == null ? [] : List<NotificationList>.from(json["Data"]!.map((x) => NotificationList.fromJson(x))),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "Success": success,
    "Message": message,
  };
}

class NotificationList {
  int? passengerNotificationId;
  String? notificationTitle;
  String? notificationMessage;
  int? employeeId;
  bool? isRead;
  bool? isDiscard;
  bool? isActive;
  bool? isDelete;
  int? createdBy;
  DateTime? createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  NotificationList({
    this.passengerNotificationId,
    this.notificationTitle,
    this.notificationMessage,
    this.employeeId,
    this.isRead,
    this.isDiscard,
    this.isActive,
    this.isDelete,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    passengerNotificationId: json["PassengerNotificationId"],
    notificationTitle: json["NotificationTitle"],
    notificationMessage: json["NotificationMessage"],
    employeeId: json["EmployeeId"],
    isRead: json["IsRead"],
    isDiscard: json["IsDiscard"],
    isActive: json["IsActive"],
    isDelete: json["IsDelete"],
    createdBy: json["CreatedBy"],
    createdDate: json["CreatedDate"] == null ? null : DateTime.parse(json["CreatedDate"]),
    updatedBy: json["UpdatedBy"],
    updatedDate: json["UpdatedDate"] == null ? null : DateTime.parse(json["UpdatedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "PassengerNotificationId": passengerNotificationId,
    "NotificationTitle": notificationTitle,
    "NotificationMessage": notificationMessage,
    "EmployeeId": employeeId,
    "IsRead": isRead,
    "IsDiscard": isDiscard,
    "IsActive": isActive,
    "IsDelete": isDelete,
    "CreatedBy": createdBy,
    "CreatedDate": createdDate?.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedDate": updatedDate?.toIso8601String(),
  };
}
