
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaligram_transport_app/routes/app_routes.dart';
import 'package:shaligram_transport_app/ui/common/language/language_controller.dart';
import 'package:shaligram_transport_app/ui/driver_screens/trip/trip_controller.dart';
import 'package:shaligram_transport_app/ui/passenger/home/home_map/home_map_view_controller.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/rounded_button.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import '../ui/passenger/new_address/new_address_controller.dart';
import '../widget/common_widget.dart';

extension BottomSheetExt on BuildContext {

  Future<bool?> showSelectAndChangeLanguageDialog() async {
    if (Get.isDialogOpen != true) {
      return await Get.dialog(
          GetBuilder<LanguageController>(
            builder: (controller) {
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  title: Row(
                    children: [
                      Expanded(child: Padding(
                          padding: EdgeInsets.only(top: 12.sp),
                          child:
                          labelTextRegular("Change Language", 16, ThemeColor.darkTextColor)
                      )),
                      InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset("${AppConstant.assestPath}close_icon.png", width: 20.sp, height: 20.sp),
                          ),
                          onTap: () {
                            controller.selectedLanguage.value = controller.tempStoreIndex.value;
                            Get.back();
                          }
                      )
                    ],
                  ),
                  titlePadding: EdgeInsets.only(left: 24.sp, right: 10.sp, top: 10.sp),
                  contentPadding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 24.sp),
                  content: SizedBox(
                    width: Get.width,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        labelTextLight("Please select language and click on change button.", 12,  ThemeColor.lightTextColor),
                        50.hSpace,
                        Obx(() => ListView.separated(
                            itemBuilder: (context, index) {
                              return InkWell(
                                splashColor: const Color(0xFFAAAAAA).withOpacity(0.25),
                                onTap: () {
                                  controller.selectedLanguage.value = index;
                                  controller.languageList.refresh();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: SizedBox(
                                      width: Get.width,
                                      child: Row(
                                        children: [
                                          Expanded(child: labelTextRegular(controller.languageList[index], 14, ThemeColor.darkTextColor)),
                                          controller.selectedLanguage.value == index  ? const Icon(Icons.check) : 0.wSpace
                                        ],
                                      )),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(color: const Color(0xFFAAAAAA).withOpacity(0.25), thickness: 1);
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.languageList.length
                        ))
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.r))
                  ),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actionsPadding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 24.sp),
                  actions: [
                    RoundedButton(
                        isEnable: true,
                        text:  "Change",
                        fontSize: AppConstant.buttonSize,
                        onTap: controller.requestToChangeLanguage
                    )
                  ]
                ),
              );
            }
          ),
          barrierDismissible: false
      );
    }
    return null;
  }

  // SOS confirmation for Passenger
  showSOSConfirmationPassengerDialog(HomeMapViewController homeMapViewController) {
    if (Get.isDialogOpen != true) {
      Get.dialog(
          WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  Expanded(child: Padding(
                    padding: EdgeInsets.only(top: 12.sp),
                    child:
                    labelTextRegular("Send SOS message?", 16, ThemeColor.darkTextColor)
                  )),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset("${AppConstant.assestPath}close_icon.png", width: 20.sp, height: 20.sp),
                    ),
                    onTap: () {Get.back();}
                  )
                ],
              ),
              titlePadding: EdgeInsets.only(left: 24.sp, right: 10.sp, top: 10.sp),
              contentPadding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 24.sp),
              content: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  labelTextLight("Please reach your emergency contact by call or email.", 12,  ThemeColor.lightTextColor),
                  Image.asset("${AppConstant.assestPath}sos_dialog_icon.png", width: 200.sp, height: 200.sp),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r))
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actionsPadding: EdgeInsets.only(bottom: 20.r),
              actions: [
                InkWell(
                    onTap: () {
                      homeMapViewController.callSOSApi(AppConstant.SosCall);
                      Get.back();
                    },
                    child: Column(
                      children: [
                        Image.asset("${AppConstant.assestPath}call_icon.png", width: 62.sp, height: 62.sp),
                        Text("Make call to\nemergency contact", textAlign: TextAlign.center, style: ThemeColor.textStyle28px.copyWith(fontSize: 10.sp))
                      ],
                    )
                ),
                InkWell(
                    onTap: () {
                      homeMapViewController.callSOSApi(AppConstant.SosEmail);
                      Get.back();
                    },
                    child: Column(
                      children: [
                        Image.asset("${AppConstant.assestPath}mail_icon.png", width: 62.sp, height: 62.sp),
                        Text("Send email to your\nemergency contact", textAlign: TextAlign.center, style: ThemeColor.textStyle28px.copyWith(fontSize: 10.sp))
                      ],
                    )
                )
              ]
            ),
          ),
          barrierDismissible: false
      );
    }
  }


  loadNoData(){
    Widget noData(){
      return  Center(
        child:  labelTextRegular("No Data", 16.sp,  ThemeColor.darkTextColor),);
    }
  }



  // SOS confirmation for Driver
  showSOSConfirmationDriverDialog(TripController tripController) {
    if (Get.isDialogOpen != true) {
      Get.dialog(
          WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Expanded(child: Padding(
                        padding: EdgeInsets.only(top: 12.sp),
                        child:
                        labelTextRegular("Send SOS message?", 16, ThemeColor.darkTextColor)
                    )),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset("${AppConstant.assestPath}close_icon.png", width: 20.sp, height: 20.sp),
                        ),
                        onTap: () {Get.back();}
                    )
                  ],
                ),
                titlePadding: EdgeInsets.only(left: 24.sp, right: 10.sp, top: 10.sp),
                contentPadding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 24.sp),
                content: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    labelTextLight("Please reach your emergency contact by call or email.", 12,  ThemeColor.lightTextColor),
                    Image.asset("${AppConstant.assestPath}sos_dialog_icon.png", width: 200.sp, height: 200.sp),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.r))
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actionsPadding: EdgeInsets.only(bottom: 20.r),
                actions: [
                  InkWell(
                      onTap: () {
                       tripController.callSOSApi(AppConstant.SosCall);
                        Get.back();
                      },
                      child: Column(
                        children: [
                          Image.asset("${AppConstant.assestPath}call_icon.png", width: 62.sp, height: 62.sp),
                          Text("Make call to\nemergency contact", textAlign: TextAlign.center, style: ThemeColor.textStyle28px.copyWith(fontSize: 10.sp))
                        ],
                      )
                  ),
                  InkWell(
                      onTap: () {
                        tripController.callSOSApi(AppConstant.SosEmail);
                        Get.back();
                      },
                      child: Column(
                        children: [
                          Image.asset("${AppConstant.assestPath}mail_icon.png", width: 62.sp, height: 62.sp),
                          Text("Send email to your\nemergency contact", textAlign: TextAlign.center, style: ThemeColor.textStyle28px.copyWith(fontSize: 10.sp))
                        ],
                      )
                  )
                ]
            ),
          ),
          barrierDismissible: false
      );
    }
  }

  showNoRouteAssignedDialog(bool isPassenger) async{
    if (Get.isDialogOpen != true) {
      return await Get.dialog<bool>(
          WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Expanded(child: Padding(
                      padding: EdgeInsets.only(top: 12.sp),
                      child:   labelTextRegular("Alert".tr, 16, ThemeColor.darkTextColor),
                    )),
                    InkWell(
                        onTap: () {
                          //Get.back<bool>(result: false);
                          if(isPassenger == true){
                            Get.back();
                          }else {
                            Get.offAllNamed(Routes.home);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset("${AppConstant.assestPath}close_icon.png", width: 20.sp, height: 20.sp),
                        )
                    ),
                  ],
                ),
                titlePadding: EdgeInsets.only(left: 24.sp, right: 10.sp, top: 10.sp),
                contentPadding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 24.sp),
                content: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    labelTextLight("No Route found!", 12, ThemeColor.lightTextColor),
                    Image.asset("${AppConstant.assestPath}bus_complete_icon.png"),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.r))
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actionsPadding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 24.sp),
                actions: [
                  RoundedButton(
                      isEnable: true,
                      text: "Go Back",
                      fontSize: AppConstant.buttonSize,
                      onTap: () {
                        if(isPassenger == true){
                          Get.back();
                        }else {
                          Get.offAllNamed(Routes.home);
                        }
                      //  Get.back<bool>(result: true);
                       // Get.back();
                      })
                ]
            ),
          ),
          barrierDismissible: true
      );
    } else {
      return Future.value(false);
    }
  }

  Future<bool?> showTripCompleteDialog() async {
    if (Get.isDialogOpen != true) {
      return await Get.dialog<bool>(
          WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Expanded(child: Padding(
                      padding: EdgeInsets.only(top: 12.sp),
                      child:   labelTextRegular("Confirm Trip".tr, 16, ThemeColor.darkTextColor),
                    )),
                    InkWell(
                        onTap: () {
                          Get.back<bool>(result: false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset("${AppConstant.assestPath}close_icon.png", width: 20.sp, height: 20.sp),
                        )
                    ),
                  ],
                ),
                titlePadding: EdgeInsets.only(left: 24.sp, right: 10.sp, top: 10.sp),
                contentPadding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 24.sp),
                content: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    labelTextLight("Are you sure you want to complete this trip?", 12, ThemeColor.lightTextColor),
                    Image.asset("${AppConstant.assestPath}bus_complete_icon.png"),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.r))
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actionsPadding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 24.sp),
                actions: [
                  RoundedButton(
                    isEnable: true,
                    text: "Yes",
                    fontSize: AppConstant.buttonSize,
                    onTap: () {
                      Get.back<bool>(result: true);
                    })
                ]
            ),
          ),
          barrierDismissible: true
      );
    } else {
      return Future.value(false);
    }
  }
}

