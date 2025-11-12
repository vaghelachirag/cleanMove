import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/driver_screens/total_passengers/total_passengers_controller.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import '../../../utils/theme_color.dart';
import '../../../widget/common_widget.dart';

class TotalPassengersPage extends GetView<TotalPassengersController> {

  const TotalPassengersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getTotalPassenger();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: topHeaderWithBackIcon("total_passenger_title".tr),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 20.sp),
          child: Column(
            children: [
              10.hSpace,
              SizedBox(
                height: 50.sp,
                child: TextFormField(
                  obscureText: false,
                  enabled: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: inputDecorationWithBorderWithIconWithRadius(
                      'search'.tr,
                      "assets/images/search_normal_icon.png",
                      false,
                      ThemeColor.textFieldBGStrokeColor,
                      Colors.white,
                      16.r,
                      () {}
                  ),
                ),
              ),
              10.hSpace,
              Expanded(
                child: ListView.builder(
                    itemCount: controller.listPassenger.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var passengerName = "${controller.listPassenger[index].firstName!} ${controller.listPassenger[index].lastName}";
                      var address  = controller.listPassenger[index].pickUpName!;
                      return buildPassengerItem(index, 0,passengerName,address);
                    }),
              )
            ],
          ),
        )
    );
  }

  Widget buildPassengerItem(int index, int selectedIndex, String passengerName, String address) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.sp),
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
              child: createUserNameIcon(passengerName!,80.sp,80.sp,20.sp),
            ),
          ),
          10.wSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelTextRegular(passengerName!!, 16, ThemeColor.darkTextColor),
                labelTextLight(address!!, 12, ThemeColor.lightTextColor)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
