
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppConstant {

 static  String assestPath = 'assets/images/';
 static  String assestPathIcon = 'assets/icons/';
 static double inputLabelSize = 12.0;
 static double buttonSize = 14.0 ;

 //  For Get Device Width and Height
 static double deviceWidth = Get.width;
 static double deviceHeight = Get.width;

 // Font Family
 static const String labelFrontRegular = 'Poppins-Regular' ;
 static const String labelFrontLight = 'Poppins-Light' ;
 static const String labelFrontBold = 'Poppins-Bold' ;
 static const String labelFrontLightItalic = 'Poppins-LightItalic.ttf' ;

 // For Language Translation
 static const String languageCode = "language_code";
 static const String countryCode = "country_code";
 static const String authToken = "authToken";
 static const String keepMeLogin = "keepMeLogin";
 static const String userRole = "userRole";
 
 static const String rememberMe = "rememberMe";
 static const String username = "userName";
 static const String password = "password";
 static const String userId = "userId";
 static const String profileName = "profileName";
 static const String email = "email";

 static const String storageName = "CleanMove";
 static const int roleIdPassenger =  7;
 static const int roleIdDriver =   6;

 static const Locale englishUS = Locale("en", "US");
 static const Locale spanishES = Locale("es", "ES");
 static const Locale portuguesePT = Locale("pt", "PT");

 static const String SosCall = "Call";
 static const String SosEmail = "Email";

 static  String noInternetMessage = "No Internet! Please Check Your Internet And Try Again".tr;

 static  String otpSentMessage = "OTP sent successfully to your number, please check your register number".tr;

 static  String authError = "Authorization Error!".tr;


// static  String imagePathBaseUrl = "http://192.168.1.8:2018/";

 // Image Constant
static String tempUserIcon = "temp_user_icon.png";

static int polylineWidth = 5 ;

// Route Status
static var updateRouteStatusReadyToGo = 1 ;
 static var updateRouteStatusStart = 2 ;
 static var updateRouteStatusCompletedTrip = 3 ;


// Socket Connection
 static  String signalRBaseUrl = "http://192.168.1.8:2018/";
 static  String MapApiKey = "AIzaSyAcKacVPrecvkVNJXcIIz2RQHnhFsM1KYk";

}