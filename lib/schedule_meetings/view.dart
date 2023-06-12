import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/responsive_widget.dart';
import 'controller.dart';
import 'small.dart';

class MeetingView extends StatelessWidget {

  MeetingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MeetingController>(
      init: MeetingController(),
      didChangeDependencies: (state) {
        // state.controller?.getMeetings(email);
      },
      builder: (controller) {
        return ResponsiveWidget(
          smallScreen: Small(
            controller: controller,
          ),
          /*largeScreen: Large(
            controller: controller,
          ),
          mediumScreen: Medium(controller: controller),*/
        );
      },
    );
  }
}
