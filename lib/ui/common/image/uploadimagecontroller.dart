import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';

class UploadImageController extends GetxController {


  RxList<String> languageList = RxList([
    "Camera",
    "Gallery"
  ]);

  RxInt selectedLanguage = RxInt(0);

  void uploadImageFromGallery() async{
    final ImagePicker _picker = ImagePicker();
    final img =
    await _picker.pickImage(source: ImageSource.gallery);
  }

  void uploadImageFromCamera() async{
    final ImagePicker _picker = ImagePicker();
    final img =
    await _picker.pickImage(source: ImageSource.camera);
  }
}