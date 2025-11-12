import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaligram_transport_app/models/place_model.dart';
import 'package:shaligram_transport_app/provider/getChangeAddress_provider.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';
import 'package:shaligram_transport_app/services/place_provider.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/location_manager.dart';
import 'package:geocoding/geocoding.dart' hide Location;

import '../../../models/api_status.dart';
import '../../../models/passenger/address/GetChangeAddressResponse.dart';
import '../../../utils/internetChecker.dart';
import '../../../widget/common_widget.dart';

class NewAddressController extends GetxController {

  final LocationManager _locationManager = Get.find<LocationManager>();
  PlaceApiProvider placeApiProvider = Get.find<PlaceApiProvider>();

  TextEditingController locationTextController = TextEditingController();
  TextEditingController addressLocationTextController = TextEditingController();


  TextEditingController houseNo = TextEditingController();
  TextEditingController zipCode = TextEditingController();



  final Completer<GoogleMapController> _googleMapController = Completer<GoogleMapController>();
  RxList<Marker> allMarkers = RxList();
  RxBool isLoading = RxBool(false);
  RxBool isButton = RxBool(false);
  RxString query = RxString("");
  RxString debounceQuery = RxString("");
  RxBool isListVisible = RxBool(false);
  RxBool isEditAddress = RxBool(false);
  RxBool isConfirmEnable = RxBool(false);
  RxBool isCurrentLocation = true.obs;

  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

  XFile? imageData;

  // For Internet Check
  final InternetChecker controller = Get.put(InternetChecker());



  // For Store Data
  GetStorage getStorage;

  NewAddressController({required this.getStorage});


  final GetChangeAddressProvider changeAddressProvider = Get.find<GetChangeAddressProvider>();

  @override
  onInit() async {
    super.onInit();
    currentIcon = await LocationManager.createMarkerImageFromAsset("${AppConstant.assestPath}location_pin.png");
    addressLocationTextController.addListener(() {
      debounce(query, (value) {
        debounceQuery.value = value;
      }, time: const Duration(seconds: 1));
    });
  }

  onGoogleMapController(GoogleMapController mapController) async {
    _googleMapController.complete(mapController);

    var location = await getCurrentLocation();
    if (location != null) {
      await mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: location, zoom: 15)));
      allMarkers.add(Marker(
          markerId: const MarkerId("MyLocation"),
          icon: currentIcon,
          position: location
      ));
    }
  }

  // Upload Image from Gallery
  void uploadImageFromGallery() async{
    final ImagePicker picker = ImagePicker();
    imageData = await picker.pickImage(source: ImageSource.gallery);
  }

  // Upload Image from Camera
  void uploadImageFromCamera() async{
    final ImagePicker picker = ImagePicker();
    imageData = await picker.pickImage(source: ImageSource.camera);
  }


  onCameraIdleCallBack() async {
    final GoogleMapController controller = await _googleMapController.future;
    LatLngBounds bounds = await controller.getVisibleRegion();
    LatLng center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    isLoading.value = true;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(center.latitude, center.longitude);
      if (placemarks.isNotEmpty) {
        isLoading.value = false;
        var placeName = "${placemarks.first.name} ${placemarks.first.subAdministrativeArea}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, (${placemarks.first.postalCode}), ${placemarks.first.country}";
        locationTextController.text = placeName;
        isConfirmEnable.value  = true;
        //addressLocationTextController.text = placeName;
        //rxPoint.value = { "placeName": placeName, "latitude": center.latitude, "longitude": center.longitude };
      } else {
        isLoading.value = false;
      }
    } catch (e){
      isLoading.value = false;
    }
  }

  onCameraMoveCallBack(CameraPosition position) {
    int cabMarkerIndex = allMarkers.indexWhere((element) => element.markerId.value == "MyLocation");
    if (cabMarkerIndex != -1) {
      Marker marker = allMarkers.firstWhere((element) => element.markerId.value == "MyLocation");
      Marker newMarker = marker.copyWith(positionParam: position.target);
      allMarkers[cabMarkerIndex] = newMarker;
      allMarkers.refresh();
    } else {
      var marker = Marker(
          anchor: const Offset(0.5, 0.5),
          icon: currentIcon,
          zIndex: double.maxFinite,
          markerId: const MarkerId("MyLocation"),
          position: position.target,
          infoWindow: const InfoWindow(title: "My Location")
      );
      allMarkers.add(marker);
      allMarkers.refresh();
    }
  }

  void navigateToPlace(Place place) async {
    final GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(place.lat ?? 0.0, place.lng ?? 0.0)));
  }

  Future<LatLng?> getCurrentLocation() async {
    isCurrentLocation.value = false;
    final hasPermission = await _locationManager.handlePermission();
    if (hasPermission) {
      final position = await _locationManager.getCurrentLocation();
      return LatLng(position?.latitude ?? 0.0, position?.longitude ?? 0.0);
    } else {
      return null;
    }

  }

  void requestToChangeAddress() {
    var house = houseNo.text.toString();
    var zipcode = zipCode.text.toString();

      if(controller.is_InternetConnected.value){
        isButton.value = true;
       // startLoading();
        changeAddressProvider.getChangeAddressResponse(File(imageData?.path ?? ''),house,zipcode).then((value) => {
          isLoading.value = false,
          isButton.value = false,
        //  stopLoading(),
          if (value is Success<GetChangeAddressResponse>) {
            isButton.value = false,
          //  stopLoading(),
            showSnakeBar(buildContext, "Address Changes Success"),
            Get.offAllNamed(Routes.passengerHome),
          } else if (value is Failure<GetChangeAddressResponse>) {
          //  stopLoading(),
            isButton.value = false,
            showSnakeBar(buildContext,value.message)
          }
        }).onError((error, stackTrace) => {
          isLoading.value = false,
          isButton.value = false,
       //   stopLoading(),
        });
      }
      else{
        showSnakeBar(Get.context as BuildContext, AppConstant.noInternetMessage);
      }
    }
}
