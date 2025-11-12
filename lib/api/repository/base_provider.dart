import 'package:get/get.dart';

import '../../services/api/api_service.dart';

class BaseProvider {
  var apiService = Get.find<ApiService>();
}