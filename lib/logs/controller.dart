import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:robocon_admin_2023/helper/meeting_model.dart';

import '../helper/color_helper.dart';
import '../helper/date_format_helper.dart';
import '../helper/firebase_helper.dart';
import '../helper/logs_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart'  as xlsio;
import 'package:robocon_admin_2023/helper/save_export.dart' as helper;

class LogsController extends GetxController {
  bool isLoading = false;

  List<MeetingModel> dateTimeList = [];
  List<LogsModel> logs = [];
  int selectedDate = 0;
  int? sortColumnIndex;
  bool sortAscending = true;
  final GlobalKey<SfDataGridState> sfDataKey = GlobalKey<SfDataGridState>();
  String? selectedType;
  String? selectedCommittee;

  @override
  void onInit() {
    // setDatesList();
    super.onInit();
  }


  void getLogs(MeetingModel model) async {
    DateTime dateTime = DateFormatHelper.getDateFromString(model.date??"", "dd-MM-yyyy");
    DateTime todayStartDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      0,
      0,
      0,
      0,
    );
    DateTime todayEndDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      0,
      0,
      0,
      0,
    ).add(Duration(days: 1));

    isLoading = true;
    update();
    logs = await FirebaseHelper.getLogs(todayStartDate.millisecondsSinceEpoch,
        todayEndDate.millisecondsSinceEpoch);

    if(selectedType != null){
      if(selectedType=="Volunteer"){
        if(selectedCommittee=="All"){
          logs = logs.where((element) =>element.type=="Volunteer").toList();
        }else{
          logs = logs.where((element) =>element.type=="Volunteer"&& element.committee==selectedCommittee).toList();
        }
      }else{
        logs = logs.where((element) =>element.type==selectedType).toList();
      }
    }
    isLoading = false;
    update();
  }

  void setDatesList(MeetingModel? model) {
    /*for (int i = 0; i < 10; i++) {
      var date = DateTime.now().subtract(Duration(days: i));
      dateTimeList.add(date);
    }*/

    FirebaseHelper.getMeetingData().listen((event) {
      dateTimeList.clear();
      dateTimeList.addAll(event);
      dateTimeList.sort((a,b)=>DateFormatHelper.getDateFromString(a.date!, "dd-MM-yyyy").compareTo(DateFormatHelper.getDateFromString(b.date!, "dd-MM-yyyy")));
      if(model !=null){
        var index = dateTimeList.indexWhere((element) => element.date==model.date);

        if(index >= 0){
          selectedDate = index;
        }else{
          selectedDate=0;
        }
      }else{
        selectedDate=0;
      }
      update();
      // getLogs(dateTimeList[selectedDate]);
    });

  }

  void onChangeDateTab(int index) {
    selectedDate = index;
    update();
    getLogs(dateTimeList[selectedDate]);
  }

  Future<void> exportDataGridToExcel() async {
    final xlsio.Workbook workbook = sfDataKey.currentState!.exportToExcelWorkbook(
        excludeColumns: ['pic'],
        cellExport: (DataGridCellExcelExportDetails details) {
          if (details.cellType == DataGridExportCellType.columnHeader) {
            if (details.columnName != 'pic') {
              details.excelRange.cellStyle.hAlign = xlsio.HAlignType.left;
            }
          }
        });
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await helper.FileSaveHelper.saveAndLaunchFile(
        bytes, '${dateTimeList[selectedDate].date ?? "Default"}.xlsx');
  }

  Future<void> exportDataGridToPdf() async {
    final ByteData data = await rootBundle.load('asset/robocon_logo.png');
    final PdfDocument? document = sfDataKey.currentState?.exportToPdfDocument(
        fitAllColumnsInOnePage: true,
        excludeColumns: ['pic'],
        cellExport: (DataGridCellPdfExportDetails details) async {
          /*if (details.cellType == DataGridExportCellType.row) {
              if (details.columnName == 'pic') {
                // Add the image widget to the PDF page
                var bytes = await await getImageBytesFromUrl(details.pdfCell.value);

                details.pdfCell.value = DateFormat('MM/dd/yyyy')
                    .format(DateTime.parse(details.pdfCell.value));
              }
            }*/
        },
        headerFooterExport: (DataGridPdfHeaderFooterExportDetails details) {
          final double width = details.pdfPage.getClientSize().width;
          final PdfPageTemplateElement header =
          PdfPageTemplateElement(Rect.fromLTWH(0, 0, width, 65));

          header.graphics.drawImage(
              PdfBitmap(data.buffer
                  .asUint8List(data.offsetInBytes, data.lengthInBytes)),
              Rect.fromLTWH(width - 148, 0, 148, 60));

          header.graphics.drawString(
            dateTimeList[selectedDate].date ?? "Default",
            PdfStandardFont(PdfFontFamily.helvetica, 13,
                style: PdfFontStyle.bold),
            bounds: const Rect.fromLTWH(0, 25, 200, 60),
          );

          details.pdfDocumentTemplate.top = header;
        });
    if (document != null) {
      final List<int> bytes = document.saveSync();
      await helper.FileSaveHelper.saveAndLaunchFile(
          bytes, '${dateTimeList[selectedDate].date ?? "Default"}.pdf');
      document.dispose();
    } else {
      Get.log("kjdczn");
    }
  }
}
