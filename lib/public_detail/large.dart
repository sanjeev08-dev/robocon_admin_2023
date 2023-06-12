import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../helper/flutter_bounce.dart';
import '../helper/styles.dart';
import 'controller.dart';

class Large extends StatelessWidget {
  PublicDetailController controller;

  Large({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context),
      height: height(context),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              "asset/bg_image.png",
              width: width(context),
              height: height(context),
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height(context) * 0.1,
                  width: width(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        getWidth(5, context),
                      ),
                      bottomRight: Radius.circular(
                        getWidth(5, context),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-3, 3),
                        blurRadius: getWidth(20, context),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "asset/robocon_logo.png",
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(
                    getWidth(20, context),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: getWidth(50, context),
                    vertical: getHeight(20, context),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      getWidth(10, context),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-3, 3),
                        blurRadius: getWidth(20, context),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: controller.isLoading || controller.model.name == null
                      ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: getWidth(45, context),
                        )
                      : Column(
                          children: [
                            Text(
                              "Details",
                              style: textStyle(
                                context: context,
                                fontSize: FontSize.H1,
                                isBold: true,
                              ),
                            ),
                            if (controller.model.photograph != null)
                              Image.network(
                                controller.model.photograph ?? "",
                                width: (width(context) * 0.2) * 0.75,
                                height: width(context) * 0.2,
                                fit: BoxFit.cover,
                              ),
                            Bounce(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red[800],
                                      borderRadius: BorderRadius.circular(
                                          getWidth(100, context))),
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
                                  controller.viewNameTag(context);
                                }),
                            if (controller.model.isVerified != null)
                              getDetailVerifiedTile(
                                context,
                                "Verified",
                                controller.model.isVerified,
                              ),
                            getDetailTile(
                              context,
                              "Type",
                              controller.studentName.isNotEmpty
                                  ? "Student"
                                  : controller.model.type ?? "NA",
                              isType: true,
                            ),
                            if (controller.model.type != null &&
                                controller.model.type == "Participant")
                              Column(
                                children: [
                                  getDetailTile(
                                    context,
                                    "Team Name",
                                    controller.model.team ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Full Name",
                                    controller.model.name ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Personal Email id",
                                    controller.model.personalEmail ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "College Email id",
                                    controller.model.collegeEmail ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Gender",
                                    controller.model.gender ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Mobile Number",
                                    controller.model.mobileNumber ?? "NA",
                                  ),
                                  /*getDetailTile(
                                    context,
                                    "Name of Parent",
                                    controller.model.parentName ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Parent Contact Number",
                                    controller.model.parentContact ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Current Address (Home/Hostel/PG)",
                                    controller.model.currentAddress ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Permanent Home Address",
                                    controller.model.permanentAddress ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Aadhar card",
                                    controller.model.aadhar ?? "NA",
                                    isDocument: true,
                                  ),
                                  getDetailTile(
                                    context,
                                    "Any Relative staying Delhi/ NCR?",
                                    controller.model.haveRelativeInDelhi ??
                                        "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Name of Relative",
                                    controller.model.relativeName ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Relative Contact Number",
                                    controller.model.relativeContact ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Relative Complete Address",
                                    controller.model.relativeAddress ?? "NA",
                                  ),*/
                                  getDetailTile(
                                    context,
                                    "College Name (Please do not use Abbreviations)",
                                    controller.model.collageName ?? "NA",
                                  ),
                                  /*getDetailTile(
                                    context,
                                    "College GST Number",
                                    controller.model.collegeGst ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Department",
                                    controller.model.department ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Current Semester",
                                    controller.model.currentSemester ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "College Address (Please mention complete Address)",
                                    controller.model.collegeAddress ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Emergency College Contact Number",
                                    controller.model.emergencyCollegeContact ??
                                        "NA",
                                  ),*/
                                  getDetailTile(
                                    context,
                                    "Coordinating Faculty Name",
                                    controller.model.coordinatingFacultyName ??
                                        "NA",
                                  ),
                                  /*getDetailTile(
                                    context,
                                    "Coordinating Faculty  Contact Number",
                                    controller
                                            .model.coordinatingFacultyContact ??
                                        "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "College ID",
                                    controller.model.collageIdCard ?? "NA",
                                    isDocument: true,
                                  ),*/
                                  getDetailTile(
                                    context,
                                    "Blood Group",
                                    controller.model.bloodGroup ?? "NA",
                                  ),
                                  /*getDetailTile(
                                    context,
                                    "Have you ever been diagnosed with Covid-19?",
                                    controller.model.haveEverBeenCovid19 ??
                                        "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Is any member of your immediate family currently suffering from Covid 19?",
                                    controller.model.anyFamilyMember ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Are you currently suffering from any prolonged disease (Asthma, Anxiety, Hypertension, Diabetes, etc.) If Yes, Please specify.",
                                    controller.model.otherDisease ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Name of Medical Fraternity",
                                    controller.model.medicalFraternity ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Mobile Number of Doctor",
                                    controller.model.doctorContact ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Mode of Transport",
                                    controller.model.modeOfTransport ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Your Departure Station",
                                    controller.model.departureStation ?? "NA",
                                  ),
                                  controller.model.departureDatetime != null
                                      ? getDetailTile(
                                          context,
                                          "Your Departure Date",
                                          DateFormatHelper.convertDateFromDate(
                                              DateTime.parse(controller
                                                  .model.departureDatetime!),
                                              "dd MMM, yyyy"),
                                        )
                                      : getDetailTile(
                                          context,
                                          "Your Departure Date",
                                          "NA",
                                        ),
                                  controller.model.departureDatetime != null
                                      ? getDetailTile(
                                          context,
                                          "Your Departure Time",
                                          DateFormatHelper.convertDateFromDate(
                                              DateTime.parse(controller
                                                  .model.departureDatetime!),
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
                                    controller.model.arrivalStation ?? "NA",
                                  ),
                                  controller.model.arrivalDatetime != null
                                      ? getDetailTile(
                                          context,
                                          "Your Arrival Date",
                                          DateFormatHelper.convertDateFromDate(
                                              DateTime.parse(controller
                                                  .model.arrivalDatetime!),
                                              "dd MMM, yyyy"),
                                        )
                                      : getDetailTile(
                                          context,
                                          "Your Arrival Date",
                                          "NA",
                                        ),
                                  controller.model.arrivalDatetime != null
                                      ? getDetailTile(
                                          context,
                                          "Your Arrival Time",
                                          DateFormatHelper.convertDateFromDate(
                                              DateTime.parse(controller
                                                  .model.arrivalDatetime!),
                                              "hh:mm a"),
                                        )
                                      : getDetailTile(
                                          context,
                                          "Your Arrival Time",
                                          "NA",
                                        ),
                                  getDetailTile(
                                    context,
                                    "Your Train Name",
                                    controller.model.trainName ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Your Train Number",
                                    controller.model.trainNumber ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Ticket",
                                    controller.model.tickets ?? "NA",
                                    isDocument: true,
                                  ),
                                  controller.model.departureDatetimeFromDelhi !=
                                          null
                                      ? getDetailTile(
                                          context,
                                          "Your Departure Date from delhi",
                                          DateFormatHelper.convertDateFromDate(
                                              DateTime.parse(controller.model
                                                  .departureDatetimeFromDelhi!),
                                              "dd MMM, yyyy"),
                                        )
                                      : getDetailTile(
                                          context,
                                          "Your Departure Date from delhi",
                                          "NA",
                                        ),
                                  controller.model.departureDatetimeFromDelhi !=
                                          null
                                      ? getDetailTile(
                                          context,
                                          "Your Departure Time from delhi",
                                          DateFormatHelper.convertDateFromDate(
                                              DateTime.parse(controller.model
                                                  .departureDatetimeFromDelhi!),
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
                                    controller
                                            .model.departureStationFromDelhi ??
                                        "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Return Ticket ",
                                    controller.model.ticketsDeparture ?? "NA",
                                    isDocument: true,
                                  ),*/
                                ],
                              ),
                            if (controller.model.type != null &&
                                controller.model.type == "Volunteer")
                              Column(
                                children: [
                                  getDetailTile(
                                    context,
                                    "Committee",
                                    controller.model.comitteeName ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Full Name",
                                    controller.model.name ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Organization Name",
                                    controller.model.nameOfVolunteer ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Email id",
                                    controller.model.email ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Mobile Number",
                                    controller.model.mobile ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Department",
                                    controller.model.department ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Location",
                                    controller.model.location ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "T-Shirt Size",
                                    controller.model.tShirtSize ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Have you ever been diagnosed with Covid-19?",
                                    controller.model.haveEverBeenCovid19 ??
                                        "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Is any member of your immediate family currently suffering from Covid 19?",
                                    controller.model.anyFamilyMember ?? "NA",
                                  ),
                                ],
                              ),
                            if (controller.model.type != null &&
                                controller.model.type == "Sponsor")
                              Column(
                                children: [
                                  getDetailTile(
                                    context,
                                    "Full Name",
                                    controller.model.name ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Organization Name",
                                    controller.model.nameOfSponsor ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Email id",
                                    controller.model.email ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Mobile Number",
                                    controller.model.mobile ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Gender",
                                    controller.model.gender ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Designation",
                                    controller.model.designation ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Department",
                                    controller.model.department ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Location",
                                    controller.model.location ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Have you ever been diagnosed with Covid-19?",
                                    controller.model.haveEverBeenCovid19 ??
                                        "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Is any member of your immediate family currently suffering from Covid 19?",
                                    controller.model.anyFamilyMember ?? "NA",
                                  ),
                                ],
                              ),
                            if (controller.model.type != null &&
                                controller.model.type == "Organizer")
                              Column(
                                children: [
                                  getDetailTile(
                                    context,
                                    "Full Name",
                                    controller.model.name ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Organization Name",
                                    controller.model.nameOfOrganization ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Email id",
                                    controller.model.email ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Mobile Number",
                                    controller.model.mobile ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Designation",
                                    controller.model.designation ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Department",
                                    controller.model.department ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "T-Shirt Size",
                                    controller.model.tShirtSize ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Have you ever been diagnosed with Covid-19?",
                                    controller.model.haveEverBeenCovid19 ??
                                        "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Is any member of your immediate family currently suffering from Covid 19?",
                                    controller.model.anyFamilyMember ?? "NA",
                                  ),
                                ],
                              ),
                            if (controller.model.type != null &&
                                controller.model.type == "Visitor")
                              Column(
                                children: [
                                  if (controller.model.name != null)
                                    getDetailTile(
                                      context,
                                      "Full Name",
                                      controller.model.name ?? "NA",
                                    ),
                                  if (controller.model.nameOfVisitor != null)
                                    getDetailTile(
                                      context,
                                      "Organization Name",
                                      controller.model.nameOfVisitor ?? "NA",
                                    ),
                                  if (controller.model.email != null)
                                    getDetailTile(
                                      context,
                                      "Email id",
                                      controller.model.email ?? "NA",
                                    ),
                                  if (controller.model.mobile != null)
                                    getDetailTile(
                                      context,
                                      "Mobile Number",
                                      controller.model.mobile ?? "NA",
                                    ),
                                  if (controller.model.designation != null)
                                    getDetailTile(
                                      context,
                                      "Designation",
                                      controller.model.designation ?? "NA",
                                    ),
                                  if (controller.model.location != null)
                                    getDetailTile(
                                      context,
                                      "Location",
                                      controller.model.location ?? "NA",
                                    ),
                                  if (controller.model.aadhar != null)
                                    getDetailTile(context, "ID Card",
                                        controller.model.aadhar ?? "NA",
                                        isDocument: true),
                                  if (controller.model.visitorType != null)
                                    getDetailTile(
                                      context,
                                      "Visitor Type",
                                      controller.model.visitorType ?? "NA",
                                    ),
                                  if ((controller.model.visitorType != null &&
                                      controller.model.visitorType == "Paid"))
                                    getDetailTile(
                                      context,
                                      "Receipt",
                                      controller.model.receiptVisitor ?? "NA",
                                      isDocument: true,
                                    ),
                                  if ((controller.model.visitorType != null &&
                                      controller.model.visitorType !=
                                          "Paid")) ...[
                                    if (controller.model.referenceEmail != null)
                                      getDetailTile(
                                        context,
                                        "Reference Email",
                                        controller.model.referenceEmail ?? "NA",
                                      ),
                                    if (controller.model.referenceName != null)
                                      getDetailTile(
                                        context,
                                        "Reference Name",
                                        controller.model.referenceName ?? "NA",
                                      ),
                                    if (controller.model.collageIdCard != null)
                                      getDetailTile(
                                        context,
                                        "Reference Email Document",
                                        controller.model.collageIdCard ?? "NA",
                                        isDocument: true,
                                      ),
                                  ],
                                  if (controller.model.haveEverBeenCovid19 !=
                                      null)
                                    getDetailTile(
                                      context,
                                      "Have you ever been diagnosed with Covid-19?",
                                      controller.model.haveEverBeenCovid19 ??
                                          "NA",
                                    ),
                                  if (controller.model.anyFamilyMember != null)
                                    getDetailTile(
                                      context,
                                      "Is any member of your immediate family currently suffering from Covid 19?",
                                      controller.model.anyFamilyMember ?? "NA",
                                    ),
                                ],
                              ),
                            if (controller.model.type != null &&
                                controller.model.type == "SoSE-Teacher")
                              Column(
                                children: [
                                  if (controller.studentName.isNotEmpty)
                                    getDetailTile(
                                      context,
                                      "Student Code",
                                      "${controller.model.collageName}-${controller.studentName}",
                                    ),
                                  getDetailTile(
                                    context,
                                    "Teacher Name",
                                    controller.model.name ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "School/Institute Name",
                                    controller.model.collageName ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Email id",
                                    controller.model.email ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Mobile Number",
                                    controller.model.mobile ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Location",
                                    controller.model.location ?? "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Have you ever been diagnosed with Covid-19?",
                                    controller.model.haveEverBeenCovid19 ??
                                        "NA",
                                  ),
                                  getDetailTile(
                                    context,
                                    "Is any member of your immediate family currently suffering from Covid 19?",
                                    controller.model.anyFamilyMember ?? "NA",
                                  ),
                                  if (controller.studentName.isEmpty)
                                    getDetailTile(
                                        context,
                                        "No. of Students",
                                        controller.model.studentQr != null
                                            ? "${controller.model.studentQr?.length}"
                                            : "0")
                                ],
                              ),
                            SizedBox(
                              height: getHeight(10, context),
                            ),
                            if (controller.model.qrImage != null)
                              Image.network(
                                controller.model.qrImage ?? "",
                                width: width(context) * 0.2,
                                height: width(context) * 0.2,
                              ),
                          ],
                        ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getDetailTile(BuildContext context, String title, String value,
      {bool isDocument = false, bool isType = false}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textStyle(
                context: context,
                isBold: true,
              ),
            ),
            isType
                ? Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.getColor(value),
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
                      ),
                    ),
                  )
                : Expanded(
                    child: isDocument
                        ? Bounce(
                            onPressed: () {
                              // launchUrl(Uri.parse(value));
                              controller.viewPDF(value, context);
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
                            textAlign: TextAlign.end,
                          ),
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
              width: getWidth(25, context),
              height: getWidth(25, context),
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
}
