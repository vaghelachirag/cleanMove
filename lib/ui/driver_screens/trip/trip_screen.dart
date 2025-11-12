import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaligram_transport_app/provider/driver/Trip/GetDriverRouteProvider.dart';
import 'package:shaligram_transport_app/provider/driver/Trip/GetPassengerCheckinProvider.dart';
import 'package:shaligram_transport_app/provider/driver/Trip/GetRoutePassengerListProvider.dart';
import 'package:shaligram_transport_app/provider/driver/Trip/GetUpdateRouteStatusProvider.dart';
import 'package:shaligram_transport_app/provider/getSOSpress_provider.dart';
import 'package:shaligram_transport_app/ui/driver_screens/trip/trip_controller.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';
import 'package:shaligram_transport_app/widget/custom_bottomsheet.dart';
import 'package:shaligram_transport_app/widget/sliding_up_panel.dart';

import '../../../utils/appConstant.dart';
import '../../../utils/rounded_button.dart';
import '../../../utils/theme_color.dart';
import '../../../widget/slide_action_button.dart';

class TripPage extends GetView<TripController> {
  var selectedPassengerIndex = 0;

  TripPage({Key? key}) : super(key: key);

  var coordinateStartPoint = const LatLng(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GetDriverRouteProvider>(() => GetDriverRouteProvider());
    Get.lazyPut<GetRoutePassengerListProvider>(
        () => GetRoutePassengerListProvider());
    Get.lazyPut<GetPassengerCheckInProvider>(
        () => GetPassengerCheckInProvider());
    Get.lazyPut<GetSoSProvider>(() => GetSoSProvider());
    Get.lazyPut<GetUpdateRouteStatusProvider>(
        () => GetUpdateRouteStatusProvider());
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (now.difference(controller.currentBackPressTime) >
            const Duration(seconds: 2)) {
          controller.currentBackPressTime = now;
          showSnakeBar(Get.context!, "Press Back Button Again to Exit App");
          return Future.value(false);
        } else {
          SystemNavigator.pop();
          return Future.value(true);
        }
      },
      child: Scaffold(
          backgroundColor: ThemeColor.primaryColor,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 10.sp),
              child: Obx(() => controller.isTripStarted.value == true
                  ? controller.isAllPassengerPickup.value == true
                      ? SizedBox(
                          height: 50.sp,
                          child: SlideActionBtn(
                              buttonText: "swipe_to_complete_CTA".tr,
                              swipeAction: () async {
                                await controller.requestToCompleteTrip();
                              }),
                        )
                      : controller.isShowPassenger.value == true
                          ? buildShowPassengerButton(
                              "pickup_passengers_CTA", false)
                          : buildShowPassengerButton(
                              "show_passengers_CTA", true)
                  : SizedBox(
                      height: 50.sp,
                      child: SlideActionBtn(
                          buttonText: "swipe_to_start_CTA".tr,
                          swipeAction: () async {
                            await controller.requestToStartTrip();
                          }),
                    ))),
          body: Obx(
            () => SlidingUpPanel(
                controller: controller.pc,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.transparent,
                  )
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r)),
             //   renderPanelSheet: true,
                slideDirection: SlideDirection.UP,
                defaultPanelState: PanelState.CLOSED,
                isDraggable: controller.isStart.value == true &&
                        controller.isButton.value == false
                    ? true
                    : false,
                onPanelOpened: () {
                  if (controller.isTripRunning.value == true) {
                    controller.disableScroll.value = false;
                    controller.isShowPassenger.value = true;
                  }
                },
                onPanelClosed: () {
                  controller.disableScroll.value = true;
                  controller.isShowPassenger.value = false;
                  controller.isButton.value = false;
                },
              minHeight: Platform.isIOS ? 210.sp : 250.sp,
                maxHeight: Get.height - (Platform.isIOS ? 120.sp : 100.sp),
                panelBuilder: (sc) {
                  return Obx(() => SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: 50.sp,
                            height: 3.sp,
                            margin: EdgeInsets.only(top: 10.sp),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.r))),
                          ),
                        ),
                        controller.isShowPassenger.value == true
                            ? buildPassengerDetailsView()
                       : buildLocationTripView(),
                      ],
                    ),
                  ));
                },
                body: Stack(
                  children: [
                    Obx(() => buildGoogleMap()),
                    /*  Positioned(
                        left: 0,
                        top: Platform.isIOS ? 40.sp : 18.sp,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: ClipRect(
                            child: Material(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.r)),
                              child: InkWell(
                                splashColor: ThemeColor.disableColor,
                                onTap: () {
                                  Get.back();
                                },
                                child: SizedBox(
                                    width: 28.sp,
                                    height: 28.sp,
                                    child: const Icon(Icons.arrow_back,
                                        color: Colors.black)),
                              ),
                            ),
                          ),
                        )),*/
                    Positioned(
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
                                child: Image.asset(
                                    "${AppConstant.assestPath}sos_icon.png")),
                          ),
                        )),
                  ],
                )),
          )),
    );
  }

  // Google Map
  Widget buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition:
          CameraPosition(target: coordinateStartPoint, zoom: 15),
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

  Widget buildLocationTripView() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
      child: Column(
        children: [
          12.hSpace,
          buildLocation(
              controller.startLocation.value, controller.endLocation.value),
          20.hSpace,
        ],
      ),
    );
  }

  // Build Show Passenger Button
  Widget buildShowPassengerButton(String title, bool showPassenger) {
    return RoundedButton(
        text: title.tr,
        isEnable: true,
        height: 50.sp,
        fontSize: AppConstant.buttonSize,
        onTap: () {
          controller.isButton.value = !controller.isButton.value;
          if (controller.isButton.value == true) {
            controller.pc.open();
          } else {
            controller.pc.close();
            controller.isShowPassenger.value = showPassenger;
          }
        });
  }

  Widget buildLocation(String startAddress, endAddress) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Image.asset("${AppConstant.assestPath}start_location_icon.png"),
            Image.asset("${AppConstant.assestPath}dash_line_icon.png"),
            Image.asset("${AppConstant.assestPath}destination_icon.png"),
          ],
        ),
        8.wSpace,
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              labelTextLight(
                  "start_location".tr, 12, ThemeColor.lightTextColor),
              labelTextRegular(startAddress, 14, ThemeColor.primaryColor),
              10.hSpace,
              labelTextLight("destination".tr, 12, ThemeColor.lightTextColor),
              labelTextRegular("$endAddress", 14, ThemeColor.primaryColor),
            ],
          ),
        )
      ],
    );
  }

  Widget buildPassengerDetailsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 18.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelTextBold(
                  "passenger_details".tr, 14, ThemeColor.darkTextColor),
              20.hSpace,
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: controller.requestToTotalPassengers,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.sp, horizontal: 16.sp),
                        decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            border: Border.all(
                                color: const Color(0xFFE2E2E2), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.r))),
                        child: Column(
                          children: [
                            labelTextBold(
                                controller.listPassenger.length.toString(),
                                14,
                                ThemeColor.darkTextColor),
                            8.hSpace,
                            labelTextLight("total_passengers".tr, 12,
                                ThemeColor.lightTextColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                  20.wSpace,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.sp, horizontal: 16.sp),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          border: Border.all(
                              color: const Color(0xFFE2E2E2), width: 1),
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.r))),
                      child: Column(
                        children: [
                          Obx(() => labelTextBold(
                              controller.totalPassengerInside.value
                                  .toString()
                                  .padLeft(2, "0"),
                              14,
                              ThemeColor.darkTextColor)),
                          8.hSpace,
                          labelTextLight(
                              "inside_bus".tr, 12, ThemeColor.lightTextColor)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Obx(
          () => controller.isLoadPassenger.value
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : controller.listPassenger.isEmpty
                  ? const Center(child: Text("No Data"))
                  : ListView.builder(
                      itemCount: controller.listPassenger.length,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          top: 20.sp, bottom: Platform.isIOS ? 100.sp : 70.sp),
                      itemBuilder: (context, index) {
                        return Obx(
                          () => InkWell(
                            onTap: () {
                              /// controller.selectedPassengerIndex.value = index;
                            },
                            child: buildPassengerItem(
                                "${controller.listPassenger[index].firstName} ${controller.listPassenger[index].lastName}",
                                index,
                                -1,
                                controller.listPassenger[index].pickUpName ??
                                    ''),
                          ),
                        );
                      }),
        )
      ],
    );
  }

  Widget buildPassengerItem(
      String passengerName, int index, int selectedIndex, String pickupName) {
    return Obx(() => Container(
          color: index == controller.selectedPassengerIndex.value
              ? const Color(0xFFDAEBE4)
              : Colors.white,
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 18.sp),
          child: Row(
            children: [
              ClipOval(
                child: Container(
                    width: 38.sp,
                    height: 38.sp,
                    decoration: const BoxDecoration(
                      color: ThemeColor.primaryColorLight50,
                      shape: BoxShape.circle,
                    ),
                    child:
                        createUserNameIcon(passengerName, 80.sp, 80.sp, 20.sp)),
              ),
              10.wSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelTextRegular(
                        passengerName, 16, ThemeColor.darkTextColor),
                    labelTextLight(pickupName, 12, ThemeColor.lightTextColor)
                  ],
                ),
              ),
                InkWell(
                  onTap: () {
                    if (controller.listPassenger[index].isPassengerInside == false) {
                      if (controller.totalPassengerInside.value > 0) {
                        controller.totalPassengerInside.value -= 1;
                        controller.listPassenger[index].isPassengerInside = true;
                        controller.selectedPassengerIndex.value = index;
                        controller.getPassengerCheckInCheckoutResponse(
                            controller.listPassenger[index].employeeId, true);
                        controller.listPassenger.refresh();
                      }
                    }
                    else{
                      controller.totalPassengerInside.value += 1;
                      controller.listPassenger[index].isPassengerInside = false;
                      controller.selectedPassengerIndex.value = index;
                      controller.getPassengerCheckInCheckoutResponse(
                          controller.listPassenger[index].employeeId, true);
                      controller.listPassenger.refresh();
                    }
                  },
                  child: (controller.listPassenger[index].isPassengerInside == false) ? Image.asset(
                      "${AppConstant.assestPath}minus_circle_icon.png",
                      width: 24.sp,
                      height: 24.sp) : Image.asset(
                      "${AppConstant.assestPath}add_circle_icon.png",
                      width: 24.sp,
                      height: 24.sp),
                )
             /* if (controller.listPassenger[index].isPassengerInside == false)
                InkWell(
                  onTap: () {
                       if (controller.totalPassengerInside.value > 0) {
                      controller.totalPassengerInside.value -= 1;
                      controller.listPassenger[index].isPassengerInside = true;
                      controller.selectedPassengerIndex.value = index;
                       controller.getPassengerCheckInCheckoutResponse(
                          controller.listPassenger[index].employeeId, true);
                       controller.listPassenger.refresh();
                    }
                  },
                  child: Image.asset(
                      "${AppConstant.assestPath}minus_circle_icon.png",
                      width: 24.sp,
                      height: 24.sp),
                )
              else
                InkWell(
                  onTap: () {
                    controller.totalPassengerInside.value += 1;
                    controller.listPassenger[index].isPassengerInside = false;
                    controller.selectedPassengerIndex.value = index;
                    controller.getPassengerCheckInCheckoutResponse(
                        controller.listPassenger[index].employeeId, true);
                    controller.listPassenger.refresh();
                  },
                  child: Image.asset(
                      "${AppConstant.assestPath}add_circle_icon.png",
                      width: 24.sp,
                      height: 24.sp),
                ),*/
            ],
          ),
        ));
  }
}
