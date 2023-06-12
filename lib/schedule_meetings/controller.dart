import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:robocon_admin_2023/helper/date_format_helper.dart';
import 'package:robocon_admin_2023/helper/meeting_model.dart';
import 'package:robocon_admin_2023/logs/view.dart';

import '../helper/firebase_helper.dart';

class MeetingController extends GetxController {
  List<MeetingModel> meetings = [];
  TextEditingController agendaController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isLoading = false;

  @override
  void onInit() {}

  Future<void> openDateDialog(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //get today's date
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2024));
    if (pickedDate != null) {
      dateController.text =
          DateFormatHelper.convertDateFromDate(pickedDate, "dd-MM-yyyy");
      update();
    }
  }

  void deleteMeetingData(MeetingModel dataList) {
    FirebaseHelper.deleteMeeting(dataList);
  }

  Future<void> scheduleMeeting() async {
    if (agendaController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter Meeting Agenda");
      return;
    }
    if (dateController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter Meeting Agenda");
      return;
    }
    MeetingModel model = MeetingModel(
        agenda: agendaController.text.trim(), date: dateController.text.trim());
    isLoading = true;
    update();
    await FirebaseHelper.addMeeting(model);
    agendaController.clear();
    dateController.clear();
    isLoading = false;
    update();
  }

  void getAttendance(MeetingModel dataList) {
    Get.to(()=>LogsView(model: dataList,));
  }
}
