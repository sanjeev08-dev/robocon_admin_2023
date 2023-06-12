import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robocon_admin_2023/helper/responsive_widget.dart';
import 'package:robocon_admin_2023/schedule_meetings/view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../detail/view.dart';
import '../helper/app_holder.dart';
import '../helper/firebase_helper.dart';
import '../helper/flutter_bounce.dart';
import '../helper/registration_model.dart';
import '../widgets/flutter_switch.dart';

class DataListController extends GetxController {
  bool isLoading = false;
  List<RegistrationModel> dataList = [];
  bool showMobile = false;

  // List<RegistrationModel> tabDataList = [];
  String? selectedTab;
  List<String> tabs = [
    // "Organizer",
    "DD",
    "Participant",
    "Sponsor",
    "Volunteer",
    "Visitor",
    // "SoSE-Teacher",
  ];
  int? sortColumnIndex;
  bool sortAscending = true;
  List<int> counts = [
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  List<RegistrationModel> allUserList = [];
  List<RegistrationModel> showUserList = [];
  List<RegistrationModel> userListDD = [];
  List<RegistrationModel> userListParticipant = [];
  List<RegistrationModel> userListSponsor = [];
  List<RegistrationModel> userListVolunteer = [];
  List<RegistrationModel> userListVisitor = [];

  int verifiedCount = 0;
  int unVerifiedCount = 0;
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "All"
  ];

  int currentAlphabet = 26;
  int currentCommittee = 0;
  int currentTeam = 0;
  int selectedUserIndex = 0;
  late ScrollController scrollController;

