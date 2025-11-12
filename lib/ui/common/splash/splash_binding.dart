import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/ui/common/splash/splash_controller.dart';

import '../../../utils/appConstant.dart';

class SplashBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(getStorage:  GetStorage(AppConstant.storageName)));
  }
}