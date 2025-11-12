
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/models/login/GetChangePasswordResponse.dart';
import 'package:shaligram_transport_app/models/request/ChangePasswordRequestModel.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';

import '../../../models/api_status.dart';
import '../../../provider/login_provider.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/internetChecker.dart';
import '../../../widget/common_widget.dart';

class ChangePasswordController extends GetxController {

  TextEditingController oldPasswordTextController = TextEditingController();
  TextEditingController newPasswordTextController = TextEditingController();
  TextEditingController confirmNewPasswordTextController = TextEditingController();

  RxBool isShowOldPassword = RxBool(false);
  RxBool isShowNewPassword = RxBool(false);
  RxBool isShowConfirmNewPassword = RxBool(false);
  RxBool isLoading = RxBool(false);



  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());

  final LoginProvider _loginProvider = Get.find<LoginProvider>();


  void requestToResetPassword() {

    var oldPassword =   oldPasswordTextController.text.toString();
    var newPassword =   newPasswordTextController.text.toString();
    var confirmPassword = confirmNewPasswordTextController.text.toString();


    if(oldPassword.isEmpty){
      showSnakeBar(buildContext, "Please Enter Your Old Password!");
    }else if(newPassword.isEmpty){
      showSnakeBar(buildContext, "Please Enter Your New Password!");
    }
    else if(newPassword.length < 4){
      showSnakeBar(buildContext, "Password length must be greater than 4 characters ");
    }
    else if(confirmPassword.isEmpty){
      showSnakeBar(buildContext, "Please Enter Confirm Your New Password!");
    }
    else if(newPassword != confirmPassword){
      showSnakeBar(buildContext, "Your password doesn't match!");
    }
    else{
    var changePasswordRequestModel = ChangePasswordRequestModel(oldPassword: oldPassword,confirmNewPassword: confirmPassword,newPassword: newPassword).obs;
   // startLoading();

    if(controller.is_InternetConnected.value){
      isLoading.value = true;
      changePasswordRequestModel.value.oldPassword = oldPassword;
      changePasswordRequestModel.value.confirmNewPassword = confirmPassword;
      changePasswordRequestModel.value.newPassword = newPassword;

     //  startLoading();
      _loginProvider.getChangePasswordResponse(changePasswordRequestModel.value).then((value) => {
        isLoading.value = false,
        //stopLoading(),
        if (value is Success<GetChangePasswordResponse>) {
        //  stopLoading(),
          isLoading.value = false,
          showSnakeBar(buildContext, value.data.message),
          if(value.data.success){
            Get.offAllNamed(Routes.login)
          }
        } else if (value is Failure<GetChangePasswordResponse>) {
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

  void requestToResetPassword1() {
    Get.offAndToNamed(Routes.home);
  }


}
