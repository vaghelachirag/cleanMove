import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shaligram_transport_app/ui/paggination/paggination_controller.dart';
import '../../widget/common_widget.dart';

class Pagination extends GetView<PagginationController> {

  late ScrollController _controller;

  Pagination({super.key});

  @override
  Widget build(BuildContext context) {
    _controller = ScrollController()..addListener(_loadMore);
    // TODO: implement build
    return
      Scaffold(
      backgroundColor: Colors.white,
      appBar: topHeaderWithBackIcon("Paggination"),
      body: Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 20.sp),child:  Column(
        children: [
         Expanded(child:
         Obx(() =>   controller.isFirstLoadRunning.value == true ? const CircularProgressIndicator():
          Padding(
         padding: const EdgeInsets.only(top: 10, bottom: 40),
          child:
          Stack(
            children: <Widget>[
              ListView.builder(
                itemCount: controller.partnerList.length,
                controller: _controller,
                itemBuilder: (_, index) =>  Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 10),
                  child:
                  Padding(padding: const EdgeInsets.all(10),child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${controller.partnerList[index].firstName} ${controller.partnerList[index].lastName}"),
                      Text(controller.partnerList[index].email)
                    ],
                  ) ,)
                  ,
                ),
              ),
             if (controller.isLoadMoreRunning.value == true)
             const Padding(
             padding: EdgeInsets.only(top: 10, bottom: 40),
        child:
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ),
        ),
            ],
          )
         ),
         )),
        ],
      ) ,
    ));
  }

  void _loadMore() async {
     controller.getAllPartnerList(_controller);
  }
}