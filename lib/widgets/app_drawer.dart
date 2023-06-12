import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robocon_admin_2023/login/view.dart';
import 'package:robocon_admin_2023/widgets/large/button.dart';

import '../data_list/controller.dart';
import '../helper/app_holder.dart';
import '../helper/flutter_bounce.dart';
import '../helper/styles.dart';
import '../logs/view.dart';
import '../main.dart';
import '../registration/view.dart';

class AppDrawer extends StatelessWidget {
  DataListController controller;

  AppDrawer({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 0.3,
      height: height(context),
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Bounce(
              onPressed: () {
                Get.back();
                if (AppHolder.loginAs == "admin") {
                  Get.to(() => LogsView());
                } else {
                  Get.to(() => const RegistrationView());
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(
                    getWidth(
                      100,
                      context,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Text(
                  AppHolder.loginAs == "admin"
                      ? "Attendance"
                      : "New Registration",
                  style: textStyle(
                    context: context,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (AppHolder.loginAs == "admin")
              SizedBox(
                height: 5,
              ),
            if (AppHolder.loginAs == "admin")
              Bounce(
                onPressed: controller.manageMeeting,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.cyan[800],
                    borderRadius: BorderRadius.circular(
                      getWidth(
                        100,
                        context,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Text(
                    "Schedule Meetings",
                    style: textStyle(
                      context: context,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow[800],
                borderRadius: BorderRadius.circular(
                  getWidth(
                    100,
                    context,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Text(
                "Total : ${controller.allUserList.length}",
                style: textStyle(
                  context: context,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Wrap(
              spacing: 10,
              children: [
                Bounce(
                  onPressed: controller.getVerified,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                      borderRadius: BorderRadius.circular(
                        getWidth(
                          100,
                          context,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Text(
                      "Verified : ${controller.allUserList.where((element) => element.isVerified == true).length}",
                      style: textStyle(
                        context: context,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Bounce(
                  onPressed: controller.getUnverified,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red[800],
                      borderRadius: BorderRadius.circular(
                        getWidth(
                          100,
                          context,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Text(
                      "No Verified : ${controller.allUserList.where((element) => element.isVerified == false).length}",
                      style: textStyle(
                        context: context,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                controller.tabs.length,
                (index) => controller.allUserList
                        .where(
                            (element) => element.type == controller.tabs[index])
                        .isNotEmpty
                    ? Bounce(
                        onPressed: () {
                          controller.onTabChange(controller.tabs[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                controller.tabs[index] == controller.selectedTab
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          child: Column(
                            children: [
                              Text(
                                controller.tabs[index] == "DD"
                                    ? "Doordarshan"
                                    : controller.tabs[index],
                                style: textStyle(
                                  context: context,
                                  color: controller.tabs[index] !=
                                          controller.selectedTab
                                      ? Theme.of(context).primaryColor
                                      : Colors.white,
                                  isBold: controller.tabs[index] ==
                                      controller.selectedTab,
                                ),
                              ),
                              Text(
                                "${controller.allUserList.where((element) => element.type == controller.tabs[index]).length}",
                                style: textStyle(
                                  context: context,
                                  fontSize: FontSize.H1,
                                  color: controller.tabs[index] !=
                                          controller.selectedTab
                                      ? Theme.of(context).primaryColor
                                      : Colors.white,
                                  isBold: controller.tabs[index] ==
                                      controller.selectedTab,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.red[800],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    child: Text(
                                      "${controller.allUserList.where((element) => element.type == controller.tabs[index] && element.isVerified == false).length}",
                                      style: textStyle(
                                        context: context,
                                        color: Colors.white,
                                        isBold: index ==
                                            controller.currentCommittee,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.green[800],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    child: Text(
                                      "${controller.allUserList.where((element) => element.type == controller.tabs[index] && element.isVerified == true).length}",
                                      style: textStyle(
                                        context: context,
                                        color: Colors.white,
                                        isBold: index ==
                                            controller.currentCommittee,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 0,
                        height: 0,
                      ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (controller.selectedTab != "Volunteer" &&controller.selectedTab != "Participant" &&
                controller.allUserList.isNotEmpty)
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  controller.alphabets.length,
                  (index) => index == 26
                      ? Bounce(
                          onPressed: () {
                            controller.onAlphabetTabChange(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: index == controller.currentAlphabet
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                getWidth(1, context),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            child: Text(
                              controller.alphabets[index],
                              style: textStyle(
                                context: context,
                                color: index != controller.currentAlphabet
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                isBold: index == controller.currentAlphabet,
                              ),
                            ),
                          ),
                        )
                      : controller.allUserList
                              .where((element) =>
                                  element.name!.toUpperCase().startsWith(
                                      controller.alphabets[index]) &&
                                  element.type == controller.selectedTab)
                              .isNotEmpty
                          ? Bounce(
                              onPressed: () {
                                controller.onAlphabetTabChange(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: index == controller.currentAlphabet
                                      ? Theme.of(context).primaryColor
                                      : Colors.white,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    getWidth(1, context),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 5,
                                ),
                                child: Text(
                                  controller.alphabets[index],
                                  style: textStyle(
                                    context: context,
                                    color: index != controller.currentAlphabet
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    isBold: index == controller.currentAlphabet,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                border: Border.all(
                                  color: Colors.grey[800]!,
                                ),
                                borderRadius: BorderRadius.circular(
                                  getWidth(1, context),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 5,
                              ),
                              child: Text(
                                controller.alphabets[index],
                                style: textStyle(
                                  context: context,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                ),
              ),
            if (controller.selectedTab == "Volunteer")
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                    AppHolder.committeeList.length,
                    (index) => Bounce(
                          onPressed: () {
                            controller.onCommitteeTabChange(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: index == controller.currentCommittee
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                getWidth(1, context),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppHolder.committeeList[index],
                                  style: textStyle(
                                    context: context,
                                    color: index != controller.currentCommittee
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    isBold:
                                        index == controller.currentCommittee,
                                  ),
                                ),
                                Text(
                                  AppHolder.committeeList[index]=="All"?"${controller.allUserList.where((element) => element.type == "Volunteer").length}":"${controller.allUserList.where((element) => element.type == "Volunteer" && element.comitteeName == AppHolder.committeeList[index]).length}",
                                  style: textStyle(
                                    context: context,
                                    color: index != controller.currentCommittee
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    isBold:
                                        index == controller.currentCommittee,
                                    fontSize: FontSize.H4,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.red[800],
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      child: Text(
                                        AppHolder.committeeList[index]=="All"?"${controller.allUserList.where((element) => element.type == "Volunteer" && element.isVerified == false).length}":"${controller.allUserList.where((element) => element.type == "Volunteer" && element.comitteeName == AppHolder.committeeList[index] && element.isVerified == false).length}",
                                        style: textStyle(
                                          context: context,
                                          color: Colors.white,
                                          isBold: index ==
                                              controller.currentCommittee,
                                          fontSize: FontSize.H5,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.green[800],
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      child: Text(
                                        AppHolder.committeeList[index]=="All"?"${controller.allUserList.where((element) => element.type == "Volunteer" && element.isVerified == true).length}":"${controller.allUserList.where((element) => element.type == "Volunteer" && element.comitteeName == AppHolder.committeeList[index] && element.isVerified == true).length}",
                                        style: textStyle(
                                          context: context,
                                          color: Colors.white,
                                          isBold: index ==
                                              controller.currentCommittee,
                                          fontSize: FontSize.H5,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
              ),
            if (controller.selectedTab == "Participant")
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                    AppHolder.teamsList.keys.length,
                        (index) => Bounce(
                      onPressed: () {
                        controller.onTeamTabChange(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: index == controller.currentTeam
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            getWidth(1, context),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppHolder.teamsList.keys.toList()[index],
                              style: textStyle(
                                context: context,
                                color: index != controller.currentTeam
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                isBold:
                                index == controller.currentTeam,
                              ),
                            ),
                            Text(
                              AppHolder.teamsList.keys.toList()[index]=="All"?"${controller.allUserList.where((element) => element.type == "Participant").length}":"${controller.allUserList.where((element) => element.type == "Participant" && element.team == AppHolder.teamsList.keys.toList()[index]).length}",
                              style: textStyle(
                                context: context,
                                color: index != controller.currentTeam
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                isBold:
                                index == controller.currentTeam,
                                fontSize: FontSize.H4,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.red[800],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  child: Text(
                                    AppHolder.teamsList.keys.toList()[index]=="All"?"${controller.allUserList.where((element) => element.type == "Participant" && element.isVerified == false).length}":"${controller.allUserList.where((element) => element.type == "Participant" && element.team == AppHolder.teamsList.keys.toList()[index] && element.isVerified == false).length}",
                                    style: textStyle(
                                      context: context,
                                      color: Colors.white,
                                      isBold: index ==
                                          controller.currentTeam,
                                      fontSize: FontSize.H5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.green[800],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  child: Text(
                                    AppHolder.teamsList.keys.toList()[index]=="All"?"${controller.allUserList.where((element) => element.type == "Participant" && element.isVerified == true).length}":"${controller.allUserList.where((element) => element.type == "Participant" && element.team == AppHolder.teamsList.keys.toList()[index] && element.isVerified == true).length}",
                                    style: textStyle(
                                      context: context,
                                      color: Colors.white,
                                      isBold: index ==
                                          controller.currentTeam,
                                      fontSize: FontSize.H5,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            SizedBox(
              height: 5,
            ),
            AppButton(
              padding: 4,
              text: "Log out ${AppHolder.loginAs.toUpperCase()}",
              onTap: () async {
                await prefs.clearUser();
                Get.offAll(() => const LoginView());
              },
            )
          ],
        ),
      ),
    );
  }
}
