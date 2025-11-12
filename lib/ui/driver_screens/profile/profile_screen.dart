import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/provider/common/GetLogoutProvider.dart';
import 'package:shaligram_transport_app/provider/driver/GetDriverDetailProvider.dart';
import 'package:shaligram_transport_app/ui/driver_screens/profile/profile_controller.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';

import '../../../utils/appConstant.dart';
import '../../../utils/rounded_button.dart';
import '../../../utils/theme_color.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GetDriverDetailProvider>(() => GetDriverDetailProvider());
    Get.lazyPut<GetLogoutProvider>(() => GetLogoutProvider());
    return  FocusDetector(
        onFocusGained: (){
          controller.getProfileDetail();
        },
        onForegroundLost: () {},
        child:
      scrollviewConfigure(
      Container(
          decoration: const BoxDecoration(color: ThemeColor.backgroundColor),
          child: Scaffold(
            backgroundColor: ThemeColor.backgroundColor,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset('${AppConstant.assestPathIcon}icon_back.png'),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    labelTextRegular("profile_title".tr, 16, ThemeColor.darkTextColor)
                  ],
                )
            ),
           // appBar: topHeaderWithBackIcon("profile_title".tr , isHideBackButton: true),
            body:   SafeArea(
                  child: Column(
                children:  [ Obx(() =>buildCarDetail())],
              )),

          ))),
    );
  }

  Widget buildCarDetail() {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.only(
        left: 30.sp,
        right: 30.sp,
      ),
      child: Column(children: [
        30.hSpace,

        Center(
          child: Container(
              padding: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(
                border: Border.all(color: ThemeColor.profileBgBorder),
                borderRadius: BorderRadius.all(Radius.circular(90.r)),
              ),
              child: SizedBox(
                child: createUserNameIcon(controller.userName.value,80.sp,80.sp,15.sp),
              )),
        ),
        15.hSpace,
        labelTextRegular("${controller.firstName} ${controller.lastName}", 15, ThemeColor.darkTextColor),
        3.hSpace,
        labelTextLight(controller.address.toString(), 12, ThemeColor.lightTextColor),
        25.hSpace,
        Visibility(
          visible: false,
            child:
        SizedBox(
          width: 128.sp,
          child: RoundedButton(
            isEnable: true,
            text: "edit_profile_CTA".tr,
            fontSize: AppConstant.buttonSize,
            onTap: () {},
          ),
        )),
        20.hSpace,
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ThemeColor.disableColor, width: 0.1),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Obx(() => ListView.separated(
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
              color: ThemeColor.lightTextColor.withOpacity(.2),
            ),
            itemCount: controller.listProfileData.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                },
                child: buildVehicleDetail(index,context),
              );
            },
          )),
        )
      ]),
    ));
  }

  Widget buildVehicleDetail(int index, BuildContext context) {
    return InkWell(
      splashColor: ThemeColor.disableColor,
      onTap: () {
        if (index == 0) {
          controller.redirectToChangePassword();
        }
        if (index == 1) {
          controller.requestToChangeLanguage();
        }
        if(index == 2){
         showLogoutDialogDriver(context,GetStorage(AppConstant.storageName),controller);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(0.0),
        child: SizedBox(
            width: Get.width,
            child: Row(
              children: [
                Image(
                    image: AssetImage(AppConstant.assestPathIcon +
                        controller.listProfileData[index].icons)),
                15.wSpace,
                Expanded(
                  child: labelTextLight(controller.listProfileData[index].titles, 14,
                      ThemeColor.darkTextColor),
                ),
                controller.listProfileData[index].languageData != null ?
                labelTextBold(controller.listProfileData[index].languageData, 14, ThemeColor.lightTextColor) :
                0.wSpace,
              ],
            )),
      ),
    );
  }
}
