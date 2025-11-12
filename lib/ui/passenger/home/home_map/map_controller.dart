import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_directions/google_maps_directions.dart';
import 'package:google_maps_utils/google_maps_utils.dart' as utils;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shaligram_transport_app/models/driver/trip/route/SetPickupWayPointsModel.dart';

import 'package:shaligram_transport_app/services/place_provider.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/location_manager.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../../../models/driver/signalR/setDriverLatLongModel.dart';
import '../../../../models/passenger/signalR/GetDriverLatLongFromServer.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/GetBytesFromCanvas.dart';
import '../../../../utils/theme_color.dart';
import "package:vector_math/vector_math.dart" show degrees;
import 'dart:math';

import '../../../driver_screens/trip/trip_controller.dart';
import "package:google_maps_directions/google_maps_directions.dart" as gmd;



class MapController extends GetxController with GetTickerProviderStateMixin {

  LocationManager locationManager = Get.find<LocationManager>();
  PlaceApiProvider placeApiProvider = Get.find<PlaceApiProvider>();


  RxMap<PolylineId, Polyline> polyLines = RxMap();
  RxMap<MarkerId, Marker> markers = RxMap();
  RxMap<CircleId, Circle> circles = RxMap();
  RxList<math.Point> dataList = RxList();
  RxList<LatLng> firstPolylineCoordinates = RxList();
  RxList<LatLng> secondPolylineCoordinates = RxList();
  RxBool polyLoading = RxBool(false);

  Rx<LatLng> startLatLong = Rx(const LatLng(0.0, 0.0));
  Rx<LatLng> destLatLong = Rx(const LatLng(0.0, 0.0));
  var oldLatitude = 0.0.obs;
  var oldLongitude = 0.0.obs;

  Animation<double>? animation;

   Uint8List? pickupPin;
   Uint8List? currentLocationPin;
   Uint8List? pickUp;
   Uint8List? dest;
  List<Future> futures = <Future>[];

  // Signal R
  HubConnection? connection;
  Timer? timer;
  RxBool isSignalRConnected = RxBool(false);

  // Driver Path Poly lines
  final List<LatLng> _driverPathPoints = <LatLng>[];


  @override
  onInit() async {
    super.onInit();
    pickupPin = await LocationManager.getBytesFromAsset("${AppConstant.assestPath}pickup_icon.png", 130);
    var currentRoute = Get.currentRoute;

    if (currentRoute == Routes.passengerHome) {
      currentLocationPin = await LocationManager.getBytesFromAsset("${AppConstant.assestPath}ic_current_loc.png", 130);
    }
    else{
      currentLocationPin = await LocationManager.getBytesFromAsset("${AppConstant.assestPath}icon_driverpin.png", 70);
    }

    pickUp = await LocationManager.getBytesFromAsset("${AppConstant.assestPath}start_point_pin.png", 70);
    dest = await LocationManager.getBytesFromAsset("${AppConstant.assestPath}end_point_pin.png", 70);
  }


  Future requestToFindRoutesBetween(LatLng startLocation, LatLng endLocation, List<PolylineWayPoint> wayPoints, LatLng currentLocation) async {
    try {
      polyLoading(true);
      await getPolyline(
          PointLatLng(
              startLocation.latitude, startLocation.longitude),
          PointLatLng(endLocation.latitude, endLocation.longitude),
          wayPoints);
      await addStartMarker(startLocation);
      await addCurrentLocationMarker(currentLocation);
      await createPolyline();
      await addDestinationMarker(endLocation);

    } finally {
      polyLoading(false);
    }
  }

  Future addPickupWayPoints(RxList<SetPickupWayPointsModel> pickupWayList) async{
    if(pickupWayList != null){
      for(int i=0; i< pickupWayList.length; i++){
        addWayPoints(pickupWayList.value[i].location!,pickupWayList.value[i].id!,pickupWayList.value[i].pickupOrder!);
      }
    }
  }

  void updateMyLocationMarker(LocationData locationData) async {
    LatLng newPosition = LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
    LatLng oldPosition = LatLng(oldLatitude.value, oldLongitude.value);
    await addDriverMarker(oldPosition, newPosition,0);
    await moveMapCamera(newPosition, zoom: 18, bearing: locationData.heading!);
    await updatePolylineAlgo(locationData);
    oldLatitude.value = locationData.latitude ?? 0.0;
    oldLongitude.value = locationData.longitude ?? 0.0;
  }

  moveMarkerOnMap(LatLng oldPosition, LatLng newPosition, double bearing) async{
    await addDriverMarker(oldPosition, newPosition,bearing);
  }


  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  void startLocationUpdates(Completer<GoogleMapController> googleMapController) async {
    locationManager.startLocationUpdates(googleMapController);
  }

