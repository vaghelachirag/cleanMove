import 'dart:io';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaligram_transport_app/provider/getSOSpress_provider.dart';
import 'package:shaligram_transport_app/provider/passenger/GetPassengerRouteDetailProvider.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';


import 'home_map_view_controller.dart';

class HomeMapView extends GetView<HomeMapViewController> {

  HomeMapView({super.key});

  var coordinateStartPoint =  const LatLng(0.0,0.0);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GetSoSProvider>(() => GetSoSProvider());
    Get.lazyPut<GetPassengerRouteDetailProvider>(() => GetPassengerRouteDetailProvider());
    return   FocusDetector(
        onFocusGained: (){
          controller.getPassengerRouteDetail();
          coordinateStartPoint = LatLng(controller.startLocationLat.value, controller.startLocationLng.value);
        },
        onForegroundLost: () {
        },
        child:   AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            backgroundColor: ThemeColor.primaryColor,
            body:
            Stack(
              children: [
                Obx(() => buildGoogleMap()),
                buildSOSButton(),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      buildCheckInContainer(),
                      buildDriverInfoView(),
                    ],
                  ),
                ),

              ],
            ))));
  }

  // Google Map
  Widget buildGoogleMap(){
    return GoogleMap(
      initialCameraPosition:  CameraPosition(
          target: coordinateStartPoint, zoom: 15),
      compassEnabled: true,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      markers: Set<Marker>.of(controller.mapController.markers.values),
      circles: Set<Circle>.of(controller.mapController.circles.values),
      polylines: Set<Polyline>.of(controller.mapController.polyLines.values),
      onMapCreated: (mapController) {
        controller.onGoogleMapController(mapController);
      },
    );
  }


  // For SOS Button
  Widget buildSOSButton(){
    return   Positioned(
        right: 0,
        top: Platform.isIOS ? 40.sp : 18.sp,
        child: Padding(
          padding: EdgeInsets.all(14.sp),
          child: InkWell(
            splashColor: ThemeColor.disableColor,
            onTap: () {
              controller.showSOSConfirmationDialog();
            },
            child: SizedBox(
                width: 52.sp,
                height: 52.sp,
                child: Image.asset("${AppConstant.assestPath}sos_icon.png")),
          ),
        ));
  }

  Widget buildDriverInfoView() {
    return Obx(
      () =>  Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.transparent,
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 18.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.hSpace,
            labelTextRegular(controller.estimatedTime.value, 13, ThemeColor.darkTextColor),
            8.hSpace,
            Divider(color: const Color(0xFFAAAAAA).withOpacity(0.25), thickness: 1),
            Row(
              children: [
                ClipOval(
                  child: Container(
                    width: 36.sp,
                    height: 36.sp,
                    decoration: BoxDecoration(
                        color: ThemeColor.primaryColorLight50,
                        shape: BoxShape.circle,
                        border: Border.all(color: ThemeColor.primaryColor, width: 1)
                    ),
                    child: createUserNameIcon(controller.driverName.value,80.sp,80.sp,20.sp),
                  ),
                ),
                10.wSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelTextBold(controller.driverName.value, 14, ThemeColor.darkTextColor)
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    labelTextRegular(controller.vehicleNumber.value, 12, ThemeColor.darkTextColor),
                    labelTextLight("Short Van", 10, ThemeColor.lightTextColor),
                  ],
                )
              ],
            ),
          //  Divider(color: const Color(0xFFAAAAAA).withOpacity(0.25), thickness: 1),
          ],
        ),
      ),
    );
  }

  Widget buildLocationTripView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.sp),
      child: Column(
        children: [
          buildLocation(controller.passengerStartLocation.value,
              controller.passengerDestinationLocation.value),
        ],
      ),
    );
  }

  // Switch For Check In
  Widget buildCheckInSwitch(){
    return  Obx(
      () =>  Transform.scale(
        scale: 1.2,
        child: CupertinoSwitch(
          activeColor: ThemeColor.switchActiveColor,
          thumbColor: ThemeColor.primaryColor,
          trackColor: ThemeColor.disableColor,
          value: controller.isCheckIn.value,
          onChanged: (value) {
            if (value) {
             // controller.requestToStartNavigation();
            } else {
            //  controller.requestToStopNavigation();
            }
            controller.isCheckIn.value = !controller.isCheckIn.value;
          },
        ),
      ),
    );
  }

  // Check In Switch Container
  Widget buildCheckInContainer(){
    return  Container(
    margin: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: labelTextRegular("check_in".tr, 13, ThemeColor.darkTextColor)),
          SizedBox(
            width: 50.sp,
            height: 10.sp,
            child: buildCheckInSwitch(),
          )
        ],
      ),
    );
  }

  // Trip Info Container
  Widget buildTripInfoContainer(){
    return  Obx(() =>   Container(
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 50.sp,
              height: 3.sp,
              margin: EdgeInsets.only(top: 8.sp),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                  BorderRadius.all(Radius.circular(3.sp))),
            ),
          ),
          buildDriverInfoView(),
          buildLocationTripView(),
          // ListView.builder(
          //     itemCount: 10,
          //     physics: const ClampingScrollPhysics(),
          //     shrinkWrap: true,
          //     padding: EdgeInsets.only(top: 20.sp),
          //     itemBuilder: (context, index) {
          //       return buildStepView;
          //     })
        ],
      ),
    ));
  }

  Widget  buildStepView() {
    return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.wSpace,
            Column(
              children: [
                labelTextLight("8:00", 12, ThemeColor.darkTextColor),
                4.hSpace,
                Image.asset("${AppConstant.assestPath}start_location_icon.png", width: 10.sp, height: 10.sp),
                4.hSpace,
                DottedLine(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  lineLength: 50.sp,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: Colors.black,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                ),
                4.hSpace,
              ],
            ),
            10.wSpace,
            const VerticalDivider(color: Color(0xFFAAAAAA), thickness: 1),
            10.wSpace,
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelTextRegular("Harrow Road", 13, ThemeColor.darkTextColor),
                    6.hSpace,
                    labelTextLight("Kensal Green Backpackers Ltd, 639 Harrow Road", 11, ThemeColor.lightTextColor),
                    10.hSpace,
                    labelTextRegular("Harrow Road", 13, ThemeColor.darkTextColor),
                    6.hSpace,
                    labelTextLight("Kensal Green Backpackers Ltd, 639 Harrow Road", 11, ThemeColor.lightTextColor),
                    10.hSpace,
                  ],
                )),
            16.wSpace,
            Padding(
              padding: EdgeInsets.only(top: 20.sp),
              child: labelTextLight("10 Min", 11, const Color(0xFF459B79)),
            ),
            16.wSpace,
          ],
        ),
      );
  }
}
