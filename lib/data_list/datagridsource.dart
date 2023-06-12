import 'dart:convert';
import 'dart:math' as math;

/// Package imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:robocon_admin_2023/detail/view.dart';
import 'package:robocon_admin_2023/helper/flutter_bounce.dart';
import 'package:robocon_admin_2023/helper/styles.dart';
import 'package:robocon_admin_2023/widgets/detail_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../helper/app_holder.dart';
import '../helper/registration_model.dart';
import '../widgets/flutter_switch.dart';
import 'controller.dart';

class DataInfoDataGridSource extends DataGridSource {
  /// Creates the order data source class with required details.
  DataInfoDataGridSource(
      {required this.isWebOrDesktop,
      this.orderDataCount,
      required this.ordersCollection,
      this.culture,
      required this.dataListController,
      required this.context,
      bool? isFilteringSample}) {
    this.isFilteringSample = isFilteringSample ?? false;
    orders = ordersCollection;

    buildDataGridRows();
  }

  /// Determine to decide whether the platform is web or desktop.
  final bool isWebOrDesktop;
  final DataListController dataListController;
  final BuildContext context;

  /// Localization Source.
  String? culture;

  /// Get data count of an order.
  int? orderDataCount;
  final math.Random _random = math.Random();

  /// Instance of an order.
  List<RegistrationModel> orders = <RegistrationModel>[];

  /// Instance of an order collection for rtl sample
  List<RegistrationModel> ordersCollection;

  /// Instance of DataGridRow.
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  /// Currency symbol for culture.
  String currencySymbol = '';

  /// Checks whether the source is used for the filtering sample or not.
  late bool isFilteringSample;

