import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';

import '../../../../models/api_status.dart';
import '../../../../models/passenger/GetPassegnerDetailResponse.dart';
import '../../../../provider/getpassengerdetail_provider.dart';
import '../../../../utils/appConstant.dart';
import '../../../../utils/internetChecker.dart';

class ProfileViewController extends GetxController {

  ProfileViewController({required this.getStorage});

  RxBool isLoading = RxBool(false);
  RxString firstName = RxString("");
  RxString lastName = RxString("");
  RxString address = RxString("");
  RxString currentAddress = RxString("");

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());

  final GetPassengerDetailProvider _passengerDetailProvider = Get.find<GetPassengerDetailProvider>();



  // For Store Data
  GetStorage getStorage;

  // For UserName
  var userName =  RxString("");
  var userId =  RxString("");

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setUserName();
  }


  void requestToChangeAddress() {
    isLoading.value = true;
     Get.toNamed(Routes.passengerNewAddress);
   }

  void getPassengerDetail(){
    if(controller.is_InternetConnected.value){
      // startLoading();
      _passengerDetailProvider.getPassengerDetail().then((value) => {
        isLoading.value = false,
      //  stopLoading(),
        if (value is Success<GetPassengerDetailResponse>) {
          isLoading.value = false,
          setPassengerDetail(value)
        } else if (value is Failure<GetPassengerDetailResponse>) {
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

  setPassengerDetail(Success<GetPassengerDetailResponse> value) {
       if(value !=null){
         firstName.value = value.data.data.firstName!!;
         lastName.value = value.data.data.lastName!!;
         address.value = value.data.data.street!!;
       }
  }

  void setUserName() {
    userName.value = getStorage!.read(AppConstant.profileName);
  }
}