import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shaligram_transport_app/models/api_status.dart';
import 'package:shaligram_transport_app/models/login/resetPasswordRequestModal.dart';
import 'package:shaligram_transport_app/models/login/resetPasswordResponseModal.dart';
import 'package:shaligram_transport_app/provider/login_provider.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/internetChecker.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';

import '../common/login/login_contoller.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController newPasswordTextController = TextEditingController();
  TextEditingController resetpasswordTokenController = TextEditingController();
  final InternetChecker controller = Get.put(InternetChecker());
  final LoginProvider _loginProvider = Get.find<LoginProvider>();
  RxBool isLoading = false.obs;
  String email = "";

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<LoginController>()) {
      email = Get.find<LoginController>().emailTextController.text;
      emailTextController.text = email;
    }
  }


  void requestToResetPassword() {


    var newPassword =   newPasswordTextController.text.toString();


    if(emailTextController.text.isEmpty){
      showSnakeBar(buildContext, "Please Enter Email");
    }else if(newPassword.isEmpty){
      showSnakeBar(buildContext, "Please Enter Your New Password!");
    }
    else{


      var resetPasswordModal = ResetPasswordRequestModal(email: emailTextController.text , password: newPassword , resetPasswordToken: "oRRuoFBDriurJHRZTWitLMNZZXpil5dg").obs;
      // startLoading();

      if(controller.is_InternetConnected.value){
        isLoading.value = true;
        //  startLoading();
        _loginProvider.resetPassword(resetPasswordModal.value).then((value) => {
          isLoading.value = false,
          //stopLoading(),
          if (value is Success<ResetPasswordResponseModal>) {
            //  stopLoading(),
            isLoading.value = false,
            showSnakeBar(buildContext, value.data.message),
            if(value.data.success){
              Get.offAllNamed(Routes.login)
            }
          } else if (value is Failure<ResetPasswordResponseModal>) {
            //  stopLoading(),
            isLoading.value = false,
            checkAuthError(value.message)
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
}