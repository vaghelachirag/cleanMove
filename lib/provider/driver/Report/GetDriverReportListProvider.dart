import 'dart:convert';
import 'package:shaligram_transport_app/models/driver/report/GetDriverReportResponse.dart';
import '../../../api/repository/api_end_points.dart';
import '../../../api/repository/base_provider.dart';
import '../../../models/api_status.dart';
import '../../../widget/common_widget.dart';

class  GetDriverReportListProvider extends BaseProvider {


// Get Driver Report List
  Future<Result<GetDriverReportMenuResponse>> getDriverReportList() async {

    try {
      var handleRes =  await apiService.get(ApiEndPoints.getDriverReportList);
      handleRes = errorHandler(handleRes);
      if (handleRes.statusCode == 200) {
        if (handleRes.body != null) {
          if(handleRes.body["Data"] != null){
            final result = json.decode(json.encode(handleRes.body));
            var userModel =   GetDriverReportMenuResponse.fromJson(result);
            return Success(data: userModel);
          }else{
            return Failure(message: "No Route Assign!");
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