  @override
  void onInit() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset < 100) {
        print("Scroll Reset");
      }
    });
    // getCounts();
    getAllUsersData();

    // getVerifiedCount(true);
    // getVerifiedCount(false);
    /*FirebaseHelper.getAllTabData(selectedTab).then((value) {
      tabDataList = value;
      // print(jsonEncode(value));
      update();
    });*/
    super.onInit();
  }

  void onTabChange(String value) {
    /*if (selectedTab == value) {
      return;
    }*/
    selectedUserIndex = 0;
    selectedTab = value;
    if (value == "Volunteer") {
      // getDataVolunteer(AppHolder.committeeList[currentCommittee]);
    } else {
      /*FirebaseHelper.getAllTabData(value).then((dataValue) {
        tabDataList = dataValue;
        // print(jsonEncode(value));
        update();
      });*/
      // getData(selectedTab??"");
    }
  }

  void onCommitteeTabChange(int value) {
    selectedUserIndex = 0;
    if (currentCommittee == value) {
      return;
    }

    currentCommittee = value;
    // getDataVolunteer(AppHolder.committeeList[currentCommittee]);
    // getAllUsersData();
  }

  void onTeamTabChange(int value) {
    // currentTeam = 0;
    // if (currentTeam == value) {
    //   return;
    // }

    currentTeam = value;
    // getDataVolunteer(AppHolder.committeeList[currentCommittee]);
    // getAllUsersData();
  }

  void onAlphabetTabChange(int value) {
    selectedUserIndex = 0;
    if (currentAlphabet == value) {
      return;
    }

    currentAlphabet = value;
    // getData(selectedTab);
    // getAllUsersData();
  }

  /*void getData(String selectedTab) async {
    isLoading = true;
    update();
    if (currentAlphabet == 26) {
      dataList = await FirebaseHelper.getAllTabData(selectedTab);
    } else if (currentAlphabet < 25) {
      dataList = await FirebaseHelper.getAllData(selectedTab,
          alphabets[currentAlphabet], alphabets[currentAlphabet + 1]);
    } else {
      dataList = await FirebaseHelper.getAllDataLast(
          selectedTab, alphabets[currentAlphabet]);
    }
    isLoading = false;
    update();
  }*/

  void getVerifiedData(String selectedTab, bool verified) async {
    isLoading = true;
    update();
    if (currentAlphabet == 26) {
      dataList =
          await FirebaseHelper.getAllTabVerifiedData(selectedTab, verified);
    } else if (currentAlphabet < 25) {
      dataList = await FirebaseHelper.getAllVerifiedData(selectedTab,
          alphabets[currentAlphabet], alphabets[currentAlphabet + 1], verified);
    } else {
      dataList = await FirebaseHelper.getAllDataLast(
          selectedTab, alphabets[currentAlphabet]);
    }
    isLoading = false;
    update();
  }

  void verifyToggle(bool value, String userEmail, bool isNormal) async {
    RegistrationModel user;
    if (isNormal) {
      user = dataList.where((element) => element.email == userEmail).first;
    } else {
      user =
          dataList.where((element) => element.personalEmail == userEmail).first;
    }
    user.isVerified = value;
    update();
    /*if (selectedTab == "Participant") {
      await FirebaseHelper.registerDataParticipants(user);
    } else {
      await FirebaseHelper.registerDataOthers(user);
    }
    getAllUsersData();*/
  }

  void tShirtToggle(bool value, String userEmail, bool isNormal) async {
    RegistrationModel user;
    if (isNormal) {
      user = dataList.where((element) => element.email == userEmail).first;
    } else {
      user = dataList.where((element) => element.email == userEmail).first;
    }
    user.tShirtReceived = value;
    update();
    /*if (selectedTab == "Participant") {
      FirebaseHelper.registerDataParticipants(user).then((value) {
        getAllUsersData();
        */ /*getVerifiedCount(true);
        getVerifiedCount(false);*/ /*
      });
    } else {
      FirebaseHelper.registerDataOthers(user).then((value) {
        getAllUsersData();
        */ /*getVerifiedCount(true);
        getVerifiedCount(false);*/ /*
      });
    }
    update();*/
  }

  Future<void> getCounts() async {
    await getStudentCounts();

    /*for (var item in tabs) {
      if (item != "Student") {
        FirebaseHelper.getUserCount(item).then((data) {
          counts[tabs.indexOf(item)] = counts[tabs.indexOf(item)] + data;
           update();
        });
      }
    }*/
  }

  /* void getDataVolunteer(String committeeList) async {
    isLoading = true;
    update();
    dataList = await FirebaseHelper.getVolunteerData(committeeList);
    isLoading = false;
    update();
  }*/

  Future<void> getStudentCounts() async {
    FirebaseHelper.getAllTabData("SoSE-Teacher").then((data) {
      if (data.isNotEmpty) {
        int countsValue = 0;
        for (var item in data) {
          if (item.studentQr != null) {
            countsValue = countsValue + item.studentQr!.length;
          }
        }
        counts[tabs.indexOf("SoSE-Teacher")] =
            counts[tabs.indexOf("SoSE-Teacher")] + countsValue;
        update();
      }
    });
  }

  /*void getUnverified() async {
    getVerifiedData(selectedTab ?? "", false);
  }

  void getVerified() {
    getVerifiedData(selectedTab ?? "", true);
  }*/

  void onDetailSelected(BuildContext context, int index) async {
    if (ResponsiveWidget.isSmallScreen(context)) {
      Get.to(() => DetailView(
            email: dataList[index].email ?? dataList[index].personalEmail ?? "",
          ));
    } else {
      selectedUserIndex = index;
      update();
    }
  }

  void getAllUsersData() async {
    allUserList = await FirebaseHelper.getAllUsersData();
    userListDD = allUserList.where((element) => element.type == "DD").toList();
    userListParticipant =
        allUserList.where((element) => element.type == "Participant").toList();
    userListSponsor =
        allUserList.where((element) => element.type == "Sponsor").toList();
    userListVolunteer =
        allUserList.where((element) => element.type == "Volunteer").toList();
    userListVisitor =
        allUserList.where((element) => element.type == "Visitor").toList();
    if (selectedTab == null) {
      if (userListDD.isNotEmpty) {
        selectedTab = "DD";
      } else if (userListParticipant.isNotEmpty) {
        selectedTab = "Participant";
      } else if (userListSponsor.isNotEmpty) {
        selectedTab = "Sponsor";
      } else if (userListVolunteer.isNotEmpty) {
        selectedTab = "Volunteer";
      } else if (userListVisitor.isNotEmpty) {
        selectedTab = "Visitor";
      }
    }
    if (selectedTab == "Volunteer") {
      showUserList = userListVolunteer.where((element) => element.comitteeName==AppHolder.committeeList[currentCommittee]).toList();
    } else if (selectedTab == "Participant") {
      showUserList = userListParticipant.where((element) => element.team==AppHolder.teamsList.keys.toList()[currentTeam]).toList();
    } else {
      if(selectedTab=="DD"){
        showUserList = userListDD;
      }
      if(selectedTab=="Sponsor"){
        showUserList = userListSponsor;
      }
      if(selectedTab=="Visitor"){
        showUserList = userListVisitor;
      }
    }
    update();
  }

  void manageMeeting() {
    Get.to(() => MeetingView());
  }

/*Future<void> getDataParticipant(String list) async {
    isLoading = true;
    update();
    dataList = await FirebaseHelper.getAllTabData("Participant");
    dataList = dataList.where((element) => element.team==list).toList();
    isLoading = false;
    update();
  }*/
}
