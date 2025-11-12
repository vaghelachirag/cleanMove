
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/appConstant.dart';
import 'profile_controller.dart';

class ProfileBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(getStorage: GetStorage(AppConstant.storageName)));
  }
}