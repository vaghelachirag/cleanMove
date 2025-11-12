import 'dart:convert';

GetSurveyResponse getSurveyResponseFromJson(String str) => GetSurveyResponse.fromJson(json.decode(str));

String getSurveyResponseToJson(GetSurveyResponse data) => json.encode(data.toJson());

class GetSurveyResponse {
  List<GetSurveyListData> data;
  bool success;
  String message;

  GetSurveyResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory GetSurveyResponse.fromJson(Map<String, dynamic> json) => GetSurveyResponse(
    data: List<GetSurveyListData>.from(json["Data"].map((x) => GetSurveyListData.fromJson(x))),
    success: json["Success"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    "Success": success,
    "Message": message,
  };
}

class GetSurveyListData {
  int surveyId;
  String userName;
  String enquiryNo;
  DateTime moveDate;
  String companyName;
  String address;
  String phoneWork;
  String mobile1;
  dynamic mobile2;
  String phoneHome;
  String emailAddress1;
  String emailAddress2;
  int userId;
  int totalRecords;
  bool isSubmitted;
  String reportLink;
  DateTime? submittedDate;
  String surveyerName;
  String surveyDate;
  String surveyTime;
  String enquiryType;
  dynamic submittedTime;

  GetSurveyListData({
    required this.surveyId,
    required this.userName,
    required this.enquiryNo,
    required this.moveDate,
    required this.companyName,
    required this.address,
    required this.phoneWork,
    required this.mobile1,
    required this.mobile2,
    required this.phoneHome,
    required this.emailAddress1,
    required this.emailAddress2,
    required this.userId,
    required this.totalRecords,
    required this.isSubmitted,
    required this.reportLink,
    required this.submittedDate,
    required this.surveyerName,
    required this.surveyDate,
    required this.surveyTime,
    required this.enquiryType,
    required this.submittedTime,
  });

  factory GetSurveyListData.fromJson(Map<String, dynamic> json) => GetSurveyListData(
    surveyId: json["SurveyId"],
    userName: json["UserName"],
    enquiryNo: json["EnquiryNo"],
    moveDate: DateTime.parse(json["MoveDate"]),
    companyName: json["CompanyName"],
    address: json["Address"],
    phoneWork: json["PhoneWork"],
    mobile1: json["Mobile1"],
    mobile2: json["Mobile2"],
    phoneHome: json["PhoneHome"],
    emailAddress1: json["EmailAddress1"],
    emailAddress2: json["EmailAddress2"],
    userId: json["UserId"],
    totalRecords: json["TotalRecords"],
    isSubmitted: json["IsSubmitted"],
    reportLink: json["ReportLink"],
    submittedDate: json["SubmittedDate"] == null ? null : DateTime.parse(json["SubmittedDate"]),
    surveyerName: json["SurveyerName"],
    surveyDate: json["SurveyDate"],
    surveyTime: json["SurveyTime"],
    enquiryType: json["EnquiryType"],
    submittedTime: json["SubmittedTime"],
  );

  Map<String, dynamic> toJson() => {
    "SurveyId": surveyId,
    "UserName": userName,
    "EnquiryNo": enquiryNo,
    "MoveDate": moveDate.toIso8601String(),
    "CompanyName": companyName,
    "Address": address,
    "PhoneWork": phoneWork,
    "Mobile1": mobile1,
    "Mobile2": mobile2,
    "PhoneHome": phoneHome,
    "EmailAddress1": emailAddress1,
    "EmailAddress2": emailAddress2,
    "UserId": userId,
    "TotalRecords": totalRecords,
    "IsSubmitted": isSubmitted,
    "ReportLink": reportLink,
    "SubmittedDate": submittedDate?.toIso8601String(),
    "SurveyerName": surveyerName,
    "SurveyDate": surveyDate,
    "SurveyTime": surveyTime,
    "EnquiryType": enquiryType,
    "SubmittedTime": submittedTime,
  };
}
