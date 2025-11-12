import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/ui/common/image/uploadimagecontroller.dart';
import 'package:shaligram_transport_app/ui/passenger/new_address/new_address_controller.dart';

import '../../../provider/getChangeAddress_provider.dart';
import '../../../utils/appConstant.dart';

class NewAddressBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<NewAddressController>(() => NewAddressController(getStorage:  GetStorage(AppConstant.storageName)));
    Get.lazyPut<UploadImageController>(() => UploadImageController());
    Get.lazyPut<GetChangeAddressProvider>(() => GetChangeAddressProvider(getStorage:  GetStorage(AppConstant.storageName)));
  }

}