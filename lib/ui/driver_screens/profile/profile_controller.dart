import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/models/common/logout/GetLogoutResponse.dart';
import 'package:shaligram_transport_app/provider/driver/GetDriverDetailProvider.dart';
import 'package:shaligram_transport_app/ui/common/language/language_controller.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';

import '../../../models/api_status.dart';
import '../../../models/driver/profile/GetDriverDetailResponse.dart';
import '../../../models/setProfileData.dart';
import '../../../provider/common/GetLogoutProvider.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/internetChecker.dart';
import '../../../widget/common_widget.dart';

class ProfileController extends GetxController {


  ProfileController({required this.getStorage});

  RxBool isLoading = RxBool(false);
  RxBool isProfileLoad = RxBool(true);
  LanguageController languageController =  Get.find<LanguageController>();

  RxString  firstName = RxString("");
  RxString  lastName = RxString("");
  RxString  address = RxString("");


  RxList<SetProfileData> listProfileData = RxList([
    SetProfileData("icon_privacy.png", "changePassword".tr, null),
    SetProfileData("translation.png", "language".tr, ""),
    SetProfileData("icon_logout.png", "log_out".tr, null)
  ]);

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());

  final GetDriverDetailProvider _getDriverDetailProvider = Get.find<GetDriverDetailProvider>();
  final GetLogoutProvider _getLogoutProvider = Get.find<GetLogoutProvider>();

  // For UserName
  var userName =  RxString("");
  var userId =  RxString("");

  // For Store Data
  GetStorage getStorage;



  @override
  void onInit() {
    super.onInit();
    updateLanguage();
    //getProfileDetail();
    setUserName();
  }

  void requestToChangeLanguage() {
    Get.context?.showSelectAndChangeLanguageDialog().then((value) {
      if (value == true) {
        updateLanguage();
      }
    });
  }

  void updateLanguage() {
    var data = listProfileData[1];
    data.languageData = "${languageController.locale.countryCode?.flagEmoji}${languageController.locale.languageCode.toUpperCase()}";
    listProfileData[1] = data;
    listProfileData.refresh();
  }

  void requestToLogout(){
  //  Get.toNamed(Routes.login);
    if(controller.is_InternetConnected.value){
    //  startLoading();
      isLoading.value = true;
      _getLogoutProvider.getLogoutResponse(userId.value, AppConstant.roleIdDriver.toString()).then((value) => {
        isLoading.value = false,
       // stopLoading(),
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
      //  stopLoading(),
      });
    }
    else{
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }
  void getProfileDetail(){
    if(controller.is_InternetConnected.value){
      // startLoading();
      isProfileLoad.value = true;
      _getDriverDetailProvider.getDriverDetailResponse().then((value) => {
        isProfileLoad.value = false,
      //  stopLoading(),
        if (value is Success<GetDriverDetailResponse>) {
          isProfileLoad.value = false,
          setDriverDetail(value)
        } else if (value is Failure<GetDriverDetailResponse>) {
          isProfileLoad.value = false,
          checkAuthError(value.message),
          showSnakeBar(buildContext,value.message)
        }
      }).onError((error, stackTrace) => {
        isProfileLoad.value = false,
     //   stopLoading(),
      });
    }
    else{
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  setDriverDetail(Success<GetDriverDetailResponse> value) {
    if(value !=null && value.data.data!.isNotEmpty){
      firstName.value = value.data.data![0].firstName!;
      lastName.value = value.data.data![0].lastName!;
      address.value = value.data.data![0].street!;
    }
  }

  redirectToChangePassword(){
    Get.toNamed(Routes.changePassword);
  }

  void setUserName() {
    userName.value = getStorage!.read(AppConstant.profileName);
   // userId.value = getStorage!.read(AppConstant.userId);
    userId.value = getStorage!.read("logOutuserId");
  }
}
