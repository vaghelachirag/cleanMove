import 'dart:convert';
import '../../models/login/GetLoginResponse.dart';
import 'api.dart';
import 'api_end_points.dart';
import 'api_utils.dart';

class ApiRepo {

  // For Get Login Response
  Future<GetLoginResponse> getLoginResponse(String email,String password)  async {

    final loginParams = {
      'Username': email,
      'Password':password
    };

    try {
      String url = Api.baseUrl + ApiEndPoints.login;
      final response = await apiUtils.post(url: url,data: jsonEncode(loginParams));
      if(response.statusCode == 200){
        var json = response;
        return getLoginResponseFromJson(jsonEncode(json));
      }
      else{
        throw Exception("Unable to perform request!");
      }
    } catch (e) {
       throw Exception("Unable to perform request!$e");
    }
  }
}
