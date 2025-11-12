import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/ui/passenger/home/home_map/map_controller.dart';

import '../../../utils/appConstant.dart';
import '../../../utils/location_manager.dart';
import 'passenger_home_controller.dart';
import 'home_map/home_map_view_controller.dart';
import 'notification/notification_view_controller.dart';
import 'profile/profile_view_controller.dart';
import 'settings/settings_view_controller.dart';

class PassengerHomeBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => MapController());
    Get.lazyPut(() => LocationManager());
    Get.lazyPut(() => HomeMapViewController(getStorage: GetStorage(AppConstant.storageName)));
    Get.lazyPut(() => NotificationViewController(getStorage: GetStorage(AppConstant.storageName)));
    Get.lazyPut(() => ProfileViewController(getStorage: GetStorage(AppConstant.storageName)));
    Get.lazyPut(() => SettingViewController(getStorage: GetStorage(AppConstant.storageName)));
    Get.lazyPut(() => PassengerHomeController());
  }
}