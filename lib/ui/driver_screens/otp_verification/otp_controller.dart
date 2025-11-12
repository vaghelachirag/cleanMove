import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/provider/driver/Otp/GetVerifyOTPProvider.dart';

import '../../../models/api_status.dart';
import '../../../models/driver/otp/GetOTPverifyResponse.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/internetChecker.dart';
import '../../../widget/common_widget.dart';

class OtpController extends GetxController {


  // For Load Progress
  RxBool isLoading = RxBool(false);


  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();


  // OTP controller
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();

  var textOTP1 = "", textOTP2 = "",textOTP3 = "",textOTP4 = "",textOTP5 = "" ;

  Timer? timer;
  int _start = 60;
  RxString timerTime = RxString("") ;
  RxBool resendOTP = RxBool(false) ;
  RxString verificationId = RxString("") ;
  RxString vehicleId = RxString("") ;
  var phoneNumber =  RxString("");

  // Provider for API
  final GetVerifyOTPProvider _getVerifyOTPProvider = Get.find<GetVerifyOTPProvider>();

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments == true){
      verificationId.value = Get.parameters["verificationId"]!;
      phoneNumber.value = Get.parameters["phoneNumber"]!;
      phoneNumber.value = Get.parameters["phoneNumber"]!;
      vehicleId.value = Get.parameters["vehicleId"]!;
    }
    startTimer();
  }

  void startTimer(){
    resendOTP.value = false;
    _start = 60;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          resendOTP.value = true;
          timer.cancel();
        } else {
          _start--;
          if(_start < 10){
            timerTime.value =  " 00: "+ "0" + _start.toString();
          }else {
            timerTime.value = " 00: $_start";
          }
        }
      },
    );
  }
  void otpVerification() {
    textOTP1 = otp1.text.toString();
    textOTP2 = otp2.text.toString();
    textOTP3 = otp3.text.toString();
    textOTP4 = otp4.text.toString();
    textOTP5 = otp5.text.toString();

    if(textOTP1.isEmpty){
      showSnakeBar(buildContext, "Please Enter OTP!");
    }else if(textOTP2.isEmpty){
      showSnakeBar(buildContext, "Please Enter OTP!");
    }
    else if(textOTP2.isEmpty){
      showSnakeBar(buildContext, "Please Enter OTP!");
    }
    else if(textOTP3.isEmpty){
      showSnakeBar(buildContext, "Please Enter OTP!");
    }
    else if(textOTP4.isEmpty){
      showSnakeBar(buildContext, "Please Enter OTP!");
    }
    else if(textOTP5.isEmpty){
      showSnakeBar(buildContext, "Please Enter OTP!");
    }
    else {

      var otp = textOTP1 + textOTP2 + textOTP3 + textOTP4 + textOTP5 ;
     // startLoading();

      if(controller.is_InternetConnected.value){
        isLoading.value = true;
        _getVerifyOTPProvider.getOTPVerifyResponse(phoneNumber.value,otp,verificationId.value).then((value) => {
          isLoading.value = false,
          //stopLoading(),
          if (value is Success<GetVerifyOtpResponse>) {
          //  stopLoading(),
            isLoading.value = false,
            showSnakeBar(buildContext,"OTP Verify Successfully!"),
            redirectToStartTrip()
          } else if (value is Failure<GetVerifyOtpResponse>) {
            isLoading.value = false,
            checkAuthError(value.message),
            showSnakeBar(buildContext,value.message)
          }
        }).onError((error, stackTrace) => {
          isLoading.value = false,
         // stopLoading(),
        });
      }
      else{
        showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
      }
    }
    }

  redirectToStartTrip() {
    Get.toNamed(Routes.trip, parameters: {'driverId': "1",'phoneNumber': phoneNumber.value,'vehicleId': vehicleId.value},arguments: true);
  }
}
