
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/models/login/GetLoginResponse.dart';
import 'package:shaligram_transport_app/models/login/deviceInfoRequestModel.dart';
import 'package:shaligram_transport_app/models/login/deviceInfoResponseModal.dart';
import 'package:shaligram_transport_app/models/login/updateFcmTokenRequestModal.dart';
import 'package:shaligram_transport_app/models/login/updateFcmTokenResponseModal.dart';
import 'package:shaligram_transport_app/provider/login_provider.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/internetChecker.dart';
import 'package:shaligram_transport_app/utils/validation.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';
import '../../../models/api_status.dart';
import '../../../provider/common/AddFCMTokenProvider.dart';
import '../../../widget/notification_widget.dart';

class LoginController extends GetxController {

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  RxBool isRememberMe = RxBool(false);
  RxBool isShowPassword = RxBool(false);
  RxBool isLoading = RxBool(false);
  RxString fcmToken = RxString("");
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());

  final LoginProvider _loginProvider = Get.find<LoginProvider>();
  final AddFCMTokenProvider _addFCMTokenProvider = Get.find<AddFCMTokenProvider>();
  GetLoginData? getLoginData;

  // For Store Data
  GetStorage getStorage;

  LoginController({required this.getStorage});
  var email = "", password = "" ;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setUserNameAndPassword();
    getToken();
    getDeviceInfo();
    //NotificationFromFirebase().notificationInitialisation();
  }
  void requestToForgotPassword() {
    if(emailTextController.value.text.trim().isEmpty){
      showSnakeBar(Get.context! , "Please Enter EmailId");
    }else if(Validation.validateEmail(emailTextController.value.text) != null){
      showSnakeBar(Get.context! , "Please Enter Valid EmailId");
    }
    else {
      Get.toNamed(Routes.forgotPassword);
    }
  }

  void changeRememberMe(bool? value){

    email = emailTextController.text.toString();
    password = passwordTextController.text.toString();

    if (value != null) isRememberMe.value = value;
     getStorage.write(AppConstant.rememberMe,  isRememberMe.value);
    if(value == true){
      getStorage.write(AppConstant.username, email);
      getStorage.write(AppConstant.password, password);
    }
    else{
      getStorage.remove(AppConstant.username);
      getStorage.remove(AppConstant.password);
    }
    setUserNameAndPassword();
  }

  void setUserNameAndPassword(){
   var  rememberMe = getStorage.read(AppConstant.rememberMe) ?? false;
   if(rememberMe == true){
     emailTextController.text =   getStorage.read(AppConstant.username);
     passwordTextController.text =  getStorage.read(AppConstant.password);
     isRememberMe.value = true;
   }
  }
  Future<void> requestToCreatePassword() async {

    email = emailTextController.text.trim().toString();
    password = passwordTextController.text.trim().toString();

    if(email.isEmpty){
      showSnakeBar(buildContext, "Please Enter Your Email!");
    }else if(Validation.validateEmail(emailTextController.value.text) != null){
      showSnakeBar(Get.context! , "Please Enter Valid EmailId");
    }else if(password.isEmpty){
      showSnakeBar(buildContext, "Please Enter Your Password!");
    }else{
      isLoading.value = true;
      //startLoading();
      if(controller.is_InternetConnected.value){
       // startLoading();
      await  _loginProvider.validateLogin(email, password).then((value) => {
          isLoading.value = false,
        //  stopLoading(),
          if (value is Success<GetLoginResponse>) {
            isLoading.value = false,
          //  stopLoading(),
           // registerDeviceToken(value),
           // stopLoading(),
            showSnakeBar(buildContext, "Login Successfully!"),
            getLoginData = value.data.data,
            saveUserData(value),

            redirectToLogin(value.data.data.roleId,email,password),
            if(fcmToken.value.isNotEmpty){

              saveMobileDeviceInfo(),
              updateFcmToken(),
            }
          } else if (value is Failure<GetLoginResponse>) {

            isLoading.value = false,
        //   stopLoading(),
            showSnakeBar(Get.context!,value.message)
          }
        }).onError((error, stackTrace) async => {
        isLoading.value = false,
        // stopLoading()
            });
      }
      else{
        showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
      }
    }
  }

  redirectToLogin(int roleId, String email, String password) {
    if(roleId != null){
      //  Write storage Data
      getStorage.write(AppConstant.keepMeLogin, true);
      getStorage.write(AppConstant.userRole, roleId);

      if(getStorage.read(AppConstant.rememberMe) == true){
        getStorage.write(AppConstant.username, email);
        getStorage.write(AppConstant.password, password);
      }else{
        getStorage.remove(AppConstant.username);
        getStorage.remove(AppConstant.password);
      }

      // Redirect  To Home
     redirectToHome(roleId);
   //   Get.toNamed(Routes.driverReport);
    }
  }

  // Save Login Data
  saveUserData(Success<GetLoginResponse> value) {
    getStorage.write(AppConstant.authToken,value.data.data.token);
    getStorage.write(AppConstant.userId,value.data.data.commonId.toString());
    getStorage.write("logOutuserId",value.data.data.userId.toString());
    getStorage.write(AppConstant.profileName,value.data.data.userName.toString());
    getStorage.write(AppConstant.email,value.data.data.email.toString());
  }

  getToken() async {
    fcmToken.value = (await NotificationFromFirebase().firebaseMessaging.getToken())!;
  }



  Future<void> saveMobileDeviceInfo() async {
    if(controller.is_InternetConnected.value) {
      if (getLoginData != null && androidInfo != null || iosInfo != null) {

        SaveDeviceInfoRequestModal saveDeviceInfoRequestModal = SaveDeviceInfoRequestModal(
            userId: getLoginData?.userId,
            userName: getLoginData?.userName,
            appVersion: "",
            email: email,
            lastName: getLoginData?.lastName,
            firstName: getLoginData?.firstName,
            companyId: getLoginData?.companyId,
            deviceId: Platform.isAndroid ? androidInfo?.id : iosInfo?.identifierForVendor,
            deviceModel: Platform.isAndroid ? androidInfo?.model : iosInfo?.model,
            deviceOs:Platform.isAndroid ? androidInfo?.hardware : androidInfo?.hardware,
            deviceType:Platform.isAndroid ? "Android": "Ios",
            fcmToken: fcmToken.value,
            industryId: 1,
            preferredLanguage: "",
            roleId: getLoginData?.roleId,
            token: ""
        );


      await  _loginProvider.saveMobileDeviceDetails(saveDeviceInfoRequestModal)
            .then((value) =>
        {

          if (value is Success<SaveDeviceInfoResponseModal>) {
            // stopLoading(),

            showSnakeBar(buildContext, "SuccessFully Save"),
          } else
            if (value is Failure<SaveDeviceInfoResponseModal>) {
              showSnakeBar(buildContext, value.message)
            }
        }).onError((error, stackTrace) =>
        {
          showSnakeBar(buildContext, "Error to SuccessFully Save"),
        });
      }

      else {
        showSnakeBar(
            Get.context as BuildContext, AppConstant.noInternetMessage);
      }
    }
  }

  Future<void> updateFcmToken() async {
    if(controller.is_InternetConnected.value) {
      if (getLoginData != null && androidInfo != null || iosInfo != null) {

        UpdateFcmTokenRequestModal updateFcmTokenRequestModal = UpdateFcmTokenRequestModal(
            userId: getLoginData?.userId,
            userName: getLoginData?.userName,
            appVersion: "",
            email: email,
            lastName: getLoginData?.lastName,
            firstName: getLoginData?.firstName,
            companyId: getLoginData?.companyId,
            deviceId: Platform.isAndroid ? androidInfo?.id : iosInfo?.identifierForVendor,
            deviceModel: Platform.isAndroid ? androidInfo?.model : iosInfo?.model,
            deviceOs:Platform.isAndroid ? androidInfo?.hardware : androidInfo?.hardware,
            deviceType:Platform.isAndroid ? "Android": "Ios",
            fcmToken: fcmToken.value,
            industryId: 1,
            preferredLanguage: "",
            roleId: getLoginData?.roleId,
            token: ""
        );


        await  _loginProvider.updateFcmToken(updateFcmTokenRequestModal)
            .then((value) =>
        {

          if (value is Success<UpdateFcmTokenResponseModal>) {
            // stopLoading(),

            showSnakeBar(buildContext, "SuccessFully Update"),
          } else
            if (value is Failure<UpdateFcmTokenResponseModal>) {
              showSnakeBar(buildContext, value.message)
            }
        }).onError((error, stackTrace) =>
        {
          showSnakeBar(buildContext, "Error to SuccessFully Save"),
        });
      }

      else {
        showSnakeBar(
            Get.context as BuildContext, AppConstant.noInternetMessage);
      }
    }
  }

  getDeviceInfo() async {
    if(Platform.isAndroid) {
      androidInfo = await deviceInfo.androidInfo;

    }else {
      iosInfo = await deviceInfo.iosInfo;
    }
  }





}
