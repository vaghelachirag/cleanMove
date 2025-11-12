import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassengerHomeController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabController;
  RxInt selectedTabIndex = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
