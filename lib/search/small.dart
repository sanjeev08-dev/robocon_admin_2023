import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:robocon_admin_2023/widgets/large/text_field_container.dart';
import 'package:transparent_image/transparent_image.dart';

import '../helper/app_holder.dart';
import '../helper/flutter_bounce.dart';
import '../helper/registration_model.dart';
import '../helper/responsive_widget.dart';
import '../helper/styles.dart';
import '../widgets/detail_widget.dart';
import '../widgets/flutter_switch.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  SearchController controller;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Small({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "asset/robocon_logo.png",
                height: height(context) * 0.07,
              ),
              Expanded(
                child: TextFieldContainer(
                  title: "",
                  textEditingController: controller.searchController,
                  onChanged: controller.onTextChange,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<List<RegistrationModel>>(
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                List<RegistrationModel> dataList = snapshot.data!;
                return dataList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex:
                                  controller.selectedData.name == null ? 1 : 5,
                              child: Container(
                                height: height(context),
                                width: width(context),
                                margin: EdgeInsets.only(right: 5),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Wrap(
                                        // crossAxisAlignment: WrapCrossAlignment.start,
                                        alignment: WrapAlignment.start,
                                        runSpacing: 10,
                                        spacing: 10,
                                        runAlignment: WrapAlignment.start,
                                        children: List.generate(
                                          dataList.length,
                                          (index) => Bounce(
                                            onPressed: () {
                                              controller.onDetailSelected(
                                                  context,
                                                  dataList[index],
                                                  dataList);
                                            },
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minWidth: 300,
                                                maxWidth: 300,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    dataList[index].isVerified!
                                                        ? Color(0xFFCCFFD7)
                                                        : Color(0xFFFFB6B6),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(-3, 3),
                                                    blurRadius: 6,
                                                    color: Colors.grey[100]!,
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: controller
                                                              .selectedData !=
                                                          dataList[index]
                                                      ? dataList[index]
                                                              .isVerified!
                                                          ? Color(0xFFCCFFD7)
                                                          : Color(0xFFFFB6B6)
                                                      : Colors.grey,
                                                  width: 5,
                                                ),
                                              ),
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              dataList[index]
                                                                      .name ??
                                                                  "",
                                                              style: textStyle(
                                                                context:
                                                                    context,
                                                                isBold: true,
                                                              ),
                                                            ),
                                                            Text(
                                                              dataList[index]
                                                                      .email ??
                                                                  dataList[
                                                                          index]
                                                                      .personalEmail ??
                                                                  "",
                                                              style: textStyle(
                                                                context:
                                                                    context,
                                                                isBold: false,
                                                                fontSize:
                                                                    FontSize.H5,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        width: ResponsiveWidget
                                                                .isSmallScreen(
                                                                    context)
                                                            ? 50
                                                            : 100,
                                                        height: ResponsiveWidget
                                                                .isSmallScreen(
                                                                    context)
                                                            ? 50
                                                            : 100,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          // boxShadow: [
                                                          //   BoxShadow(
                                                          //     offset: const Offset(-3, 3),
                                                          //     blurRadius: getWidth(20, context),
                                                          //     color: Colors.grey,
                                                          //   ),
                                                          // ],
                                                          // border: Border.all(),
                                                          color: Colors.white,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(width(
                                                                      context)),
                                                          child: FadeInImage
                                                              .memoryNetwork(
                                                            width: ResponsiveWidget
                                                                    .isSmallScreen(
                                                                        context)
                                                                ? 50
                                                                : 100,
                                                            height: ResponsiveWidget
                                                                    .isSmallScreen(
                                                                        context)
                                                                ? 50
                                                                : 100,
                                                            fit: BoxFit.cover,
                                                            /*errorBuilder: (_, __, ___) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[800]!,
                                                        ),
                                                      ),
                                                      width: ResponsiveWidget
                                                              .isSmallScreen(
                                                                  context)
                                                          ? 50
                                                          : 100,
                                                      height: ResponsiveWidget
                                                              .isSmallScreen(
                                                                  context)
                                                          ? 50
                                                          : 100,
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Center(
                                                        child: Text(
                                                          "No Image",
                                                        ),
                                                      ),
                                                    );
                                                  },*/
                                                            placeholder:
                                                                kTransparentImage,
                                                            image: (dataList[index]
                                                                            .photograph !=
                                                                        null &&
                                                                    dataList[
                                                                            index]
                                                                        .photograph!
                                                                        .isNotEmpty)
                                                                ? dataList[
                                                                        index]
                                                                    .photograph!
                                                                : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/512px-No-Image-Placeholder.svg.png",
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  getDetailView(
                                                    context,
                                                    "Phone",
                                                    dataList[index].mobile,
                                                  ),
                                                  getDetailView(
                                                    context,
                                                    "Organization Name",
                                                    dataList[index].collageName,
                                                  ),
                                                  getDetailView(
                                                    context,
                                                    "Team Name",
                                                    dataList[index].team,
                                                  ),
                                                  getDetailView(
                                                    context,
                                                    "T-Shirt Size",
                                                    dataList[index].tShirtSize,
                                                  ),
                                                  getDetailActionView(
                                                      context,
                                                      "Received T-Shirt",
                                                      dataList[index]
                                                          .tShirtReceived,
                                                      "Yes",
                                                      "No", (val) {
                                                    controller.tShirtToggle(
                                                        val,
                                                        dataList[index],
                                                        dataList);
                                                  }, true),
                                                  getDetailActionView(
                                                      context,
                                                      "Verify",
                                                      dataList[index]
                                                          .isVerified,
                                                      "Verified",
                                                      "Not Verified", (val) {
                                                    controller.verifyToggle(
                                                        val,
                                                        dataList[index],
                                                        dataList);
                                                  },
                                                      dataList[index].type ==
                                                          "Visitor"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height(context) * 0.09,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (!ResponsiveWidget.isSmallScreen(context) &&
                                controller.selectedData.name != null)
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: height(context),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F5F5),
                                    border: Border.all(
                                        color: Color(0xFFDFDFDF), width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DetailWidget(
                                          model: controller.selectedData,
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.09,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      )
                    : Center(
                        child:
                            controller.searchController.text.trim().isNotEmpty
                                ? Text(
                                    "User not found with entered name",
                                    style: textStyle(
                                        context: context,
                                        isBold: true,
                                        fontSize: FontSize.H1),
                                  )
                                : LoadingAnimationWidget.inkDrop(
                                    color: Colors.green[800]!,
                                    size: width(context) * 0.1));
              } else {
                return Center(
                    child: controller.searchController.text.trim().isEmpty
                        ? Text(
                            "Start Finding user by name",
                            style: textStyle(
                                context: context,
                                isBold: true,
                                fontSize: FontSize.H1),
                          )
                        : LoadingAnimationWidget.inkDrop(
                            color: Colors.green[800]!,
                            size: width(context) * 0.1));
              }
            },
            stream: controller.streamController.stream,
          ),
          /*if (dataList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: height(context),
                      width: width(context),
                      margin: EdgeInsets.only(right: 5),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Wrap(
                              // crossAxisAlignment: WrapCrossAlignment.start,
                              alignment: WrapAlignment.start,
                              runSpacing: 10,
                              spacing: 10,
                              runAlignment: WrapAlignment.start,
                              children: List.generate(
                                dataList.length,
                                (index) => Bounce(
                                  onPressed: () {
                                    controller.onDetailSelected(context, index);
                                  },
                                  child: Container(
                                    constraints: BoxConstraints(
                                      minWidth: 300,
                                      maxWidth: 300,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          dataList[index].isVerified!
                                              ? Color(0xFFCCFFD7)
                                              : Color(0xFFFFB6B6),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(-3, 3),
                                          blurRadius: 6,
                                          color: Colors.grey[100]!,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: controller.selectedUserIndex !=
                                                index
                                            ? controller
                                                    .dataList[index].isVerified!
                                                ? Color(0xFFCCFFD7)
                                                : Color(0xFFFFB6B6)
                                            : Colors.grey,
                                        width: 5,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    dataList[index]
                                                            .name ??
                                                        "",
                                                    style: textStyle(
                                                      context: context,
                                                      isBold: true,
                                                    ),
                                                  ),
                                                  Text(
                                                    dataList[index]
                                                            .email ??
                                                        controller
                                                            .dataList[index]
                                                            .personalEmail ??
                                                        "",
                                                    style: textStyle(
                                                      context: context,
                                                      isBold: false,
                                                      fontSize: FontSize.H5,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: ResponsiveWidget
                                                      .isSmallScreen(context)
                                                  ? 50
                                                  : 100,
                                              height: ResponsiveWidget
                                                      .isSmallScreen(context)
                                                  ? 50
                                                  : 100,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                // boxShadow: [
                                                //   BoxShadow(
                                                //     offset: const Offset(-3, 3),
                                                //     blurRadius: getWidth(20, context),
                                                //     color: Colors.grey,
                                                //   ),
                                                // ],
                                                // border: Border.all(),
                                                color: Colors.white,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        width(context)),
                                                child:
                                                    FadeInImage.memoryNetwork(
                                                  width: ResponsiveWidget
                                                          .isSmallScreen(
                                                              context)
                                                      ? 50
                                                      : 100,
                                                  height: ResponsiveWidget
                                                          .isSmallScreen(
                                                              context)
                                                      ? 50
                                                      : 100,
                                                  fit: BoxFit.cover,
                                                  */ /*errorBuilder: (_, __, ___) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        border: Border.all(
                                                          color:
                                                              Colors.grey[800]!,
                                                        ),
                                                      ),
                                                      width: ResponsiveWidget
                                                              .isSmallScreen(
                                                                  context)
                                                          ? 50
                                                          : 100,
                                                      height: ResponsiveWidget
                                                              .isSmallScreen(
                                                                  context)
                                                          ? 50
                                                          : 100,
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Center(
                                                        child: Text(
                                                          "No Image",
                                                        ),
                                                      ),
                                                    );
                                                  },*/ /*
                                                  placeholder:
                                                      kTransparentImage,
                                                  image: (controller
                                                                  .dataList[
                                                                      index]
                                                                  .photograph !=
                                                              null &&
                                                          controller
                                                              .dataList[index]
                                                              .photograph!
                                                              .isNotEmpty)
                                                      ? controller
                                                          .dataList[index]
                                                          .photograph!
                                                      : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/512px-No-Image-Placeholder.svg.png",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        getDetailView(
                                          context,
                                          "Phone",
                                          dataList[index].mobile,
                                        ),
                                        getDetailView(
                                          context,
                                          "Organization Name",
                                          controller
                                              .dataList[index].collageName,
                                        ),
                                        getDetailView(
                                          context,
                                          "Team Name",
                                          dataList[index].team,
                                        ),

                                        */ /*getDetailView(
                                        context,
                                        "T-Shirt Size",
                                        dataList[index].tShirtSize,
                                      ),*/ /*
                                        */ /*getDetailActionView(
                                          context,
                                          "Received T-Shirt",
                                          controller
                                              .dataList[index].tShirtReceived,
                                          "Yes",
                                          "No", (val) {
                                        controller.tShirtToggle(
                                            val, dataList[index]);
                                      }),*/ /*
                                        getDetailActionView(
                                            context,
                                            "Verify",
                                            controller
                                                .dataList[index].isVerified,
                                            "Verified",
                                            "Not Verified", (val) {
                                          controller.verifyToggle(
                                              val, dataList[index]);
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height(context) * 0.09,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!ResponsiveWidget.isSmallScreen(context))
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: height(context),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          border:
                              Border.all(color: Color(0xFFDFDFDF), width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailWidget(
                                model: controller
                                    .dataList[controller.selectedUserIndex],
                              ),
                              SizedBox(
                                height: height(context) * 0.09,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            )*/
        ],
      ),
    );
  }

  getDetailView(BuildContext context, String title, String? value) {
    return value == null || value.isEmpty
        ? SizedBox(
            height: 0,
            width: 0,
          )
        : Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    "$title :",
                    style: textStyle(
                        context: context, isBold: true, fontSize: FontSize.H5),
                  ),
                ),
                Expanded(
                  child: Text(
                    value,
                    style: textStyle(
                        context: context, isBold: false, fontSize: FontSize.H5),
                  ),
                ),
              ],
            ),
          );
  }

  getDetailActionView(
      BuildContext context,
      String title,
      bool? value,
      String yesText,
      String noText,
      void Function(bool) onToggle,
      bool isEditable) {
    return value == null
        ? SizedBox(
            height: 0,
            width: 0,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  "$title :",
                  style: textStyle(
                      context: context, isBold: true, fontSize: FontSize.H5),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 5,
                  ),
                  alignment: Alignment.centerLeft,
                  child: isEditable
                      ? FlutterSwitch(
                          value: value,
                          activeColor: Colors.green[800]!,
                          inactiveColor: Colors.red[800]!,
                          onToggle: onToggle,
                        )
                      : AppHolder.loginAs != "admin"
                          ? Container(
                              decoration: BoxDecoration(
                                color: value
                                    ? Colors.green[800]!
                                    : Colors.red[800]!,
                                borderRadius: BorderRadius.circular(2000),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                value ? yesText : noText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : FlutterSwitch(
                              value: value,
                              activeColor: Colors.green[800]!,
                              inactiveColor: Colors.red[800]!,
                              onToggle: onToggle,
                            ),
                ),
              ),
            ],
          );
  }
}
