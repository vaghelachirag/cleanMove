import 'package:get/get.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

class InternetChecker extends GetxController{
  RxBool is_InternetConnected = false.obs;

  // For Internet Connection
  Future<bool> isConnectedToInternet() async {
    is_InternetConnected.value = await SimpleConnectionChecker.isConnectedToInternet();
    return is_InternetConnected.value;
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isConnectedToInternet();
  }
}

