import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:robocon_admin_2023/helper/prefs.dart';
import 'package:robocon_admin_2023/main.dart';

import '../data_list/view.dart';
import '../helper/app_holder.dart';

class LoginController extends GetxController {
  bool isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  // Map<String, dynamic> authentication = {"username": "", "password": ""};
  List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList = [];

  @override
  void onInit() {
    checkLogin();
    getAdminData();
    super.onInit();
  }

  Future<void> login(BuildContext context) async {
    // Get.to(() => const DataListView());
    /*if (authentication["username"].toString().isNotEmpty &&
        authentication["password"].toString().isNotEmpty) {
      if (usernameController.text.trim() ==
              authentication["username"].toString().trim() &&
          passwordController.text.trim() ==
              authentication["password"].toString().trim()) {
        Get.to(() => const DataListView());
      } else {
        Fluttertoast.showToast(msg: "Invalid Username or password");
      }
    } else {
      Fluttertoast.showToast(msg: "Admin Data Not Found");
    }*/
    if (usernameController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Enter username");
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Enter password");
      return;
    }
    if (dataList.isNotEmpty) {
      Iterable<QueryDocumentSnapshot<Map<String, dynamic>>> matchedData =
          dataList.where((element) =>
              element.data()["username"] == usernameController.text.trim() &&
              element.data()["password"] == passwordController.text.trim());
      if (matchedData.isNotEmpty) {
        QueryDocumentSnapshot<Map<String, dynamic>> dataItem =
            matchedData.first;
        AppHolder.loginAs = dataItem.id;
        await prefs.saveUser(
          UserModel(
            email: usernameController.text.trim(),
            password: passwordController.text.trim(),
            type: dataItem.id,
          ),
        );
        Get.off(() => DataListView());
      } else {
        Fluttertoast.showToast(msg: "Invalid Username or password");
      }
    } else {
      Fluttertoast.showToast(msg: " Data Not Found");
    }
  }

  void getAdminData() async {
    /*DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("admin").doc("admin").get();
    authentication = snapshot.data() ?? {"username": "", "password": ""};*/
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("admin").get();
    dataList = snapshot.docs;
  }

  void checkLogin() async {
    var user = await prefs.getUser();
    if (user.type != null) {
      AppHolder.loginAs = user.type ?? "";
      Get.off(() => DataListView());
    }
  }
}
