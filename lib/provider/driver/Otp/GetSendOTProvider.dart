
import 'dart:convert';

import 'package:shaligram_transport_app/models/driver/otp/GetSendOTPResponse.dart';
import '../../../api/repository/api_end_points.dart';
import '../../../api/repository/base_provider.dart';
import '../../../models/api_status.dart';

import '../../../widget/common_widget.dart';

class  GetSendOTPProvider extends BaseProvider {

  // Get Send OTP Response
  Future<Result<GetSendOTPResponse>> getSendOTPResponse(String phoneNumber) async {

    try {
      var handleRes =  await apiService.post("${ApiEndPoints.sendOTP}?phoneNumber=$phoneNumber", null);
      handleRes = errorHandler(handleRes);
      if (handleRes.statusCode == 200) {
        if (handleRes.body != null) {
          if(handleRes.body["Data"] != null){
            final result = json.decode(json.encode(handleRes.body));
            var userModel =   GetSendOTPResponse.fromJson(result);
            return Success(data: userModel);
          }else{
            return Failure(message: "Invalid credentials. Please try again");
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