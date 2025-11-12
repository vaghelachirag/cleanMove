import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/provider/common/AddFCMTokenProvider.dart';
import 'package:shaligram_transport_app/ui/common/login/login_contoller.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/rounded_button.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:shaligram_transport_app/utils/validation.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';


class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<AddFCMTokenProvider>(() => AddFCMTokenProvider());
   //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return  WillPopScope(
      onWillPop: () async  {
        SystemNavigator.pop();
        return false;
      },
      child: Container(
        color: ThemeColor.backgroundColor,
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
                    decoration: loginBgDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          100.hSpace,
                          labelTextBold("login_title".tr, 26, ThemeColor.darkTextColor),
                          10.hSpace,
                          labelTextLight("login_subtitle".tr, 12, ThemeColor.lightTextColor),
                          20.hSpace,
                          labelTextRegular('email'.tr, AppConstant.inputLabelSize, ThemeColor.darkTextColor),
                          5.hSpace,
                          TextFormField(
                            controller: controller.emailTextController,
                            obscureText: false,
                            enabled: true,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: inputDecorationWithBorderWithIcon(
                                'email'.tr,
                                "${AppConstant.assestPath}sms.png",
                                ThemeColor.textFieldBGStrokeColor,
                                ThemeColor.textFieldBGColor),
                            validator: (email) {
                              return Validation.validateEmail(email);
                            },
                          ),
                          20.hSpace,
                          labelTextRegular('password'.tr, AppConstant.inputLabelSize, ThemeColor.darkTextColor),
                          5.hSpace,
                          Obx(() => TextFormField(
                            controller: controller.passwordTextController,
                            obscureText: !controller.isShowPassword.value,
                            enabled: true,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: inputDecorationWithBorderWithIconPassword(
                                'password'.tr,
                                "${AppConstant.assestPath}lock.png",
                                controller.isShowPassword.value,
                                ThemeColor.textFieldBGStrokeColor,
                                ThemeColor.textFieldBGColor, () {
                              controller.isShowPassword.value = !controller.isShowPassword.value;
                            }),

                          )),
                          10.hSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      visualDensity: const VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      fillColor: MaterialStateProperty.resolveWith((states) {
                                        if (states.any((element) => element == MaterialState.selected)) {
                                          return ThemeColor.primaryColor;
                                        } else {
                                          return const Color(0xFFF3F3F3);
                                        }
                                      }),
                                      checkColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      side: const BorderSide(
                                          color: Color(0xFFE2E2E2),
                                          width: 1
                                      ),
                                      value: controller.isRememberMe.value,
                                      onChanged: (value) {
                                         controller.changeRememberMe(value);
                                      }),
                                  2.wSpace,
                                  labelTextRegular("remember_me".tr, 12, ThemeColor.darkTextColor),
                                ],
                              )),

                            //  const Spacer(),
                              InkWell(
                                  onTap: controller.requestToForgotPassword,
                                  child:  labelTextRegular("forgot_password".tr, 12, ThemeColor.darkTextColor)),
                            ],
                          ),
                          20.hSpace,
                          Obx(
                            () =>  RoundedButton(
                              isLoading: controller.isLoading.value,
                                isEnable: true, text: "login_CTA".tr, onTap: controller.requestToCreatePassword,fontSize: AppConstant.buttonSize),
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
      ),
    );
  }
}