  void stopLocationUpdates() {
    locationManager.stopLocationUpdates();
  }

  Future addDriverMarker(LatLng oldPos, LatLng newDriverPos, double bearing) async {

    final double bearing1 = getBearing(LatLng(oldPos.latitude, oldPos.longitude), LatLng(newDriverPos.latitude, newDriverPos.longitude));
    if (!bearing1.isNaN){
      bearing  = bearing1;
      var currentRoute = Get.currentRoute;
      if (currentRoute == Routes.passengerHome) {
        // Get.find<HomeMapViewController>().moveCameraDirection(newPosition,bearing);
      }
      else{
        if(Get.isRegistered<TripController>()) {
          Get.find<TripController>().moveCameraDirection(newDriverPos, bearing);
        }
      }
    }
    MarkerId id = const MarkerId("driverMarker");
    AnimationController animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: false);

    Tween<double> tween = Tween(begin: 0, end: 1);

    animation = tween.animate(animationController)
      ..addListener(() {
        final v = animation!.value;

        double lng = v * newDriverPos.longitude + (1 - v) * oldPos.longitude;
        double lat = v * newDriverPos.latitude + (1 - v) * oldPos.latitude;

        LatLng newPos = LatLng(lat, lng);
        if(currentLocationPin != null) {
          Marker newCar = Marker(
              markerId: id,
              position: newPos,
              icon: BitmapDescriptor.fromBytes(currentLocationPin!),
              anchor: const Offset(0.5, 0.5),
              draggable: false,
              zIndex: 2,
              flat: true,
              rotation: bearing
          );
          markers[id] = newCar;
          update();
        }
      });

   // showSnakeBar(Get.context as BuildContext, "$bearing1  $bearing");
    animationController.forward();

