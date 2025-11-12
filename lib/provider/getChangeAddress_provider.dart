import 'dart:convert';
import 'dart:io';
import 'package:shaligram_transport_app/api/repository/api_end_points.dart';
import 'package:shaligram_transport_app/models/passenger/address/GetChangeAddressResponse.dart';
import '../api/repository/api.dart';
import '../api/repository/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:get_storage/get_storage.dart';

import '../models/api_status.dart';
import '../utils/appConstant.dart';

class  GetChangeAddressProvider extends BaseProvider {


  // For Store Data
  GetStorage getStorage;

  GetChangeAddressProvider({required this.getStorage});


  // Get Login Response
  Future<Result<GetChangeAddressResponse>> getChangeAddressResponse(File imagePath, String house, String zipcode) async {
    var postUri = Uri.parse( Api.baseUrl  +  ApiEndPoints.getChangeAddressResponse);
    var request = http.MultipartRequest("POST", postUri);
     request.files.add(
         await http.MultipartFile.fromPath(
           "UploadedFile",
           imagePath.path,
           filename: imagePath.path
               .split("/")
               .last,
            contentType: MediaType('image', 'png')
         )
     );
    request.fields["AddressChangeRequestId"] = "1";
    request.fields["EmployeeId"] = getStorage!.read(AppConstant.userId);
    request.fields["HouseNo"] = house;
    request.fields["ZipCode"] = zipcode;
    request.fields["Street"] = "Street";
    request.fields["UtilityDocumentPath"] = imagePath.path;
    request.fields["CreatedBy"] = getStorage!.read(AppConstant.userId!.toString());


    if (getStorage.read(AppConstant.authToken) != "" && getStorage.read(AppConstant.authToken) != null) {
      var token = getStorage.read(AppConstant.authToken);
      var headers = {'Authorization': "Bearer $token" , "Accept": "application/json",};
      request.headers.addAll(headers);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      var responseJson = json.decode(responseString);
      if (responseJson.isEmpty) {
        return Failure(message: "Invalid credentials. Please try again");
      } else {
        var userModel =    GetChangeAddressResponse(success: true, message: responseJson['Message'].toString());
        return Success(data: userModel);
      }
  }
    else{
      return Failure(message: "Invalid credentials. Please try again");
    }
  }

}