  /// Building DataGridRows.
  void buildDataGridRows() {
    dataGridRows = isWebOrDesktop
        ? orders.map<DataGridRow>((RegistrationModel order) {
            if (dataListController.selectedTab == "Organizer" ||
                dataListController.selectedTab == "Volunteer") {
              return DataGridRow(cells: <DataGridCell>[
                DataGridCell<String>(
                    columnName: getColumnName('pic'), value: jsonEncode(order)),
                DataGridCell<String>(
                    columnName: getColumnName('name'), value: order.name),
                DataGridCell<String>(
                    columnName: getColumnName('email'), value: order.email),
                DataGridCell<String>(
                    columnName: getColumnName('mobile'), value: order.mobile),
                DataGridCell<String>(
                    columnName: getColumnName('name_of_organization'),
                    value: dataListController.selectedTab == "Organizer"
                        ? order.nameOfOrganization
                        : order.nameOfVolunteer),
                if (dataListController.selectedTab == "Volunteer")
                  DataGridCell<String>(
                      columnName: getColumnName('committee'),
                      value: order.comitteeName),
                DataGridCell<String>(
                    columnName: getColumnName('t_shirt_size'),
                    value: order.tShirtSize),
                DataGridCell<bool>(
                    columnName: getColumnName('t_shirt_received'),
                    value: order.tShirtReceived),
                DataGridCell<bool>(
                    columnName: getColumnName('verified'),
                    value: order.isVerified),
              ]);
            } else if (dataListController.selectedTab == "DD") {
              return DataGridRow(cells: <DataGridCell>[
                DataGridCell<String>(
                    columnName: getColumnName('pic'), value: jsonEncode(order)),
                DataGridCell<String>(
                    columnName: getColumnName('name'), value: order.name),
                DataGridCell<String>(
                    columnName: getColumnName('email'), value: order.email),
                DataGridCell<String>(
                    columnName: getColumnName('mobile'), value: order.mobile),
                DataGridCell<bool>(
                    columnName: getColumnName('verified'),
                    value: order.isVerified),
              ]);
            } else if (dataListController.selectedTab == "Sponsor") {
              return DataGridRow(cells: <DataGridCell>[
                DataGridCell<String>(
                    columnName: getColumnName('pic'), value: jsonEncode(order)),
                DataGridCell<String>(
                    columnName: getColumnName('name'), value: order.name),
                DataGridCell<String>(
                    columnName: getColumnName('email'), value: order.email),
                DataGridCell<String>(
                    columnName: getColumnName('mobile'), value: order.mobile),
                DataGridCell<String>(
                    columnName: getColumnName('name_of_organization'),
                    value: order.nameOfSponsor),
                DataGridCell<bool>(
                    columnName: getColumnName('verified'),
                    value: order.isVerified),
              ]);
            } else if (dataListController.selectedTab == "Visitor") {
              return DataGridRow(cells: <DataGridCell>[
                DataGridCell<String>(
                    columnName: getColumnName('pic'), value: jsonEncode(order)),
                DataGridCell<String>(
                    columnName: getColumnName('name'), value: order.name),
                DataGridCell<String>(
                    columnName: getColumnName('email'), value: order.email),
                DataGridCell<String>(
                    columnName: getColumnName('mobile'), value: order.mobile),
                DataGridCell<String>(
                    columnName: getColumnName('name_of_organization'),
                    value: order.nameOfVisitor),
                DataGridCell<String>(
                    columnName: getColumnName('aadhar'), value: order.aadhar),
                DataGridCell<bool>(
                    columnName: getColumnName('verified'),
                    value: order.isVerified),
              ]);
            } else if (dataListController.selectedTab == "Participant") {
              return DataGridRow(cells: <DataGridCell>[
                DataGridCell<String>(
                    columnName: getColumnName('pic'), value: jsonEncode(order)),
                DataGridCell<String>(
                    columnName: getColumnName('name'), value: order.name),
                DataGridCell<String>(
                    columnName: getColumnName('email'),
                    value: order.personalEmail),
                DataGridCell<String>(
                    columnName: getColumnName('gender'),
                    value: order.gender),
                DataGridCell<String>(
                    columnName: getColumnName('mobile'),
                    value: order.mobileNumber),
                DataGridCell<String>(
                    columnName: getColumnName('team'), value: order.team),
                DataGridCell<String>(
                    columnName: getColumnName('college'),
                    value: order.collageName),
                DataGridCell<String>(
                    columnName: getColumnName('member_type'),
                    value: order.memberType),
                DataGridCell<bool>(
                    columnName: getColumnName('stay_in_iit'),
                    value: order.stayInIIT),
                DataGridCell<String>(
                    columnName: getColumnName('aadhar'), value: order.aadhar),
                DataGridCell<String>(
                    columnName: getColumnName('college_id'), value: order.collageIdCard),
                DataGridCell<bool>(
                    columnName: getColumnName('verified'),
                    value: order.isVerified),
              ]);
            } else {
              return DataGridRow(cells: <DataGridCell>[
                DataGridCell<String>(
                    columnName: getColumnName('name'), value: order.name),
                DataGridCell<String>(
                    columnName: getColumnName('email'), value: order.email),
              ]);
            }
          }).toList()
        : orders.map<DataGridRow>((RegistrationModel order) {
            return DataGridRow(cells: <DataGridCell>[
              DataGridCell<String>(
                  columnName: getColumnName('name'), value: order.name),
              DataGridCell<String>(
                  columnName: getColumnName('email'), value: order.email),
            ]);
          }).toList();
  }

