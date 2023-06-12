import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/responsive_widget.dart';
import 'controller.dart';
import 'small.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
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
