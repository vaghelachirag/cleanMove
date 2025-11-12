
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/models/login/GetChangePasswordResponse.dart';
import 'package:shaligram_transport_app/models/request/ChangePasswordRequestModel.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';

import '../../../models/api_status.dart';
import '../../../provider/login_provider.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/internetChecker.dart';
import '../../../widget/common_widget.dart';

class CreatePasswordController extends GetxController {
  TextEditingController oldPasswordTextController = TextEditingController();
  TextEditingController newPasswordTextController = TextEditingController();
  TextEditingController confirmNewPasswordTextController = TextEditingController();

  RxBool isShowNewPassword = RxBool(false);
  RxBool isShowConfirmNewPassword = RxBool(false);
  RxBool isLoading = RxBool(false);
  RxBool isShowOldPassword = RxBool(false);


  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());

  final LoginProvider _loginProvider = Get.find<LoginProvider>();


  void requestToResetPassword() {
    isLoading.value = true;
    var oldPassword =   oldPasswordTextController.text.toString();
    var newPassword =   newPasswordTextController.text.toString();
    var confirmPassword = confirmNewPasswordTextController.text.toString();

    var changePasswordRequestModel = ChangePasswordRequestModel(oldPassword: oldPassword,confirmNewPassword: confirmPassword,newPassword: newPassword).obs;
   // startLoading();

    if(controller.is_InternetConnected.value){

      changePasswordRequestModel.value.oldPassword = oldPassword;
      changePasswordRequestModel.value.confirmNewPassword = confirmPassword;
      changePasswordRequestModel.value.newPassword = newPassword;

      // startLoading();
      _loginProvider.getChangePasswordResponse(changePasswordRequestModel.value).then((value) => {
        isLoading.value = false,
       // stopLoading(),
        if (value is Success<GetChangePasswordResponse>) {
         // stopLoading(),
          isLoading.value = false,
          showSnakeBar(buildContext, value.data.message),
          if(value.data.success){
            Get.offAllNamed(Routes.login)
          }
        } else if (value is Failure<GetChangePasswordResponse>) {
          isLoading.value = false,
        //  stopLoading(),
          checkAuthError(value.message)
        }
      }).onError((error, stackTrace) => {
        isLoading.value = false,
      //  stopLoading(),
      });
    }
    else{
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  void requestToResetPassword1() {
    Get.offAndToNamed(Routes.home);
  }


}
