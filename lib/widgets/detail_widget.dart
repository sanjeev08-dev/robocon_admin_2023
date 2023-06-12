import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robocon_admin_2023/helper/registration_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/color_helper.dart';
import '../helper/date_format_helper.dart';
import '../helper/flutter_bounce.dart';
import '../helper/responsive_widget.dart';
import '../helper/styles.dart';

class DetailWidget extends StatelessWidget {
  RegistrationModel model;
  DetailWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Details",
          style: textStyle(
            context: context,
            fontSize: FontSize.H1,
            isBold: true,
          ),
        ),
        if (model.photograph != null)
          Container(
            width: ResponsiveWidget.isSmallScreen(context) ? 100 : 200,
            height: ResponsiveWidget.isSmallScreen(context) ? 100 : 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(-3, 3),
                  blurRadius: getWidth(20, context),
                  color: Colors.grey,
                ),
              ],
              border: Border.all(),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(width(context)),
              child: Image.network(
                (model.photograph != null && model.photograph!.isNotEmpty)
                    ? model.photograph!
                    : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/512px-No-Image-Placeholder.svg.png",
                width: ResponsiveWidget.isSmallScreen(context) ? 100 : 200,
                height: ResponsiveWidget.isSmallScreen(context) ? 100 : 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        Bounce(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red[800],
                  borderRadius: BorderRadius.circular(getWidth(100, context))),
              padding: EdgeInsets.symmetric(
                horizontal: getWidth(20, context),
                vertical: getHeight(3, context),
              ),
              child: Text(
                "View Name Tag",
                style: textStyle(
                  context: context,
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () {
              viewNameTag(context);
            }),
        if (model.isVerified != null)
          getDetailVerifiedTile(
            context,
            "Verified",
            model.isVerified,
          ),
        getDetailTile(
          context,
          "Type",
          model.type ?? "NA",
          isType: true,
        ),
        /*if (model.tShirtReceived != null)
          getDetailTShirtTile(
            context,
            "T-Shirt",
            model.tShirtReceived,
          ),*/
        if (model.type != null && model.type == "Participant")
          Column(
            children: [
              getDetailTile(
                context,
                "Team Name",
                model.team ?? "NA",
              ),
              getDetailTile(
                context,
                "Full Name",
                model.name ?? "NA",
              ),
              getDetailTile(
                context,
                "Country",
                model.country ?? "NA",
              ),
              getDetailTile(
                context,
                "Personal Email id",
                model.personalEmail ?? "NA",
              ),
              getDetailTile(
                context,
                "College Email id",
                model.collegeEmail ?? "NA",
              ),
              getDetailTile(
                context,
                "Gender",
                model.gender ?? "NA",
              ),
              getDetailTile(
                context,
                "Mobile Number",
                model.mobileNumber ?? "NA",
              ),
              getDetailTile(
                context,
                "Name of Parent",
                model.parentName ?? "NA",
              ),
              getDetailTile(
                context,
                "Parent Contact Number",
                model.parentContact ?? "NA",
              ),
              getDetailTile(
                context,
                "Current Address (Home/Hostel/PG)",
                model.currentAddress ?? "NA",
              ),
              getDetailTile(
                context,
                "Permanent Home Address",
                model.permanentAddress ?? "NA",
              ),
              getDetailTile(
                context,
                "Aadhar card",
                model.aadhar ?? "NA",
                isDocument: true,
              ),
              getDetailTile(
                context,
                "Any Relative staying Delhi/ NCR?",
                model.haveRelativeInDelhi ?? "NA",
              ),
              getDetailTile(
                context,
                "Name of Relative",
                model.relativeName ?? "NA",
              ),
              getDetailTile(
                context,
                "Relative Contact Number",
                model.relativeContact ?? "NA",
              ),
              getDetailTile(
                context,
                "Relative Complete Address",
                model.relativeAddress ?? "NA",
              ),
              getDetailTile(
                context,
                "College Name (Please do not use Abbreviations)",
                model.collageName ?? "NA",
              ),
              getDetailTile(
                context,
                "College GST Number",
                model.collegeGst ?? "NA",
              ),
              getDetailTile(
                context,
                "Department",
                model.department ?? "NA",
              ),
              getDetailTile(
                context,
                "Current Semester",
                model.currentSemester ?? "NA",
              ),
              getDetailTile(
                context,
                "College Address (Please mention complete Address)",
                model.collegeAddress ?? "NA",
              ),
              getDetailTile(
                context,
                "Emergency College Contact Number",
                model.emergencyCollegeContact ?? "NA",
              ),
              getDetailTile(
                context,
                "Coordinating Faculty Name",
                model.coordinatingFacultyName ?? "NA",
              ),
              getDetailTile(
                context,
                "Coordinating Faculty  Contact Number",
                model.coordinatingFacultyContact ?? "NA",
              ),
              getDetailTile(
                context,
                "College ID",
                model.collageIdCard ?? "NA",
                isDocument: true,
              ),
              getDetailTile(
                context,
                "Blood Group",
                model.bloodGroup ?? "NA",
              ),
              getDetailTile(
                context,
                "Have you ever been diagnosed with Covid-19?",
                model.haveEverBeenCovid19 ?? "NA",
              ),
              getDetailTile(
                context,
                "Is any member of your immediate family currently suffering from Covid 19?",
                model.anyFamilyMember ?? "NA",
              ),
              getDetailTile(
                context,
                "Are you currently suffering from any prolonged disease (Asthma, Anxiety, Hypertension, Diabetes, etc.) If Yes, Please specify.",
                model.otherDisease ?? "NA",
              ),
              getDetailTile(
                context,
                "Name of Medical Fraternity",
                model.medicalFraternity ?? "NA",
              ),
              getDetailTile(
                context,
                "Mobile Number of Doctor",
                model.doctorContact ?? "NA",
              ),
              getDetailTile(context, "RTPCR Report", model.rtpcrReport ?? "NA",
                  isDocument: model.rtpcrReport != null &&
                      model.rtpcrReport!.isNotEmpty),
              getDetailTile(
                context,
                "Mode of Transport",
                model.modeOfTransport ?? "NA",
              ),
              if (model.modeOfTransport != null &&
                  model.modeOfTransport == "Train") ...[
                getDetailTile(
                  context,
                  "Your Departure Station",
                  model.departureStation ?? "NA",
                ),
                model.departureDatetime != null
                    ? getDetailTile(
                        context,
                        "Your Departure Date",
                        DateFormatHelper.convertDateFromDate(
                            DateTime.parse(model.departureDatetime!),
                            "dd MMM, yyyy"),
                      )
                    : getDetailTile(
                        context,
                        "Your Departure Date",
                        "NA",
                      ),
                model.departureDatetime != null
                    ? getDetailTile(
                        context,
                        "Your Departure Time",
                        DateFormatHelper.convertDateFromDate(
                            DateTime.parse(model.departureDatetime!),
                            "hh:mm a"),
                      )
                    : getDetailTile(
                        context,
                        "Your Departure Time",
                        "NA",
                      ),
                getDetailTile(
                  context,
                  "Your Arrival Station",
                  model.arrivalStation ?? "NA",
                ),
                model.arrivalDatetime != null
                    ? getDetailTile(
                        context,
                        "Your Arrival Date",
                        DateFormatHelper.convertDateFromDate(
                            DateTime.parse(model.arrivalDatetime!),
                            "dd MMM, yyyy"),
                      )
                    : getDetailTile(
                        context,
                        "Your Arrival Date",
                        "NA",
                      ),
                model.arrivalDatetime != null
                    ? getDetailTile(
                        context,
                        "Your Arrival Time",
                        DateFormatHelper.convertDateFromDate(
                            DateTime.parse(model.arrivalDatetime!), "hh:mm a"),
                      )
                    : getDetailTile(
                        context,
                        "Your Arrival Time",
                        "NA",
                      ),
                getDetailTile(
                  context,
                  "Your Train Name",
                  model.trainName ?? "NA",
                ),
                getDetailTile(
                  context,
                  "Your Train Number",
                  model.trainNumber ?? "NA",
                ),
                getDetailTile(
                  context,
                  "Ticket",
                  model.tickets ?? "NA",
                  isDocument: true,
                ),
              ],
              getDetailTile(
                context,
                "Departure Mode",
                model.departureMode ?? "NA",
                isDocument: true,
              ),
              if (model.departureMode != null &&
                  model.departureMode == "Train") ...[
                model.departureDatetimeFromDelhi != null
                    ? getDetailTile(
                        context,
                        "Your Departure Date from delhi",
                        DateFormatHelper.convertDateFromDate(
                            DateTime.parse(model.departureDatetimeFromDelhi!),
                            "dd MMM, yyyy"),
                      )
                    : getDetailTile(
                        context,
                        "Your Departure Date from delhi",
                        "NA",
                      ),
                model.departureDatetimeFromDelhi != null
                    ? getDetailTile(
                        context,
                        "Your Departure Time from delhi",
                        DateFormatHelper.convertDateFromDate(
                            DateTime.parse(model.departureDatetimeFromDelhi!),
                            "hh:mm a"),
                      )
                    : getDetailTile(
                        context,
                        "Your Departure Time from delhi",
                        "NA",
                      ),
                getDetailTile(
                  context,
                  "Your Departure Station from delhi",
                  model.departureStationFromDelhi ?? "NA",
                ),
                getDetailTile(
                  context,
                  "Return Ticket ",
                  model.ticketsDeparture ?? "NA",
                  isDocument: true,
                ),
              ],
            ],
          ),
        if (model.type != null && model.type == "Volunteer")
          Column(
            children: [
              getDetailTile(
                context,
                "Committee",
                model.comitteeName ?? "NA",
              ),
              getDetailTile(
                context,
                "Full Name",
                model.name ?? "NA",
              ),
              getDetailTile(
                context,
                "Country",
                model.country ?? "NA",
              ),
              getDetailTile(
                context,
                "Organization Name",
                model.nameOfVolunteer ?? "NA",
              ),
              getDetailTile(
                context,
                "Email id",
                model.email ?? "NA",
              ),
              getDetailTile(
                context,
                "Mobile Number",
                model.mobile ?? "NA",
              ),
              getDetailTile(
                context,
                "Department",
                model.department ?? "NA",
              ),
              getDetailTile(
                context,
                "Location",
                model.location ?? "NA",
              ),
              getDetailTile(
                context,
                "T-Shirt Size",
                model.tShirtSize ?? "NA",
              ),
              getDetailTile(
                context,
                "Have you ever been diagnosed with Covid-19?",
                model.haveEverBeenCovid19 ?? "NA",
              ),
              getDetailTile(
                context,
                "Is any member of your immediate family currently suffering from Covid 19?",
                model.anyFamilyMember ?? "NA",
              ),
            ],
          ),
        if (model.type != null && model.type == "Sponsor")
          Column(
            children: [
              getDetailTile(
                context,
                "Full Name",
                model.name ?? "NA",
              ),
              getDetailTile(
                context,
                "Country",
                model.country ?? "NA",
              ),
              getDetailTile(
                context,
                "Organization Name",
                model.nameOfSponsor ?? "NA",
              ),
              getDetailTile(
                context,
                "Email id",
                model.email ?? "NA",
              ),
              getDetailTile(
                context,
                "Mobile Number",
                model.mobile ?? "NA",
              ),
              getDetailTile(
                context,
                "Gender",
                model.gender ?? "NA",
              ),
              getDetailTile(
                context,
                "Designation",
                model.designation ?? "NA",
              ),
              getDetailTile(
                context,
                "Department",
                model.department ?? "NA",
              ),
              getDetailTile(
                context,
                "Location",
                model.location ?? "NA",
              ),
              getDetailTile(
                context,
                "Have you ever been diagnosed with Covid-19?",
                model.haveEverBeenCovid19 ?? "NA",
              ),
              getDetailTile(
                context,
                "Is any member of your immediate family currently suffering from Covid 19?",
                model.anyFamilyMember ?? "NA",
              ),
            ],
          ),
        if (model.type != null && model.type == "Organizer")
          Column(
            children: [
              getDetailTile(
                context,
                "Full Name",
                model.name ?? "NA",
              ),
              getDetailTile(
                context,
                "Country",
                model.country ?? "NA",
              ),
              getDetailTile(
                context,
                "Organization Name",
                model.nameOfOrganization ?? "NA",
              ),
              getDetailTile(
                context,
                "Email id",
                model.email ?? "NA",
              ),
              getDetailTile(
                context,
                "Mobile Number",
                model.mobile ?? "NA",
              ),
              getDetailTile(
                context,
                "Designation",
                model.designation ?? "NA",
              ),
              getDetailTile(
                context,
                "Department",
                model.department ?? "NA",
              ),
              getDetailTile(
                context,
                "T-Shirt Size",
                model.tShirtSize ?? "NA",
              ),
              getDetailTile(
                context,
                "Have you ever been diagnosed with Covid-19?",
                model.haveEverBeenCovid19 ?? "NA",
              ),
              getDetailTile(
                context,
                "Is any member of your immediate family currently suffering from Covid 19?",
                model.anyFamilyMember ?? "NA",
              ),
            ],
          ),
        if (model.type != null && model.type == "Visitor")
          Column(
            children: [
              getDetailTile(
                context,
                "Full Name",
                model.name ?? "NA",
              ),
              getDetailTile(
                context,
                "Country",
                model.country ?? "NA",
              ),
              getDetailTile(
                context,
                "Organization Name",
                model.nameOfVisitor ?? "NA",
              ),
              getDetailTile(
                context,
                "Email id",
                model.email ?? "NA",
              ),
              getDetailTile(
                context,
                "Mobile Number",
                model.mobile ?? "NA",
              ),
              /*getDetailTile(
                context,
                "Designation",
                model.designation ?? "NA",
              ),*/
              getDetailTile(
                context,
                "Location",
                model.location ?? "NA",
              ),
              if (model.aadhar != null)
                getDetailTile(context, "ID Card", model.aadhar ?? "NA",
                    isDocument: true),
              /*getDetailTile(
                context,
                "Visitor Type",
                model.visitorType ?? "NA",
              ),
              if ((model.visitorType != null && model.visitorType == "Paid"))
                getDetailTile(
                  context,
                  "Receipt",
                  model.receiptVisitor ?? "NA",
                  isDocument: true,
                ),
              if ((model.visitorType != null &&
                  model.visitorType != "Paid")) ...[

                getDetailTile(
                  context,
                  "Reference Email",
                  model.referenceEmail ?? "NA",
                ),
                getDetailTile(
                  context,
                  "Reference Name",
                  model.referenceName ?? "NA",
                ),
                getDetailTile(
                  context,
                  "Reference Email Document",
                  model.collageIdCard ?? "NA",
                  isDocument: true,
                ),
              ],*/
              getDetailTile(
                context,
                "Have you ever been diagnosed with Covid-19?",
                model.haveEverBeenCovid19 ?? "NA",
              ),
              getDetailTile(
                context,
                "Is any member of your immediate family currently suffering from Covid 19?",
                model.anyFamilyMember ?? "NA",
              ),
            ],
          ),
        if (model.type != null && model.type == "SoSE-Teacher")
          Column(
            children: [
              getDetailTile(
                context,
                "Full Name",
                model.name ?? "NA",
              ),
              getDetailTile(
                context,
                "Country",
                model.country ?? "NA",
              ),
              getDetailTile(
                context,
                "School/Institute Name",
                model.collageName ?? "NA",
              ),
              getDetailTile(
                context,
                "Email id",
                model.email ?? "NA",
              ),
              getDetailTile(
                context,
                "Mobile Number",
                model.mobile ?? "NA",
              ),
              getDetailTile(
                context,
                "Location",
                model.location ?? "NA",
              ),
              getDetailTile(
                context,
                "Have you ever been diagnosed with Covid-19?",
                model.haveEverBeenCovid19 ?? "NA",
              ),
              getDetailTile(
                context,
                "Is any member of your immediate family currently suffering from Covid 19?",
                model.anyFamilyMember ?? "NA",
              ),
            ],
          ),
        if (model.qrImage != null)
          Image.network(
            model.qrImage ?? "",
            width: width(context) * 0.2,
            height: width(context) * 0.2,
          ),
        SizedBox(
          height: getHeight(10, context),
        ),
        /*AppButton(
                  text: "Edit",
                  onTap: controller.goToEditPage,
                  isLoading: controller.isLoading,
                ),*/
      ],
    );
  }

  Widget getDetailTile(BuildContext context, String title, String value,
      {bool isDocument = false, bool isType = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle(
            context: context,
            isBold: true,
          ),
        ),
        isType
            ? Container(
                decoration: BoxDecoration(
                  color: getColor(value),
                  borderRadius: BorderRadius.circular(
                    getWidth(5, context),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(5, context),
                  vertical: getHeight(2, context),
                ),
                child: Text(
                  value.isEmpty ? "NA" : value,
                  style: textStyle(
                    context: context,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ),
              )
            : isDocument
                ? Bounce(
                    onPressed: () {
                      viewPDF(value, context);
                    },
                    child: Text(
                      "View Document",
                      style: textStyle(
                        context: context,
                        textDecoration: TextDecoration.underline,
                        color: Colors.red,
                        isBold: true,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  )
                : Text(
                    value.isEmpty ? "NA" : value,
                    style: textStyle(
                      context: context,
                    ),
                  ),
        Container(
          margin: EdgeInsets.only(
            bottom: getWidth(10, context),
          ),
          width: width(context),
          height: 1,
          color: Theme.of(context).shadowColor,
        )
      ],
    );
  }

  getDetailVerifiedTile(
    BuildContext context,
    String title,
    bool? value,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: textStyle(
                context: context,
                isBold: true,
              ),
            ),
            Image.asset(
              value! ? "asset/verified.png" : "asset/not_verified.png",
              fit: BoxFit.contain,
              width: 30,
              height: 30,
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: getWidth(10, context),
          ),
          width: width(context),
          height: 1,
          color: Theme.of(context).shadowColor,
        )
      ],
    );
  }

  Widget getDetailTShirtTile(
    BuildContext context,
    String title,
    bool? value,
  ) {
    return value != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyle(
                  context: context,
                  isBold: true,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: value ? Colors.green[800] : Colors.red[800],
                  borderRadius: BorderRadius.circular(
                    getWidth(5, context),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(5, context),
                  vertical: getHeight(2, context),
                ),
                child: Text(
                  value ? "Received" : "Not Received",
                  style: textStyle(
                    context: context,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: getWidth(10, context),
                ),
                width: width(context),
                height: 1,
                color: Theme.of(context).shadowColor,
              )
            ],
          )
        : const SizedBox(
            width: 0,
            height: 0,
          );
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
    Get.dialog(
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
    );
    // launchUrl(Uri.parse(value));
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