Future<void> showUploadImageBill(BuildContext context) async {
  if (Get.isDialogOpen != true) {
    return await Get.dialog(
        GetBuilder<NewAddressController>(
            builder: (controller) {
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                    backgroundColor: Colors.white,
                    title: Row(
                      children: [
                        Expanded(child: Padding(
                            padding: EdgeInsets.only(top: 12.sp),
                            child:
                            labelTextRegular(
                                "Select Image", 16, ThemeColor.darkTextColor)
                        )),
                        InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                  "${AppConstant.assestPath}close_icon.png",
                                  width: 20.sp, height: 20.sp),
                            ),
                            onTap: () {
                              Get.back<bool>(result: false);
                            }
                        )
                      ],
                    ),
                    titlePadding: EdgeInsets.only(
                        left: 24.sp, right: 10.sp, top: 10.sp),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 6.sp, horizontal: 24.sp),
                    content: SizedBox(
                      width: Get.width,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          labelTextLight(
                              "Please upload utility bill from Gallery or Camera",
                              12, ThemeColor.lightTextColor),
                          50.hSpace,
                        InkWell(
                          onTap: () {
                            controller.uploadImageFromGallery();
                            Get.back<bool>(result: false);
                          },
                          child: getUploadImageOption("Gallery","gallery_icon.png"),
                        ),
                          InkWell(
                            onTap: () {
                             controller.uploadImageFromCamera();
                              Get.back<bool>(result: false);
                            },
                            child: getUploadImageOption("Camera","camera_icon.png"),
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))
                    ),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    actionsPadding: EdgeInsets.symmetric(
                        vertical: 14.sp, horizontal: 24.sp),
                    actions: const [
                    ]
                ),
              );
            }
        ),
        barrierDismissible: false
    );
  }else{
    return Future.value(false);
  }
}

