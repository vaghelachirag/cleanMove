import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:shaligram_transport_app/models/driver/signalR/setUpdateDriverLatLongModel.dart';
import 'package:shaligram_transport_app/models/driver/vehicle/GetVehicleRouteDataModel.dart';
import 'package:shaligram_transport_app/provider/driver/Trip/GetDriverRouteProvider.dart';
import 'package:shaligram_transport_app/provider/driver/Trip/GetUpdateRouteStatusProvider.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:wakelock/wakelock.dart';
import '../../../api/repository/api.dart';
import '../../../models/api_status.dart';
import '../../../models/driver/signalR/setCheckInSignalRModel.dart';
import '../../../models/driver/signalR/setDriverLatLongModel.dart';
import '../../../models/driver/trip/passengerlist/GetRoutePassengerListDetail.dart';
import '../../../models/driver/trip/passengerlist/GetRoutePassengerListResponse.dart';
import '../../../models/driver/trip/route/GetUpdateRouteStatusResponse.dart';
import '../../../models/driver/trip/route/SetPickupWayPointsModel.dart';
import '../../../models/driver/vehicle/GetDriverRouteResponseModel.dart';
import '../../../models/driver/vehicle/GetRoutePickUpData.dart';
import '../../../models/passenger/sos/GetSosresponse.dart';
import '../../../models/passenger/sos/SOSRequestModel.dart';
import '../../../provider/driver/Trip/GetRoutePassengerListProvider.dart';
import '../../../provider/getSOSpress_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/internetChecker.dart';
import '../../../widget/common_widget.dart';
import '../../../widget/sliding_up_panel.dart';
import '../../passenger/home/home_map/map_controller.dart';



class TripController extends GetxController with GetTickerProviderStateMixin {

  final Completer<GoogleMapController> _googleMapController = Completer<
      GoogleMapController>();
  var polyLines = <Polyline>[].obs;
  RxBool isStart = false.obs;
  RxBool isButton = false.obs;

  /*TODO Temp*/
  final List<LatLng> _polylinePoints = <LatLng>[];

  List<PolylineWayPoint> wayPoints = [];


  final PanelController pc = PanelController();
  final ScrollController sc = ScrollController();
  var disableScroll = true.obs;

  RxBool isTripStarted = RxBool(false);
  RxBool isAllPassengerPickup = RxBool(false);
  RxBool isShowPassenger = RxBool(false);
  RxBool isLoadPassenger = RxBool(false);
  RxInt totalPassengerInside = RxInt(0);
  RxInt totalPassenger = RxInt(1);
  DateTime currentBackPressTime = DateTime.now();

  // List for Passenger
  RxList<GetRoutePassengerListDetail> listPassenger = RxList([]);
  List<GetRoutePickUpData> listRouteLatLng = [];


  // Get Driver's Route Param
  RxString vehicleId = RxString("") ;
  RxString driverId = RxString("") ;
  RxString updateRouteId = RxString("");

  // API Provider
  final GetDriverRouteProvider _getDriverRouteProvider = Get.find<
      GetDriverRouteProvider>();
  final GetRoutePassengerListProvider _getRoutePassengerListProvider = Get.find<
      GetRoutePassengerListProvider>();
  final GetSoSProvider _sosProvider = Get.find<GetSoSProvider>();
  final GetUpdateRouteStatusProvider _getUpdateRouteStatusProvider = Get.find<
      GetUpdateRouteStatusProvider>();

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());

  // Loading
  RxBool isLoading = RxBool(true);


  // For Store Data
  GetStorage getStorage;

  TripController({required this.getStorage});

  // Set Route Data
  RxString startLocation = RxString("");

  RxString endLocation = RxString("");

  RxDouble startLocationLat = RxDouble(0.0);
  RxDouble startLocationLng = RxDouble(0.0);
  RxDouble endLocationLat = RxDouble(0.0);
  RxDouble endLocationLng = RxDouble(0.0);

  var oldLatitude = 0.0.obs;
  var oldLongitude = 0.0.obs;

  RxInt selectedPassengerIndex = RxInt(0);
  RxInt routeId = RxInt(0);
  RxInt dailyRouteId = RxInt(0);


  // Check Trip is Running
  RxBool isTripRunning = RxBool(false);

  // For Route Lat Long Data
  late GetVehicleRouteDataModel getRouteData;


  // Map Controller
  MapController mapController = Get.find<MapController>();


  // Current  Location
