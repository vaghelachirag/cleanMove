import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/ui/common/forgot_password/forgot_password_controller.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';

class ForgotPasswordBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }

}