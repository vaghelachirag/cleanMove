import 'dart:convert';
import 'package:shaligram_transport_app/models/driver/trip/route/GetUpdateRouteStatusResponse.dart';
import '../../../api/repository/api_end_points.dart';
import '../../../api/repository/base_provider.dart';
import '../../../models/api_status.dart';
import '../../../widget/common_widget.dart';

class  GetUpdateRouteStatusProvider extends BaseProvider {

// Get Update Route Status
  Future<Result<GetUpdateRouteStatusResponse>> getUpdateRouteStatus(String routeId,int tripStatus) async {

    try {
      var handleRes =  await apiService.post("${ApiEndPoints.getUpdateRouteStatus}?routeId=$routeId&tripStatusId=$tripStatus", null);
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