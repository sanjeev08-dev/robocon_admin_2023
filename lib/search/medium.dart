// import 'package:data_table_2/data_table_2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
//
// import '../helper/app_holder.dart';
// import '../helper/flutter_bounce.dart';
// import '../helper/styles.dart';
// import '../logs/view.dart';
// import '../registration/view.dart';
// import 'controller.dart';
//
// class Medium extends StatelessWidget {
//   DataListController controller;
//
//   Medium({Key? key, required this.controller}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: width(context),
//       height: height(context),
//       child: Column(
//         children: [
//           Container(
//             width: width(context),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(
//                   getWidth(5, context),
//                 ),
//                 bottomRight: Radius.circular(
//                   getWidth(5, context),
//                 ),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   offset: Offset(-3, 3),
//                   blurRadius: getWidth(20, context),
//                   color: Colors.grey,
//                 ),
//               ],
//             ),
//             alignment: Alignment.centerLeft,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Image.asset(
//                       "asset/robocon_logo.png",
//                       height: height(context) * 0.07,
//                     ),
//                     Row(
//                       children: [
//                         if (AppHolder.loginAs == "admin")
//                           Bounce(
//                             onPressed: () {
//                               if (AppHolder.loginAs == "admin") {
//                                 Get.to(() => LogsView());
//                               } else {
//                                 Get.to(() => const RegistrationView());
//                               }
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context).primaryColor,
//                                 borderRadius: BorderRadius.circular(
//                                   getWidth(
//                                     100,
//                                     context,
//                                   ),
//                                 ),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: getWidth(10, context),
//                                 vertical: getHeight(5, context),
//                               ),
//                               child: Text(
//                                 AppHolder.loginAs == "admin"
//                                     ? "Attendance"
//                                     : "New Registration",
//                                 style: textStyle(
//                                   context: context,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         SizedBox(
//                           width: getWidth(4, context),
//                         ),
//                         Bounce(
//                           onPressed: controller.getUnverified,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.red[800],
//                               borderRadius: BorderRadius.circular(
//                                 getWidth(
//                                   100,
//                                   context,
//                                 ),
//                               ),
//                             ),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: getWidth(10, context),
//                               vertical: getHeight(5, context),
//                             ),
//                             child: Text(
//                               "No Verified : ${controller.unVerifiedCount}",
//                               style: textStyle(
//                                 context: context,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: getWidth(4, context),
//                         ),
//                         Bounce(
//                           onPressed: controller.getVerified,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.green[800],
//                               borderRadius: BorderRadius.circular(
//                                 getWidth(
//                                   100,
//                                   context,
//                                 ),
//                               ),
//                             ),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: getWidth(10, context),
//                               vertical: getHeight(5, context),
//                             ),
//                             child: Text(
//                               "Verified : ${controller.verifiedCount}",
//                               style: textStyle(
//                                 context: context,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: getWidth(5, context),
//                         ),
//                         Text(
//                           "Total Registrations : ${controller.counts.reduce((value, element) => value + element)}",
//                           style: textStyle(
//                             context: context,
//                             isBold: true,
//                             fontSize: FontSize.H2,
//                           ),
//                         ),
//                         SizedBox(
//                           width: getWidth(5, context),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: getHeight(4, context),
//                 ),
//                 SizedBox(
//                   width: width(context),
//                   child: Wrap(
//                     crossAxisAlignment: WrapCrossAlignment.center,
//                     alignment: WrapAlignment.spaceAround,
//                     children: List.generate(
//                       controller.tabs.length,
//                       (index) => Bounce(
//                         onPressed: () {
//                           controller.onTabChange(controller.tabs[index]);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color:
//                                 controller.tabs[index] == controller.selectedTab
//                                     ? Theme.of(context).primaryColor
//                                     : Colors.white,
//                             border: Border.all(
//                               color: Theme.of(context).primaryColor,
//                             ),
//                             borderRadius: BorderRadius.circular(
//                               getWidth(1, context),
//                             ),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             vertical: getHeight(5, context),
//                             horizontal: getWidth(5, context),
//                           ),
//                           child: Column(
//                             children: [
//                               Text(
//                                 controller.tabs[index],
//                                 style: textStyle(
//                                   context: context,
//                                   color: controller.tabs[index] !=
//                                           controller.selectedTab
//                                       ? Theme.of(context).primaryColor
//                                       : Colors.white,
//                                   isBold: controller.tabs[index] ==
//                                       controller.selectedTab,
//                                 ),
//                               ),
//                               Text(
//                                 "${controller.counts[index]}",
//                                 style: textStyle(
//                                   context: context,
//                                   fontSize: FontSize.H1,
//                                   color: controller.tabs[index] !=
//                                           controller.selectedTab
//                                       ? Theme.of(context).primaryColor
//                                       : Colors.white,
//                                   isBold: controller.tabs[index] ==
//                                       controller.selectedTab,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: getHeight(4, context),
//                 ),
//                 if (controller.selectedTab != "Volunteer" &&
//                     controller.tabDataList.isNotEmpty)
//                   SizedBox(
//                     width: width(context),
//                     child: Wrap(
//                       crossAxisAlignment: WrapCrossAlignment.center,
//                       alignment: WrapAlignment.spaceAround,
//                       children: List.generate(
//                         controller.alphabets.length,
//                         (index) => index == 26
//                             ? Bounce(
//                                 onPressed: () {
//                                   controller.onAlphabetTabChange(index);
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: index == controller.currentAlphabet
//                                         ? Theme.of(context).primaryColor
//                                         : Colors.white,
//                                     border: Border.all(
//                                       color: Theme.of(context).primaryColor,
//                                     ),
//                                     borderRadius: BorderRadius.circular(
//                                       getWidth(1, context),
//                                     ),
//                                   ),
//                                   padding: EdgeInsets.symmetric(
//                                     vertical: getHeight(5, context),
//                                     horizontal: getWidth(5, context),
//                                   ),
//                                   child: Text(
//                                     controller.alphabets[index],
//                                     style: textStyle(
//                                       context: context,
//                                       color: index != controller.currentAlphabet
//                                           ? Theme.of(context).primaryColor
//                                           : Colors.white,
//                                       isBold:
//                                           index == controller.currentAlphabet,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : controller.tabDataList
//                                     .where((element) => element.name!
//                                         .toUpperCase()
//                                         .startsWith(
//                                             controller.alphabets[index]))
//                                     .isNotEmpty
//                                 ? Bounce(
//                                     onPressed: () {
//                                       controller.onAlphabetTabChange(index);
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color:
//                                             index == controller.currentAlphabet
//                                                 ? Theme.of(context).primaryColor
//                                                 : Colors.white,
//                                         border: Border.all(
//                                           color: Theme.of(context).primaryColor,
//                                         ),
//                                         borderRadius: BorderRadius.circular(
//                                           getWidth(1, context),
//                                         ),
//                                       ),
//                                       padding: EdgeInsets.symmetric(
//                                         vertical: getHeight(5, context),
//                                         horizontal: getWidth(5, context),
//                                       ),
//                                       child: Text(
//                                         controller.alphabets[index],
//                                         style: textStyle(
//                                           context: context,
//                                           color: index !=
//                                                   controller.currentAlphabet
//                                               ? Theme.of(context).primaryColor
//                                               : Colors.white,
//                                           isBold: index ==
//                                               controller.currentAlphabet,
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 : Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey,
//                                       border: Border.all(
//                                         color: Colors.grey[800]!,
//                                       ),
//                                       borderRadius: BorderRadius.circular(
//                                         getWidth(1, context),
//                                       ),
//                                     ),
//                                     padding: EdgeInsets.symmetric(
//                                       vertical: getHeight(5, context),
//                                       horizontal: getWidth(5, context),
//                                     ),
//                                     child: Text(
//                                       controller.alphabets[index],
//                                       style: textStyle(
//                                         context: context,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                       ),
//                     ),
//                   ),
//                 if (controller.selectedTab == "Volunteer")
//                   SizedBox(
//                     width: width(context),
//                     child: Wrap(
//                       crossAxisAlignment: WrapCrossAlignment.center,
//                       alignment: WrapAlignment.spaceAround,
//                       runSpacing: getWidth(4, context),
//                       children: List.generate(
//                           AppHolder.committeeList.length,
//                           (index) => Bounce(
//                                 onPressed: () {
//                                   controller.onCommitteeTabChange(index);
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: index == controller.currentCommittee
//                                         ? Theme.of(context).primaryColor
//                                         : Colors.white,
//                                     border: Border.all(
//                                       color: Theme.of(context).primaryColor,
//                                     ),
//                                     borderRadius: BorderRadius.circular(
//                                       getWidth(1, context),
//                                     ),
//                                   ),
//                                   padding: EdgeInsets.symmetric(
//                                     vertical: getHeight(5, context),
//                                     horizontal: getWidth(5, context),
//                                   ),
//                                   child: Text(
//                                     AppHolder.committeeList[index],
//                                     style: textStyle(
//                                       context: context,
//                                       color:
//                                           index != controller.currentCommittee
//                                               ? Theme.of(context).primaryColor
//                                               : Colors.white,
//                                       isBold:
//                                           index == controller.currentCommittee,
//                                     ),
//                                   ),
//                                 ),
//                               )),
//                     ),
//                   ),
//                 SizedBox(
//                   height: getHeight(4, context),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//               child: controller.isLoading
//                   ? Center(
//                       child: LoadingAnimationWidget.inkDrop(
//                         color: Theme.of(context).primaryColor,
//                         size: width(context) * 0.2,
//                       ),
//                     )
//                   : controller.dataList.isEmpty
//                       ? Center(
//                           child: Text(
//                             "No Data Found...",
//                             style: textStyle(
//                               context: context,
//                               isBold: true,
//                               fontSize: FontSize.H1,
//                             ),
//                           ),
//                         )
//                       : getTableData(context)),
//         ],
//       ),
//     );
//   }
//
//   getTableData(BuildContext context) {
//     switch (controller.selectedTab) {
//       case "Participant":
//         return DataTable2(
//           columnSpacing: 12,
//           horizontalMargin: 12,
//           border: TableBorder(
//             top: const BorderSide(color: Colors.black),
//             bottom: BorderSide(color: Colors.grey[300]!),
//             left: BorderSide(color: Colors.grey[300]!),
//             right: BorderSide(color: Colors.grey[300]!),
//             verticalInside: BorderSide(color: Colors.grey[300]!),
//             horizontalInside: const BorderSide(
//               color: Colors.grey,
//               width: 1,
//             ),
//           ),
//           dividerThickness: 1,
//           // this one will be ignored if [border] is set above
//           bottomMargin: 10,
//           minWidth: 900,
//           sortColumnIndex: controller.sortColumnIndex,
//           sortAscending: controller.sortAscending,
//           dataRowHeight: 100,
//           columns: [
//             DataColumn2(
//               label: Text('S No'),
//               size: ColumnSize.S,
//               numeric: true,
//               fixedWidth: getWidth(20, context),
//             ),
//             const DataColumn2(
//               label: Text('Photo'),
//               fixedWidth: 75,
//             ),
//             DataColumn2(
//               label: const Text('Name'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.name!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Email'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.personalEmail!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Phone'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.mobileNumber!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('College Name'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.collageName!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Team Name'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.team!, columnIndex, ascending),
//             ),
//             if (AppHolder.loginAs == "admin")
//               const DataColumn2(
//                 label: Text('RTPCR Report'),
//                 size: ColumnSize.S,
//               ),
//             DataColumn2(
//               label: Text('Verify'),
//               size: ColumnSize.S,
//               fixedWidth: getWidth(50, context),
//             ),
//           ],
//           empty: Center(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               color: Colors.grey[200],
//               child: const Text('No data'),
//             ),
//           ),
//           rows: List<DataRow>.generate(
//               controller.dataSourceParticipants.rowCount,
//               (index) => controller.dataSourceParticipants.getRow(index)!),
//         );
//       case "Organizer":
//         return DataTable2(
//           columnSpacing: 12,
//           horizontalMargin: 12,
//           border: TableBorder(
//             top: const BorderSide(color: Colors.black),
//             bottom: BorderSide(color: Colors.grey[300]!),
//             left: BorderSide(color: Colors.grey[300]!),
//             right: BorderSide(color: Colors.grey[300]!),
//             verticalInside: BorderSide(color: Colors.grey[300]!),
//             horizontalInside: const BorderSide(
//               color: Colors.grey,
//               width: 1,
//             ),
//           ),
//           dividerThickness: 1,
//           // this one will be ignored if [border] is set above
//           bottomMargin: 10,
//           minWidth: 900,
//           sortColumnIndex: controller.sortColumnIndex,
//           sortAscending: controller.sortAscending,
//           dataRowHeight: 100,
//           columns: [
//             DataColumn2(
//               label: Text('S No'),
//               size: ColumnSize.S,
//               numeric: true,
//               fixedWidth: getWidth(20, context),
//             ),
//             const DataColumn2(
//               label: Text('Photo'),
//               fixedWidth: 75,
//             ),
//             DataColumn2(
//               label: const Text('Name'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.name!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Email'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.email!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Phone'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.mobile!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Organization Name'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.nameOfOrganization!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('T- Shirt Size'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.tShirtSize!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Received T-Shirt'),
//               size: ColumnSize.S,
//               fixedWidth: getWidth(50, context),
//             ),
//             DataColumn2(
//               label: Text('Verify'),
//               size: ColumnSize.S,
//               fixedWidth: getWidth(50, context),
//             ),
//           ],
//           empty: Center(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               color: Colors.grey[200],
//               child: const Text('No data'),
//             ),
//           ),
//           rows: List<DataRow>.generate(
//               controller.dataSourceParticipants.rowCount,
//               (index) => controller.dataSourceParticipants.getRow(index)!),
//         );
//       case "Sponsor":
//         return DataTable2(
//           columnSpacing: 12,
//           horizontalMargin: 12,
//           border: TableBorder(
//             top: const BorderSide(color: Colors.black),
//             bottom: BorderSide(color: Colors.grey[300]!),
//             left: BorderSide(color: Colors.grey[300]!),
//             right: BorderSide(color: Colors.grey[300]!),
//             verticalInside: BorderSide(color: Colors.grey[300]!),
//             horizontalInside: const BorderSide(
//               color: Colors.grey,
//               width: 1,
//             ),
//           ),
//           dividerThickness: 1,
//           // this one will be ignored if [border] is set above
//           bottomMargin: 10,
//           minWidth: 900,
//           sortColumnIndex: controller.sortColumnIndex,
//           sortAscending: controller.sortAscending,
//           dataRowHeight: 100,
//           columns: [
//             DataColumn2(
//               label: Text('S No'),
//               size: ColumnSize.S,
//               numeric: true,
//               fixedWidth: getWidth(20, context),
//             ),
//             const DataColumn2(
//               label: Text('Photo'),
//               fixedWidth: 75,
//             ),
//             DataColumn2(
//               label: const Text('Name'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.name!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Email'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.email!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Phone'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.mobile!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Organization Name'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.nameOfSponsor!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Department'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.department!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: Text('Verify'),
//               size: ColumnSize.S,
//               fixedWidth: getWidth(50, context),
//             ),
//           ],
//           empty: Center(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               color: Colors.grey[200],
//               child: const Text('No data'),
//             ),
//           ),
//           rows: List<DataRow>.generate(
//               controller.dataSourceParticipants.rowCount,
//               (index) => controller.dataSourceParticipants.getRow(index)!),
//         );
//       case "Volunteer":
//         return DataTable2(
//           columnSpacing: 12,
//           horizontalMargin: 12,
//           border: TableBorder(
//             top: const BorderSide(color: Colors.black),
//             bottom: BorderSide(color: Colors.grey[300]!),
//             left: BorderSide(color: Colors.grey[300]!),
//             right: BorderSide(color: Colors.grey[300]!),
//             verticalInside: BorderSide(color: Colors.grey[300]!),
//             horizontalInside: const BorderSide(
//               color: Colors.grey,
//               width: 1,
//             ),
//           ),
//           dividerThickness: 1,
//           // this one will be ignored if [border] is set above
//           bottomMargin: 10,
//           minWidth: 900,
//           sortColumnIndex: controller.sortColumnIndex,
//           sortAscending: controller.sortAscending,
//           dataRowHeight: 100,
//           columns: [
//             DataColumn2(
//               label: Text('S No'),
//               size: ColumnSize.S,
//               numeric: true,
//               fixedWidth: getWidth(20, context),
//             ),
//             const DataColumn2(
//               label: Text('Photo'),
//               fixedWidth: 75,
//             ),
//             DataColumn2(
//               label: const Text('Name'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.name!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Email'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.email!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Phone'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.mobile!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Organization Name'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.nameOfVolunteer!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Department'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.department!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Committee Name'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.comitteeName!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('T- Shirt Size'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.tShirtSize!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Received T-Shirt'),
//               size: ColumnSize.S,
//               fixedWidth: getWidth(50, context),
//             ),
//             DataColumn2(
//               label: Text('Verify'),
//               size: ColumnSize.S,
//               fixedWidth: getWidth(50, context),
//             ),
//           ],
//           empty: Center(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               color: Colors.grey[200],
//               child: const Text('No data'),
//             ),
//           ),
//           rows: List<DataRow>.generate(
//               controller.dataSourceParticipants.rowCount,
//               (index) => controller.dataSourceParticipants.getRow(index)!),
//         );
//       case "Visitor":
//         return DataTable2(
//           columnSpacing: 12,
//           horizontalMargin: 12,
//           border: TableBorder(
//             top: const BorderSide(color: Colors.black),
//             bottom: BorderSide(color: Colors.grey[300]!),
//             left: BorderSide(color: Colors.grey[300]!),
//             right: BorderSide(color: Colors.grey[300]!),
//             verticalInside: BorderSide(color: Colors.grey[300]!),
//             horizontalInside: const BorderSide(
//               color: Colors.grey,
//               width: 1,
//             ),
//           ),
//           dividerThickness: 1,
//           // this one will be ignored if [border] is set above
//           bottomMargin: 10,
//           minWidth: 900,
//           sortColumnIndex: controller.sortColumnIndex,
//           sortAscending: controller.sortAscending,
//           dataRowHeight: 100,
//           columns: [
//             DataColumn2(
//               label: Text('S No'),
//               size: ColumnSize.S,
//               numeric: true,
//               fixedWidth: getWidth(20, context),
//             ),
//             const DataColumn2(
//               label: Text('Photo'),
//               fixedWidth: 75,
//             ),
//             DataColumn2(
//               label: const Text('Name'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.name!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Email'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.email!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Phone'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.mobile!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Organization Name'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.nameOfVisitor!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Designation'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.designation!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: Text('Verify'),
//               size: ColumnSize.S,
//               fixedWidth: getWidth(50, context),
//             ),
//           ],
//           empty: Center(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               color: Colors.grey[200],
//               child: const Text('No data'),
//             ),
//           ),
//           rows: List<DataRow>.generate(
//               controller.dataSourceParticipants.rowCount,
//               (index) => controller.dataSourceParticipants.getRow(index)!),
//         );
//       case "SoSE-Teacher":
//         return DataTable2(
//           columnSpacing: 12,
//           horizontalMargin: 12,
//           border: TableBorder(
//             top: const BorderSide(color: Colors.black),
//             bottom: BorderSide(color: Colors.grey[300]!),
//             left: BorderSide(color: Colors.grey[300]!),
//             right: BorderSide(color: Colors.grey[300]!),
//             verticalInside: BorderSide(color: Colors.grey[300]!),
//             horizontalInside: const BorderSide(
//               color: Colors.grey,
//               width: 1,
//             ),
//           ),
//           dividerThickness: 1,
//           // this one will be ignored if [border] is set above
//           bottomMargin: 10,
//           minWidth: 900,
//           sortColumnIndex: controller.sortColumnIndex,
//           sortAscending: controller.sortAscending,
//           dataRowHeight: 100,
//           columns: [
//             DataColumn2(
//               label: const Text('S No'),
//               size: ColumnSize.S,
//               numeric: true,
//               fixedWidth: getWidth(20, context),
//             ),
//             const DataColumn2(
//               label: Text('Photo'),
//               fixedWidth: 75,
//             ),
//             DataColumn2(
//               label: const Text('Name'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.name!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Email'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.email!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Phone'),
//               size: ColumnSize.S,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.mobile!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('School/Institute Name'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.nameOfVisitor!, columnIndex, ascending),
//             ),
//             DataColumn2(
//               label: const Text('Location'),
//               size: ColumnSize.L,
//               onSort: (columnIndex, ascending) => controller.sort<String>(
//                   (d) => d.designation!, columnIndex, ascending),
//             ),
//             const DataColumn2(
//               label: Text('No. of Students'),
//               size: ColumnSize.S,
//             ),
//             DataColumn2(
//               label: const Text('Verify'),
//               size: ColumnSize.S,
//               fixedWidth: getWidth(50, context),
//             ),
//           ],
//           empty: Center(
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               color: Colors.grey[200],
//               child: const Text('No data'),
//             ),
//           ),
//           rows: List<DataRow>.generate(
//               controller.dataSourceParticipants.rowCount,
//               (index) => controller.dataSourceParticipants.getRow(index)!),
//         );
//       default:
//         return Container();
//     }
//   }
// }
