import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shaligram_transport_app/models/driver/vehicle/GetVehicleListDataResponseModel.dart';
import 'package:shaligram_transport_app/models/driver/vehicle/GetVehicleListResponseModel.dart';
import 'package:shaligram_transport_app/provider/driver/Vehicle/GetVehicleListProvider.dart';
import '../../../models/api_status.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/internetChecker.dart';
import '../../../widget/common_widget.dart';



class HomeController extends GetxController {

  HomeController({required this.getStorage});

  RxBool isLoading = RxBool(true);
  RxBool isNoData = RxBool(false);


  List<GetVehicleDataResponseModel> listVehicleDetail = [];
  final RefreshController refreshController = RefreshController();

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());


  // Provider for API
  final GetVehicleListProvider _getVehicleListProvider = Get.find<GetVehicleListProvider>();

  // For UserName
  var userName =  RxString("");

  // For Store Data
  GetStorage getStorage;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   setUserName();
  }

  loadVehicleData() async{
   // isLoading.value = true;
   //startLoading();
    if(controller.is_InternetConnected.value){
      _getVehicleListProvider.getVehicleListApiResponse().then((value) => {
        isLoading.value = false,
       // stopLoading(),
        if (value is Success<GetVehicleListResponse>) {
          setVehicleData(value),
      refreshController.refreshCompleted(),
        } else if (value is Failure<GetVehicleListResponse>) {
          refreshController.refreshCompleted(),
          checkAuthError(value.message),
          showSnakeBar(buildContext,value.message)
        }
      }).onError((error, stackTrace) => {
        isLoading.value = false,
        isNoData.value = true,

       // stopLoading(),
      });
    }
    else{
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  void getProfileUserName(){
    getUserName(getStorage);
  }
  void showSOSConfirmationDialog() {
   // Get.context?.showSOSConfirmationDialog(this);
  }

  void requestToVehicleDetails(GetVehicleDataResponseModel vehicleDetail) {
    Get.toNamed(Routes.vehicleDetail,arguments: vehicleDetail);
  }

  void redirectToProfileScreen(){
    Get.toNamed(Routes.profile);
  }

  void setVehicleData(Success<GetVehicleListResponse> value) {
   // listVehicleDetail = [];
    if(value.data != null){
      if(value.data.data.isNotEmpty){
        listVehicleDetail = value.data.data;
        isNoData.value = false;
      }
      else{
        isNoData.value = true ;
      }
    }
    else{
      isNoData.value = true ;
    }
  }

  void setUserName() {
    userName.value = getStorage!.read(AppConstant.profileName);
  }
  void onLoadingScheduled() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }
  void onRefreshScheduled() async {
    // monitor network fetch
    listVehicleDetail.clear();
    loadVehicleData();


  }


}
