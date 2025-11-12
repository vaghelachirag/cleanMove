import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/driver_screens/vehicleDetail/vehicledetail_controller.dart';


class VehicleDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VehicleController>(() => VehicleController());
  }

}