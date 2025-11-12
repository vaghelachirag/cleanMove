
import 'dart:convert';

import 'package:shaligram_transport_app/ui/paggination/getSurveyListResponse.dart';
import 'package:shaligram_transport_app/ui/paggination/partner/getPartnerListResponse.dart';

import '../api/repository/base_provider.dart';
import '../models/api_status.dart';


class  PaginationProvider extends BaseProvider {

  // Get Login Response
  Future<Result<GetSurveyResponse>> getAllPost(_page,_limit) async {

    try {
      var handleRes =  await apiService.get("/Survey/GetSurveyList?_page=$_page&_limit=$_limit");
      if (handleRes.statusCode == 200) {
        if (handleRes.body != null) {
          if(handleRes.body["Data"] != null){
            var userModel =   GetSurveyResponse.fromJson(handleRes.body);

            return Success(data: userModel);
          }else{

            return Failure(message: "Invalid credentials. Please try again");
          }
        } else {

          return Failure(message: "Invalid credentials. Please try again");
        }
      } else {

        var error = json.decode(handleRes.bodyString.toString());
        return Failure(message: error['Message']);
      }
    } catch (e) {

      return Failure(message: e.toString());
    }
  }


  // Get Login Response
  Future<Result<GetPartnerListResponse>> getAllPartner(_page,_limit) async {

    try {
      var handleRes =  await apiService.get("/Partner/GetPartnerList?PageNumber=$_page&PageSize=$_limit");
      if (handleRes.statusCode == 200) {
        if (handleRes.body != null) {
          if(handleRes.body["Data"] != null){
            var userModel =    GetPartnerListResponse.fromJson(handleRes.body);

            return Success(data: userModel);
          }else{

            return Failure(message: "Invalid credentials. Please try again");
          }
        } else {

          return Failure(message: "Invalid credentials. Please try again");
        }
      } else {

        var error = json.decode(handleRes.bodyString.toString());
        return Failure(message: error['Message']);
      }
    } catch (e) {

      return Failure(message: e.toString());
    }
  }

}