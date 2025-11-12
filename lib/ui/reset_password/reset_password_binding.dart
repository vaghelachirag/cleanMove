
import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/reset_password/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }

}