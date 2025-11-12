import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/reset_password/reset_password_controller.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/rounded_button.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 50,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child:  Padding(
                    padding:  EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                        child: Icon(Icons.arrow_back)),
                  ),
                ), 20.hSpace,

                labelTextBold('Reset Password'.tr, 26, ThemeColor.darkTextColor),
                20.hSpace,
                labelTextRegular('Email', AppConstant.inputLabelSize,
                    ThemeColor.darkTextColor),
                5.hSpace,
                TextFormField(
                  readOnly: true,
                  controller: controller.emailTextController,
                  obscureText: false,
                  enabled: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecorationWithBorderWithIcon(
                      'email'.tr,
                      "assets/images/sms.png",
                      ThemeColor.textFieldBGStrokeColor,
                      ThemeColor.textFieldBGColor),
                ),
                20.hSpace,
                labelTextRegular('new_password'.tr, AppConstant.inputLabelSize,
                    ThemeColor.darkTextColor),
                5.hSpace,
                TextFormField(
                  controller: controller.newPasswordTextController,
                  enabled: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: inputDecorationWithBorderWithIcon(
                      'new_password'.tr,
                      "${AppConstant.assestPath}lock.png",
                      ThemeColor.textFieldBGStrokeColor,
                      ThemeColor.textFieldBGColor),
                ),
                20.hSpace,
                labelTextRegular('reset password', AppConstant.inputLabelSize,
                    ThemeColor.darkTextColor),
                5.hSpace,
                TextFormField(
                  controller: controller.resetpasswordTokenController,
                  enabled: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: inputDecorationWithBorderWithIcon(
                      'reset Password Token',
                      "${AppConstant.assestPath}sms.png",
                      ThemeColor.textFieldBGStrokeColor,
                      ThemeColor.textFieldBGColor),
                ),
                20.hSpace,
              Obx(
                () =>  RoundedButton(
                        isLoading: controller.isLoading.value,
                        isEnable: true, text: "reset_password_CTA".tr, onTap: () {
                         controller.requestToResetPassword();
                        },fontSize: AppConstant.buttonSize),
              ),

                10.hSpace,
              ],
            ),
          ),
        ));
  }
}
