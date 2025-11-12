
import 'package:get/get.dart';

import 'driver_report_controller.dart';

class DriverReportBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<DriverReportController>(() => DriverReportController());
  }

}