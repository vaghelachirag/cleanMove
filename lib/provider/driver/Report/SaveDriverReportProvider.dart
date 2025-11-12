import '../../../api/repository/base_provider.dart';
import 'dart:convert';
import '../../../api/repository/api_end_points.dart';
import '../../../models/api_status.dart';
import '../../../models/driver/report/GetSaveDriverReport.dart';
import '../../../models/driver/report/SetSaveDriverReport.dart';
import '../../../widget/common_widget.dart';

class  SaveDriverReportProvider extends BaseProvider {


// Get Driver Report List
  Future<Result<GetSaveDriverReport>> getSaveDriverReportResponse(GetSaveDriverReportResponse getSaveDriverReportResponse) async {
    try {
      var handleRes =  await apiService.post(ApiEndPoints.saveDriverReportList , getSaveDriverReportResponse.toJson());
      handleRes = errorHandler(handleRes);
      if (handleRes.statusCode == 200) {
        if (handleRes.body != null) {
          if(handleRes.body["Success"] == true){
            final result = json.decode(json.encode(handleRes.body));
            var userModel =   GetSaveDriverReport.fromJson(result);
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