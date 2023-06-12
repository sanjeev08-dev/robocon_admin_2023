import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/responsive_widget.dart';
import 'controller.dart';
import 'large.dart';
import 'medium.dart';
import 'small.dart';

class PublicDetailView extends StatelessWidget {
  String email;
  String? studentName;
  PublicDetailView({Key? key, required this.email, this.studentName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicDetailController>(
      init: PublicDetailController(),
      didChangeDependencies: (state) {
        state.controller?.getDetails(email);
        state.controller?.setStudent(studentName);
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
