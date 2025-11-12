import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/provider/common/GetLogoutProvider.dart';
import 'package:shaligram_transport_app/ui/driver_screens/profile/profile_controller.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';

import '../../../../utils/theme_color.dart';
import 'settings_view_controller.dart';

class SettingsView extends GetView<SettingViewController> {
  const SettingsView({super.key});


  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GetLogoutProvider>(() => GetLogoutProvider());
    return WillPopScope(
      onWillPop: () async  {
        SystemNavigator.pop();
        return false;
      },
      child: Container(
          color: ThemeColor.backgroundColor,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: ThemeColor.backgroundColor,
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      labelTextRegular("settings_title".tr ,  16, ThemeColor.darkTextColor)
                    ],
                  )
              ),
             // appBar: topHeaderWithBackIcon("settings_title".tr, isHideBackButton: true),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  decoration: settingDecoration(),
                  child: buildSettingListView(),
                ),
              ),
            ),
          )),
    );
  }

  // Box Decoration for Setting
  BoxDecoration settingDecoration(){
    return  BoxDecoration(
      border:
      Border.all(color: ThemeColor.disableColor, width: 0.1),
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Colors.white,
          blurRadius: 3.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    );
  }

  // Setting ListView
  Widget buildSettingListView(){
    return Obx(() => ListView.separated(
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
        color: ThemeColor.lightTextColor.withOpacity(.2),
      ),
      itemCount: controller.listSettingData.length,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: buildSettingItem(index,context),
        );
      },
    ));
  }

  // Setting List Item
  Widget buildSettingItem(int index, BuildContext context) {
    return InkWell(
      splashColor: ThemeColor.disableColor,
      onTap: () {
        if(index == 2){
          controller.redirectToChangePassword();
        }
        if (index == 3) {
          controller.requestToChangeLanguage();
        }
        if (index == 4) {
         showLogoutDialogPassenger(context,GetStorage(AppConstant.storageName),controller);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(0.0),
        child: SizedBox(
            width: Get.width,
            child:Row(
              children: [
                Image(
                    image: AssetImage(AppConstant.assestPathIcon +
                        controller.listSettingData[index].icons)),
                15.wSpace,
                Expanded(
                  child: labelTextLight(controller.listSettingData[index].titles.tr, 14,
                      ThemeColor.darkTextColor),
                ),
                controller.listSettingData[index].languageData != null ?
                labelTextBold(controller.listSettingData[index].languageData, 14, ThemeColor.lightTextColor) :
                0.wSpace,
              ],
            )
        ),
      ),
    );
  }
}
