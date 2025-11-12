import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/ui/driver_screens/trip/trip_controller.dart';

import '../../../utils/appConstant.dart';
import '../../../utils/location_manager.dart';
import '../../passenger/home/home_map/map_controller.dart';


class TripBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => MapController());
    Get.lazyPut(() => LocationManager());
    Get.lazyPut<TripController>(() => TripController(getStorage:  GetStorage(AppConstant.storageName)));
  }
}