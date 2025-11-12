import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/widget/notification_widget.dart';

import '../../../widget/common_widget.dart';


class SplashController extends GetxController {


  // For Store Data
  GetStorage getStorage;

  SplashController({required this.getStorage});

  var keepMeLogin = false;
  @override
  void onInit() {
    super.onInit();
    keepMeLogin = getStorage.read(AppConstant.keepMeLogin) ?? false;
    Future.delayed(const Duration(seconds: 4), () {
      if(!keepMeLogin){
        Get.offAndToNamed(Routes.login);
      }
      else{
        redirectToScreen();
      }
    });
//    NotificationFromFirebase().notificationInitialisation();
  }

  // Redirect To Screen
  void redirectToScreen() {
    var roleId =  getStorage.read(AppConstant.userRole) ?? false;
    redirectToHome(roleId);
  }
}