/*  RxDouble userCurrentLocationLat = RxDouble(23.029204112);
  RxDouble userCurrentLocationLng = RxDouble(72.48247318);*/
  RxDouble userCurrentLocationLat = RxDouble(0.0);
  RxDouble userCurrentLocationLng = RxDouble(0.0);

  //
  // Animation<double>? animation;
  // late Uint8List currentLocationPin;
  // RxMap<MarkerId, Marker> currentPinMarker = RxMap();
  // RxMap<MarkerId, Marker> markers = RxMap();


  // Signal R
  HubConnection? connection;
  Timer? timer;
  RxBool isSignalRConnected = RxBool(false);


  RxList<MarkerData> customMarkers = RxList();


  // Google map Controller
  late GoogleMapController googleMapController;


  // Pickup Way Points
  RxList<SetPickupWayPointsModel> pickupWayList = RxList([]);


  @override
  Future<void> onInit() async {
    super.onInit();
    selectedPassengerIndex.value = 0;

    if (Get.arguments == true) {
      vehicleId.value = Get.parameters["vehicleId"]!;
      driverId.value = getStorage.read(AppConstant.userId);
      getDriverRoute();
    }

    sc.addListener(() {
      if (pc.isPanelOpen) {
        disableScroll.value = sc.offset <= 0;
      }
    });

    sc.addListener(() {
      isStart.value = true;
    });

    totalPassengerInside.stream.listen((event) {
      if (event == listPassenger.length) {
        isAllPassengerPickup.value = true;
      } else {
        isAllPassengerPickup.value = false;
      }
    });

    connectToSignalRPassengerCheckInUpdate();
  }

  void updateCurrentLocation(LocationData position) async {
    if (position.latitude != 0.0 && position.longitude != 0.0) {
      LatLng oldPosition = LatLng(userCurrentLocationLat.value, userCurrentLocationLng.value);
      userCurrentLocationLat.value = position.latitude ?? 0.0;
      userCurrentLocationLng.value = position.longitude ?? 0.0;

      LatLng newPosition = LatLng(
          userCurrentLocationLat.value, userCurrentLocationLng.value);

      await mapController.moveMarkerOnMap(
          oldPosition, newPosition, position.heading!);
      //  await moveMapCamera(newPosition, zoom: 16, bearing: position.heading!);
      // await moveMapCamera(newPosition, zoom: 16);

      MarkerData currentLocation = await createMarkerWithImage("end_point_pin.png", newPosition, "End Point");
      customMarkers.add(currentLocation);
    }
  }

