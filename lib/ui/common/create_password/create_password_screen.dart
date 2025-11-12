import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/rounded_button.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:shaligram_transport_app/utils/validation.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';
import 'create_password_controller.dart';

class CreatePasswordPage extends GetView<CreatePasswordController> {

  const CreatePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
      decoration: BoxDecoration( color:Colors.white,),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/login_bg.png"),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter),
              ),
              child: Container(
                decoration: loginBgDecoration(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).padding.top + 50,),
                      labelTextBold('create_new_password_title'.tr, 26, ThemeColor.darkTextColor),
                      10.hSpace,
                      labelTextLight("create_new_password_subtitle".tr, 12, ThemeColor.lightTextColor),
                      20.hSpace,
                      labelTextRegular('old_password'.tr, AppConstant.inputLabelSize, ThemeColor.darkTextColor),
                      5.hSpace,
                      Obx(() => TextFormField(
                        controller: controller.oldPasswordTextController,
                        obscureText: !controller.isShowOldPassword.value,
                        enabled: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: inputDecorationWithBorderWithIconPassword(
                            'old_password'.tr,  "${AppConstant.assestPath}lock.png",
                            controller.isShowOldPassword.value,
                            ThemeColor.textFieldBGStrokeColor,
                            ThemeColor.textFieldBGColor,
                                () {
                          controller.isShowOldPassword.value = !controller.isShowOldPassword.value;
                        }),
                      )),
                      20.hSpace,
                      labelTextRegular('new_password'.tr, AppConstant.inputLabelSize, ThemeColor.darkTextColor),
                      5.hSpace,
                      Obx(() => TextFormField(
                        controller: controller.newPasswordTextController,
                        obscureText: !controller.isShowNewPassword.value,
                        enabled: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: inputDecorationWithBorderWithIconPassword(
                            'new_password'.tr,  "${AppConstant.assestPath}lock.png",
                            controller.isShowNewPassword.value,
                            ThemeColor.textFieldBGStrokeColor,
                            ThemeColor.textFieldBGColor, () {
                          controller.isShowNewPassword.value = !controller.isShowNewPassword.value;
                        }),
                      )),
                      20.hSpace,
                      labelTextRegular('confirm_new_password'.tr, AppConstant.inputLabelSize, ThemeColor.darkTextColor),
                      5.hSpace,
                      Obx(() => TextFormField(
                        controller: controller.confirmNewPasswordTextController,
                        obscureText: !controller.isShowConfirmNewPassword.value,
                        enabled: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: inputDecorationWithBorderWithIconPassword(
                            'confirm_new_password'.tr,
                            "${AppConstant.assestPath}lock.png",
                            controller.isShowConfirmNewPassword.value,
                            ThemeColor.textFieldBGStrokeColor,
                            ThemeColor.textFieldBGColor, () {
                          controller.isShowConfirmNewPassword.value = !controller.isShowConfirmNewPassword.value;
                        }),
                        validator: (pwd) {
                          return Validation.validateConfirmPassword(pwd, controller.newPasswordTextController.text);
                        },
                      )),
                      26.hSpace,
                      Obx(
                        () =>  RoundedButton(
                          isLoading: controller.isLoading.value,
                            isEnable: true, text: "reset_password_CTA".tr, onTap: controller.requestToResetPassword,fontSize: AppConstant.buttonSize),
                      ),
                      10.hSpace,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back)),
            ),
          ],
        ),
      ),
    );
  }
}