Widget getUploadImageOption(String option,path){
  return
    Container(
      padding: const EdgeInsets.symmetric(
          vertical: 10),
      child: SizedBox(
          width: Get.width,
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child:   Image.asset('${AppConstant.assestPath}'+ path),
              ),
              const SizedBox(width: 5,),
              labelTextRegular(
                  option,
                  14, ThemeColor
                  .darkTextColor)
            ],
          )),
    );
}

void requestToDrawPathOnMap(GoogleMapController mapController, List<LatLng> polylinePoints) async {
  Future.delayed(const Duration(milliseconds: 1000), () async {
    var start = polylinePoints.first;
    var end = polylinePoints.last;
    var bound = getStartAndEndLocationBounds(start, end);
  //  await mapController.animateCamera(CameraUpdate.newLatLngBounds(bound, 50));
    //  addPolyLines(start,end, wayPointLatLng);
  });

}


LatLngBounds getStartAndEndLocationBounds(LatLng start, LatLng end) {
  var southwest = LatLng(
      start.latitude <= end.latitude
          ? start.latitude
          : end.latitude,
      start.longitude <= end.longitude
          ? start.longitude
          : end.longitude);
  var northeast = LatLng(
      start.latitude <= end.latitude
          ? end.latitude
          : start.latitude,
      start.longitude <= end.longitude
          ? end.longitude
          : start.longitude);
  return LatLngBounds(southwest: southwest, northeast: northeast);
}