// Move Map Camera According Angle
  Future moveCameraDirection(LatLng newPosition, position) async {
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          bearing: position,
          target: LatLng(
            newPosition.latitude,
            newPosition.longitude,
          ),
        ),
      ),
    );
  }


  Future moveMapCamera(LatLng target,
      {double zoom = 16, double bearing = 0}) async {
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 16,
          bearing: bearing,
          target: LatLng(
            target.latitude,
            target.longitude,
          ),
        ),
      ),
    );
  }


  Future<void> requestToStartTrip() async {
    isStart.value = true;
    return await Future.delayed(const Duration(seconds: 3), () {
      isTripStarted.value = true;
      if (updateRouteId.value.isNotEmpty || updateRouteId.value != "") {
        updateRouteStatus(AppConstant.updateRouteStatusStart);
      }
    });
  }

  void requestToTotalPassengers() {
    Get.toNamed(Routes.totalPassengers, arguments: listPassenger);
  }

  void showSOSConfirmationDialog() {
    Get.context?.showSOSConfirmationDriverDialog(this);
  }

  Future<void> requestToCompleteTrip() async {
    var response = await Get.context?.showTripCompleteDialog();
    if (response == true) {
      return await Future.delayed(const Duration(seconds: 5), () {
        updateRouteStatus(AppConstant.updateRouteStatusCompletedTrip);
        // Get.offAndToNamed(Routes.driverReport);
      });
    } else {
      return;
    }
  }

  onCameraIdleCallBack() async {

  }

  onCameraMoveCallBack(CameraPosition position) {

  }

  onGoogleMapController(GoogleMapController mapController) {
    _googleMapController.complete(mapController);
    this.mapController.startLocationUpdates(_googleMapController);
  }

  void requestToStartNavigation(Completer<GoogleMapController> googleMapController) async {
    var startLocation = LatLng(startLocationLat.value, startLocationLng.value);
    var endLocation = LatLng(endLocationLat.value, endLocationLng.value);
    var currentLocation = LatLng(
        userCurrentLocationLat.value, userCurrentLocationLng.value);
    await mapController.requestToFindRoutesBetween(
        startLocation, endLocation, wayPoints, currentLocation).then((value) {
      if (mapController.polyLoading.value == false) {
        var startLocation = LatLng(
            startLocationLat.value, startLocationLng.value);
        var destinationLocation = LatLng(
            endLocationLat.value, endLocationLng.value);
        mapController.startLocationUpdates(googleMapController);
        Wakelock.enable();
      }
    });
  }


  void requestToDrawPathOnMap(GoogleMapController mapController,
      List<LatLng> polylinePoints) async {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      var start = polylinePoints.first;
      var end = polylinePoints.last;
      var bound = getStartAndEndLocationBounds(start, end);
      //  await mapController.animateCamera(CameraUpdate.newLatLngBounds(bound, 50));
      //  addPolyLines(start,end, wayPointLatLng);
    });
  }


  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer
        .asUint8List();
  }


  void getDriverRoute() {
    if (controller.is_InternetConnected.value) {
      //  startLoading(buildContext);
      _getDriverRouteProvider.getDriverRouteResponse(
          driverId.value, vehicleId.value).then((value) =>
      {
        isLoading.value = false,
        //  stopLoading(buildContext),
        if (value is Success<GetRouteResponseModel>) {
          setRouteData(value),
          updateRouteId.value =
              value.data.data!.routeMapingData.routeId.toString(),
          drawDriverRoute(value),

          // Signal R Connection
        } else
          if (value is Failure<GetRouteResponseModel>) {
            //  checkAuthError(value.message),
            Get.context?.showNoRouteAssignedDialog(false)
            //   showSnakeBar(buildContext,value.message)
          }
      }).onError((error, stackTrace) =>
      {
        isLoading.value = false,
        // stopLoading(buildContext),
      });
    }
    else {
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  void updateRouteStatus(int updateRouteStatus) {
    if (controller.is_InternetConnected.value) {
      //  startLoading(buildContext);
      _getUpdateRouteStatusProvider.getUpdateRouteStatus(
          updateRouteId.value, updateRouteStatus).then((value) =>
      {
        // isLoading.value = false,
        //  stopLoading(buildContext),
        if (value is Success<GetUpdateRouteStatusResponse>) {

          if(updateRouteStatus == AppConstant.updateRouteStatusStart){
            isTripRunning.value = true,
            startDriverTrip()
          }
          else
            {
              isTripRunning.value = false,
              showSnakeBar(buildContext, "Trip Completed Successfully!"),
              Get.toNamed(Routes.driverReport),
              Wakelock.disable()
              // Get.back()
            }
        } else
          if (value is Failure<GetUpdateRouteStatusResponse>) {
            //  checkAuthError(value.message),
            isTripRunning.value = false,
            checkAuthError(value.message),
            Wakelock.disable()
            //   showSnakeBar(buildContext,value.message)
          }
      }).onError((error, stackTrace) =>
      {

        // isLoading.value = false,
        // showSnakeBar(buildContext,error.toString())
        // stopLoading(buildContext),

      });
    }
    else {
      Wakelock.disable();
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  void getPassengerCheckInCheckoutResponse(int? passengerId, bool checkIn) {
    if (controller.is_InternetConnected.value) {
      var setCheckInSignalRModel = SetCheckInSignalRModel(
          passengerId: passengerId, checkIn: checkIn, routeId: routeId.value)
          .obs;
   /*   connection!.invoke('UpdateRoutePassengerCheckIn',
          args: [setCheckInSignalRModel.toJson()]).then((value) =>
      {

      });*/

      connection!.send(methodName: 'UpdateRoutePassengerCheckIn' , args: [setCheckInSignalRModel.toJson()]).then((dynamic data) {
        connection!.on('UpdateRoutePassengerCheckIn', (message) {
        });
      });
    }
    else {
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  drawDriverRoute(Success<GetRouteResponseModel> value) {
    if (value != null) {
      if (value.data != null) {
        if (value.data.data != null &&
            value.data.data!.routeMapingData != null) {
          var routeData = value.data.data!.routeMapingData;
          startLocation.value = routeData.startingPoint!;
          endLocation.value = routeData.endingPoint!;
          var startLocationLatLong = json.decode(
              routeData.startLocationLatLng!);
          var endLocationLatLong = json.decode(routeData.endLocationLatLng!);
          startLocationLat.value = startLocationLatLong["Latitude"];
          startLocationLng.value = startLocationLatLong["Longitude"];
          endLocationLat.value = endLocationLatLong["Latitude"];
          endLocationLng.value = endLocationLatLong["Longitude"];
          totalPassenger.value = routeData.totalPassengers!;
          listRouteLatLng = value.data.data!.routePickUpDatas;

          getRouteData = value.data.data!;
        }
      }
    }
  }

  void getRoutePassengerListResponse(int? routeId) {
    if (controller.is_InternetConnected.value) {
      //  startLoading(buildContext);
      isLoadPassenger.value = true;
      _getRoutePassengerListProvider.getRoutePassengerListResponse(
          routeId.toString()).then((value) =>
      {
        isLoading.value = false,
        isLoadPassenger.value = false,
        //  stopLoading(buildContext),
        if (value is Success<GetRoutePassengerListResponse>) {
          isLoadPassenger.value = false,
          setPassengerList(value)
        } else
          if (value is Failure<GetRoutePassengerListResponse>) {
            isLoadPassenger.value = false,
            checkAuthError(value.message),
            //   showSnakeBar(buildContext,value.message)
          }
      }).onError((error, stackTrace) =>
      {
        isLoading.value = false,
        isLoadPassenger.value = false,
        // stopLoading(buildContext),
      });
    }
    else {
      showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
    }
  }

  setPassengerList(Success<GetRoutePassengerListResponse> value) {
    if (value != null) {
      if (value.data != null) {
        listPassenger.value = value.data.data!;
      }
    }
  }

  void callSOSApi(String sosCall) {
    int userId = int.parse(driverId.value);
    if (userCurrentLocationLat.value != 0.0 &&
        userCurrentLocationLng.value != 0.0) {
      var sosPressRequestModel = SetSosResponse(
          userId: userId,
          sosType: sosCall,
          sosDetails: sosCall,
          comment: sosCall,
          latitude: userCurrentLocationLat.value.toString(),
          longitude: userCurrentLocationLng.value.toString(),
          routeId: int.parse(updateRouteId.value)).obs;

      if (controller.is_InternetConnected.value) {
        // startLoading(buildContext);
        _sosProvider.getSoSResponse(sosPressRequestModel.value).then((value) =>
        {
          isLoading.value = false,
          // stopLoading(buildContext),
          if (value is Success<GetSosResponse>) {
            //  stopLoading(buildContext),
            showSnakeBar(buildContext, "SOS Sent Successfully")
          } else
            if (value is Failure<GetSosResponse>) {
              checkAuthError(value.message),
              // stopLoading(buildContext),
              showSnakeBar(buildContext, value.message)
            }
        }).onError((error, stackTrace) =>
        {
          isLoading.value = false,
          showSnakeBar(buildContext, error.toString())
          // stopLoading(buildContext),
        });
      }
      else {
        showSnakeBar(
            Get.context as BuildContext, AppConstant.noInternetMessage);
      }
    } else {
      showSnakeBar(Get.context!, "can't get current location");
    }
  }

  void createPolylineList(GetVehicleRouteDataModel? data) async {
    if (data != null) {
      var routeData = data.routePickUpDatas;
      if (routeData.isNotEmpty) {
        for (var routeData in routeData) {
          var routeLat = double.parse(routeData.latitude!);
          var routeLng = double.parse(routeData.longitude!);
          _polylinePoints.add(LatLng(routeLat, routeLng));
          var setPickupWayPont = SetPickupWayPointsModel(
              id: routeData.routePickUpId,
              location: LatLng(routeLat, routeLng),
              pickupOrder: routeData.pickUpOrder);
          pickupWayList.value.add(setPickupWayPont);
          addWayPointMarker(
              LatLng(routeLat, routeLng), routeData.pickUpOrder, customMarkers);
          wayPoints.add(PolylineWayPoint(location: "$routeLat,$routeLng"));
          // MarkerData wayPoint = await createMarker(LatLng(routeLat, routeLng), "Way Point"+ routeId.toString(), routeData.routePickUpId.toString());
          // customMarkers.add(wayPoint);
        }
        mapController.addPickupWayPoints(pickupWayList);
      }
    }
  }

  startDriverTrip() {
    var routeData = getRouteData.routeMapingData;
    createPolylineList(getRouteData);
    requestToStartNavigation(_googleMapController);
    routeId.value = routeData.routeId!;
    dailyRouteId.value = routeData.dailyRouteId!;
    getRoutePassengerListResponse(routeData.routeId);
    connectToSignalRPassengerCheckInUpdate();
  }


  Future<void> connectToSignalRPassengerCheckInUpdate() async {
    try {
      connection =
          HubConnectionBuilder().withUrl('${Api.baseUrl}PassengerCheckIn')
              .build();
      if (connection!.state != HubConnectionState.connected) {
        await connection!.start()!.then((value) {
          timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {

            if (connection!.state == HubConnectionState.disconnected) {
              timer!.cancel();

            } else {
              connection!.on('UpdateRoutePassengerCheckIn', (message) {
                /*
                if(listPassenger.isNotEmpty) {
                  listPassenger.map((element) => null);
                  var setCheckInSignalRModel = SetCheckInSignalRModel(
                      passengerId: listPassenger[index].employeeId,
                      checkIn: checkIn,
                      routeId: routeId.value).obs;

                  connection?.send(
                      methodName: "UpdateRoutePassengerCheckIn", args:setCheckInSignalRModel.toJson())
                      .then((value) => null);
                  // showSnakeBar(buildContext, "message");
                }*/
              });

              connection!.on('AddUpdateDriverDailyRouteTracking', (message) {
                //   showSnakeBar(buildContext, "Updated");
              });

              var userId = int.parse(driverId.value);
              var listLatLng = <dynamic>[];
              var setLatLng = SetDriverLatLongModel(
                  lat: userCurrentLocationLat.value,
                  lng: userCurrentLocationLng.value);
              listLatLng.add(setLatLng);
              var updateLocation = jsonEncode(
                  listLatLng.map((e) => e.toJson()).toList());
              var setUpdateDriverLocation = SetUpdateDriverLocationModel(
                  dailyRouteId: dailyRouteId.value,
                  routeId: routeId.value,
                  routeTrackData: updateLocation.toString(),
                  createdBy: userId).obs;

              if(isTripRunning.value == true){
                connection!.invoke('AddUpdateDriverDailyRouteTracking',
                    args: [setUpdateDriverLocation.toJson()]).then((value) =>
                {

                });
              }
            }
          });
        });
      }
    } catch (e) {

    }
  }


  setRouteData(Success<GetRouteResponseModel> value) {
    if (value != null) {

    }
  }

}
