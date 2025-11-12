import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shaligram_transport_app/ui/driver_screens/trip/trip_controller.dart';
import 'package:shaligram_transport_app/ui/passenger/home/home_map/home_map_view_controller.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';

import '../routes/app_routes.dart';
import '../ui/passenger/home/home_map/map_controller.dart';

class LocationManager extends GetxController  {

  //final SocketProvider _socketProvider = Get.find<SocketProvider>();
  final Location _location = Get.put(Location());
  LocationData? currentLocation;
  StreamSubscription<LocationData>? locationUpdateStream;
  RxBool isLocationUpdate = RxBool(false);

  Future<LocationData?> getCurrentLocation() async {
    currentLocation = await _location.getLocation();
    await onReady();
    return currentLocation;
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled = await _location.serviceEnabled();

    if (!serviceEnabled) {
      return false;
    }
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission == PermissionStatus.denied) {
        return false;
      } else if (permission == PermissionStatus.deniedForever) {
        return false;
      } else {
        return true;
      }
    } else if (permission == PermissionStatus.deniedForever) {
      return false;
    } else {
      return true;
    }
  }

  startLocationUpdates(Completer<GoogleMapController> googleMapController) async {
    if (locationUpdateStream?.isPaused == null) {
      locationUpdateStream = _location.onLocationChanged.listen((position) {
        currentLocation = position;
       // _socketProvider.updateUserLocation(latLng);
        isLocationUpdate.value = true;
        var currentRoute = Get.currentRoute;
        if (currentRoute == Routes.passengerHome) {
          Get.find<MapController>().updateMyLocationMarker(position);
         // Get.find<HomeMapViewController>().updateCurrentLocation(position);
        }
        else{
          Get.find<TripController>().updateCurrentLocation(position);
        }
      });
      var isBackGroundMode = await _location.isBackgroundModeEnabled();
      if (!isBackGroundMode) {
        _location.enableBackgroundMode(enable: true);
      }
    } else if (locationUpdateStream?.isPaused == true) {
      locationUpdateStream?.resume();
      isLocationUpdate.value = true;
    }
  }

  void stopLocationUpdates() {
    locationUpdateStream?.pause();
    isLocationUpdate.value = false;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.granted) {
      var isBackGroundMode = await _location.isBackgroundModeEnabled();
      if (!isBackGroundMode) {
        _location.changeSettings(accuracy: LocationAccuracy.high,
            interval: 10000,
            distanceFilter: 10);
        _location.changeNotificationOptions(
            channelName: "CleanMove-Notification-Channel",
            title: "Faster pickup & drop",
            subtitle: "When you're riding with CleanMove, your location is being collected for faster pickup & drop. Manage permissions in your device's location settings.",
            color: ThemeColor.primaryColor,
            onTapBringToFront: true
        );

        _location.enableBackgroundMode(enable: true);
      }
    }
  }

  static Future<BitmapDescriptor> createMarkerImageFromAsset(String image) async {
    final Uint8List markerIcon = await getBytesFromAsset(image, 70);
    return BitmapDescriptor.fromBytes(markerIcon);
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  void onClose() {
    locationUpdateStream?.cancel();
    super.onClose();
  }
}