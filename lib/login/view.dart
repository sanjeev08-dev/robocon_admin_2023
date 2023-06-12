import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/responsive_widget.dart';
import 'controller.dart';
import 'large.dart';
import 'medium.dart';
import 'small.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
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
