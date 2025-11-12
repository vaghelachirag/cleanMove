import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/common/forgot_password/forgot_password_controller.dart';
import 'package:shaligram_transport_app/utils/rounded_button.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:shaligram_transport_app/utils/validation.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';

import '../../../utils/appConstant.dart';


class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.primaryColor,
      child: Scaffold(
        backgroundColor: ThemeColor.backgroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login_bg.png"),
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0x33FFFFFF),
                        ],
                        begin: FractionalOffset(0.0, 1.0),
                        end: FractionalOffset(0.0, 0.0),
                        stops: [0.5, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(18.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        30.hSpace,
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                            child: const Icon(Icons.arrow_back)),
                        60.hSpace,
                        labelTextBold('forgot_your_password_title'.tr, 26, ThemeColor.darkTextColor),
                        10.hSpace,
                        labelTextLight('forgot_your_password_subtitle'.tr, 12, ThemeColor.lightTextColor),
                        20.hSpace,
                        labelTextRegular('email'.tr, AppConstant.inputLabelSize, ThemeColor.darkTextColor),
                        8.hSpace,
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
                          validator: (email) {
                            return Validation.validateEmail(email);
                          },
                        ),
                        24.hSpace,
                        Obx(
                          () =>  RoundedButton(
                            isLoading: controller.isLoading.value,
                              isEnable: true, fontSize: AppConstant.buttonSize,  text: "continue_CTA".tr, onTap: controller.requestForgotPassword),
                        ),
                        30.hSpace,
                        Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(text: 'remember_password'.tr,
                                  style: ThemeColor.textStyle14px.copyWith(fontSize: 12.sp, color: ThemeColor.darkTextColor),
                                  children: [
                                    TextSpan(
                                      text: ' Login',
                                     style: ThemeColor.textStyle14px.copyWith(fontSize: 12.sp, color: ThemeColor.darkTextColor, fontWeight: FontWeight.w600),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          controller.redirectToLogin() ;
                                        }
                                        ),
                                  ]),
                            )
                        ),
                        20.hSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
