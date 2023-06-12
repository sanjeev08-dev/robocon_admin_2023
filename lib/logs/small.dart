import 'dart:typed_data';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;
import '../helper/date_format_helper.dart';
import '../helper/flutter_bounce.dart';
import '../helper/styles.dart';
import '../schedule_meetings/datagridsource.dart';
import '../widgets/large/button.dart';
import '../widgets/small/committee_type_widget.dart';
import '../widgets/small/logs_type_widget.dart';
import 'controller.dart';


class Small extends StatelessWidget {
  LogsController controller;

  Small({Key? key, required this.controller}) : super(key: key);

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
          Column(
            children: [
              Container(
                height: height(context) * 0.05,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "asset/robocon_logo.png",
                    ),
                    Text(
                      "Attendance",
                      style: textStyle(
                        context: context,
                        fontSize: FontSize.H2,
                        isBold: true,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                    Opacity(
                      opacity: 0,
                      child: Image.asset(
                        "asset/robocon_logo.png",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: getHeight(40, context),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 10,
                    children: List.generate(
                      controller.dateTimeList.length,
                      (index) => Bounce(
                        onPressed: () {
                          controller.onChangeDateTab(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.selectedDate == index
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(
                              getWidth(100, context),
                            ),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(10, context),
                            vertical: getHeight(5, context),
                          ),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            bottom: getHeight(1, context),
                            right: getWidth(10, context),
                          ),
                          child: Text(
                            DateFormatHelper.convertDateFromString(
                              controller.dateTimeList[index].date??"",
                              "dd-MM-yyyy",
                              "dd MMMM",
                            ),
                            style: textStyle(
                              context: context,
                              color: controller.selectedDate == index
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              isBold: controller.selectedDate == index,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(
                    getWidth(5, context),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: getWidth(10, context),
                    vertical: getHeight(5, context),
                  ),
                  width: width(context),
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
                  child: controller.isLoading
                      ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Theme.of(context).primaryColor,
                          size: getWidth(45, context),
                        )
                      : Column(
                    children: [
                      Wrap(
                        runSpacing: 10,
                        spacing: 30,
                        children: [
                          LogsTypeWidget(
                            onChanged: (value) {
                              controller.selectedType = value;
                              controller.update();
                            },
                            selectedType: controller.selectedType,
                          ),
                          if (controller.selectedType ==
                              "Volunteer")
                            CommitteeTypeWidget(
                              onChanged: (value) {
                                controller.selectedCommittee =
                                    value;
                                controller.update();
                              },
                              selectedType:
                              controller.selectedCommittee,
                            ),
                          if (controller.selectedType != null)
                            SizedBox(
                                width: 150,
                                child: AppButton(
                                  text: "Go",
                                  isLoading: controller.isLoading,
                                  padding: 0,
                                  haveMargin: false,
                                  onTap: (){
                                    controller.getLogs(controller.dateTimeList[controller.selectedDate]);
                                  },
                                ))
                        ],
                      ),
                      if (!controller.isLoading && controller.logs.isNotEmpty)
                        _buildExportingButtons(context),
                      if (!controller.isLoading && controller.logs.isNotEmpty)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SfDataGrid(
                              key: controller.sfDataKey,
                              source: DataInfoDataGridSource(
                                isWebOrDesktop: true,
                                context: context,
                                ordersCollection: controller.logs,
                                logsController:  controller,
                              ),
                              columns: getColumns(context),
                              rowHeight: 74,
                              gridLinesVisibility: GridLinesVisibility.both,
                              headerGridLinesVisibility: GridLinesVisibility.both,
                              columnWidthMode: ColumnWidthMode.fill,
                              allowSorting: true,
                              allowMultiColumnSorting: false,
                              allowTriStateSorting: false,
                              showSortNumbers: true,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  Widget _buildExportingButtons(BuildContext context) {

    return Row(
      children: <Widget>[
        _buildExportingButton('Export to Excel', 'asset/bg_image.png',
            onPressed: controller.exportDataGridToExcel),
        _buildExportingButton('Export to PDF', 'asset/bg_image.png',
            onPressed: controller.exportDataGridToPdf)
      ],
    );
  }

  Widget _buildExportingButton(String buttonName, String imagePath,
      {required VoidCallback onPressed}) {
    return Container(
      height: 60.0,
      padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.red,
        child: SizedBox(
          width: 150.0,
          height: 40.0,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: ImageIcon(
                  AssetImage(imagePath),
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Text(buttonName, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  List<GridColumn> getColumns(BuildContext context) {
    return <GridColumn>[

      GridColumn(
          columnName: 'name',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Name',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          allowSorting: true),
      GridColumn(
        columnName: 'email',
        label: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Email',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'type',
        label: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Type',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'committee',
        label: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Committee',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'date',
        width: 0,
        label: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Date',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'time',
        label: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Time',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        columnName: 'attended_by',
        label: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Marked By',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ];
  }

  Future<List<int>> getImageBytesFromUrl(String url) async {
    var response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}
