import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/models/driver/report/GetDriverReportResponse.dart';
import 'package:shaligram_transport_app/provider/driver/Report/GetDriverReportListProvider.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import '../../../provider/driver/Report/SaveDriverReportProvider.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/rounded_button.dart';
import '../../../utils/theme_color.dart';
import '../../../widget/common_widget.dart';
import 'driver_report_controller.dart';



class DriverReportScreen extends GetView<DriverReportController> {

  const DriverReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GetDriverReportListProvider>(() =>
        GetDriverReportListProvider());
    Get.lazyPut<SaveDriverReportProvider>(() => SaveDriverReportProvider());
    return FocusDetector(
        onFocusGained: () {
          controller.getDriverReportList();
        },
        onForegroundLost: () {},
        child: Container(
            decoration: const BoxDecoration(color: ThemeColor.backgroundColor),
            child: SafeArea(
              child: Scaffold(
                backgroundColor: ThemeColor.backgroundColor,
                appBar: topHeaderWithBackIcon("driver_report_title".tr),
                body: Column(
                  children: [
                    Expanded(child: Obx(() =>
                    controller.isLoading.value == true
                        ? const Center(child: CupertinoActivityIndicator(),)
                        : controller.listDriverMenuList.isEmpty
                        ? noData()
                        : driverReportContainer())),
                    Obx(
                          () =>
                          Padding(
                            padding:
                            EdgeInsets.only(
                                left: 18.sp, right: 18.sp, bottom: 18.sp),
                            child: RoundedButton(
                              isLoading: controller.isButton.value,
                              isEnable: true,
                              text: "submit_CTA".tr,
                              fontSize: AppConstant.buttonSize,
                              onTap: () {

                                if (controller.listDriverMenuList
                                    .where((p0) => p0.isSelected == true)
                                    .toList()
                                    .isNotEmpty) {
                                  var selectData = controller.listDriverMenuList
                                      .where((p0) => p0.isSelected == true)
                                      .toList();
                                  var strings = selectData.map<String>((e) =>
                                      e.reportText.toString()).toList();
                                  for (var item in selectData) {
                                    controller.driverReportId = item.reportId;
                                  }
                                  String s = strings.join(', ');
                                  print('strings $s');
                                  controller.submitDriverReport(
                                      s, controller.driverReportId);
                                }
                                else {
                                  showSnakeBar(
                                      Get.context!, "Please select Value");
                                }

                              },
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            )));
  }


  Widget noData() {
    return Center(
      child: labelTextRegular("No Data", 16.sp, ThemeColor.darkTextColor),);
  }

  Widget driverReportContainer() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(

          child: Obx(
            () => controller.newMap.isNotEmpty ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.newMap.length,
              itemBuilder: (BuildContext context, int index) {

               // String categoryName = controller.newMap.keys.elementAt(index).toString();

                 controller.itemsInCategory.value = controller.newMap[controller.newMap.keys.elementAt(index)];

                return Column(
                  children: [

                    Container(
                      padding: EdgeInsets.all(10.sp),
                      margin: EdgeInsets.all(15.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.sp, left: 20.sp, bottom: 0),
                            child: Text("${controller.newMap.keys.elementAt(index)}", style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.bold)),
                          ),
                          5.hSpace,
                          Padding(
                            padding: EdgeInsets.only(top: 0.sp, left: 20.sp, bottom: 0),
                            child: Divider(
                              color: Colors.grey.withOpacity(0.50),
                              thickness: 2.0,
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.itemsInCategory.length,
                            itemBuilder: (BuildContext context, int index1) {
                            Datum item = controller.itemsInCategory[index1];
                              return  Container(
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 0.sp, left: 15.sp, bottom: 0),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                              value: item.isSelected ??
                                                  false,
                                              hoverColor: Colors.grey,
                                              side: MaterialStateBorderSide.resolveWith(
                                                    (states) =>
                                                const BorderSide(
                                                    width: 1.0, color: ThemeColor.driverReportCheckBoxBg),
                                              ),
                                              fillColor: MaterialStateProperty.resolveWith((states) {
                                                if (!states.contains(MaterialState.selected)) {
                                                  return ThemeColor.driverReportCheckBoxBg;
                                                }
                                                return null;
                                              }),
                                              //   checkColor: ThemeColor.driverReportCheckBoxBg,
                                              // activeColor: ThemeColor.driverReportCheckBoxBg,
                                              checkColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5.r)),
                                              onChanged: (value) {
                                                // controller.isSelect.value = !controller.isSelect.value;
                                                item.isSelected = !(item.isSelected ??  false);
                                                controller.newMap.refresh();
                                                controller.itemsInCategory.refresh();
                                              //  controller.itemsInCategory.refresh();
                                               // item.refresh();

                                              },
                                            ),

                                          Padding(
                                              padding: EdgeInsets.only(left: 15.sp),
                                              child: labelTextLight(
                                                  item.reportText,
                                                  14, ThemeColor.primaryColorDark))
                                        ],
                                      ))
                              );

                            }, ),
                        ],
                      ),
                    ),
                  ], );
              },
            ) : SizedBox(),
          ),
        );
      },
    );
  }

  Widget buildVehicleDetailHeader(int index) {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          labelTextRegular(
              "Report List", 18, ThemeColor.primaryColorDark),
          const Divider(),
        ],
      ),
    );
  }


}
