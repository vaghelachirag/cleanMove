import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shaligram_transport_app/provider/driver/Vehicle/GetVehicleListProvider.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GetVehicleListProvider>(() => GetVehicleListProvider());
    return FocusDetector(
        onFocusGained: () {
          controller.loadVehicleData();
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
                color: ThemeColor.primaryColor,
                child: SafeArea(
                  bottom: false,
                  maintainBottomViewPadding: true,
                  child: Scaffold(
                    body: Column(
                      children: [
                        buildTopHeader(),
                        Expanded(
                          child: buildVehicleDetail(),
                        )
                      ],
                    ),
                  ),
                ))));
  }

  Widget buildVehicleDetail() {
    return Obx(() => controller.isLoading.value == true
        ? const Center(
            child: CupertinoActivityIndicator(),
          )
        : controller.listVehicleDetail.isEmpty
            ? noData()
            : loadVehicleDetail());
  }

  Widget noData() {
    return Center(
      child: labelTextRegular("No Data", 16.sp, ThemeColor.darkTextColor),
    );
  }

  Widget loadVehicleDetail() {
    return SmartRefresher(
      enablePullDown: true,
      controller: controller.refreshController,
      onRefresh: controller.onRefreshScheduled,
      onLoading: controller.onLoadingScheduled,
   /*   header: const ClassicHeader(
        colorLoader: ThemeColor.primaryColor,
        textStyle: TextStyle(fontSize: 19, color: ThemeColor.primaryColor),
        failedIcon: Icon(Icons.error, color: ThemeColor.primaryColor),
        completeIcon: Icon(Icons.done, color: ThemeColor.primaryColor),
        idleIcon: Icon(Icons.arrow_downward, color: ThemeColor.primaryColor),
        releaseIcon: Icon(Icons.refresh, color: ThemeColor.primaryColor),
      ),*/
      child: ListView.separated(
        separatorBuilder: (context, index) => 20.hSpace,
        itemCount: controller.listVehicleDetail.length,
        shrinkWrap: true,
        primary: false,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 16.sp, bottom: 30.sp),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller
                  .requestToVehicleDetails(controller.listVehicleDetail[index]);
              //  print("OnTap"+ index.toString());
            },
            child: buildCarsCard(
                index, controller.listVehicleDetail[index].vehicleImagePath),
          );
        },
      ),
    );
  }

  Widget buildTopHeader() {
    return Container(
      decoration: BoxDecoration(
          color: ThemeColor.kBackgroundColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.sp),
              bottomRight: Radius.circular(20.sp))),
      child: Padding(
        padding: EdgeInsets.only(
            top: 30.sp, bottom: 30.sp, left: 20.sp, right: 20.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Hi,",
                          style: ThemeColor.textStyle12px
                              .copyWith(fontSize: 28, color: Colors.white)),
                      5.wSpace,
                      SizedBox(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 13),
                          child: Text(
                            controller.userName.toString(),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: ThemeColor.textStyle28px
                                .copyWith(fontSize: 28, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /*   RichText(
                    text: TextSpan(
                        text: 'Hi, ',
                        style: ThemeColor.textStyle12px
                            .copyWith(fontSize: 28, color: Colors.white),
                        children: [
                          TextSpan(
                            text: controller.userName.toString(),
                            style: ThemeColor.textStyle28px
                                .copyWith(fontSize: 28, color: Colors.white),
                          )
                        ]),
                  ),*/
                  5.hSpace,
                  labelTextLight(
                      'home_subtitle'.tr, 12, const Color(0xFFAAAAAA))
                ],
              ),
            ),
            InkWell(
              onTap: () {
                controller.redirectToProfileScreen();
              },
              child: Obx(() => SizedBox(
                    width: 50.sp,
                    height: 50.sp,
                    child: createUserNameIcon(
                        controller.userName.value, 80.sp, 80.sp, 20.sp),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCarsCard(int index, String? vehicleImagePath) {
    return Padding(
      padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(40.r)),
        child: Stack(
          children: [
            loadImageFromNetwork(
              vehicleImagePath!, /*200*/
            ),
            bottomDetail(index)
          ],
        ),
      ),
    );
  }

  Widget bottomDetail(int index) {
    return Positioned(
      bottom: 0,
      child: Container(
          width: Get.width,
          alignment: Alignment.center,
          decoration: carListDecoration(),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.sp, vertical: 20.sp),
              child: Column(
                children: [
                  20.hSpace,
                  Row(
                    children: [
                      Expanded(
                          child: labelTextRegular(
                              controller
                                  .listVehicleDetail[index].vehicleCategoryName,
                              18,
                              Colors.white)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          labelTextRegular(
                              controller
                                  .listVehicleDetail[index].vehiclePlateNo,
                              16,
                              Colors.white),
                          5.hSpace,
                          Row(
                            children: [
                              labelTextLight(
                                  controller.listVehicleDetail[index].seat
                                      .toString(),
                                  10,
                                  const Color(0xFFAAAAAA)),
                              verticalDivider(),
                              labelTextLight(
                                  "${controller.listVehicleDetail[index].consumption} km",
                                  10,
                                  const Color(0xFFAAAAAA)),
                            ],
                          )
                        ],
                      ),
                      40.wSpace,
                    ],
                  ),
                ],
              ))),
    );
  }

  Widget verticalDivider() {
    return Container(
      margin: const EdgeInsets.all(8),
      height: 10.sp,
      width: 1.sp,
      color: Colors.white,
    );
  }
}
