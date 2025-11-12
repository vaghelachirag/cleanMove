
import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/driver_screens/otp_verification/otp_controller.dart';


class OtpVerificationBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<OtpController>(() => OtpController());
  }
}