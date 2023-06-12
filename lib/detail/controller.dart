import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/color_helper.dart';
import '../helper/firebase_helper.dart';
import '../helper/registration_model.dart';
import '../helper/responsive_widget.dart';
import '../helper/styles.dart';

class DetailController extends GetxController {
  RegistrationModel model = RegistrationModel();
  bool isLoading = false;
  bool dataFound = false;
  bool showButton = false;
  TextEditingController numberOfStudentController = TextEditingController();

  // ["Guest","Participant","Volunteer","Service","Doordarshan"]

  @override
  void onInit() {
    numberOfStudentController.addListener(onTextChange);
    super.onInit();
  }

  void getDetails(String email) async {
    isLoading = true;
    update();

    var haveData = await FirebaseHelper.haveCollectionOrNot(email);
    if (haveData) {
      dataFound = true;
      var data = await FirebaseHelper.getData(email);
      if (data != null) {
        model = data;
        if (model.type == "SoSE-Teacher") {
          numberOfStudentController.text =
              model.studentQr == null ? "0" : "${model.studentQr!.length}";
        }
      }
      isLoading = false;
      update();
    } else {
      dataFound = false;
      isLoading = false;
      update();
    }
  }

  Color getColor(String value) {
    switch (value) {
      case "Organizer":
        return organiserColor;
      case "Participant":
        return participantColor;
      case "Sponsor":
        return sponsorColor;
      case "Volunteer":
        return volunteerColor;
      case "Visitor":
        return visitorColor;
      case "SoSE-Teacher":
        return teacherColor;
      default:
        return Colors.white;
    }
  }

  void viewPDF(String value, BuildContext context) async {
    /*Get.dialog(
      Center(
        child: SizedBox(
          height: height(context) * 0.9,
          width: width(context) * 0.9,
          child: Card(
            elevation: 0,
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  "View Document",
                  style: textStyle(
                    context: context,
                    isBold: true,
                  ),
                ),
                Expanded(
                  child: SfPdfViewer.network(
                    value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );*/
    launchUrl(Uri.parse(value));
  }

  void onTextChange() {
    try {
      if (numberOfStudentController.text.isNotEmpty) {
        int number = int.parse(numberOfStudentController.text.trim());
        if (number > 0) {
          int savedNumber =
              model.studentQr == null ? 0 : model.studentQr!.length;
          if (number != savedNumber) {
            showButton = true;
          } else {
            showButton = false;
          }
        } else {
          showButton = false;
        }
      } else {
        showButton = false;
      }
      update();
    } catch (e) {
      Fluttertoast.showToast(msg: "Enter Numeric value only");
    }
  }

  void uploadNumberOfStudents() async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    if (numberOfStudentController.text.isNotEmpty) {
      int number = int.parse(numberOfStudentController.text.trim());
      if (number > 0) {
        int savedNumber = model.studentQr == null ? 0 : model.studentQr!.length;
        // print(number);
        if (number != savedNumber) {
          List<String> list = [];
          for (int i = 0; i < number; i++) {
            var map = {
              "email": model.email,
              "name": (i + 1).toString().padLeft(3, '0')
            };
            String emailEncoded = stringToBase64.encode(jsonEncode(map));
            String qrCodeUrl =
                "https://api.qrserver.com/v1/create-qr-code/?data=https://ddrobocon-profile.web.app?$emailEncoded&size=512x512";
            list.add(qrCodeUrl);
          }
          model.studentQr = list;
          // print(jsonEncode(model));
          isLoading = true;
          update();
          await FirebaseHelper.registerDataOthers(model);
          isLoading = false;
          update();
          Get.back(result: true);
        }
      }
    }
  }

  void viewNameTag(BuildContext context) {
    Get.dialog(
      Center(
        child: Container(
          width: (height(context) * 0.95) * 0.66,
          height: height(context) * 0.95,
          margin: EdgeInsets.all(getWidth(10, context)),
          color: getBGColor(),
          child: Column(
            children: [
              Container(
                height: height(context) * 0.05,
                color: Colors.white,
                alignment: Alignment.center,
                child: FittedBox(
                    child: Text(
                  "Name Tag",
                  style: textStyle(context: context, isBold: true),
                )),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "asset/iit_logo.png",
                    fit: BoxFit.contain,
                    height: height(context) * 0.1,
                  ),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        "asset/robocon_logo.png",
                        fit: BoxFit.contain,
                        height: height(context) * 0.1,
                      ),
                    ),
                  ),
                  Image.asset(
                    "asset/dd_logo.png",
                    fit: BoxFit.contain,
                    height: height(context) * 0.1,
                  )
                ],
              ),
              SizedBox(
                height: height(context) * 0.08,
                child: FittedBox(
                  child: Text(
                    model.name ?? "",
                    style: textStyle(
                      context: context,
                      isCard: true,
                      isBold: true,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
              SizedBox(
                height: height(context) * 0.04,
                child: FittedBox(
                  child: Text(
                    model.collageName ??
                        model.nameOfOrganization ??
                        model.nameOfVisitor ??
                        model.nameOfVolunteer ??
                        model.nameOfSponsor ??
                        model.nameOfEmployee ??
                        "",
                    style: textStyle(
                      context: context,
                      isCard: true,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
              Expanded(child: Container()),
              Image.network(
                model.qrImage ?? "",
                width: width(context),
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: ResponsiveWidget.isLargeScreen(context)
                    ? getHeight(5, context)
                    : getWidth(10, context),
              ),
              Container(
                decoration: BoxDecoration(
                  color: getForegroundColor(),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: getHeight(8, context),
                ),
                alignment: Alignment.center,
                width: width(context),
                child: Text(
                  model.type?.toUpperCase() ?? "",
                  style: textStyle(
                    context: context,
                    color: Colors.white,
                    isBold: true,
                    fontSize: FontSize.H2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getForegroundColor() {
    switch (model.type) {
      case "Organizer":
        return organiserColor;
      case "Participant":
        return participantColor;
      case "Sponsor":
        return sponsorColor;
      case "Volunteer":
        return volunteerColor;
      case "Visitor":
        return visitorColor;
      case "SoSE-Teacher":
        return teacherColor;
      default:
        return Colors.white;
    }
  }

  Color getBGColor() {
    switch (model.type) {
      case "Organizer":
        return organiserBGColor;
      case "Participant":
        return participantBGColor;
      case "Sponsor":
        return sponsorBGColor;
      case "Volunteer":
        return volunteerBGColor;
      case "Visitor":
        return visitorBGColor;
      case "SoSE-Teacher":
        return teacherBGColor;
      default:
        return teacherBGColor;
    }
  }
}
