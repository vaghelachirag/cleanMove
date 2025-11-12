import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/src/storage_impl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaligram_transport_app/api/repository/api.dart';
import 'package:shaligram_transport_app/ui/driver_screens/profile/profile_controller.dart';
import 'package:shaligram_transport_app/ui/passenger/home/settings/settings_view_controller.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import '../routes/app_routes.dart';
import '../utils/theme_color.dart';

InputDecoration inputDecorationWithBorder(getHint) {
  return InputDecoration(
    labelText: getHint,
    labelStyle: const TextStyle(color: ThemeColor.BLACK),
    hintText: getHint,
    filled: true,
    alignLabelWithHint: true,
    fillColor: ThemeColor.EmailBg,
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: ThemeColor.DARK_GRAY),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: ThemeColor.DARK_GRAY),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: ThemeColor.DARK_GRAY),
    ),
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
        )),
    errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: ThemeColor.DARK_GRAY)),
    focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: ThemeColor.DARK_GRAY)),
    hintStyle: TextStyle(fontSize: 14.sp, color: ThemeColor.BLACK),
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );
}

 BuildContext buildContext = Get.context as BuildContext;

// For Internet Connection
Future<bool> isConnectedToInternet() async {
 var isInternetConnected = await SimpleConnectionChecker.isConnectedToInternet();
  return isInternetConnected;
}


showSnakeBar(BuildContext context, String msg) {
  if(!Get.isSnackbarOpen) {
    Get.rawSnackbar(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        duration: const Duration(milliseconds: 1000),
        message: msg,
        borderRadius: 8,
        messageText: Text(
          "$msg", style: TextStyle(fontSize: 15, color: ThemeColor.primaryColor),),
        backgroundColor: ThemeColor.greenShade,
        snackPosition: SnackPosition.TOP,
        isDismissible: true
    );
  }
}

// For Internet Connection
Future<String> getUserName(GetStorage getStorage) async {
 var userName = getStorage.read(AppConstant.profileName);
  return userName;
}

InputDecoration inputDecorationWithBorderWithIcon(String hint, dynamic iconName, Color strokeColor, Color backgroundColor) {
  return InputDecoration(
    prefixIcon: GestureDetector(
      child: Image.asset(iconName, width: 10, height: 10),
    ),
    labelText: "",
    labelStyle: const TextStyle(color: ThemeColor.EmailTextColor),
    hintText: hint,
    filled: true,
    fillColor: backgroundColor,
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
        )),
    errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: Colors.red)),
    hintStyle: TextStyle(fontSize: 14.sp, color:ThemeColor.EmailTextColor),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorStyle: const TextStyle(
      color: Colors.red,
    ),
  );
}

InputDecoration inputDecorationWithoutBorderWithoutIcon(String hint, dynamic iconName, Color strokeColor, Color backgroundColor) {
  return InputDecoration(
    labelText: "",
    labelStyle: const TextStyle(color: ThemeColor.EmailTextColor),
    hintText: "",
    filled: true,
    fillColor: backgroundColor,
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          width: 1,
        )),
    errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(width: 1, color: Colors.red)),
    hintStyle: TextStyle(fontSize: 14.sp, color:ThemeColor.EmailTextColor),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorStyle: const TextStyle(
      color: Colors.red,
    ),
  );
}

InputDecoration inputDecorationWithBorderWithIconPassword(String hint, dynamic iconName,
    bool isShowPassword, Color strokeColor, Color backgroundColor, Function toggleObscured) {
  return InputDecoration(
    prefixIcon: GestureDetector(
      // onTap: () {},
      child: Image.asset(iconName, width: 10, height: 10),
    ),
    suffixIcon: Visibility(
        child: GestureDetector(
          onTap: () { toggleObscured();},
          child: isShowPassword ? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.remove_red_eye_sharp),
        )),
    labelText: "",
    labelStyle: const TextStyle(color: ThemeColor.EmailTextColor),
    hintText: hint,
    filled: true,
    fillColor: backgroundColor,
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
        )),
    errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: Colors.red)),
    hintStyle: TextStyle(fontSize: 14.sp, color: ThemeColor.EmailTextColor),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorStyle: const TextStyle(
      color: Colors.red,
    ),
  );
}

