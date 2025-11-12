
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/passenger/home/notification/notification_view.dart';
import 'package:shaligram_transport_app/ui/passenger/home/passenger_home_controller.dart';
import 'package:shaligram_transport_app/ui/passenger/home/profile/profile_view.dart';
import 'package:shaligram_transport_app/ui/passenger/home/settings/settings_view.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';

import '../../../widget/fade_indexed_stack.dart';
import 'home_map/home_map_view.dart';

class PassengerHomePage extends GetView<PassengerHomeController> {

  const PassengerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
   // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return WillPopScope(
      onWillPop: () async  {
        SystemNavigator.pop();
        return false;
      },
      child: Container(
        color: ThemeColor.backgroundColor,
        child: SafeArea(
          top: false,bottom: false,
          maintainBottomViewPadding: true,
          child: Obx(() => Scaffold(
            backgroundColor: ThemeColor.backgroundColor,
            body: FadeIndexedStack(
              index: controller.selectedTabIndex.value,
              children:  [
                HomeMapView(),
                const ProfileView(),
                 const NotificationView(),
                const SettingsView()
              ],
            ),
            bottomNavigationBar: buildTabContainer(context),
          )),
        ),
      ),
    );
  }

  // TabBar Container
  Widget buildTabContainer(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: buildTabBar(context),
    );
  }

  // TabBar Widget
  Widget buildTabBar(BuildContext context){
    return TabBar(
        controller: controller.tabController,
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom == 0.sp ? 10.sp : MediaQuery.of(context).padding.bottom + 10.sp, top: 10.sp, right: 10.sp, left: 10.sp),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50.sp),
            color: ThemeColor.primaryColor
        ),
        onTap: (value) {

        },
        tabs: [
          Tab(
            icon: controller.selectedTabIndex.value == 0 ? Image.asset("${AppConstant.assestPath}home_tab_icon.png", width: 24.sp, height: 24.sp, color: Colors.white) : Image.asset("${AppConstant.assestPath}home_tab_icon.png", width: 24.sp, height: 24.sp),
          ),
          Tab(
            icon: controller.selectedTabIndex.value == 1 ? Image.asset("${AppConstant.assestPath}profile_tab_icon.png", width: 24.sp, height: 24.sp, color: Colors.white) : Image.asset("${AppConstant.assestPath}profile_tab_icon.png", width: 24.sp, height: 24.sp),
          ),
          Tab(
            icon: controller.selectedTabIndex.value == 2 ? Image.asset("${AppConstant.assestPath}notification_tab_icon.png", width: 24.sp, height: 24.sp, color: Colors.white) : Image.asset("${AppConstant.assestPath}notification_tab_icon.png", width: 24.sp, height: 24.sp),
          ),
          Tab(
            icon: controller.selectedTabIndex.value == 3 ? Image.asset("${AppConstant.assestPath}setting_tab_icon.png", width: 24.sp, height: 24.sp, color: Colors.white) : Image.asset("${AppConstant.assestPath}setting_tab_icon.png", width: 24.sp, height: 24.sp),
          ),
        ]);
  }
}
