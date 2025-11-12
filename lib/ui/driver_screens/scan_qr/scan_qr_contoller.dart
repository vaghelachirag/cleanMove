import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRController extends GetxController {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;


  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {

    });
  }

  void onPermissionSet(QRViewController ctrl, bool p) {
    if (!p) {
      Get.snackbar(
        'Alert!!',
        'no Permission',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        borderRadius: 13,
        backgroundColor: Colors.greenAccent,
      );
    }
  }

  @override
  void onReady() {
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  @override
  void onDetached() {
    controller?.dispose();
  }
}
