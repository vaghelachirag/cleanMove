import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(getStorage: GetStorage(AppConstant.storageName)));
  }

}