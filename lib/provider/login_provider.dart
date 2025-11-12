import 'dart:convert';
import 'package:shaligram_transport_app/models/login/GetChangePasswordResponse.dart';
import 'package:shaligram_transport_app/models/login/GetForgotPasswordResponse.dart';
import 'package:shaligram_transport_app/models/login/deviceInfoRequestModel.dart';
import 'package:shaligram_transport_app/models/login/deviceInfoResponseModal.dart';
import 'package:shaligram_transport_app/models/login/resetPasswordRequestModal.dart';
import 'package:shaligram_transport_app/models/login/resetPasswordResponseModal.dart';
import 'package:shaligram_transport_app/models/login/updateFcmTokenRequestModal.dart';
import 'package:shaligram_transport_app/models/request/ChangePasswordRequestModel.dart';
import 'package:shaligram_transport_app/models/request/ForgotPasswordRequestModel.dart';
import '../api/repository/api_end_points.dart';
import '../api/repository/base_provider.dart';
import '../models/api_status.dart';
import '../models/login/GetLoginResponse.dart';
import '../models/login/updateFcmTokenResponseModal.dart';
import '../widget/common_widget.dart';

class  LoginProvider extends BaseProvider {

  // Get Login Response
  Future<Result<GetLoginResponse>> validateLogin(email,password) async {

    final loginParams = {
      'Username': email,
      'Password':password
    };

    try {
      var handleRes =  await apiService.post(ApiEndPoints.login, loginParams);
      if (handleRes.statusCode == 200) {
        if (handleRes.body != null) {
          if(handleRes.body["Data"] != null){
            final result = json.decode(json.encode(handleRes.body));
            var userModel =   GetLoginResponse.fromJson(result);

            return Success(data: userModel);
          }else{
            return Failure(message: "Invalid credentials. Please try again");
          }
        } else {
          return Failure(message: "Invalid credentials. Please try again");
        }
      } else {
        var error = json.decode(handleRes.bodyString.toString());
        return Failure(message: error.message ?? "");
      }
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  // Get Forgot Password Response
  Future<Result<GetForgotPasswordResponse>> getForgotPasswordResponse(ForgotPasswordRequestModel forgotPasswordRequestModel) async {
    try {
      var handleRes =  await apiService.post(ApiEndPoints.forgotPassword, forgotPasswordRequestModel.toJson());
      if (handleRes.statusCode == 200) {
        if (handleRes.body != null) {
          if(handleRes.body["Success"] == true) {
            final result = json.decode(json.encode(handleRes.body));
            var userModel = GetForgotPasswordResponse.fromJson(result);
            return Success(data: userModel);
          }else{
            return Failure(message: handleRes.body["Message"]);
          }
        } else {
          return Failure(message: "Invalid credential");
        }
      } else {
        var error = json.decode(handleRes.bodyString.toString());
        return Failure(message: error['message']);
      }
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  // Get Change Password Response
  Future<Result<GetChangePasswordResponse>> getChangePasswordResponse(ChangePasswordRequestModel changePasswordRequestModel) async {
    try {
      var response =  await apiService.post(ApiEndPoints.changePassword, changePasswordRequestModel.toJson());
       response = errorHandler(response);
      if (response.statusCode == 200) {
        if (response.body != null) {
          final result = json.decode(json.encode(response.body));
          var userModel =   GetChangePasswordResponse.fromJson(result);
          return Success(data: userModel);
        } else {
          return Failure(message: "Invalid credential");
        }
      } else {
        var error = json.decode(response.bodyString.toString());
        return Failure(message: error['message']);
      }
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  Future<Result<SaveDeviceInfoResponseModal>> saveMobileDeviceDetails(SaveDeviceInfoRequestModal saveDeviceInfoRequestModal) async {
    try {

      var response =  await apiService.post(ApiEndPoints.saveMobileDeviceDetails , saveDeviceInfoRequestModal.toJson());
      response = errorHandler(response);
      if (response.statusCode == 200) {
        if (response.body != null) {
          final result = json.decode(json.encode(response.body));
          var userModel =   SaveDeviceInfoResponseModal.fromJson(result);
          return Success(data: userModel);
        } else {
          return Failure(message: "Invalid credential");
        }
      } else {
        var error = json.decode(response.bodyString.toString());
        return Failure(message: error['message']);
      }
    } catch (e) {
      return Failure(message: e.toString());
    }
  }




  Future<Result<UpdateFcmTokenResponseModal>> updateFcmToken(UpdateFcmTokenRequestModal updateFcmTokenRequestModal) async {
    try {

      var response =  await apiService.post(ApiEndPoints.updateFcmToken , updateFcmTokenRequestModal.toJson());
      response = errorHandler(response);
      if (response.statusCode == 200) {
        if (response.body != null) {
          final result = json.decode(json.encode(response.body));
          var userModel =   UpdateFcmTokenResponseModal.fromJson(result);
          return Success(data: userModel);
        } else {
          return Failure(message: "Invalid credential");
        }
      } else {
        var error = json.decode(response.bodyString.toString());
        return Failure(message: error['message']);
      }
    } catch (e) {
      return Failure(message: e.toString());
    }
  }

  // Get Change Password Response
  Future<Result<ResetPasswordResponseModal>> resetPassword(ResetPasswordRequestModal resetPasswordRequestModal) async {
    try {
      var response =  await apiService.post(ApiEndPoints.resetPassword, resetPasswordRequestModal.toJson());
      response = errorHandler(response);
      if (response.statusCode == 200) {
        if (response.body != null) {
          final result = json.decode(json.encode(response.body));
          var userModel =   ResetPasswordResponseModal.fromJson(result);
          return Success(data: userModel);
        } else {
          return Failure(message: "Invalid credential");
        }
      } else {
        var error = json.decode(response.bodyString.toString());
        return Failure(message: error['message']);
      }
    } catch (e) {
      return Failure(message: e.toString());
    }
  }
}
