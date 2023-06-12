import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/responsive_widget.dart';
import '../widgets/app_drawer.dart';
import 'controller.dart';
import 'small.dart';

class DataListView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  DataListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataListController>(
      init: DataListController(),
      builder: (controller) {
        return ResponsiveWidget(
          smallScreen: Small(
            controller: controller,
            drawerKey: _key,
          ),
          drawer: AppDrawer(
            controller: controller,
          ),
          drawerKey: _key,
          /*largeScreen: Large(
                controller: controller,
              ),
              mediumScreen: Medium(controller: controller),*/
        );
      },
    );
  }
}
