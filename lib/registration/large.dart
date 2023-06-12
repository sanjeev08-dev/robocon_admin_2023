import 'package:flutter/material.dart';

import '../helper/styles.dart';
import '../widgets/large/button.dart';
import '../widgets/large/line_title.dart';
import '../widgets/large/my_file_picker.dart';
import '../widgets/large/text_field_container.dart';
import '../widgets/large/yes_no_button.dart';
import 'controller.dart';

class Large extends StatelessWidget {
  RegistrationController controller;

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
                  // padding: EdgeInsets.all(
                  //   getWidth(20, context),
                  // ),
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
                  child: Column(
                    children: [
                      Text(
                        "Robocon Visitors Registration",
                        style: textStyle(
                          context: context,
                          fontSize: FontSize.H1,
                          isBold: true,
                        ),
                      ),
                      Column(
                        children: [
                          LineTitleWidget(title: "Personal Details"),
                          /*if (controller.registrationModel.visitorType !=
                                    null &&
                                controller.registrationModel.visitorType ==
                                    "Paid") ...[
                              getDetailTile(
                                context,
                                "Account Number",
                                "00000039508578635",
                              ),
                              getDetailTile(
                                context,
                                "Account Type",
                                "Current Account",
                              ),
                              getDetailTile(
                                context,
                                "IFSC Code",
                                "SBIN0001077",
                              ),
                              getDetailTile(
                                context,
                                "Name",
                                "I-HUB FOUNDATION FOR COBOTICS",
                              ),
                              getDetailTile(
                                context,
                                "Branch",
                                "IIT DELHI, New Delhi",
                              ),
                            ],*/
                          GridView.count(
                            crossAxisCount: 2,
                            physics: NeverScrollableScrollPhysics(),
                            childAspectRatio: 6,
                            shrinkWrap: true,
                            children: [
                              TextFieldContainer(
                                textEditingController:
                                    controller.collegeNameController,
                                title: "Name of organization *",
                                hint: "name",
                                isLastField: false,
                                keyboardType: TextInputType.name,
                              ),
                              TextFieldContainer(
                                textEditingController:
                                    controller.nameController,
                                title: "Name of visitor *",
                                hint: "name",
                                isLastField: false,
                                keyboardType: TextInputType.name,
                              ),
                              TextFieldContainer(
                                textEditingController:
                                    controller.mobileNumberController,
                                title: "Mobile Number",
                                hint: "phone",
                                isLastField: false,
                                keyboardType: TextInputType.phone,
                              ),
                              TextFieldContainer(
                                textEditingController:
                                    controller.personalEmailController,
                                title: "Email id *",
                                hint: "email",
                                isLastField: false,
                                readOnly: controller.isReadOnly,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              TextFieldContainer(
                                textEditingController:
                                    controller.currentSemController,
                                title: "Designation",
                                hint: "address",
                                isLastField: false,
                                keyboardType: TextInputType.name,
                              ),
                              TextFieldContainer(
                                textEditingController:
                                    controller.permanentAddressController,
                                title: "Location",
                                hint: "address",
                                isLastField: false,
                                keyboardType: TextInputType.name,
                              ),
                              FilePickerButton(
                                title: "Upload Your Passport Size Photograph",
                                onFileSelected: controller.uploadProfilePhoto,
                                extensions: const ['jpg', 'png'],
                                isLoading: controller.isPhotoUploading,
                                filePath:
                                    controller.registrationModel.photograph,
                              ),
                              FilePickerButton(
                                title: "Upload Your ID Card",
                                onFileSelected: controller.uploadAadhar,
                                extensions: const ['pdf'],
                                isLoading: controller.isAadharUploading,
                                filePath: controller.registrationModel.aadhar,
                              ),
                              YesNoButton(
                                title:
                                    "Is any member of your immediate family currently suffering from Covid 19? *",
                                isShow: controller
                                        .registrationModel.anyFamilyMember ==
                                    "yes",
                                onChanges: (value) {
                                  if (value) {
                                    controller.registrationModel
                                        .anyFamilyMember = "yes";
                                  } else {
                                    controller.registrationModel
                                        .anyFamilyMember = "no";
                                  }
                                  controller.update();
                                },
                              ),
                            ],
                          ),
                          if (controller.registrationModel.anyFamilyMember ==
                              "yes")
                            Text(
                              "You are not eligible for registration",
                              style: textStyle(
                                context: context,
                                isBold: true,
                                color: Colors.red[800],
                              ),
                            ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: getWidth(100, context),
                            ),
                            child: AppButton(
                              text: "Submit",
                              onTap: controller.registrationAsVisitor,
                              isLoading: controller.isLoading,
                            ),
                          ),
                        ],
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
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getWidth(15, context),
      ),
      child: Column(
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
              Expanded(
                child: Text(
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
      ),
    );
  }
}
