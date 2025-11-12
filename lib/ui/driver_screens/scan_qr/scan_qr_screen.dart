import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shaligram_transport_app/ui/driver_screens/scan_qr/scan_qr_contoller.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';

import '../../../routes/app_routes.dart';


class ScanQRPage extends GetView<ScanQRController> {
  const ScanQRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 230.0.sp
        : 280.0.sp;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        color: ThemeColor.backgroundColor,
        child: Scaffold(
          backgroundColor: ThemeColor.backgroundColor,
          body: Stack(
            children: [
              QRView(
                key: controller.qrKey,
                cameraFacing: CameraFacing.back,
                overlay: QrScannerOverlayShape(
                    borderColor: Colors.white,
                    overlayColor: Colors.black87,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: scanArea),
                onPermissionSet: (ctrl, p) => controller.onPermissionSet(ctrl, p),
                onQRViewCreated: (qrViewController) {
                  controller.onQRViewCreated(qrViewController);
                },
              ),
              Column(
                children: [
                  30.hSpace,
                  InkWell(
                    onTap: () {
                      Get.offAndToNamed(Routes.trip);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                  60.hSpace,
                  Text("scan_the_qr_code_to_start".tr, textAlign: TextAlign.center, style: ThemeColor.textStyle28px.copyWith(color: Colors.white))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
