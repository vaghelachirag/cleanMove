import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/rounded_button.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';

import '../../../../provider/getpassengerdetail_provider.dart';
import 'profile_view_controller.dart';

class ProfileView extends GetView<ProfileViewController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GetPassengerDetailProvider>(() => GetPassengerDetailProvider());
    return FocusDetector(
        onFocusGained: () {
          controller.getPassengerDetail();
        },
        onForegroundLost: () {},
        child: Container(
            color: ThemeColor.backgroundColor,
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: ThemeColor.backgroundColor,
                  appBar: topHeaderWithBackIcon("profile_title".tr,
                      isHideBackButton: true),
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Obx(
                      () => Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildProfileIcon(),
                            16.hSpace,
                            Center(
                                child: labelTextRegular(
                                    "${controller.firstName.value} ${controller.lastName.value}",
                                    15,
                                    ThemeColor.darkTextColor)),
                            16.hSpace,
                            labelTextRegular(
                                'full_name'.tr,
                                AppConstant.inputLabelSize,
                                ThemeColor.darkTextColor),
                            8.hSpace,
                            buildProfileContainer(
                                "${controller.firstName.value} ${controller.lastName.value}"),
                            16.hSpace,
                            labelTextRegular(
                                'address'.tr,
                                AppConstant.inputLabelSize,
                                ThemeColor.darkTextColor),
                            8.hSpace,
                            buildProfileContainer(controller.address.value),
                            16.hSpace,
                            labelTextRegular(
                                'current_pick_up_stop'.tr,
                                AppConstant.inputLabelSize,
                                ThemeColor.darkTextColor),
                            8.hSpace,
                            buildProfileContainer(controller.address.value),
                            26.hSpace,
                            buildChangeAddressButton(),
                            26.hSpace,
                          ],
                        ),
                      ),
                    ),
                  )),
            )));
  }

  //  Profile Icon
  Widget buildProfileIcon() {
    return Center(
      child: Container(
          decoration: buildProfileDecoration(60.sp),
          child: createUserNameIcon(
              controller.userName.value, 80.sp, 80.sp, 20.sp)),
    );
  }

  // Profile List Text
  Widget buildProfileContainer(String profileText) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      width: Get.width,
      decoration: buildProfileDecoration(16.r),
      child: Text(profileText, style: ThemeColor.textStyle14px),
    );
  }

  // Address Button
  Widget buildChangeAddressButton() {
    return Obx(
      () =>  RoundedButton(
        isLoading: controller.isLoading.value,
          text: "change_address_CTA".tr,
          fontSize: AppConstant.buttonSize,
          isEnable: true,
          onTap: controller.requestToChangeAddress),
    );
  }
}
