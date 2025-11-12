
import 'package:get/get.dart';

import '../../../models/driver/trip/passengerlist/GetRoutePassengerListDetail.dart';


class TotalPassengersController extends GetxController {

  // List for Passenger
  List<GetRoutePassengerListDetail> listPassenger = [];

  @override
  void onInit() {
    super.onInit();
    listPassenger = Get.arguments;
    if(listPassenger != null){
    }
  }

  void getTotalPassenger() {

  }
}
