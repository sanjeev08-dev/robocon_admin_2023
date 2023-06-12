import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../detail/view.dart';
import '../helper/firebase_helper.dart';
import '../helper/registration_model.dart';
import '../helper/responsive_widget.dart';

class SearchController extends GetxController {
  late StreamController<List<RegistrationModel>> streamController;

  RegistrationModel selectedData = RegistrationModel();
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    streamController = StreamController<List<RegistrationModel>>.broadcast();
    super.onInit();
  }

  void onDetailSelected(BuildContext context, RegistrationModel dataList,
      List<RegistrationModel> list) async {
    if (ResponsiveWidget.isSmallScreen(context)) {
      Get.to(() => DetailView(
            email: dataList.email ?? dataList.personalEmail ?? "",
          ));
    } else {
      selectedData = dataList;
      streamController.sink.add(list);

      // update();
    }
  }

  void verifyToggle(bool value, RegistrationModel dataList,
      List<RegistrationModel> list) async {
    dataList.isVerified = value;
    if (dataList.type == "Participant") {
      FirebaseHelper.registerDataParticipants(dataList).then((value) {});
    } else {
      FirebaseHelper.registerDataOthers(dataList).then((value) {});
    }
    selectedData = dataList;
    streamController.sink.add(list);

    // update();
  }

  onTextChange(String query) {
    if (query.trim().isNotEmpty) {
      FirebaseHelper.getSearchData(query).listen((event) {
        // print(event.length);
        if (!streamController.isClosed) {
          streamController.sink.add(event);
        }
      });
    }
  }

  void tShirtToggle(
      bool value, RegistrationModel dataList, List<RegistrationModel> list) {
    dataList.tShirtReceived = value;
    update();
    if (dataList.type == "Participant") {
      FirebaseHelper.registerDataParticipants(dataList).then((value) {
        // getAllUsersData();
        /*getVerifiedCount(true);
        getVerifiedCount(false);*/
      });
    } else {
      FirebaseHelper.registerDataOthers(dataList).then((value) {
        // getAllUsersData();
        /*getVerifiedCount(true);
        getVerifiedCount(false);*/
      });
    }
    selectedData = dataList;
    streamController.sink.add(list);
    // update();
  }

  @override
  void onClose() {
    print("Close Stream");
    // streamController.close();
    super.onClose();
  }
}
