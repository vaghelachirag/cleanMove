import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';


class CustomBottomSheet extends StatefulWidget {

  List<Widget> slivers;


  CustomBottomSheet({super.key , required this.slivers});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {

  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
        return DraggableScrollableSheet(
          key: _sheet,
          initialChildSize: 0.4,
          maxChildSize: 0.7,
          minChildSize: 0.4,
          expand: true,
          snap: true,
          snapSizes: const [0.5],
          controller: _controller,
          builder: (BuildContext context, ScrollController scrollController) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverList.list(
                    children: const [
                      Text('Content'),
                    ],
                  ),
                ]
              ),
            );
          },
        );


  }
}
