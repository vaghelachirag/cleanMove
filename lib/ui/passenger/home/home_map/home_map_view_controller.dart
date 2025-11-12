import 'dart:async';
import 'dart:convert';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaligram_transport_app/provider/getSOSpress_provider.dart';
import 'package:shaligram_transport_app/provider/passenger/GetPassengerRouteDetailProvider.dart';
import 'package:shaligram_transport_app/ui/passenger/home/home_map/map_controller.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';
import 'package:shaligram_transport_app/widget/sliding_up_panel.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../../../api/repository/api.dart';
import '../../../../models/api_status.dart';
import '../../../../models/driver/signalR/setDriverLatLongModel.dart';
import '../../../../models/passenger/route/GetPassengerRouteDetailResponse.dart';
import '../../../../models/passenger/signalR/GetDriverLatLongFromServer.dart';
import '../../../../models/passenger/sos/GetSosresponse.dart';
import '../../../../models/passenger/sos/SOSRequestModel.dart';
import '../../../../utils/appConstant.dart';
import '../../../../utils/internetChecker.dart';

class HomeMapViewController extends GetxController  with GetTickerProviderStateMixin{


  HomeMapViewController({required this.getStorage});

  MapController mapController = Get.find<MapController>();

  final PanelController pc = PanelController();
  final ScrollController sc = ScrollController();
  RxBool disableScroll = RxBool(true);
  RxBool isCheckIn = RxBool(true);

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());
  final GetSoSProvider _sosProvider = Get.find<GetSoSProvider>();
  final GetPassengerRouteDetailProvider _getPassengerRouteDetailProvider = Get.find<GetPassengerRouteDetailProvider>();

  RxBool isLoading = RxBool(true);

  // Set Passenger Detail
  RxString passengerStartLocation = RxString("");
  RxString  passengerDestinationLocation = RxString("");
  RxString  driverName = RxString("");
  RxString  vehicleNumber = RxString("");
  RxString  estimatedTime = RxString("");


  RxDouble startLocationLat = RxDouble(0.0);
  RxDouble startLocationLng = RxDouble(0.0);
  RxDouble endLocationLat = RxDouble(0.0);
  RxDouble endLocationLng = RxDouble(0.0);

  RxList<MarkerData> customMarkers = RxList();
  var polyLines = <Polyline>[].obs;
  final Completer<GoogleMapController> _googleMapController = Completer<GoogleMapController>();
  /*TODO Temp*/
  final List<LatLng> _polylinePoints = <LatLng>[];


  // Google map Controller
  late GoogleMapController googleMapController ;


  RxString passengerId = RxString("") ;
  RxInt routeId = RxInt(0) ;
  RxInt dailyRouteId = RxInt(0) ;


  // For Store Data
  GetStorage getStorage;


  // Current  Location
  RxDouble userCurrentLocationLat = RxDouble(0.0);
  RxDouble userCurrentLocationLng = RxDouble(0.0);
  RxDouble userStartLocationLat = RxDouble(0.0);
  RxDouble userStartLocationLng = RxDouble(0.0);

  // For UserName
  var userName =  RxString("");

  RxMap<MarkerId, Marker> mapMarker = RxMap();

 // Signal R
  HubConnection? connection;
  Timer? timer;
  RxBool isSignalRConnected = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    initMapController();
    setUserName();
    passengerId.value =  getStorage.read(AppConstant.userId);
    sc.addListener(() {
      if (pc.isPanelOpen) {
        disableScroll.value = sc.offset <= 0;
      }
    });
    //getPassengerRouteDetail();
    connectToSignalRGetDriver();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    googleMapController.dispose();
    mapController.dispose();
  }

  void showSOSConfirmationDialog() {
    Get.context?.showSOSConfirmationPassengerDialog(this);
  }


  onCameraIdleCallBack() async {
  }

  onCameraMoveCallBack(CameraPosition position) {
  }


  void requestToStartNavigation() async {
    var startLocation = LatLng(startLocationLat.value, startLocationLng.value);
    var endLocation = LatLng(endLocationLat.value, endLocationLng.value);
    var currentLocation = LatLng(userCurrentLocationLat.value, userCurrentLocationLng.value);
    await mapController.requestToFindRoutesBetween(startLocation,endLocation,[],currentLocation).then((value) {
       if(value !=null){

       }
       else{
     //    Get.context?.showNoRouteAssignedDialog()
       }
    });
  }

  onGoogleMapController(GoogleMapController mapController) {
    _googleMapController.complete(mapController);
  //  requestToDrawPathOnMap();
  }

  void requestToStopNavigation() {
    mapController.stopLocationUpdates();
  }


  void getPassengerRouteDetail(){
    if(controller.is_InternetConnected.value){
      // startLoading(buildContext);
      _getPassengerRouteDetailProvider.getPassengerRouteDetailResponse(passengerId.value).then((value) => {
        //   isLoading.value = false,
        // stopLoading(buildContext),
        if (value is Success<GetPassengerRouteDetailResponse>) {
          // stopLoading(buildContext),
          setPassengerRouteDetail(value)
        } else if (value is Failure<GetPassengerRouteDetailResponse>) {
          Get.context?.showNoRouteAssignedDialog(true)
         // checkAuthError(value.message),
          //  stopLoading(buildContext),
          // showSnakeBar(buildContext,value.message)
        }
      }).onError((error, stackTrace) => {
        // isLoading.value = true,
        //   stopLoading(buildContext),
      });
    }
    else{
      // showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  void moveCameraDirection(double bearing) async{
    
  }


  void callSOSApi(String sosCall){

    int userId = int.parse(passengerId.value);

    var sosPressRequestModel = SetSosResponse(userId: userId,sosType: sosCall,sosDetails: sosCall,comment: sosCall, latitude:  userCurrentLocationLat.value.toString(),longitude:   userCurrentLocationLng.value.toString(),routeId: 1).obs;


   // startLoading();
    if(controller.is_InternetConnected.value){
     // startLoading();
      _sosProvider.getSoSResponse(sosPressRequestModel.value).then((value) => {
        isLoading.value = false,
       // stopLoading(),
        if (value is Success<GetSosResponse>) {
         // stopLoading(),
          isLoading.value = false,
          showSnakeBar(buildContext, "SOS Sent Successfully!")
        } else if (value is Failure<GetSosResponse>) {
          isLoading.value = false,
          checkAuthError(value.message),
         // stopLoading(),
          showSnakeBar(buildContext,value.message)
        }
      }).onError((error, stackTrace) => {
        isLoading.value = false,
     //   stopLoading(),
      });
    }
    else{
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  setPassengerRouteDetail(Success<GetPassengerRouteDetailResponse> value) {

    if(value.data.data != null){
      passengerStartLocation.value = value.data.data!.startingPoint!;
      passengerDestinationLocation.value = value.data.data!.endingPoint!;
      driverName.value = value.data.data!.driverName ?? "";
      vehicleNumber.value = value.data.data!.vehiclePlateNo!;
      var startLocationLatLong =  json.decode(value.data.data!.startLocationLatLng!);
      var endLocationLatLong =  json.decode(value.data.data!.endLocationLatLng!);
      startLocationLat.value = startLocationLatLong["Latitude"];
      startLocationLng.value = startLocationLatLong["Longitude"];
     endLocationLat.value = endLocationLatLong["Latitude"];
     endLocationLng.value = endLocationLatLong["Longitude"];
      _polylinePoints.add(LatLng(startLocationLat.value, startLocationLng.value));
      _polylinePoints.add(LatLng(endLocationLat.value, endLocationLng.value));
       routeId.value =   value.data.data!.routeId!;
      dailyRouteId.value = value.data.data!.dailyRouteId!;
       requestToStartNavigation();
       //getEstimatedTime();
    }
    }

  void initMapController() async{
    googleMapController = await _googleMapController.future;
  }

  void setUserName() {
    userName.value = getStorage.read(AppConstant.profileName);
  }

  Future<void> connectToSignalRGetDriver() async {
    try {
      connection = HubConnectionBuilder().withUrl('${Api.baseUrl}PassengerCheckIn')
          .build();
      if (connection!.state != HubConnectionState.connected) {
        await connection!.start()!.then((value) {
          timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
            if(connection!.state == HubConnectionState.disconnected){
              timer!.cancel();
            }else{
              connection!.on('GetDailyRouteLiveTrackingData', (message) {
                if(message != null){
                  var getDriverLatLongFromServer   = getDriverLatLongFromServerFromJson(json.encode(message[0]));

                  setDriverUpdatedLocation(getDriverLatLongFromServer);
                //  getEstimatedTime();
                }
                //  showSnakeBar(buildContext, "message");
              });

              Map<String, dynamic> getRouteData = {
                "DailyRouteId": dailyRouteId.value,
                "RouteId": routeId.value,
              };

              connection!.invoke('GetDailyRouteLiveTrackingData', args: [getRouteData]).then((value) => {

              });
            }
          });
        });
      }
    } catch (e) {
    }
  }

  void setDriverUpdatedLocation(GetDriverLatLongFromServer getDriverLatLongFromServer) async{
    var getLocationData = getDriverLatLongFromServer;
    if(getDriverLatLongFromServer.success == true){
      if(getDriverLatLongFromServer.data != null){
        var updatedLatLong = getLocationData.data!.routeTrackData;
        var getDriverLatLongFromServer   = setUpdateDriverLocationModelFromJson(updatedLatLong!);

        LatLng newPosition = LatLng(getDriverLatLongFromServer.last.lat!, getDriverLatLongFromServer.last.lng!);
        var oldPosition = LatLng(userCurrentLocationLat.value, userCurrentLocationLng.value);

        await mapController.moveMarkerOnMap(oldPosition,newPosition,0);
        userCurrentLocationLat.value =   getDriverLatLongFromServer.last.lat!;
        userCurrentLocationLng.value =   getDriverLatLongFromServer.last.lng!;
        await moveMapCamera(newPosition, zoom: 18);

      }
    }
    }

  Future moveMapCamera(LatLng target, {double zoom = 16, double bearing = 0}) async {
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          target: LatLng(
            target.latitude,
            target.longitude,
          ),
        ),
      ),
    );
  }

  void getEstimatedTime() {
     LatLng driverLatLng = LatLng(userCurrentLocationLat.value,userCurrentLocationLng.value);
     LatLng startLatLng = LatLng(startLocationLat.value,startLocationLng.value);
     mapController.getEstimatedDuration(driverLatLng,startLatLng).then((value) =>
     estimatedTime.value =  "Your Driver is Arriving In $value Min" );
  }

}