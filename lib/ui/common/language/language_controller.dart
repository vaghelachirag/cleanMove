import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';

class LanguageController extends GetxController {

  GetStorage getStorage;

  LanguageController({required this.getStorage}) {
    loadCurrentLanguage();
  }

  Locale _locale = AppConstant.englishUS;

  Locale get locale => _locale;


  void loadCurrentLanguage() {
    var languageCode = getStorage.read(AppConstant.languageCode) ?? AppConstant.englishUS.languageCode;
    var countryCode = getStorage.read(AppConstant.countryCode) ?? AppConstant.englishUS.countryCode;

    _locale = Locale(languageCode, countryCode);

    if (_locale.toString() == AppConstant.spanishES.toString()) {
       selectedLanguage.value = 1;
    } else if (_locale.toString() == AppConstant.portuguesePT.toString()) {
      selectedLanguage.value = 2;
    } else {
      selectedLanguage.value = 0;
    }

    update();
  }

  RxList<String> languageList = RxList([
    "${AppConstant.englishUS.countryCode?.flagEmoji} English",
    "${AppConstant.spanishES.countryCode?.flagEmoji} Spanish",
    "${AppConstant.portuguesePT.countryCode?.flagEmoji} Portuguese",
  ]);

  RxInt selectedLanguage = RxInt(0);
  RxInt tempStoreIndex = RxInt(0);


  void requestToChangeLanguage() {
    tempStoreIndex.value = selectedLanguage.value;
    if (selectedLanguage.value == 1) {
      setLanguage(AppConstant.spanishES);
    } else if (selectedLanguage.value == 2) {
      setLanguage(AppConstant.portuguesePT);
    } else {
      setLanguage(AppConstant.englishUS);
    }
    Get.back<bool>(result: true);
    languageList.refresh();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void saveLanguage(Locale locale) async {
    getStorage.write(AppConstant.languageCode, locale.languageCode);
    getStorage.write(AppConstant.countryCode, locale.countryCode);
  }

  void profileDetail() async{

  }
}