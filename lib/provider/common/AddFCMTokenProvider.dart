import 'dart:convert';
import 'package:shaligram_transport_app/models/common/fcm/SetAddFCMTokenModel.dart';
import 'package:shaligram_transport_app/models/common/logout/GetLogoutResponse.dart';
import '../../../api/repository/api_end_points.dart';
import '../../../api/repository/base_provider.dart';
import '../../../models/api_status.dart';

import '../../../widget/common_widget.dart';
import '../../models/driver/trip/route/GetUpdateRouteStatusResponse.dart';

class  AddFCMTokenProvider extends BaseProvider {

  // Get Logout Response
  Future<Result<GetUpdateRouteStatusResponse>> getAddFCMTokenResponse(SetAddFcmTokenModel setAddFcmTokenModel) async {

    try {
      var handleRes =  await apiService.post(ApiEndPoints.saveFCMToken, setAddFcmTokenModel.toJson());
      handleRes = errorHandler(handleRes);
      if (handleRes.statusCode == 200) {
        if (handleRes.body != null) {
          if(handleRes.body["Success"]  == true){
            final result = json.decode(json.encode(handleRes.body));
            var userModel =   GetUpdateRouteStatusResponse.fromJson(result);
            return Success(data: userModel);
          }else{
            return Failure(message: handleRes.body["Message"]);
          }
        } else {
          return Failure(message: "Invalid credentials. Please try again");
        }
      } else {
        var error = json.decode(handleRes.bodyString.toString());
        return Failure(message: error['message']);
      }
    } catch (e) {
      return Failure(message: e.toString());
    }
  }
}