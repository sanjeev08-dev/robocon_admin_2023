import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../detail/view.dart';
import '../helper/firebase_helper.dart';
import '../helper/registration_model.dart';
import '../helper/validation_helper.dart';

class RegistrationController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController personalEmailController;
  late TextEditingController collegeEmailController;
  late TextEditingController mobileNumberController;
  late TextEditingController parentNameController;
  late TextEditingController parentContactController;
  late TextEditingController currentAddressController;
  late TextEditingController permanentAddressController;
  late TextEditingController relativeNameController;
  late TextEditingController relativeContactController;
  late TextEditingController relativeAddressController;
  late TextEditingController collegeNameController;
  late TextEditingController departmentController;
  late TextEditingController currentSemController;
  late TextEditingController collegeAddressController;
  late TextEditingController emergencyCollegeContactController;
  late TextEditingController coordinatingFacultyNameController;
  late TextEditingController coordinatingFacultyContactController;
  late TextEditingController medicalFraternityController;
  late TextEditingController doctorContactController;
  late TextEditingController departureStationController;
  late TextEditingController arrivalStationController;
  late TextEditingController trainNameController;
  late TextEditingController trainNumberController;
  late TextEditingController fromDelhiDepartureController;
  late TextEditingController collegeGSTController;
  late TextEditingController referenceEmail;
  late TextEditingController referenceName;

  RegistrationModel registrationModel = RegistrationModel();
  bool isAadharUploading = false;
  bool isPhotoUploading = false;
  bool isCollegeIDUploading = false;
  bool isTicketsUploading = false;
  bool isTicketsDepartureUploading = false;
  bool isVisitorReceiptUploading = false;
  bool isRTPCRUploading = false;
  bool isLoading = false;

  bool isReadOnly = false;
  bool isRTPRCUploadingValid = false;

  @override
  void onInit() {
    nameController = TextEditingController();
    personalEmailController = TextEditingController();
    collegeEmailController = TextEditingController();
    mobileNumberController = TextEditingController();
    parentNameController = TextEditingController();
    parentContactController = TextEditingController();
    currentAddressController = TextEditingController();
    permanentAddressController = TextEditingController();
    relativeNameController = TextEditingController();
    relativeContactController = TextEditingController();
    relativeAddressController = TextEditingController();
    collegeNameController = TextEditingController();
    departmentController = TextEditingController();
    currentSemController = TextEditingController();
    collegeAddressController = TextEditingController();
    emergencyCollegeContactController = TextEditingController();
    coordinatingFacultyNameController = TextEditingController();
    coordinatingFacultyContactController = TextEditingController();
    medicalFraternityController = TextEditingController();
    doctorContactController = TextEditingController();
    departureStationController = TextEditingController();
    arrivalStationController = TextEditingController();
    trainNameController = TextEditingController();
    trainNumberController = TextEditingController();
    fromDelhiDepartureController = TextEditingController();
    collegeGSTController = TextEditingController();
    referenceEmail = TextEditingController();
    referenceName = TextEditingController();

    registrationModel.anyFamilyMember = "no";
    registrationModel.type = "Visitor";

    super.onInit();
  }

  void uploadAadhar(Uint8List? data) async {
    if (!Validator.validateEmail(personalEmailController.text.trim(),
        "Enter your email", "Email is invalid")) {
      return;
    }
    isAadharUploading = true;
    update();
    var downloadUrl = await FirebaseHelper.uploadFile(
        data!, "Aadhar.pdf", personalEmailController.text.trim());
    isAadharUploading = false;

    registrationModel.aadhar = downloadUrl;
    update();
  }

  void uploadProfilePhoto(Uint8List? data) async {
    if (!Validator.validateEmail(personalEmailController.text.trim(),
        "Enter your email", "Email is invalid")) {
      return;
    }
    isPhotoUploading = true;
    update();
    var downloadUrl = await FirebaseHelper.uploadFile(
        data!, "Photograph.jpg", personalEmailController.text.trim());
    isPhotoUploading = false;

    registrationModel.photograph = downloadUrl;
    update();
  }

  void registrationAsVisitor() async {
    if (registrationModel.anyFamilyMember == "yes") {
      Fluttertoast.showToast(msg: "You are not eligible for registration");
      return;
    }
    if (registrationModel.type == null) {
      Fluttertoast.showToast(msg: "Select your registration type");
      return;
    }
    if (collegeNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your Organization name");
      return;
    }
    if (!Validator.validateName(nameController.text.trim(),
        "Enter visitor name", "Visitor name is invalid")) {
      return;
    }
    /*if (!Validator.validatePhone(mobileNumberController.text.trim(), false,
        "Enter your mobile number", "Mobile number is invalid")) {
      return;
    }*/
    if (!Validator.validateEmail(personalEmailController.text.trim(),
        "Enter your email", "Email is invalid")) {
      return;
    }

    /*if (currentSemController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter your designation");
      return;
    }*/
    /*if (permanentAddressController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter location");
      return;
    }*/
    /*if (registrationModel.photograph == null) {
      Fluttertoast.showToast(msg: "Upload your passport size photo");
      return;
    }*/

    /*if (registrationModel.aadhar == null) {
      Fluttertoast.showToast(msg: "Upload your ID Card document.");
      return;
    }*/

    registrationModel.name = nameController.text.trim();
    registrationModel.email = personalEmailController.text.trim();
    registrationModel.mobile = mobileNumberController.text.trim();
    registrationModel.nameOfVisitor = collegeNameController.text.trim();
    registrationModel.designation = currentSemController.text.trim();
    registrationModel.location = permanentAddressController.text.trim();

    print(jsonEncode(registrationModel));
    isLoading = true;
    update();
    await FirebaseHelper.registerData(registrationModel);
    isLoading = false;
    update();
    Get.off(() => DetailView(
          email: personalEmailController.text.trim(),
        ));
  }
}
