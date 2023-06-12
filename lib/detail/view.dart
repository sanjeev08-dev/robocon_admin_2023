import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/responsive_widget.dart';
import 'controller.dart';
import 'small.dart';

class DetailView extends StatelessWidget {
  String email;
  DetailView({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: DetailController(),
      didChangeDependencies: (state) {
        state.controller?.getDetails(email);
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
