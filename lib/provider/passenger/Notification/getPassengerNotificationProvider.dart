import 'dart:convert';
import 'package:shaligram_transport_app/models/passenger/notification/getPassengerNotificationDetail.dart';
import 'package:shaligram_transport_app/models/passenger/notification/getPassengerNotificationResponse.dart';
import '../../../api/repository/api_end_points.dart';
import '../../../api/repository/base_provider.dart';
import '../../../widget/common_widget.dart';

class  GetPassengerNotificationProvider extends BaseProvider {
  Future<List<NotificationList>?> getPassengerNotification(String passengerId) async {
    var handleRes =  await apiService.get("${ApiEndPoints.getPassengerNotification}?passengerId=$passengerId");
    handleRes = errorHandler(handleRes);
    try {
      if (handleRes.statusCode == 200) {
         final result = json.decode(json.encode(handleRes.body));
         var userModel =   GetPassengerNotificationResponse.fromJson(result);
        return userModel.data;
      } else {
        print('${handleRes.statusCode} : ${handleRes.body.toString()}');
      }
    } catch (error) {
      print(error);
    }
  }
}