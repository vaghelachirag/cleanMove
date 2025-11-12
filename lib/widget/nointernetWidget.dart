import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/appConstant.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetryClick;
  const NoInternetWidget({super.key, 
    required this.onRetryClick
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            width: Get.width * 0.5,
            height: Get.height / 2,
            child: Image.asset(
              '${AppConstant.assestPath}no_internet.png',
              fit: BoxFit.contain,
            ),
          ),
          const Text("No Internet!",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.none),)
        ],
      ),
    );
  }

}