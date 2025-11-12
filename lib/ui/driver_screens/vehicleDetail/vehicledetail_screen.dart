import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/provider/driver/Otp/GetSendOTProvider.dart';
import 'package:shaligram_transport_app/ui/driver_screens/vehicleDetail/vehicledetail_controller.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';
import '../../../utils/appConstant.dart';
import '../../../utils/rounded_button.dart';
import '../../../utils/theme_color.dart';

class VehicleDetailScreen extends GetView<VehicleController> {

  const VehicleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GetSendOTPProvider>(() => GetSendOTPProvider());
    return Container(
        color: ThemeColor.backgroundColor,
        child: Scaffold(
          appBar: topHeaderWithBackIcon("vehicle_details".tr),
          backgroundColor: ThemeColor.backgroundColor,
          body: SafeArea(
              child: Column(
            children: [
              Expanded(child: buildCarDetail()),
              Obx(
                () =>  Padding(
                  padding: EdgeInsets.only(left: 18.sp, right: 18.sp, bottom: 18.sp),
                  child: RoundedButton(
                    isLoading: controller.isLoading.value,
                    isEnable: true,
                    text: "get_otp_CTA".tr,
                    fontSize: AppConstant.buttonSize,
                    onTap: controller.requestToScanQR,
                  ),
                ),
              )
            ],
          )),
        ));
  }

  Widget buildCarDetail() {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
      padding: EdgeInsets.only(
        left: 18.sp,
        right: 18.sp,
      ),
      child: Column(children: [
        30.hSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            alignment: Alignment.center,
            child:
            loadImageFromNetwork(controller.vehicleImageURL!.value!!,/*200*/)
          ),
        ),
        15.hSpace,
        ListView.separated(
          separatorBuilder: (context, index) => 10.hSpace,
          itemCount: controller.listVehicleData.length,
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.only(bottom: 10.sp),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: buildVehicleDetail(index),
            );
          },
        )
      ]),
    ));
  }

  Widget buildVehicleDetail(int index) {
    return Container(
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
      child: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 18.sp, left: 15.sp),
              child: labelTextLight(
                  controller.listVehicleData[index].title, 18, ThemeColor.lightTextColor),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.sp, left: 15.sp, bottom: 18.sp),
              child: labelTextRegular(
                  controller.listVehicleData[index].detail, 14, ThemeColor.darkTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