  // Overrides

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = dataGridRows.indexOf(row);
    Color backgroundColor = Colors.transparent;
    if (isWebOrDesktop) {
      if (dataListController.selectedTab == "Organizer" ||
          dataListController.selectedTab == "Volunteer") {
        return DataGridRowAdapter(
            color: backgroundColor,
            cells: List.generate(row.getCells().length, (index) {
              if (index == 0) {
                RegistrationModel registrationModel =
                RegistrationModel.fromJson(
                    jsonDecode(row.getCells()[index].value.toString()));
                return Bounce(
                  onPressed: () {
                    Get.dialog(
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.symmetric(
                            vertical: 20, horizontal: width(context) * 0.25),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: SingleChildScrollView(
                            child: DetailWidget(
                              model: registrationModel,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(-3, 3),
                          blurRadius: 6,
                          color: Colors.grey,
                        ),
                      ],
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        registrationModel.photograph ?? "",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
              if ((index == 6 || index == 7) &&
                  dataListController.selectedTab == "Organizer" &&
                  row.getCells()[4].value.toString() == "DD") {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: row.getCells()[index].value.toString() == "true"
                          ? Colors.green[800]!
                          : Colors.red[800]!,
                      borderRadius: BorderRadius.circular(2000),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text(
                      "Not Eligible",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              }
              if (index ==
                  (dataListController.selectedTab == "Organizer" ? 6 : 7)) {
                return FlutterSwitch(
                  value: row.getCells()[index].value.toString() == "true",
                  activeColor: Colors.green[800]!,
                  inactiveColor: Colors.red[800]!,
                  onToggle: (val) {
                    dataListController.tShirtToggle(
                        val, row.getCells()[2].value.toString(), true);
                  },
                );
              }
              if (index ==
                  (dataListController.selectedTab == "Organizer" ? 7 : 8)) {
                return AppHolder.loginAs != "admin"
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                row.getCells()[index].value.toString() == "true"
                                    ? Colors.green[800]!
                                    : Colors.red[800]!,
                            borderRadius: BorderRadius.circular(2000),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            row.getCells()[index].value.toString() == "true"
                                ? "Verified"
                                : "Not Verified",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    : FlutterSwitch(
                        value: row.getCells()[index].value.toString() == "true",
                        activeColor: Colors.green[800]!,
                        inactiveColor: Colors.red[800]!,
                        onToggle: (val) {
                          dataListController.verifyToggle(
                              val, row.getCells()[2].value.toString(), true);
                        },
                      );
              }
              return Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerRight,
                child: Text(
                  row.getCells()[index].value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }));
      } else if (dataListController.selectedTab == "DD") {
        return DataGridRowAdapter(
            color: backgroundColor,
            cells: List.generate(row.getCells().length, (index) {
              if (index == 0) {
                RegistrationModel registrationModel =
                RegistrationModel.fromJson(
                    jsonDecode(row.getCells()[index].value.toString()));
                return Bounce(
                  onPressed: () {
                    Get.dialog(
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.symmetric(
                            vertical: 20, horizontal: width(context) * 0.25),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: SingleChildScrollView(
                            child: DetailWidget(
                              model: registrationModel,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(-3, 3),
                          blurRadius: 6,
                          color: Colors.grey,
                        ),
                      ],
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        registrationModel.photograph ?? "",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
              if (index == 4) {
                return AppHolder.loginAs != "admin"
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                row.getCells()[index].value.toString() == "true"
                                    ? Colors.green[800]!
                                    : Colors.red[800]!,
                            borderRadius: BorderRadius.circular(2000),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            row.getCells()[index].value.toString() == "true"
                                ? "Verified"
                                : "Not Verified",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    : FlutterSwitch(
                        value: row.getCells()[index].value.toString() == "true",
                        activeColor: Colors.green[800]!,
                        inactiveColor: Colors.red[800]!,
                        onToggle: (val) {
                          dataListController.verifyToggle(
                              val, row.getCells()[2].value.toString(), true);
                        },
                      );
              }
              return Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerRight,
                child: Text(
                  row.getCells()[index].value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }));
      } else if (dataListController.selectedTab == "Sponsor") {
        return DataGridRowAdapter(
            color: backgroundColor,
            cells: List.generate(row.getCells().length, (index) {
              if (index == 0) {
                RegistrationModel registrationModel =
                RegistrationModel.fromJson(
                    jsonDecode(row.getCells()[index].value.toString()));
                return Bounce(
                  onPressed: () {
                    Get.dialog(
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.symmetric(
                            vertical: 20, horizontal: width(context) * 0.25),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: SingleChildScrollView(
                            child: DetailWidget(
                              model: registrationModel,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(-3, 3),
                          blurRadius: 6,
                          color: Colors.grey,
                        ),
                      ],
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        registrationModel.photograph ?? "",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
              if (index == 5) {
                return AppHolder.loginAs != "admin"
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                row.getCells()[index].value.toString() == "true"
                                    ? Colors.green[800]!
                                    : Colors.red[800]!,
                            borderRadius: BorderRadius.circular(2000),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            row.getCells()[index].value.toString() == "true"
                                ? "Verified"
                                : "Not Verified",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    : FlutterSwitch(
                        value: row.getCells()[index].value.toString() == "true",
                        activeColor: Colors.green[800]!,
                        inactiveColor: Colors.red[800]!,
                        onToggle: (val) {
                          dataListController.verifyToggle(
                              val, row.getCells()[2].value.toString(), true);
                        },
                      );
              }
              return Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerRight,
                child: Text(
                  row.getCells()[index].value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }));
      } else if (dataListController.selectedTab == "Visitor") {
        return DataGridRowAdapter(
            color: backgroundColor,
            cells: List.generate(row.getCells().length, (index) {
              if (index == 0) {
                RegistrationModel registrationModel =
                RegistrationModel.fromJson(
                    jsonDecode(row.getCells()[index].value.toString()));
                return Bounce(
                  onPressed: () {
                    Get.dialog(
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.symmetric(
                            vertical: 20, horizontal: width(context) * 0.25),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: SingleChildScrollView(
                            child: DetailWidget(
                              model: registrationModel,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(-3, 3),
                          blurRadius: 6,
                          color: Colors.grey,
                        ),
                      ],
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        registrationModel.photograph ?? "",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
              if (index == 5) {
                return Center(
                  child: Bounce(
                    onPressed: () {
                      Get.dialog(
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: width(context) * 0.25),
                          child: Image.network(
                            row.getCells()[index].value.toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[800]!,
                        borderRadius: BorderRadius.circular(2000),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: const Text(
                        "View Aadhar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (index == 6) {
                return AppHolder.loginAs != "admin"
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                row.getCells()[index].value.toString() == "true"
                                    ? Colors.green[800]!
                                    : Colors.red[800]!,
                            borderRadius: BorderRadius.circular(2000),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            row.getCells()[index].value.toString() == "true"
                                ? "Verified"
                                : "Not Verified",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    : FlutterSwitch(
                        value: row.getCells()[index].value.toString() == "true",
                        activeColor: Colors.green[800]!,
                        inactiveColor: Colors.red[800]!,
                        onToggle: (val) {
                          dataListController.verifyToggle(
                              val, row.getCells()[2].value.toString(), true);
                        },
                      );
              }
              return Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerRight,
                child: Text(
                  row.getCells()[index].value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }));
      } else if (dataListController.selectedTab == "Participant") {
        return DataGridRowAdapter(
            color: backgroundColor,
            cells: List.generate(row.getCells().length, (index) {
              if (index == 0) {
                RegistrationModel registrationModel =
                    RegistrationModel.fromJson(
                        jsonDecode(row.getCells()[index].value.toString()));
                return Bounce(
                  onPressed: () {
                    Get.dialog(
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.symmetric(
                            vertical: 20, horizontal: width(context) * 0.25),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: SingleChildScrollView(
                            child: DetailWidget(
                              model: registrationModel,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(-3, 3),
                          blurRadius: 6,
                          color: Colors.grey,
                        ),
                      ],
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        registrationModel.photograph ?? "",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
              if (index == 7) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color:  getMemberTypeColor(row.getCells()[index].value.toString()),
                      borderRadius: BorderRadius.circular(2000),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      getMemberTypeText(row.getCells()[index].value.toString()),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              }
              if (index == 8) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: row.getCells()[index].value.toString() == "true"
                          ? Colors.green[800]!
                          : Colors.red[800]!,
                      borderRadius: BorderRadius.circular(2000),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      row.getCells()[index].value.toString() == "true"
                          ? "Yes"
                          : "No",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              }
              if (index == 9) {
                return Center(
                  child: Bounce(
                    onPressed: () {
                      Get.dialog(
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: width(context) * 0.25),
                          child: SfPdfViewer.network(
                            row.getCells()[index].value.toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[800]!,
                        borderRadius: BorderRadius.circular(2000),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: const Text(
                        "Aadhar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (index == 10) {
                return Center(
                  child: Bounce(
                    onPressed: () {
                      Get.dialog(
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: width(context) * 0.25),
                          child: SfPdfViewer.network(
                            row.getCells()[index].value.toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.cyan[800]!,
                        borderRadius: BorderRadius.circular(2000),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: const Text(
                        "College ID",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (index == 11) {
                return FlutterSwitch(
                  value: row.getCells()[index].value.toString() == "true",
                  activeColor: Colors.green[800]!,
                  inactiveColor: Colors.red[800]!,
                  onToggle: (val) {
                    dataListController.verifyToggle(
                        val, row.getCells()[2].value.toString(), false);
                  },
                );
                /*return AppHolder.loginAs != "admin"
                    ? Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                row.getCells()[index].value.toString() == "true"
                                    ? Colors.green[800]!
                                    : Colors.red[800]!,
                            borderRadius: BorderRadius.circular(2000),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            row.getCells()[index].value.toString() == "true"
                                ? "Verified"
                                : "Not Verified",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    : FlutterSwitch(
                        value: row.getCells()[index].value.toString() == "true",
                        activeColor: Colors.green[800]!,
                        inactiveColor: Colors.red[800]!,
                        onToggle: (val) {
                          dataListController.verifyToggle(
                              val, row.getCells()[2].value.toString(), true);
                        },
                      );*/
              }

              return Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerRight,
                child: Text(
                  row.getCells()[index].value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }));
      } else {
        return DataGridRowAdapter(
            color: backgroundColor,
            cells: List.generate(row.getCells().length, (index) {
              return Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerRight,
                child: Text(
                  row.getCells()[index].value.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }));
      }
    } else {
      Widget buildWidget({
        AlignmentGeometry alignment = Alignment.centerLeft,
        EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
        TextOverflow textOverflow = TextOverflow.ellipsis,
        required Object value,
      }) {
        return Container(
          padding: padding,
          alignment: alignment,
          child: Text(
            value.toString(),
            overflow: textOverflow,
          ),
        );
      }

      return DataGridRowAdapter(
          color: backgroundColor,
          cells: List.generate(row.getCells().length, (index) {
            return Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerRight,
              child: Text(
                row.getCells()[index].value.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }));
    }
  }

  @override
  Future<void> handleLoadMoreRows() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    // orders = getOrders(orders, 15);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Future<void> handleRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    // orders = getOrders(orders, 15);
    buildDataGridRows();
    notifyListeners();
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    Widget? widget;
    Widget buildCell(String value, EdgeInsets padding, Alignment alignment) {
      return Container(
        padding: padding,
        alignment: alignment,
        child: Text(value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w500)),
      );
    }

    if (summaryRow.showSummaryInRow) {
      widget = buildCell(
          summaryValue, const EdgeInsets.all(16.0), Alignment.centerLeft);
    } else if (summaryValue.isNotEmpty) {
      if (summaryColumn!.columnName == 'freight') {
        summaryValue = double.parse(summaryValue).toStringAsFixed(2);
      }

      summaryValue = 'Sum: ' +
          NumberFormat.currency(locale: 'en_US', decimalDigits: 0, symbol: r'$')
              .format(double.parse(summaryValue));

      widget = buildCell(
          summaryValue, const EdgeInsets.all(8.0), Alignment.centerRight);
    }
    return widget;
  }

  /// Provides the column name.
  String getColumnName(String columnName) {
    if (isFilteringSample) {
      switch (columnName) {
        case 'id':
          return 'Order ID';
        case 'customerId':
          return 'Customer ID';
        case 'name':
          return 'Name';
        case 'email':
          return 'Email';
        case 'city':
          return 'City';
        case 'price':
          return 'Price';
        default:
          return columnName;
      }
    }
    return columnName;
  }

  /// Update DataSource
  void updateDataSource() {
    notifyListeners();
  }

  Color getMemberTypeColor(String type) {
    switch(type){
      case "additional":
        return Colors.purple[800]!;
      case "faculty":
        return Colors.red[800]!;
      case "core":
        return Colors.yellow[800]!;
      default:
        return Colors.black12;
    }
  }
  String getMemberTypeText(String type) {
    switch(type){
      case "additional":
        return "Additional Member";
      case "faculty":
        return "Faculty Member";
      case "core":
        return "Core Member";
      default:
        return "--";
    }
  }
}
