import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/provider/login_provider.dart';
import 'package:shaligram_transport_app/ui/common/login/login_contoller.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/internetChecker.dart';

class LoginBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(getStorage:  GetStorage(AppConstant.storageName)));
    Get.lazyPut<InternetChecker>(() => InternetChecker());
    Get.lazyPut<LoginProvider>(() => LoginProvider());

  }

}