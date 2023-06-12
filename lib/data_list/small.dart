import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:robocon_admin_2023/data_list/datagridsource.dart';
import 'package:robocon_admin_2023/helper/flutter_bounce.dart';
import 'package:robocon_admin_2023/helper/save_export.dart' as helper;
import 'package:robocon_admin_2023/search/view.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row, Border;

import '../helper/app_holder.dart';
import '../helper/responsive_widget.dart';
import '../helper/styles.dart';
import 'controller.dart';

class Small extends StatelessWidget {
  DataListController controller;
  GlobalKey<ScaffoldState> drawerKey;
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  Small({Key? key, required this.controller, required this.drawerKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Bounce(
                onPressed: () {
                  drawerKey.currentState?.openDrawer();
                },
                child: Image.asset(
                  "asset/robocon_logo.png",
                  height: height(context) * 0.07,
                ),
              ),
              Text(
                controller.selectedTab == "DD"
                    ? "Doordarshan"
                    : "${controller.selectedTab}${controller.selectedTab == "Volunteer" ? " (${AppHolder.committeeList[controller.currentCommittee]})" : ""}",
                style: textStyle(
                  context: context,
                  isBold: true,
                  fontSize: ResponsiveWidget.isSmallScreen(context)
                      ? FontSize.H4
                      : FontSize.H2,
                ),
              ),
              Row(
                children: [
                  Bounce(
                    child: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 26,
                    ),
                    onPressed: () {
                      Get.to(() => SearchView());
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  /*Text(
                    "Total Registrations : ${AppHolder.committeeList[controller.currentCommittee] == "All" ? "${controller.allUserList.where((element) => element.type == "Volunteer").length}" : "${controller.allUserList.where((element) => element.type == "Volunteer" && element.comitteeName == AppHolder.committeeList[controller.currentCommittee]).length}"}/${controller.allUserList.length}  ",
                    style: textStyle(
                      context: context,
                      isBold: true,
                      fontSize: ResponsiveWidget.isSmallScreen(context)
                          ? FontSize.H4
                          : FontSize.H2,
                    ),
                  ),*/
                ],
              ),
            ],
          ),
          if (controller.isLoading)
            Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Theme.of(context).primaryColor,
                size: width(context) * 0.1,
              ),
            ),
          if (!controller.isLoading && controller.dataList.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildExportingButtons(context),
                Row(
                  children: [
                    Checkbox(
                      value: controller.showMobile,
                      onChanged: (value) {
                        controller.showMobile = value ?? false;
                        controller.update();
                      },
                    ),
                    Text(
                      "Show Mobile",
                      style: textStyle(
                        context: context,
                        isBold: true,
                        fontSize: ResponsiveWidget.isSmallScreen(context)
                            ? FontSize.H5
                            : FontSize.H3,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          if (!controller.isLoading && controller.dataList.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfDataGrid(
                  key: _key,
                  source: DataInfoDataGridSource(
                    isWebOrDesktop: true,
                    context: context,
                    ordersCollection: controller.dataList,
                    dataListController: controller,
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
    );
  }

  Widget _buildExportingButtons(BuildContext context) {
    Future<void> exportDataGridToExcel() async {
      final Workbook workbook = _key.currentState!.exportToExcelWorkbook(
          excludeColumns: ['pic'],
          cellExport: (DataGridCellExcelExportDetails details) {
            if (details.cellType == DataGridExportCellType.columnHeader) {
              if (details.columnName != 'pic') {
                details.excelRange.cellStyle.hAlign = HAlignType.left;
              }
            }
          });
      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();
      await helper.FileSaveHelper.saveAndLaunchFile(bytes,
          '${controller.selectedTab == "Volunteer" ? "${controller.selectedTab} (${AppHolder.committeeList[controller.currentCommittee]})" : controller.selectedTab ?? "Default"}.xlsx');
    }

    Future<void> exportDataGridToPdf() async {
      final ByteData data = await rootBundle.load('asset/robocon_logo.png');
      final PdfDocument? document = _key.currentState?.exportToPdfDocument(
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
              controller.dataList.first.type ?? "",
              PdfStandardFont(PdfFontFamily.helvetica, 13,
                  style: PdfFontStyle.bold),
              bounds: const Rect.fromLTWH(0, 25, 200, 60),
            );

            details.pdfDocumentTemplate.top = header;
          });
      if (document != null) {
        final List<int> bytes = document.saveSync();
        await helper.FileSaveHelper.saveAndLaunchFile(bytes,
            '${controller.selectedTab == "Volunteer" ? "${controller.selectedTab} (${AppHolder.committeeList[controller.currentCommittee]})" : controller.selectedTab ?? "Default"}.pdf');
        document.dispose();
      } else {
        Get.log("kjdczn");
      }
    }

    return Row(
      children: <Widget>[
        _buildExportingButton('Export to Excel', 'asset/bg_image.png',
            onPressed: exportDataGridToExcel),
        _buildExportingButton('Export to PDF', 'asset/bg_image.png',
            onPressed: exportDataGridToPdf)
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
    if (controller.selectedTab == "Organizer" ||
        controller.selectedTab == "Volunteer") {
      return <GridColumn>[
        GridColumn(
            columnName: 'pic',
            width: 150,
            label: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Picture',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            allowSorting: false),
        GridColumn(
            columnName: 'name',
            label: Container(
              alignment: Alignment.centerLeft,
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
          columnName: 'mobile',
          width: controller.showMobile?double.nan:0,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Mobile',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name_of_organization',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Organization',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'committee',
          width: AppHolder.committeeList[controller.currentCommittee] == "All"
              ? double.nan
              : 0,
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
          columnName: 't_shirt_size',
          width: 150,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'T-Shirt Size',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 't_shirt_received',
          width: 150,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'T-Shirt Received',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'verified',
          width: 150,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Verify',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ];
    } else if (controller.selectedTab == "DD") {
      return <GridColumn>[
        GridColumn(
            columnName: 'pic',
            width: 150,
            label: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Picture',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            allowSorting: false),
        GridColumn(
            columnName: 'name',
            label: Container(
              alignment: Alignment.centerLeft,
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
          columnName: 'mobile',
          width: controller.showMobile?double.nan:0,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Mobile',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'verified',
          width: 150,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Verify',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ];
    } else if (controller.selectedTab == "Sponsor") {
      return <GridColumn>[
        GridColumn(
            columnName: 'pic',
            width: 150,
            label: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Picture',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            allowSorting: false),
        GridColumn(
            columnName: 'name',
            label: Container(
              alignment: Alignment.centerLeft,
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
          columnName: 'mobile',
          width: controller.showMobile?double.nan:0,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Mobile',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name_of_organization',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Organization',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'verified',
          width: 150,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Verify',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ];
    } else if (controller.selectedTab == "Visitor") {
      return <GridColumn>[
        GridColumn(
            columnName: 'pic',
            width: 150,
            label: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Picture',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            allowSorting: false),
        GridColumn(
            columnName: 'name',
            label: Container(
              alignment: Alignment.centerLeft,
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
          columnName: 'mobile',
          width: controller.showMobile?double.nan:0,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Mobile',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name_of_organization',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Organization',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'aadhar',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Aadhar',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'verified',
          width: 150,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Verify',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ];
    } else if (controller.selectedTab == "Participant") {
      return <GridColumn>[
        GridColumn(
            columnName: 'pic',
            width: 150,
            label: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Picture',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            allowSorting: false),
        GridColumn(
            columnName: 'name',
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Name',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            allowSorting: true),
        GridColumn(
          width: 0,
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
          width: 0,
          columnName: 'gender',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Gender',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'mobile',
          width: controller.showMobile?double.nan:0,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Mobile',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'team',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Team',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'college',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'College',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          width: 200,
          columnName: 'member_type',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Member',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          width: 150,
          columnName: 'stay_in_iit',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Stay In IIT',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          width: 150,
          columnName: 'aadhar',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Aadhar',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          width: 150,
          columnName: 'college_id',
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'College ID',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'verified',
          width: 150,
          label: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Verify',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

      ];
    } else {
      return [];
    }
  }

  Future<List<int>> getImageBytesFromUrl(String url) async {
    var response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}
