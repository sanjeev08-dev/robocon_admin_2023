import 'package:flutter/material.dart';

import '../helper/color_helper.dart';
import '../helper/responsive_widget.dart';
import '../helper/styles.dart';

extension WidgetExtensions on Widget {
  gradientBG(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      height: height(context),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "asset/iit_logo.png",
                    width: width(context) *
                        (ResponsiveWidget.isSmallScreen(context) ? 0.1 : 0.05),
                  ),
                  Image.asset(
                    "asset/robocon_logo.png",
                    width: width(context) *
                        (ResponsiveWidget.isSmallScreen(context) ? 0.2 : 0.1),
                  ),
                  Image.asset(
                    "asset/dd_logo.png",
                    width: width(context) *
                        (ResponsiveWidget.isSmallScreen(context) ? 0.1 : 0.05),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: ResponsiveWidget.isSmallScreen(context) ? 360 : 600,
                  minWidth: ResponsiveWidget.isSmallScreen(context) ? 360 : 600,
                ),
                decoration: BoxDecoration(
                    color: containerColor,
                    border: Border.all(
                      color: borderColor,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: this,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