InputDecoration inputDecorationWithBorderWithoutIconPassword(String hint, dynamic iconName,
    bool isShowPassword, Color strokeColor, Color backgroundColor, Function toggleObscured) {
  return InputDecoration(
    labelText: "",
    labelStyle: const TextStyle(color: ThemeColor.EmailTextColor),
    hintText: hint,
    filled: true,
    fillColor: backgroundColor,
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(
          width: 1,
        )),
    errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(width: 1, color: Colors.red)),
    hintStyle: TextStyle(fontSize: 12.sp, color: ThemeColor.EmailTextColor),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorStyle: const TextStyle(
      color: Colors.red,
    ),
  );
}

InputDecoration inputDecorationWithBorderWithIconWithRadius(String hint, dynamic iconName,
    bool isEyeShow, Color strokeColor, Color backgroundColor, double radius, Function onPrefixIconTap) {
  return InputDecoration(
    prefixIcon: GestureDetector(
      onTap: () {onPrefixIconTap();},
      child: Image.asset(iconName, width: 10, height: 10),
    ),
    suffixIcon: Visibility(
        visible: isEyeShow,
        child: GestureDetector(
          child: const Icon(Icons.remove_red_eye_sharp),
        )),
    labelText: "",
    labelStyle: const TextStyle(color: ThemeColor.EmailTextColor),
    hintText: hint,
    filled: true,
    fillColor: backgroundColor,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      borderSide: BorderSide(width: 1, color: strokeColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      borderSide:  BorderSide(width: 1, color: strokeColor),
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        borderSide: const BorderSide(
          width: 1,
        )),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        borderSide: BorderSide(width: 1, color: strokeColor)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        borderSide: BorderSide(width: 1, color: strokeColor)),
    hintStyle: TextStyle(fontSize: 14.sp, color: ThemeColor.EmailTextColor),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(vertical: 15),
    errorStyle: const TextStyle(
      color: Colors.red,
    ),
  );
}

Text labelTextBold(hint, double fontSize, Color labelTextColor) {
  return  Text(
    hint,
    style: TextStyle(
        color: labelTextColor,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(fontSize),
        fontFamily: AppConstant.labelFrontBold),
  );
}

Text labelTextRegular(hint, double fontSize, Color labelTextColor) {
  return  Text(
    hint,
    style: TextStyle(
        color: labelTextColor,
        fontWeight: FontWeight.w500,
        fontSize: ScreenUtil().setSp(fontSize),
        fontFamily: AppConstant.labelFrontRegular),
  );
}

Text labelTextLight(hint, double fontSize, Color labelTextColor) {
  return
    Text(
    hint,
    style: TextStyle(
        color: labelTextColor,
        fontWeight: FontWeight.w400,
        fontSize:   ScreenUtil().setSp(fontSize),
        fontFamily: AppConstant.labelFrontLight),
  );
}

Container topHeader() {
  return Container(
    height: 200.0,
    decoration: const BoxDecoration(
        color: ThemeColor.kBackgroundColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
  );
}

ScrollConfiguration scrollviewConfigure(Widget child){
  return  ScrollConfiguration(behavior:  const ScrollBehavior().copyWith(overscroll: false), child: child);
}

BoxDecoration loginBgDecoration() {
  return  const BoxDecoration(
    gradient: LinearGradient(
        colors: [
          Color(0xFFFFFFFF),
          Color(0x33FFFFFF),
        ],
        begin: FractionalOffset(0.0, 1.0),
        end: FractionalOffset(0.0, 0.0),
        stops: [0.5, 1.0],
        tileMode: TileMode.clamp),
  );
}

BoxDecoration carListDecoration(){
  return  BoxDecoration(
    gradient: LinearGradient(
        colors: [
          Colors.black,
          Colors.black.withOpacity(0.0),
        ],
        begin: const FractionalOffset(0.0, 1.0),
        end: const FractionalOffset(0.0, 0.0),
        stops: const [0.5, 1.0],
        tileMode: TileMode.clamp),
  );
}

BoxDecoration buildRoundDecoration(Color color){
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 2), // changes position of shadow
      ),
    ],
  );
}

