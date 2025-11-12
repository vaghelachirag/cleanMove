import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/driver_screens/total_passengers/total_passengers_controller.dart';

class TotalPassengersBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<TotalPassengersController>(() => TotalPassengersController());
  }

}