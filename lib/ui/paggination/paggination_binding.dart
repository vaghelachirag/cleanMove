import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/paggination/paggination_controller.dart';

import '../../provider/paggination_provider.dart';

class PagginationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PagginationController>(() => PagginationController());
    Get.lazyPut<PaginationProvider>(() => PaginationProvider());
  }

}