BoxDecoration buildProfileDecoration(double radius){
  return BoxDecoration(
      color: const Color(0xFFF3F3F3),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(color: const Color(0xFFE2E2E2), width: 1)
  );
}

AppBar topHeaderWithBackIcon(String title, {bool isHideBackButton = false}) {
  return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: isHideBackButton ? null : InkWell(
        onTap: () {
          Get.back();
        },
        child: Image.asset('${AppConstant.assestPathIcon}icon_back.png'),
      ),
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          labelTextRegular(title, 16, ThemeColor.darkTextColor)
        ],
      ));
}

Widget buildLocation(String startAddress, endAddress) {
  return Row(
    children: <Widget>[
      Column(
        children: [
          Image.asset("${AppConstant.assestPath}start_location_icon.png"),
          Image.asset("${AppConstant.assestPath}dash_line_icon.png"),
          Image.asset("${AppConstant.assestPath}destination_icon.png"),
        ],
      ),
      8.wSpace,
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            labelTextLight("start_location".tr, 11, ThemeColor.lightTextColor),
            labelTextRegular( startAddress, 13, ThemeColor.primaryColor),
            10.hSpace,
            labelTextLight("destination".tr, 11, ThemeColor.lightTextColor),
            labelTextRegular("$endAddress", 13, ThemeColor.primaryColor),
          ],
        ),
      )
    ],
  );
}

Widget loadImageFromNetwork(String imagePath,/* int height*/){

  return  FadeInImage.assetNetwork(
   // height: height.sp,
    width: Get.width,
    fit: BoxFit.cover,
    imageErrorBuilder:
        (context, error, stackTrace) {
      return Image.asset(
          '${AppConstant.assestPath}car_placeholder.png',
          fit: BoxFit.fitWidth);
    },
    placeholder: '${AppConstant.assestPath}car_placeholder.png',
    image: Api.baseUrl+ imagePath ,
  );


}

showLogoutDialogDriver(BuildContext context, GetStorage getStorage, ProfileController controller) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Get.back();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {
      Get.back();
      controller.requestToLogout();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.r))
  ),
    content: const Text("Are You Sure want to Logout?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}


showLogoutDialogPassenger(BuildContext context, GetStorage getStorage, SettingViewController controller) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
     Get.back();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {
      controller.requestToLogout();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r))
    ),
    content: const Text("Are You Sure want to Logout?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}

void addWayPointMarker(LatLng latLng, int? pickUpOrder, RxList<MarkerData> customMarkers) async{
  MarkerData wayPoint = await createMarker(latLng, "Way Point", pickUpOrder.toString());
  customMarkers.add(wayPoint);
}


showTokenExpireDialog(BuildContext context, GetStorage getStorage) {

  Widget continueButton = TextButton(
    child: const Text("Ok"),
    onPressed: () {
      getStorage.remove(AppConstant.keepMeLogin);
      Get.offAllNamed(Routes.login);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r))
    ),
    content: const Text("Your Token has been expired, please Login Again!"),
    actions: [
      continueButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

}

// this is where you would do your fullscreen loading
startLoading()  {

  return  showDialog<void>(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const SimpleDialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent, // can change this to your prefered color
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(ThemeColor.profileBgBorder)),
          )
        ],
      );
    },
  );
}

redirectToHome(int roleId){
  if(roleId == AppConstant.roleIdPassenger){
    Get.offAndToNamed(Routes.passengerHome);
  }
  else{

   // Get.offAndToNamed(Routes.home);
    Get.offAndToNamed(Routes.home);
  }
}

stopLoading()  {

  Get.back();
}

checkAuthError(String message) {
  if(message == AppConstant.authError){
    showTokenExpireDialog(buildContext, GetStorage(AppConstant.storageName));
  }
  else{
    showSnakeBar(buildContext,message);
}
}


errorHandler(Response response) {
  switch (response.statusCode) {
    case 201:
    case 200: {
      return response;
    }
    case 500:
      throw "Server Error pls retry later";
    case 401:
      throw AppConstant.authError;
    case 403:
      throw 'Error occurred pls check internet and retry.';
    default:
      throw 'Error occurred retry';
  }
}




