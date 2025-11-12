import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/models/driver/report/GetDriverReportResponse.dart';
import 'package:shaligram_transport_app/provider/driver/Report/GetDriverReportListProvider.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';
import '../../../models/api_status.dart';
import '../../../models/driver/report/GetSaveDriverReport.dart';
import '../../../models/driver/report/SetSaveDriverReport.dart';
import '../../../provider/driver/Report/SaveDriverReportProvider.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/internetChecker.dart';
import '../../../widget/common_widget.dart';
import "package:collection/collection.dart";

class DriverReportController extends GetxController {
  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());

  // Provider for API
  final GetDriverReportListProvider _getDriverReportMenuResponse = Get.find<GetDriverReportListProvider>();
  final SaveDriverReportProvider _saveDriverReportProvider = Get.find<SaveDriverReportProvider>();


  // For Load Progress
  RxBool isLoading = RxBool(true);
  RxBool isButton = RxBool(false);
  RxBool isSelect = false.obs;


  // List for Report Menu
  var listDriverMenuList = <Datum>[].obs;
  var newMap = {}.obs;
  var itemsInCategory=  <Datum>[].obs;
  int? driverReportId;

  RxBool isRememberMe = RxBool(false);

  void getDriverReportList() {
    if(controller.is_InternetConnected.value){
      isLoading.value = true;
      isButton.value = true;
      _getDriverReportMenuResponse.getDriverReportList().then((value) => {
        isLoading.value = false,
        isButton.value = false,
        if (value is Success<GetDriverReportMenuResponse>) {
          isButton.value = false,
          setDriverListResponse(value.data)
        } else if (value is Failure<GetDriverReportMenuResponse>) {
          isButton.value = false,
          checkAuthError(value.message),

        }
      }).onError((error, stackTrace) => {
        isButton.value = false,
        isLoading.value = false,

      });
    }
    else{
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  setDriverListResponse(GetDriverReportMenuResponse data) {
    if(data != null){
      listDriverMenuList.value = data.data!;
     Map groupItemsByCategory() {
        return groupBy(listDriverMenuList, (item) {
          return item.categoryName.toString();
        });
      }
        newMap.value = groupItemsByCategory();
    }
  }


  submitDriverReport(var reportId , var driverReportId){

    if(controller.is_InternetConnected.value){

      GetSaveDriverReportResponse getSaveDriverReport = GetSaveDriverReportResponse(
          driverReportId: driverReportId,
          reportId: reportId,
          reportDate: DateTime.now(),
          dailyRouteId: 0,
          routeId: 0,
          driverId: 0,
          companyId: 0,
          createdDate: DateTime.now(),
          createdBy: 0,
          updatedDate: DateTime.now(),
          updatedBy: 0,
          isDeleted: true
      );
      _saveDriverReportProvider.getSaveDriverReportResponse(getSaveDriverReport).then((value) => {
        isLoading.value = false,


        if (value is Success<GetSaveDriverReport>) {

           Get.offAllNamed(Routes.home)
        } else if (value is Failure<GetSaveDriverReport>) {
          checkAuthError(value.message),

        }
      }).onError((error, stackTrace) => {
        isLoading.value = false,

      });
    }
    else{
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }
}
