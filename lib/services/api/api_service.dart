
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/api/repository/api.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';

class ApiService extends GetConnect {

   GetStorage getStorage;

  ApiService({required this.getStorage});

  @override
  onInit() {
    super.onInit();
    //1.base_url
    httpClient.baseUrl = "${Api.baseUrl}api/"; //2.
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 30);

    httpClient.addResponseModifier((request, response) async {
      if (kDebugMode) {
        print("---> ${request.method.toUpperCase()} ${request.url}");
        print(request.decoder ?? "");
        print(request.headers);
        print("---> END");
        print("<--- ${response.status.code} ${request.method.toUpperCase()} ${request.url}");
        print(response.body);
        print("<--- End");
      }
      return response;
    });

    httpClient.addRequestModifier<void>((request) async {
      if (getStorage.read(AppConstant.authToken) != "" && getStorage.read(AppConstant.authToken) != null) {
        var token = getStorage.read(AppConstant.authToken);
        var headers = {'Authorization': "Bearer $token"};
        request.headers.addAll(headers);
      }
      return request;
    });
  }

   errorHandler(Response response) {
     switch (response.statusCode) {
       case 200:
       case 201:
       case 202: {
         return response.body;
       }
       case 500:
         throw "Server Error pls retry later";
       case 403:
         throw 'Error occurred pls check internet and retry.';
       case 500:
       default:
         throw 'Error occurred retry';
     }
   }
}