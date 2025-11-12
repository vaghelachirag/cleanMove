import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/driver_screens/scan_qr/scan_qr_contoller.dart';

class ScanQRBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<ScanQRController>(() => ScanQRController());
  }

}