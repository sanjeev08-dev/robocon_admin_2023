import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/meeting_model.dart';
import '../helper/responsive_widget.dart';
import 'controller.dart';
import 'large.dart';
import 'medium.dart';
import 'small.dart';

class LogsView extends StatelessWidget {
  MeetingModel? model;
  LogsView({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogsController>(
      init: LogsController(),
      didChangeDependencies: (state){
        state.controller?.setDatesList(model);
      },
      builder: (controller) {
        return ResponsiveWidget(
          smallScreen: Small(
            controller: controller,
          ),
          largeScreen: Large(
            controller: controller,
          ),
          mediumScreen: Medium(controller: controller),
        );
      },
    );
  }
}
