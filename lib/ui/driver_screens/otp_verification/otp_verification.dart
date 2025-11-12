import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/provider/driver/Otp/GetVerifyOTPProvider.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';

import '../../../utils/appConstant.dart';
import '../../../utils/rounded_button.dart';
import '../../../utils/theme_color.dart';
import '../../../widget/common_widget.dart';
import 'otp_controller.dart';

class OtpVerification extends GetView<OtpController> {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GetVerifyOTPProvider>(() => GetVerifyOTPProvider());
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
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
                        40.hSpace,
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                              '${AppConstant.assestPathIcon}icon_back.png'),
                        ),
                        50.hSpace,
                        labelTextBold(
                            "otp_title".tr, 26, ThemeColor.darkTextColor),
                        10.hSpace,
                        labelTextLight(
                            "otp_subtitle".tr, 12, ThemeColor.lightTextColor),
                        20.hSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _textFieldOTP(
                                context, true, false, controller.otp1),
                            _textFieldOTP(
                                context, false, false, controller.otp2),
                            _textFieldOTP(
                                context, false, false, controller.otp3),
                            _textFieldOTP(
                                context, false, false, controller.otp4),
                            _textFieldOTP(
                                context, false, true, controller.otp5),
                          ],
                        ),
                        5.hSpace,
                        20.hSpace,
                        Obx(
                          () =>  Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: RoundedButton(
                              isLoading: controller.isLoading.value,
                                isEnable: true,
                                text: "Verify".tr,
                                onTap: () {
                                  controller.otpVerification();
                                },
                                fontSize: AppConstant.buttonSize),
                          ),
                        ),
                        30.hSpace,
                        Obx(() => Visibility(
                            visible: controller.resendOTP.value == false,
                            child: Align(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Second Remaining : '.tr,
                                      style: ThemeColor.textStyle14px.copyWith(
                                          fontSize: 12.sp,
                                          color: ThemeColor.darkTextColor,
                                          fontWeight: FontWeight.w300),
                                      children: [
                                        TextSpan(
                                            text: controller.timerTime.value
                                                .toString(),
                                            style: ThemeColor.textStyle14px
                                                .copyWith(
                                                    fontSize: 12.sp,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {}),
                                      ]),
                                )))),
                        20.hSpace,
                        Obx(() => Visibility(
                            visible: controller.resendOTP.value == true,
                            child: Align(
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(
                                      text: 'notgetOTP'.tr,
                                      style: ThemeColor.textStyle14px.copyWith(
                                          fontSize: 12.sp,
                                          color: ThemeColor.darkTextColor,
                                          fontWeight: FontWeight.w300),
                                      children: [
                                        TextSpan(
                                            text: ' Resend OTP',
                                            style: ThemeColor.textStyle14px
                                                .copyWith(
                                                    fontSize: 12.sp,
                                                    color: ThemeColor
                                                        .darkTextColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                controller.startTimer();
                                              }),
                                      ]),
                                )))),
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

  Widget _textFieldOTP(BuildContext context, bool? first, bool? last,
      TextEditingController otp1) {
    return SizedBox(
      height: 63,
      child: AspectRatio(
        aspectRatio: 0.9,
        child: TextField(
          controller: otp1,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: 1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            counter: const Offstage(),
            fillColor: const Color(0xFFF3F3F3),
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 0.5, color: Colors.black12),
                borderRadius: BorderRadius.circular(18)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 0.5, color: ThemeColor.EmailBg),
                borderRadius: BorderRadius.circular(18)),
          ),
        ),
      ),
    );
  }
}
