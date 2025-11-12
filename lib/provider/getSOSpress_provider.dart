import 'dart:convert';
import 'package:shaligram_transport_app/models/passenger/sos/GetSosresponse.dart';
import 'package:shaligram_transport_app/models/passenger/sos/SOSRequestModel.dart';

import '../api/repository/api_end_points.dart';
import '../api/repository/base_provider.dart';
import '../models/api_status.dart';
import '../widget/common_widget.dart';


class  GetSoSProvider extends BaseProvider {

  // Get SOS Response
  Future<Result<GetSosResponse>> getSoSResponse(SetSosResponse sosrequestmodel) async {

    try {
      var handleRes =  await apiService.post(ApiEndPoints.getSosDetail,sosrequestmodel.toJson());
      handleRes = errorHandler(handleRes);
      if (handleRes.statusCode == 200) {
        if (handleRes.body != null) {
          if(handleRes.body["Data"] != null){
            final result = json.decode(json.encode(handleRes.body));
            var sosModel =   GetSosResponse.fromJson(result);
            return Success(data: sosModel);
          }else{
            return Failure(message: "SOS Sent Successfully!");
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