Future<MarkerData> createMarker(LatLng position, String title, String count) async {
  var marker = Marker(
    markerId: MarkerId(position.toString()),
    position: position,
    infoWindow: InfoWindow(title: title),
  );
  return MarkerData(marker: marker, child: _customMarker(count));
}

Widget _customMarker(String symbol) {
  return Stack(
    children: [
      Icon(
        Icons.location_on_rounded,
        color: const Color(0xFF459B79),
        size: 52.sp,
      ),
      Positioned(
        left: 12.sp,
        top: 8.sp,
        child: Container(
          width: 28.sp,
          height: 28.sp,
          padding: EdgeInsets.all(4.sp),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          child: Container(
              width: 18.sp,
              height: 18.sp,
              decoration: BoxDecoration(
                  color: const Color(0xFF459B79).withOpacity(0.7), borderRadius: BorderRadius.circular(10.r)),
              child: Center(child: Text(symbol, style: ThemeColor.textStyle12px.copyWith(color: Colors.white, fontWeight: FontWeight.w800)))),
        ),
      )
    ],
  );
}

Widget createUserNameIcon(String firstLatter,double width, double height,double textSize){
  var userName = firstLatter;
  var firstName = "";
  var lastName = "";
  var displayName = "";

  if(firstLatter.isNotEmpty){
    if(userName.contains(" ")){
      firstName =  userName.split(" ")[0] ;
      lastName =  userName.split(" ")[1] ;
      if(firstName.isNotEmpty && lastName.isNotEmpty){
        displayName = firstName[0] + lastName[0];
      }
      else{

        displayName = firstLatter[0];
      }
    }
    else{
      displayName = firstLatter[0];
    }
  }

  return FittedBox(
    fit: BoxFit.contain,
    alignment: Alignment.center,
    child: Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:  ThemeColor.profileBgBorder,
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Text(displayName, style:  TextStyle(color: Colors.white,fontSize: textSize,fontWeight: FontWeight.bold)),
    ),
  );
}

Future<MarkerData> createMarkerWithImage(String imageName, LatLng position, String title) async {
  var marker = Marker(
      markerId: MarkerId(position.toString()),
      position: position,
      infoWindow: InfoWindow(title: title),
      anchor: const Offset(0.5, 0.5)
  );
  return MarkerData(marker: marker, child: _customMarkerWithImage(imageName));
}

Widget _customMarkerWithImage(String imageName) {
  return Image.asset("${AppConstant.assestPath}$imageName", width: 20.sp, height: 20.sp);
}
extension NumExtension on num {
  SizedBox get hSpace => SizedBox(height: toDouble().sp);
  SizedBox get wSpace => SizedBox(width: toDouble().sp);
}

extension CountryCode on String {
  String get flagEmoji => toUpperCase()
      .split('')
      .map((c) => c.codeUnitAt(0) + 127397)
      .map(String.fromCharCode)
      .join();
}