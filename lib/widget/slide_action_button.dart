import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shaligram_transport_app/utils/appConstant.dart';
import 'package:shaligram_transport_app/utils/theme_color.dart';
import 'package:slide_action/slide_action.dart';

import 'common_widget.dart';

class SlideActionBtn extends StatelessWidget {

  String? buttonText;
  final FutureOr<void> Function()? swipeAction;

  SlideActionBtn({
    Key? key,
    this.buttonText,
    required this.swipeAction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      trackHeight: 50,
      thumbHitTestBehavior: HitTestBehavior.opaque,
      trackBuilder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ThemeColor.primaryColor,
          ),
          child: Center(
            child: labelTextRegular(state.isPerformingAction ? "Loading..." : "$buttonText", AppConstant.buttonSize, ThemeColor.primaryColorLight),
          ),
        );
      },
      thumbBuilder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF459B79),
            border: Border.all(color: const Color(0xFF81D8B4), width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            // Show loading indicator if async operation is being performed
            child: state.isPerformingAction
                ? const CupertinoActivityIndicator(
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
          ),
        );
      },
      action: swipeAction,
    );
  }
}