import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/models/passenger/notification/getPassengerNotificationDetail.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';
import '../../../../utils/theme_color.dart';
import 'notification_view_controller.dart';

class NotificationView extends GetView<NotificationViewController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
        onFocusGained: () {
          controller.loadNotification();
        },
        onForegroundLost: () {},
        child: Container(
            color: ThemeColor.backgroundColor,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: ThemeColor.backgroundColor,
                appBar: topHeaderWithBackIcon("notification_title".tr,
                    isHideBackButton: true),
                body: Column(
                  children: [
                    Expanded(child: driverReportContainer(context)),
                  ],
                ),
              ),
            )));
  }

  Widget driverReportContainer(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: ThemeColor.backgroundColor),
      child: Obx(() => controller.isLoading.value
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : controller.notificationList.isEmpty
              ? noData()
              : buildLoadNotificationData()),
    );
  }

  Widget buildNotificationRowHeader(int index) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
          margin:
              const EdgeInsets.only(top: 10, right: 16, left: 25, bottom: 10),
          child: labelTextLight(
              controller.notificationList[index].notificationTitle,
              16,
              const Color(0xFFAAAAAA))),
    );
  }

  Widget noData() {
    return Center(
      child: labelTextRegular("No Data", 16.sp, ThemeColor.darkTextColor),
    );
  }


 Widget buildLoadNotificationData() {
    return  Obx(
          () => controller.dateMap.isNotEmpty ? ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.dateMap.length,
        itemBuilder: (BuildContext context, int index) {
          // String categoryName = controller.newMap.keys.elementAt(index).toString();
          controller.itemsInCategory.value = controller.dateMap[controller.dateMap.keys.elementAt(index)];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.sp, left: 20.sp, bottom: 0),
                child: Text("${controller.dateMap.keys.elementAt(index)}", style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.bold)),
              ),
              5.hSpace,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.itemsInCategory.length,
                itemBuilder: (BuildContext context, int index1) {
                  NotificationList item = controller.itemsInCategory[index1];

                  return     Container(
                    margin: const EdgeInsets.only(top: 5, right: 16, left: 16),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 40.sp,
                            height: 40.sp,
                            decoration: const BoxDecoration(
                              color: ThemeColor.primaryColorLight50,
                              shape: BoxShape.circle,
                            ),
                            child: createUserNameIcon(
                                controller.userName.value, 80.sp, 80.sp, 20.sp),
                          ),
                        ),
                        10.wSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      labelTextRegular(
                                          item
                                              .notificationTitle,
                                          14,
                                          ThemeColor.primaryColor),
                                      4.hSpace,
                                      labelTextLight(
                                          item
                                              .notificationMessage,
                                          12,
                                          ThemeColor.darkTextColor),
                                      4.hSpace,
                                      labelTextRegular(
                                          item.createdDate
                                              .toString(),
                                          14,
                                          ThemeColor.primaryColor),
                                    ],
                                  ),
                                ],
                              ),
                              4.hSpace,
                            ],
                          ),
                        ),
                      ],
                    ),
                  );

                }, ),
            ],
          );
        },
      ) : SizedBox(),
    );


  }






  Widget buildNotificationRowItem(int index) {
    return  Container(
            margin: const EdgeInsets.only(top: 5, right: 16, left: 16),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    width: 40.sp,
                    height: 40.sp,
                    decoration: const BoxDecoration(
                      color: ThemeColor.primaryColorLight50,
                      shape: BoxShape.circle,
                    ),
                    child: createUserNameIcon(
                        controller.userName.value, 80.sp, 80.sp, 20.sp),
                  ),
                ),
                10.wSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labelTextRegular(
                                  controller.notificationList[index]
                                      .notificationTitle,
                                  14,
                                  ThemeColor.primaryColor),
                              4.hSpace,
                              labelTextLight(
                                  controller.notificationList[index]
                                      .notificationMessage,
                                  12,
                                  ThemeColor.darkTextColor),
                              4.hSpace,
                              labelTextRegular(
                                  controller.notificationList[index].createdDate
                                      .toString(),
                                  14,
                                  ThemeColor.primaryColor),
                            ],
                          ),
                        ],
                      ),
                      4.hSpace,
                    ],
                  ),
                ),
              ],
            ),
          );

  }
}


