
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/models/login/GetForgotPasswordResponse.dart';
import 'package:shaligram_transport_app/models/request/ForgotPasswordRequestModel.dart';
import 'package:shaligram_transport_app/ui/common/login/login_contoller.dart';

import '../../../models/api_status.dart';
import '../../../provider/login_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/internetChecker.dart';
import '../../../widget/common_widget.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailTextController = TextEditingController();

  RxBool isRememberMe = RxBool(false);
  RxBool isShowPassword = RxBool(false);
  RxBool isLoading = RxBool(false);
  String email = "";

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());


  final LoginProvider _loginProvider = Get.find<LoginProvider>();

  var forgotPasswordRequestModel = ForgotPasswordRequestModel(email: '').obs;
  GetStorage getStorage = GetStorage();
 

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Get.isRegistered<LoginController>()) {
      email = Get.find<LoginController>().emailTextController.text;

      emailTextController.text = email;
    }
  
  }

  void requestForgotPassword() {
   // startLoading();
    isLoading.value = true;
    if(controller.is_InternetConnected.value){
      if(emailTextController.text.isNotEmpty) {
        var email = emailTextController.text.toString();
        forgotPasswordRequestModel.value.email = email;
    //    startLoading();
        _loginProvider.getForgotPasswordResponse(
            forgotPasswordRequestModel.value).then((value) =>
        {
          isLoading.value = false,
         // stopLoading(),
          if (value is Success<GetForgotPasswordResponse>) {
           // stopLoading(),
            isLoading.value = false,
            showSnakeBar(buildContext, "Reset password Link Send SuccessFully"),
            if(value.data.success){
              isLoading.value = false,
              Get.offAllNamed(Routes.login)
            }
          } else if (value is Failure<GetForgotPasswordResponse>) {
            //  stopLoading(),
              print("failure"),
              isLoading.value = false,
              showSnakeBar(buildContext, value.message)
            }
        }).onError((error, stackTrace) =>
        {
        //  isLoading.value = false,
       //   stopLoading(),
        });
      }
      else{ isLoading.value = false;

      //  stopLoading();
        showSnakeBar(Get.context!, "Please Enter Email Address");
      }
    }
    else{
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  void redirectToLogin(){
    Get.offAllNamed(Routes.login);
  }

}
