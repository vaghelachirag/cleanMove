import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/models/setProfileData.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';

import '../../../../models/api_status.dart';
import '../../../../models/common/logout/GetLogoutResponse.dart';
import '../../../../provider/common/GetLogoutProvider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/appConstant.dart';
import '../../../../utils/internetChecker.dart';
import '../../../../widget/common_widget.dart';
import '../../../common/language/language_controller.dart';

class SettingViewController extends GetxController {

  SettingViewController({required this.getStorage});

  LanguageController languageController =  Get.find<LanguageController>();

  RxList<SetProfileData> listSettingData = RxList([
    SetProfileData("icon_privacy.png", "privacy".tr,  null),
    SetProfileData("icon_help.png", "help".tr,  null),
    SetProfileData("lock.png", "changePassword".tr, ""),
    SetProfileData("translation.png", "language".tr, ""),
    SetProfileData("icon_logout.png", "log_out".tr, null)
  ]);

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());
  final GetLogoutProvider _getLogoutProvider = Get.find<GetLogoutProvider>();



  // For UserName
  var userName =  RxString("");
  var userId =  RxString("");



  // For Store Data
  GetStorage getStorage;


  // For Loading
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    setUserName();
    updateLanguage();
  }

  void requestToChangeLanguage() {
    Get.context?.showSelectAndChangeLanguageDialog().then((value) {
      if (value == true) {
        updateLanguage();
      }
    });
  }

  void updateLanguage() {
    var data = listSettingData[3];
    data.languageData = "${languageController.locale.countryCode.toString().flagEmoji}${languageController.locale.languageCode.toUpperCase()}";
    listSettingData[3] = data;
    listSettingData.refresh();
  }

  void requestToLogout() {
    //  Get.toNamed(Routes.login);
    if(controller.is_InternetConnected.value){
   //   startLoading();
      isLoading.value = true;
      _getLogoutProvider.getLogoutResponse(userId.value, AppConstant.roleIdDriver.toString()).then((value) => {
        isLoading.value = false,
      //  stopLoading(),
        if (value is Success<GetLogoutResponse>) {
          isLoading.value = false,
          getStorage.remove(AppConstant.keepMeLogin),
          Get.offAllNamed(Routes.login)
        } else if (value is Failure<GetLogoutResponse>) {
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


  redirectToChangePassword(){
    Get.toNamed(Routes.changePassword);
  }



  void setUserName() {
    userName.value = getStorage.read(AppConstant.profileName);
    //userId.value = getStorage.read(AppConstant.userId);
    userId.value = getStorage!.read("logOutuserId");
  }
}