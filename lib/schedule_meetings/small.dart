import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:robocon_admin_2023/helper/firebase_helper.dart';
import 'package:robocon_admin_2023/helper/flutter_bounce.dart';
import 'package:robocon_admin_2023/helper/meeting_model.dart';
import 'package:robocon_admin_2023/widgets/detail_widget.dart';
import 'package:robocon_admin_2023/widgets/extensions.dart';
import 'package:robocon_admin_2023/widgets/large/button.dart';

import '../helper/responsive_widget.dart';
import '../helper/styles.dart';
import '../widgets/large/text_field_container.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  MeetingController controller;

  Small({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Schedule Meeting",
              style: textStyle(
                context: context,
                isBold: true,
                fontSize: ResponsiveWidget.isSmallScreen(context)
                    ? FontSize.H4
                    : FontSize.H2,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: StreamBuilder<List<MeetingModel>>(
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  List<MeetingModel> dataList = snapshot.data!;
                  print(jsonEncode(snapshot.data!));
                  return dataList.isNotEmpty
                      ? SingleChildScrollView(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                              dataList.length,
                              (index) => Stack(
                                children: [
                                  Bounce(
                                    onPressed: () {
                                      controller
                                          .getAttendance(dataList[index]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.cyan[800],
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dataList[index].date ?? "",
                                            style: textStyle(
                                              context: context,
                                              isBold: true,
                                              fontSize: FontSize.H4,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            dataList[index].agenda ?? "",
                                            style: textStyle(
                                              context: context,
                                              isBold: false,
                                              fontSize: FontSize.H5,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Bounce(
                                      onPressed: () {
                                        controller
                                            .deleteMeetingData(dataList[index]);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red[800],
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                          "No Meeting schedule",
                          style: textStyle(
                              context: context,
                              isBold: true,
                              fontSize: FontSize.H1),
                        ));
                } else {
                  return Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: Theme.of(context).primaryColor,
                      size: width(context) * 0.1,
                    ),
                  );
                }
              },
              stream: FirebaseHelper.getMeetingData(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 2,
            color: Colors.black12,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextFieldContainer(
                  textEditingController: controller.agendaController,
                  hint: "Enter Agenda",
                  isLastField: false,
                  keyboardType: TextInputType.text,
                  title: 'Enter Agenda *',
                ),
              ),
              Bounce(
                onPressed: () {
                  controller.openDateDialog(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "",
                      style: textStyle(
                        context: context,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: getHeight(5, context)),
                      width: 500,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(
                          getWidth(
                              ResponsiveWidget.isLargeScreen(context)
                                  ? 5
                                  : ResponsiveWidget.isLargeScreen(context)
                                      ? 10
                                      : 20,
                              context),
                        ),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(-6, 6),
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 12)
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: getHeight(5, context)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(5, context),
                            vertical: getHeight(10, context)),
                        child: Text(
                          controller.dateController.text.isEmpty
                              ? "Pick Date"
                              : controller.dateController.text,
                          style: textStyle(
                            context: context,
                            fontSize: FontSize.H4,
                            color: Theme.of(context).shadowColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Text(
                    "",
                    style: textStyle(
                      context: context,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  AppButton(
                    text: "Schedule",
                    onTap: controller.scheduleMeeting,
                    isLoading: controller.isLoading,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
