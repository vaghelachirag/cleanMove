import 'dart:convert';

import 'package:shaligram_transport_app/models/passenger/route/GetPassengerRouteDetailResponse.dart';

import '../../api/repository/api_end_points.dart';
import '../../api/repository/base_provider.dart';
import '../../models/api_status.dart';
import '../../widget/common_widget.dart';

class  GetPassengerRouteDetailProvider extends BaseProvider {

  // Get Passenger Route Detail API
  Future<Result<GetPassengerRouteDetailResponse>> getPassengerRouteDetailResponse(String passangerId) async {

    try {
      var handleRes =  await apiService.get("${ApiEndPoints.getPassengerRouteDetail}?passangerId=$passangerId");
      handleRes = errorHandler(handleRes);
      if (handleRes.statusCode == 200) {
        if (handleRes.body != null) {
          if(handleRes.body["Data"] != null){
            final result = json.decode(json.encode(handleRes.body));
            var userModel =   GetPassengerRouteDetailResponse.fromJson(result);
            return Success(data: userModel);
          }else{
            return Failure(message: "No Data Found!");
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