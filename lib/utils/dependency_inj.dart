import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/services/place_provider.dart';

import '../services/api/api_service.dart';
import '../ui/common/language/language_controller.dart';

Future init() async {
  await FlutterConfig.loadEnvVariables();
  await GetStorage.init("CleanMove");
  Get.put(ApiService(getStorage: GetStorage("CleanMove")));
  Get.put(PlaceApiProvider());
  Get.put(LanguageController(getStorage: GetStorage("CleanMove")));
}