    var totalDistance = calculateDistance(oldPos.latitude, oldPos.longitude, newDriverPos.latitude, newDriverPos.longitude);
    if(totalDistance > 0.0 && totalDistance < 10){
      _driverPathPoints.add(newDriverPos);
    }
  }

  double getBearing(LatLng begin, LatLng end) {
    double lat = (begin.latitude - end.latitude).abs();
    double lng = (begin.longitude - end.longitude).abs();

    if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
      return degrees(atan(lng / lat));
    } else if (begin.latitude >= end.latitude && begin.longitude < end.longitude) {
      return (90 - degrees(atan(lng / lat))) + 90;
    } else if (begin.latitude >= end.latitude && begin.longitude >= end.longitude) {
      return degrees(atan(lng / lat)) + 180;
    } else if (begin.latitude < end.latitude && begin.longitude >= end.longitude) {
      return (90 - degrees(atan(lng / lat))) + 270;
    }
    return -1;
  }

  Future addStartMarker(LatLng latLng) async {
    if(pickUp != null) {
      MarkerId destMarkerId = const MarkerId("start");
      Marker destMarker = Marker(
        markerId: destMarkerId,
        position: latLng,
        icon: BitmapDescriptor.fromBytes(pickUp!),
        anchor: const Offset(0.5, 0.5),
      );
      markers.putIfAbsent(destMarkerId, () => destMarker);
    }
  }

  Future addDestinationMarker(LatLng latLng) async {
    if(dest != null) {
      MarkerId destMarkerId = const MarkerId("dest");
      Marker destMarker = Marker(
        markerId: destMarkerId,
        position: latLng,
        icon: BitmapDescriptor.fromBytes(dest!),
        anchor: const Offset(0.5, 0.5),
      );
      markers.putIfAbsent(destMarkerId, () => destMarker);
    }
  }

  Future addCurrentLocationMarker(LatLng latLng) async {
    if(currentLocationPin != null) {
      MarkerId destMarkerId = const MarkerId("driverMarker");
      Marker destMarker = Marker(
          markerId: destMarkerId,
          position: latLng,
          icon: BitmapDescriptor.fromBytes(currentLocationPin!),
          anchor: const Offset(0.5, 0.5)
      );
      markers.putIfAbsent(destMarkerId, () => destMarker);
    }

  }

  Future addWayPoints(LatLng latLng,int markerId, int pickupOrder) async {
    final Uint8List desiredMarker = await getBytesFromCanvas(pickupOrder.toString());
    MarkerId destMarkerId =  MarkerId(markerId.toString());
    var destMarker =  Marker(
        markerId: MarkerId(markerId.toString()),
        position: latLng,
        icon: BitmapDescriptor.fromBytes(desiredMarker),
        alpha: 0.8);

    markers.putIfAbsent(destMarkerId, () => destMarker);
  }


  Future updatePolylineAlgo(LocationData locationData) async {
    var polyline = <LatLng>[].obs;

    var isOnPath = utils.PolyUtils.isLocationOnEdgeTolerance(
        math.Point(
          locationData.longitude ?? 0.0,
          locationData.latitude ?? 0.0,
        ),
        dataList,
        false,
        50);

    if (isOnPath) {
      math.Point currentPoint = math.Point(locationData.longitude ?? 0.0, locationData.latitude ?? 0.0);
      if (secondPolylineCoordinates.length > 1) {
        var x = secondPolylineCoordinates.indexWhere((e) {
          var dis = utils.SphericalUtils.computeDistanceBetween(
              currentPoint, math.Point(e.longitude, e.latitude));
          return (dis <= 30 && dis >= 0);
        });
        if (x == 0) {
          secondPolylineCoordinates.removeAt(0);
        } else {
          if (x != -1) {
            secondPolylineCoordinates.removeRange(0, x);
          }
        }
      }
      polyline.value = [LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0), ...secondPolylineCoordinates];
    }
    else {
      if (polyLoading.value == false) {
        await requestToReloadPolyline();
      }
    }
  }

  Future requestToReloadPolyline() async {
    await getCurrentLocation().then((value) async {
      if (value != null) {
        oldLatitude.value = value.latitude ?? 0.0;
        oldLongitude.value = value.longitude ?? 0.0;

        await getPolyline(
            PointLatLng(startLatLong.value.latitude, startLatLong.value.longitude),
            PointLatLng(destLatLong.value.latitude, destLatLong.value.longitude),
            [PolylineWayPoint(location: "${value.latitude},${value.longitude}")]);

        LatLng newPosition = LatLng(value.latitude ?? 0.0, value.latitude ?? 0.0);
        LatLng oldPosition = LatLng(oldLatitude.value, oldLongitude.value);

        await createPolyline();
        await addDriverMarker(oldPosition, newPosition,0);
      }
    });
  }

  Future<LocationData?> getCurrentLocation() async {
    final hasPermission = await locationManager.handlePermission();
    if (hasPermission) {
      return await locationManager.getCurrentLocation();
    } else {
      return null;
    }
  }

  Future createPolyline() async {
    PolylineId polyFirst = const PolylineId('polyFirst');
    Polyline polyline1 = Polyline(
      polylineId: polyFirst,
      color: ThemeColor.primaryColor,
      points: secondPolylineCoordinates,
      width: 4,
      patterns: [PatternItem.dash(12)],
    );
    polyLines[polyFirst] = polyline1;

    PolylineId polySecond = const PolylineId('polySecond');
    Polyline polyline2 = Polyline(
      polylineId: polySecond,
      color: ThemeColor.disableColor,
      points: _driverPathPoints,
      width: 5,
      patterns: [PatternItem.dash(12)],
    );
    polyLines[polySecond] = polyline2;
  }

  Future moveMapCamera(LatLng target, {double zoom = 16, double bearing = 0}) async {
    CameraPosition(target: target, zoom: zoom, bearing: bearing, tilt: 70);
  }

  Future<String> getEstimatedDuration(LatLng driverLatLng, LatLng driverLatLng1) async{
    DurationValue durationBetween = await gmd.duration(driverLatLng.latitude, driverLatLng.longitude,driverLatLng1.latitude, driverLatLng1.longitude, googleAPIKey : AppConstant.MapApiKey);
    int seconds = durationBetween.seconds;
    int minutes = (seconds / 60).truncate();
    if(minutes < 10){

    }
    var minutesStr = "";
   return  minutesStr = (minutes % 60).toString().padLeft(2, '0').toString();
  }

  Future getPolyline(PointLatLng startPoint, PointLatLng endPoint, List<PolylineWayPoint> wayPoints) async {
    firstPolylineCoordinates.clear();
    secondPolylineCoordinates.clear();
    dataList.clear();

    await placeApiProvider.getCreatedPolyline(startPoint, endPoint, wayPoints).then((data) {
      if (data.points.isNotEmpty) {

        for (var point in data.points) {
          firstPolylineCoordinates.add(LatLng(point.latitude, point.longitude));
          secondPolylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
      dataList.value =
          List<math.Point>.from(secondPolylineCoordinates.map((element) {
            return math.Point(element.longitude, element.latitude);
          })).toList();
    });
  }

  void setDriverUpdatedLocation(GetDriverLatLongFromServer getDriverLatLongFromServer) {
    var getLocationData = getDriverLatLongFromServer;
    if(getDriverLatLongFromServer != null){
      if(getDriverLatLongFromServer.success == true){
        if(getDriverLatLongFromServer.data != null && getLocationData != null){
          var updatedLatLong = getLocationData.data!.routeTrackData;
          var getDriverLatLongFromServer   = setUpdateDriverLocationModelFromJson(updatedLatLong!);
        }
      }
    }
  }
}