import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shaligram_transport_app/ui/passenger/new_address/new_address_controller.dart';
import 'package:shaligram_transport_app/utils/rounded_button.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:shaligram_transport_app/utils/widget_extenstion.dart';
import 'package:shaligram_transport_app/widget/common_widget.dart';

import '../../../utils/appConstant.dart';

class NewAddressPage extends GetView<NewAddressController> {

  const NewAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.backgroundColor,
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
         // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                  children: [
                    Obx(() => GoogleMap(
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(23.0240488, 72.4874809), zoom: 15),
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      onCameraIdle: controller.onCameraIdleCallBack,
                      onCameraMove: controller.onCameraMoveCallBack,
                      onMapCreated: controller.onGoogleMapController,
                      markers: controller.allMarkers.toSet(),
                    )),
                   /* Positioned(
                      right: 0,
                      left: 0,
                      top: Platform.isIOS ? 40 : 20,
                      child: Card(
                        color: ThemeColor.backgroundColor,
                        margin: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Wrap(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: TextField(
                                      controller: controller.addressLocationTextController,
                                      style: ThemeColor.textStyle14px.copyWith(color: ThemeColor.darkTextColor),
                                      decoration: InputDecoration(
                                          prefixIcon: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Image.asset("${AppConstant.assestPathIcon}icon_back.png", width: 10, height: 10),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              controller.debounceQuery.value = "";
                                              controller.addressLocationTextController.clear();
                                            },
                                            icon: const Icon(Icons.clear),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                          border: InputBorder.none,
                                          hintText: "search_here".tr,
                                          hintStyle: ThemeColor.textStyle14px
                                      ),
                                      onChanged: (txt) {
                                        controller.isListVisible.value = true;
                                        controller.query.value = txt;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Obx(() => controller.debounceQuery.value.isNotEmpty && controller.isListVisible.value ? FutureBuilder(
                              future: controller.debounceQuery.value == "" ? null : controller.placeApiProvider.fetchSuggestions(controller.query.value, Localizations.localeOf(context).languageCode),
                              builder: (context, snapshot) {
                                return snapshot.hasData ?
                                SizedBox(
                                    height: Get.height / 2,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text((snapshot.data![index]).description ?? "", style: ThemeColor.textStyle14px.copyWith(color: ThemeColor.darkTextColor)),
                                          onTap: () {
                                            var placeId = snapshot.data![index].placeId ?? "";
                                            var placeName = snapshot.data![index].description ?? "";
                                            controller.isListVisible.value = false;
                                            controller.addressLocationTextController.text = placeName;
                                            controller.placeApiProvider.getPlaceDetailFromId(placeId, placeName).then((value) {
                                              controller.navigateToPlace(value);
                                            });
                                          },
                                        );
                                      },
                                      itemCount: snapshot.data!.length,
                                    )) : Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: controller.debounceQuery.value.isNotEmpty && controller.isListVisible.value ? Text('Loading...', style: ThemeColor.textStyle14px.copyWith(color: ThemeColor.lightTextColor)) : const SizedBox()
                                );
                              },
                            ) : const SizedBox()),
                          ],
                        ),
                      ),
                    ),*/

                  ]
              ),
            ),
            Container(
              height: Get.height / 2,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                 Expanded(
                   child: ListView(
                     children: [
                      10.hSpace,
                       Row(
                         children: [
                           Expanded(child: labelTextLight("adress_change_request".tr, AppConstant.inputLabelSize, ThemeColor.lightTextColor)),
                           Obx(() => controller.isLoading.value == true ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const SizedBox())
                         ],
                       ),
                       5.hSpace,
                       const Divider(
                         color: ThemeColor.DARK_GRAY,
                         thickness: 0.8,
                       ),
                       16.hSpace,
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           getHouseAndZipcodeWidget(0.0,"House No.",controller.houseNo),
                           getHouseAndZipcodeWidget(15.0,"Zip Code",controller.zipCode)],
                       ),
                       Visibility(
                           visible: false,
                           child:
                           Row(
                             children: [
                               //  Image.asset("${AppConstant.assestPathIcon}icon_address_location.png", width: 20, height: 20),
                               10.wSpace,
                               Expanded(child: Text("Harrow Road", style: ThemeColor.textStyle28px.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
                               Obx(() => controller.isEditAddress.value == false ?
                               InkWell(
                                   splashColor: ThemeColor.disableColor,
                                   onTap: () {
                                     controller.isEditAddress.value = !controller.isEditAddress.value;
                                   },
                                   child: Padding(
                                       padding: const EdgeInsets.all(4.0),
                                       child: Image.asset("${AppConstant.assestPath}edit_location.png", width: 22, height: 22)
                                   )
                               ) :
                               0.wSpace),
                             ],
                           )),
                       15.hSpace,
                       Obx(() =>
                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               //  Image.asset("${AppConstant.assestPathIcon}icon_address_location.png", width: 20, height: 20),
                               Expanded(child:
                               Padding(padding: const EdgeInsets.only(top: 2),child:
                               TextField(
                                 maxLines: 3,
                                   controller: controller.locationTextController,
                                   readOnly: !controller.isEditAddress.value,
                                   style: ThemeColor.textStyle14px.copyWith(color: ThemeColor.lightTextColor),
                                   decoration: InputDecoration(
                                     prefixIcon: /*controller.isEditAddress.value ?*/ Padding(
                                       padding: const EdgeInsets.only(bottom: 30),
                                       child: IconButton(
                                         onPressed: () {
                                           controller.isEditAddress.value = !controller.isEditAddress.value;
                                         },
                                         icon: const Icon(Icons.location_on_outlined , color: ThemeColor.lightTextColor),
                                       ),
                                     ) ,// : 0.wSpace,
                                     isDense: /*controller.isEditAddress.value == true ? false :*/ true,
                                    // contentPadding: EdgeInsets.only(top: 30),
                                     fillColor: ThemeColor.disableColor,
                                     border: /*controller.isEditAddress.value == true ? const OutlineInputBorder() :*/ InputBorder.none,
                                   ),
                                 ),
                               ))
                             ],
                           )
                       ),
                       //labelTextRegular("Kensal Green Backpackers Ltd, 639 Harrow Road, London-NW10 5NU.", AppConstant.inputLabelSize, ThemeColor.darkTextColor),
                       0.hSpace,
                       InkWell(
                         onTap: () {
                           showUploadImageBill(context);
                         },
                         child: DottedBorder(
                           strokeWidth: 1,
                           dashPattern: const [5],
                           borderType: BorderType.RRect,
                           radius: const Radius.circular(12),
                           padding: const EdgeInsets.all(6),
                           color: const Color(0xFFAAAAAA),
                           child: SizedBox(
                             height: 36.sp,
                             child: Center(
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text("upload_bill_CTA".tr, style: ThemeColor.textStyle14px),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ),
                       30.hSpace,
                   
                     /*  Obx(() =>  RoundedButton(
                         onTap: () {
                           if(controller.locationTextController.text == null){
                             showSnakeBar(context, "Please Select Address For Update!");
                           }
                           else if(controller.houseNo.text == ""){
                             showSnakeBar(context, "Please Add House No!");
                           }
                           else if(controller.zipCode.text == ""){
                             showSnakeBar(context, "Please Add Zipcode!");
                           }
                           else if(controller.imageData == null){
                             showSnakeBar(context, "Please Select Image For Address Update!");
                           }
                           else{
                             controller.requestToChangeAddress();
                           }
                         },
                         isLoading: controller.isButton.value,
                         fontSize: AppConstant.buttonSize,
                         isEnable: controller.isConfirmEnable.value,
                         text: "Address Change Request".tr,
                       )),*/
                      // 16.hSpace,
                     ],
                   ),
                 ),
                 Obx(() =>  RoundedButton(
                   onTap: () {
                     if(controller.locationTextController.text == null){
                       showSnakeBar(context, "Please Select Address For Update!");
                     }
                     else if(controller.houseNo.text == ""){
                       showSnakeBar(context, "Please Add House No!");
                     }
                     else if(controller.zipCode.text == ""){
                       showSnakeBar(context, "Please Add Zipcode!");
                     }
                     else if(controller.imageData == null){
                       showSnakeBar(context, "Please Select Image For Address Update!");
                     }
                     else{
                       controller.requestToChangeAddress();
                     }
                   },
                   isLoading: controller.isButton.value,
                   fontSize: AppConstant.buttonSize,
                   isEnable: controller.isConfirmEnable.value,
                   text: "Address Change Request".tr,
                 )),
                 16.hSpace,
               ],
             ),
             /* child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  10.hSpace,
                  Row(
                    children: [
                      Expanded(child: labelTextLight("adress_change_request".tr, AppConstant.inputLabelSize, ThemeColor.lightTextColor)),
                      Obx(() => controller.isLoading.value == true ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const SizedBox())
                    ],
                  ),
                  5.hSpace,
                  const Divider(
                    color: ThemeColor.DARK_GRAY,
                    thickness: 0.8,
                  ),
                  16.hSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [getHouseAndZipcodeWidget(0.0,"House No.",controller.houseNo),getHouseAndZipcodeWidget(15.0,"Zip Code",controller.zipCode)],
                  ),
                  Visibility(
                      visible: false,
                      child:
                      Row(
                        children: [
                          //  Image.asset("${AppConstant.assestPathIcon}icon_address_location.png", width: 20, height: 20),
                          10.wSpace,
                          Expanded(child: Text("Harrow Road", style: ThemeColor.textStyle28px.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
                          Obx(() => controller.isEditAddress.value == false ?
                          InkWell(
                              splashColor: ThemeColor.disableColor,
                              onTap: () {
                                controller.isEditAddress.value = !controller.isEditAddress.value;
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset("${AppConstant.assestPath}edit_location.png", width: 22, height: 22)
                              )
                          ) :
                          0.wSpace),
                        ],
                      )),
                  15.hSpace,
                  Obx(() =>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //  Image.asset("${AppConstant.assestPathIcon}icon_address_location.png", width: 20, height: 20),
                          Expanded(child:
                          Padding(padding: const EdgeInsets.only(top: 2),child:
                          TextField(
                            controller: controller.locationTextController,
                            readOnly: !controller.isEditAddress.value,
                            style: ThemeColor.textStyle14px.copyWith(color: ThemeColor.lightTextColor),
                            decoration: InputDecoration(
                              suffixIcon: controller.isEditAddress.value ? IconButton(
                                onPressed: () {
                                  controller.isEditAddress.value = !controller.isEditAddress.value;
                                },
                                icon: const Icon(Icons.check),
                              ) : 0.wSpace,
                              isDense: controller.isEditAddress.value == true ? false : true,
                              contentPadding: EdgeInsets.symmetric(horizontal: controller.isEditAddress.value == true ? 10 : 0, vertical: 0),
                              fillColor: ThemeColor.disableColor,
                              border: controller.isEditAddress.value == true ? const OutlineInputBorder() : InputBorder.none,
                            ),
                          )))
                        ],
                      )
                  ),
                  //labelTextRegular("Kensal Green Backpackers Ltd, 639 Harrow Road, London-NW10 5NU.", AppConstant.inputLabelSize, ThemeColor.darkTextColor),
                  0.hSpace,
                  InkWell(
                    onTap: () {
                      showUploadImageBill(context);
                    },
                    child: DottedBorder(
                      strokeWidth: 1,
                      dashPattern: const [5],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(6),
                      color: const Color(0xFFAAAAAA),
                      child: SizedBox(
                        height: 36.sp,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("upload_bill_CTA".tr, style: ThemeColor.textStyle14px),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  30.hSpace,
                  Obx(() =>  RoundedButton(
                    onTap: () {
                      if(controller.locationTextController.text == null){
                        showSnakeBar(context, "Please Select Address For Update!");
                      }
                      else if(controller.houseNo.text == ""){
                        showSnakeBar(context, "Please Add House No!");
                      }
                      else if(controller.zipCode.text == ""){
                        showSnakeBar(context, "Please Add Zipcode!");
                      }
                      else if(controller.imageData == null){
                        showSnakeBar(context, "Please Select Image For Address Update!");
                      }
                      else{
                        controller.requestToChangeAddress();
                      }
                    },
                    isLoading: controller.isButton.value,
                    fontSize: AppConstant.buttonSize,
                    isEnable: controller.isConfirmEnable.value,
                    text: "Address Change Request".tr,
                  )),
                  16.hSpace,
                ],
              ),*/
            ),

          ],

        ),
      ),
    );
  }

 Widget getHouseAndZipcodeWidget(double margin, String header, TextEditingController controller){
    return Container(
      margin: EdgeInsets.only(left: margin),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.only(left: 5),child:labelTextRegular(header, AppConstant.inputLabelSize, ThemeColor.darkTextColor),),
          8.hSpace,
          buildAddressChangeContainer(header,margin,controller),
        ],
      ),
    );
 }
  // Profile List Text
  Widget buildAddressChangeContainer(String profileText, double margin, TextEditingController controller){
    return Container(
        alignment: Alignment.topLeft,
        width: Get.width  * 0.4,
        child:  TextFormField(
          controller: controller,
          enabled: true,
          maxLength: profileText == "House No." ? 30 : 10,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          keyboardType: profileText == "House No." ? TextInputType.text : TextInputType.number,
          decoration: inputDecorationWithBorderWithoutIconPassword(
              profileText,  "${AppConstant.assestPath}lock.png",
              true,
              ThemeColor.textFieldBGStrokeColor,
              ThemeColor.textFieldBGColor, () {
          }),
        )
    );
  }
}

