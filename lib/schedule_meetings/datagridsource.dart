import 'dart:math' as math;

/// Package imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:robocon_admin_2023/helper/date_format_helper.dart';
import 'package:robocon_admin_2023/helper/flutter_bounce.dart';
import 'package:robocon_admin_2023/helper/logs_model.dart';
import 'package:robocon_admin_2023/helper/logs_model.dart';
import 'package:robocon_admin_2023/helper/logs_model.dart';
import 'package:robocon_admin_2023/helper/logs_model.dart';
import 'package:robocon_admin_2023/helper/logs_model.dart';
import 'package:robocon_admin_2023/helper/styles.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../helper/app_holder.dart';
import '../helper/registration_model.dart';
import '../logs/controller.dart';
import '../widgets/flutter_switch.dart';
import 'controller.dart';

class DataInfoDataGridSource extends DataGridSource {
  /// Creates the order data source class with required details.
  DataInfoDataGridSource(
      {required this.isWebOrDesktop,
      this.orderDataCount,
      required this.ordersCollection,
      this.culture,
      required this.logsController,
      required this.context,
      bool? isFilteringSample}) {
    this.isFilteringSample = isFilteringSample ?? false;
    orders = ordersCollection;

    buildDataGridRows();
  }

  /// Determine to decide whether the platform is web or desktop.
  final bool isWebOrDesktop;
  final LogsController logsController;
  final BuildContext context;

  /// Localization Source.
  String? culture;

  /// Get data count of an order.
  int? orderDataCount;
  final math.Random _random = math.Random();

  /// Instance of an order.
  List<LogsModel> orders = <LogsModel>[];

  /// Instance of an order collection for rtl sample
  List<LogsModel> ordersCollection;

  /// Instance of DataGridRow.
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  /// Currency symbol for culture.
  String currencySymbol = '';

  /// Checks whether the source is used for the filtering sample or not.
  late bool isFilteringSample;

  /// Building DataGridRows.
  void buildDataGridRows() {
    dataGridRows = isWebOrDesktop
        ? orders.map<DataGridRow>((LogsModel logsModel) {
      return DataGridRow(cells: <DataGridCell>[

        DataGridCell<String>(
            columnName: getColumnName('name'), value: logsModel.name),
        DataGridCell<String>(
            columnName: getColumnName('email'), value: logsModel.email),
        DataGridCell<String>(
            columnName: getColumnName('type'), value: logsModel.type),
        DataGridCell<String>(
            columnName: getColumnName('committee'), value: logsModel.committee),
        DataGridCell<String>(
            columnName: getColumnName('date'), value: logsModel.date),
        DataGridCell<String>(
            columnName: getColumnName('time'), value: DateFormatHelper.convertDateFromDate(DateTime.fromMillisecondsSinceEpoch((logsModel.timestamp??0)), "hh:MM a")),
        DataGridCell<String>(
            columnName: getColumnName('attended_by'), value: logsModel.markedBy,),

      ]);
          }).toList()
        : orders.map<DataGridRow>((LogsModel logsModel) {
            return DataGridRow(cells: <DataGridCell>[
              DataGridCell<String>(
                  columnName: getColumnName('name'), value: logsModel.name),
              DataGridCell<String>(
                  columnName: getColumnName('email'), value: logsModel.email),
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
}
