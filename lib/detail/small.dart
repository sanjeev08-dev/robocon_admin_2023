import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:robocon_admin_2023/widgets/detail_widget.dart';
import 'package:robocon_admin_2023/widgets/extensions.dart';

import '../helper/styles.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  DetailController controller;

  Small({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controller.isLoading || controller.model.name == null
          ? LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: getWidth(45, context),
            )
          : DetailWidget(
              model: controller.model,
            ),
    ).gradientBG(context);
  }
}
