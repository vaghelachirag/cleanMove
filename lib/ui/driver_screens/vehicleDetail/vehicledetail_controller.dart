import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/models/driver/otp/GetSendOTPResponse.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';

import '../../../models/api_status.dart';
import '../../../models/driver/vehicle/GetVehicleListDataResponseModel.dart';
import '../../../models/setvehicledata.dart';
import '../../../provider/driver/Otp/GetSendOTProvider.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/internetChecker.dart';
import '../../../widget/common_widget.dart';

class VehicleController extends GetxController {

  // Loading
  RxBool isLoading = RxBool(false);

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());


  // For Verify OTP
  var vehicleId =  RxString("");
  var phoneNumber =  RxString("07878934042");
  RxString ? verificationSid = RxString("");
  RxString ? vehicleImageURL = RxString("");
  List<GetSendOTPResponse> listVehicleDetail = [];

  final GetSendOTPProvider _getSendOTPResponseProvider = Get.find<GetSendOTPProvider>();
  late  GetVehicleDataResponseModel getVehicleDataResponseModel;

  // List for Title
  List<SetVehicleData> listVehicleData = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVehicleDataResponseModel = Get.arguments;
    if(getVehicleDataResponseModel != null){
      setVehicleData();
    }
  }

  void requestToScanQR() {
    if(controller.is_InternetConnected.value){
     // startLoading();
      isLoading.value = true;
      _getSendOTPResponseProvider.getSendOTPResponse(phoneNumber.value).then((value) => {
        isLoading.value = false,
       // stopLoading(),
        if (value is Success<GetSendOTPResponse>) { isLoading.value = false,
          showSnakeBar(Get.context as BuildContext, AppConstant.otpSentMessage),
          getOTPDetail(value),
        //

        } else if (value is Failure<GetSendOTPResponse>) {
          isLoading.value = false,
          checkAuthError(value.message),
          showSnakeBar(buildContext,value.message)
        }
      }).onError((error, stackTrace) => {
        isLoading.value = false,
       // stopLoading(),
      });
    }
    else{
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  getOTPDetail(Success<GetSendOTPResponse> value) {
    if(value !=null){
      verificationSid!.value = value.data.data.verificationSid!;
    //  Get.toNamed(Routes.otpVerification,arguments: true, parameters: {'verificationId': verificationSid!.value,'phoneNumber': phoneNumber.value,'vehicleId': vehicleId.value});
      Get.toNamed(Routes.trip, parameters: {'driverId': "1",'phoneNumber': phoneNumber.value,'vehicleId': vehicleId.value},arguments: true);
    }
  }

  void setVehicleData() {
      vehicleId.value = getVehicleDataResponseModel.vehicleId.toString();
      vehicleImageURL!.value = getVehicleDataResponseModel.vehicleImagePath.toString();
      listVehicleData = [
      SetVehicleData("vehicle".tr, getVehicleDataResponseModel?.vehicleCategoryName),
      SetVehicleData("plate_no".tr, getVehicleDataResponseModel?.vehiclePlateNo),
      SetVehicleData("vehicle_id".tr, getVehicleDataResponseModel.chassisModel.toString()),
      SetVehicleData("seats".tr, "${getVehicleDataResponseModel?.seat.toString()} Seats Available"),
      SetVehicleData("fuel".tr,"${getVehicleDataResponseModel.consumption} km P/L"),
    ];
  }
}
