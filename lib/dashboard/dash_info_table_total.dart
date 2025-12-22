import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../utils/color_constants.dart';

class DashInfoTableTotal extends StatelessWidget {
  final List<DashInfoTotal> dataList;
  final String pageTitle;
  final String? pageTitleSecond;
  final Function? showData;
  final bool? isShowButton;

  const DashInfoTableTotal({
    super.key,
    required this.dataList,
    required this.pageTitle, required this.showData, this.pageTitleSecond, this.isShowButton,
  });

  @override
  Widget build(BuildContext context) {
    // Determine which columns to display based on the data
    bool showMjpjayCount = dataList.any((item) => item.mjpjayCount != null);
    bool showNonMjpjayCount =
        dataList.any((item) => item.nonMjpjayCount != null);
    bool showUnitName = dataList.any((item) => item.unitName != null);

    // int totalMjpjayCount =
    //     dataList.fold(0, (sum, item) => sum + (item.mjpjayCount ?? 0));
    // int totalNonMjpjayCount =
    //     dataList.fold(0, (sum, item) => sum + (item.nonMjpjayCount ?? 0));
    int grandTotal = dataList.fold(0, (sum, item) => sum + (item.total ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: pageTitle,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: dataList.isNotEmpty ? Column(
        children:[
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: pageTitleSecond ?? "",
              fontSize: 18.0,
              fontFam: 'Lato',
              fontWeight: FontWeight.w400,
              textColor: Colors.black,
              textAlign: TextAlign.start,
            ),
          ).paddingOnly(left: 6,right: 4),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: WidgetStateColor.resolveWith(
                          (states) => AppColor.primaryBackgroundColor),
                  columnSpacing: 16.0,
                  // Build columns dynamically based on available data
                  columns: [
                    const DataColumn(label: Text('Sr No')),
                    if (showUnitName) const DataColumn(label: Text('Unit Name')),
                    if (showMjpjayCount)
                      const DataColumn(label: Text('MJPJAY Count')),
                    if (showNonMjpjayCount)
                      const DataColumn(label: Text('Non-MJPJAY Count')),
                    const DataColumn(label: Text('Total')),
                    if (isShowButton!)  const DataColumn(label: Text('View Patient')),
                  ],
                  rows: [
                    ...dataList.asMap().entries.map((entry) {
                      int index = entry.key + 1;
                      DashInfoTotal dashInfo = entry.value;
                      return DataRow(cells: [
                        DataCell(Text(index.toString())),
                        if (showUnitName)

                          DataCell(
                            SizedBox(
                              width: 150, // Set the desired width here
                              child: Text(
                                dashInfo.unitName ?? '',
                                overflow: TextOverflow
                                    .ellipsis, // Add ellipsis if the text is too long
                              ),
                            ),
                          ),
                        if (showMjpjayCount)
                          DataCell(Text(dashInfo.mjpjayCount?.toString() ?? '')),
                        if (showNonMjpjayCount)
                          DataCell(Text(dashInfo.nonMjpjayCount?.toString() ?? '')),
                        DataCell(Text(dashInfo.total?.toString() ?? '')),
                        if (isShowButton!)  DataCell(TextButton(onPressed: () { showData!(dashInfo.unitName); }, child: const Text("Show Data"),)),
                      ]);
                    }),
                    DataRow(cells: [
                      const DataCell(Text('Total',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                      if (showUnitName) const DataCell(Text('')),
                      if (showMjpjayCount)
                        const DataCell(Text("",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                      if (showNonMjpjayCount)
                        const DataCell(Text("",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text(grandTotal.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                      if (isShowButton!) const DataCell(Text("")),
                    ]),
                  ],
                ),
              ),
            ),
          )
        ] ,
      ):const Center(
        child: CustomText(
            text: "No Data",
            fontSize: 16,
            fontWeight: FontWeight.normal,
            textColor: Colors.black,
            textAlign: TextAlign.center),
      ),
    );
  }


}

class DashInfoTableSubHeaderTicket extends StatelessWidget {
  final List<DashInfoSubHeader> dataList;
  final String pageTitle;

  const DashInfoTableSubHeaderTicket({
    super.key,
    required this.dataList,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    // Total count variables for ticket types
    // int totalCorrectionCount =
    // dataList.fold(0, (sum, item) => sum + (item.dataCorrectionTicketCount ?? 0));
    // int totalRequirementCount =
    // dataList.fold(0, (sum, item) => sum + (item.newRequirmentTIcketCount ?? 0));
    // int totalIssueCount =
    // dataList.fold(0, (sum, item) => sum + (item.operatorIssueTicketCount ?? 0));
    // int totalServiceCount =
    // dataList.fold(0, (sum, item) => sum + (item.softwereServiceTicketCount ?? 0));
    // int totalBugCount =
    // dataList.fold(0, (sum, item) => sum + (item.bugTicketCount ?? 0));
    // int totalEnhancementCount =
    // dataList.fold(0, (sum, item) => sum + (item.inhancementTicketCount ?? 0));
    int grandTotal = dataList.fold(0, (sum, item) => sum + (item.total ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: pageTitle,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset('assets/arrow-left.png'),
        ),
      ),
      body: dataList.isNotEmpty ?SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor: WidgetStateColor.resolveWith(
                (states) => AppColor.primaryBackgroundColor),
            columnSpacing: 16.0,
            // Define the column headers
            columns: const [
              DataColumn(
                  label: Text(
                'Sr No',
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label:
                      Text('Unit Name', style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Ticket Types\nData Correction',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Ticket Types\nNew Requirement',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Ticket Types\nOperator Issue',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Ticket Types\nSoftware Services',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Ticket Types\nBug',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Ticket Types\nEnhancement',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Total Count',
                      style: TextStyle(color: Colors.white))),
            ],
            rows: [
              ...dataList.asMap().entries.map((entry) {
                int index = entry.key + 1;
                DashInfoSubHeader dashInfo = entry.value;

                return DataRow(cells: [
                  DataCell(Text(index.toString())),
                  DataCell(Text(dashInfo.unitName ?? '')),
                  DataCell(Text(
                      dashInfo.dataCorrectionTicketCount?.toString() ?? '0')),
                  DataCell(Text(
                      dashInfo.newRequirmentTIcketCount?.toString() ?? '0')),
                  DataCell(Text(
                      dashInfo.operatorIssueTicketCount?.toString() ?? '0')),
                  DataCell(Text(
                      dashInfo.softwereServiceTicketCount?.toString() ?? '0')),
                  DataCell(Text(dashInfo.bugTicketCount?.toString() ?? '0')),
                  DataCell(
                      Text(dashInfo.inhancementTicketCount?.toString() ?? '0')),
                  DataCell(Text(dashInfo.total?.toString() ?? '0')),
                ]);
              }),
              // Add total row
              DataRow(cells: [
                const DataCell(Text('Total',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                const DataCell(Text('')),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                DataCell(Text(grandTotal.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold))),
              ]),
            ],
          ),
        ),
      ):const Center(
        child: CustomText(
            text: "No Data",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textColor: Colors.black,
            textAlign: TextAlign.center),
      ),
    );
  }
}

class DashInfoTableSubHeaderComplaints extends StatelessWidget {
  final List<DashInfoSubHeader> dataList;
  final String pageTitle;

  const DashInfoTableSubHeaderComplaints({
    super.key,
    required this.dataList,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    // Total count variables for ticket types
    // int totalCorrectionCount =
    // dataList.fold(0, (sum, item) => sum + (item.dataCorrectionTicketCount ?? 0));
    // int totalRequirementCount =
    // dataList.fold(0, (sum, item) => sum + (item.newRequirmentTIcketCount ?? 0));
    // int totalIssueCount =
    // dataList.fold(0, (sum, item) => sum + (item.operatorIssueTicketCount ?? 0));
    // int totalServiceCount =
    // dataList.fold(0, (sum, item) => sum + (item.softwereServiceTicketCount ?? 0));
    // int totalBugCount =
    // dataList.fold(0, (sum, item) => sum + (item.bugTicketCount ?? 0));
    // int totalEnhancementCount =
    // dataList.fold(0, (sum, item) => sum + (item.inhancementTicketCount ?? 0));
    int grandTotal = dataList.fold(0, (sum, item) => sum + (item.total ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: pageTitle,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset('assets/arrow-left.png'),
        ),
      ),
      body: dataList.isNotEmpty
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: WidgetStateColor.resolveWith(
                      (states) => AppColor.primaryBackgroundColor),
                  columnSpacing: 16.0,
                  // Define the column headers
                  columns: const [
                    DataColumn(
                        label: Text(
                      'Sr No',
                      style: TextStyle(color: Colors.white),
                    )),
                    DataColumn(
                        label: Text('Unit Name',
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text('Complaint Types\nDenial of Service',
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text(
                            'Complaint Types\nMoney Taken Against Treat',
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text('Total Count',
                            style: TextStyle(color: Colors.white))),
                  ],
                  rows: [
                    ...dataList.asMap().entries.map((entry) {
                      int index = entry.key + 1;
                      DashInfoSubHeader dashInfo = entry.value;

                      return DataRow(cells: [
                        DataCell(Text(index.toString())),
                        DataCell(Text(dashInfo.unitName ?? '')),
                        DataCell(Text(
                            dashInfo.complaintDenialService?.toString() ??
                                '0')),
                        DataCell(Text(dashInfo.complaintMonetTakeBytreatment
                                ?.toString() ??
                            '0')),
                        DataCell(Text(dashInfo.total?.toString() ?? '0')),
                      ]);
                    }),
                    // Add total row
                    DataRow(cells: [
                      const DataCell(Text('Total',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                      const DataCell(Text("")),
                      const DataCell(Text("")),
                      const DataCell(Text("")),
                      DataCell(Text(grandTotal.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                    ]),
                  ],
                ),
              ),
            )
          : const Center(
              child: CustomText(
                  text: "No Data",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
                  textAlign: TextAlign.center),
            ),
    );
  }
}

class DashInfoTableSubHeaderTestDet extends StatelessWidget {
  final List<DashInfoSubHeader> dataList;
  final String pageTitle;

  const DashInfoTableSubHeaderTestDet({
    super.key,
    required this.dataList,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    // Total count variables for ticket types
    // int totalCorrectionCount =
    // dataList.fold(0, (sum, item) => sum + (item.dataCorrectionTicketCount ?? 0));
    // int totalRequirementCount =
    // dataList.fold(0, (sum, item) => sum + (item.newRequirmentTIcketCount ?? 0));
    // int totalIssueCount =
    // dataList.fold(0, (sum, item) => sum + (item.operatorIssueTicketCount ?? 0));
    // int totalServiceCount =
    // dataList.fold(0, (sum, item) => sum + (item.softwereServiceTicketCount ?? 0));
    // int totalBugCount =
    // dataList.fold(0, (sum, item) => sum + (item.bugTicketCount ?? 0));
    // int totalEnhancementCount =
    // dataList.fold(0, (sum, item) => sum + (item.inhancementTicketCount ?? 0));
    int grandTotal =
        dataList.fold(0, (sum, item) => sum + (item.pendingTest ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: pageTitle,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset('assets/arrow-left.png'),
        ),
      ),
      body: dataList.isNotEmpty ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor: WidgetStateColor.resolveWith(
                (states) => AppColor.primaryBackgroundColor),
            columnSpacing: 16.0,
            // Define the column headers
            columns: const [
              DataColumn(
                  label: Text(
                'Sr No',
                style: TextStyle(color: Colors.white),
              )),
              DataColumn(
                  label:
                      Text('Unit Name', style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Test Types\nPending',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Test Types\nComplete',
                      style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text('Total Count',
                      style: TextStyle(color: Colors.white))),
            ],
            rows: [
              ...dataList.asMap().entries.map((entry) {
                int index = entry.key + 1;
                DashInfoSubHeader dashInfo = entry.value;

                return DataRow(cells: [
                  DataCell(Text(index.toString())),
                  DataCell(Text(dashInfo.unitName ?? '')),
                  DataCell(Text(dashInfo.pendingTest?.toString() ?? '0')),
                  const DataCell(Text('0')),

                  DataCell(Text(dashInfo.pendingTest?.toString() ?? '0')),
                  // DataCell(Text(dashInfo.total?.toString() ?? '0')),
                ]);
              }),
              // Add total row
              DataRow(cells: [
                const DataCell(Text('Total',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                DataCell(Text(grandTotal.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold))),
              ]),
            ],
          ),
        ),
      ):const Center(
        child: CustomText(
            text: "No Data",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            textColor: Colors.black,
            textAlign: TextAlign.center),
      ),
    );
  }
}

class DashInfoSubHeader {
  final String? unitName;
  final String? generatedInvoiceUnitName;
  final String? pendingInvoiceUnitName;
  final int? machineRelatedEventCount;
  final int? tuningrelatedEvenetCount;
  final int? dialyzerRelatedEventCount;
  final int? dialysateRelatedEventCount;
  final int? accessRelatedEventCOunt;
  final int? dataCorrectionTicketCount;
  final int? complaintDashDown;
  final int? complaintDenialService;
  final int? complaintMonetTakeBytreatment;
  final int? complaintMachineDown;
  final int? newRequirmentTIcketCount;
  final int? operatorIssueTicketCount;
  final int? softwereServiceTicketCount;
  final int? bugTicketCount;
  final int? pendingTest;
  final int? inhancementTicketCount;
  final int? total;
  final int? compeletTestCount;

  DashInfoSubHeader({
    this.unitName,
    this.generatedInvoiceUnitName,
    this.pendingInvoiceUnitName,
    this.machineRelatedEventCount,
    this.tuningrelatedEvenetCount,
    this.dialyzerRelatedEventCount,
    this.dialysateRelatedEventCount,
    this.accessRelatedEventCOunt,
    this.dataCorrectionTicketCount,
    this.complaintDashDown,
    this.complaintDenialService,
    this.complaintMonetTakeBytreatment,
    this.complaintMachineDown,
    this.newRequirmentTIcketCount,
    this.operatorIssueTicketCount,
    this.softwereServiceTicketCount,
    this.bugTicketCount,
    this.pendingTest,
    this.inhancementTicketCount,
    this.total,
    this.compeletTestCount
  });

  factory DashInfoSubHeader.fromJson(Map<String, dynamic> json) {
    return DashInfoSubHeader(
      unitName: json['unitName'],
      generatedInvoiceUnitName: json['generatedInvoiceUnitName'],
      pendingInvoiceUnitName: json['pendingInvoiceUnitName'],
      machineRelatedEventCount: json['machineRelatedEventCount'],
      tuningrelatedEvenetCount: json['tuningrelatedEvenetCount'],
      dialyzerRelatedEventCount: json['dialyzerRelatedEventCount'],
      dialysateRelatedEventCount: json['dialysateRelatedEventCount'],
      accessRelatedEventCOunt: json['accessRelatedEventCOunt'],
      dataCorrectionTicketCount: json['dataCorrectionTicketCount'],
      complaintDashDown: json['complaintDashDown'],
      complaintDenialService: json['complaintDenialService'],
      complaintMonetTakeBytreatment: json['complaintMonetTakeBytreatment'],
      complaintMachineDown: json['complaintMachineDown'],
      newRequirmentTIcketCount: json['newRequirmentTIcketCount'],
      operatorIssueTicketCount: json['operatorIssueTicketCount'],
      softwereServiceTicketCount: json['softwereServiceTicketCount'],
      bugTicketCount: json['bugTicketCount'],
      pendingTest: json['pendingTest'],
      inhancementTicketCount: json['inhancementTicketCount'],
      total: json['total'],
      compeletTestCount: json['compeletTestCount'],
    );
  }
}

class DashInfoTotal {
  final String? unitName;
  final int? mjpjayCount;
  final int? nonMjpjayCount;
  final int? total;

  DashInfoTotal({
    this.unitName,
    this.mjpjayCount,
    this.nonMjpjayCount,
    this.total,
  });

  factory DashInfoTotal.fromJson(Map<String, dynamic> json) {
    return DashInfoTotal(
      unitName: json['unitName'],
      mjpjayCount: json['mjpjayCount'],
      nonMjpjayCount: json['nonMjpjayCount'],
      total: json['total'],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:heamodialysis/utils/color_constants.dart';
// import 'package:heamodialysis/widgets/custom_text.dart';
//
// class DashInfoTableTotal extends StatelessWidget {
//   final List<DashInfoTotal> dataList;
//   final String pageTitle;
//
//   const DashInfoTableTotal(
//       {super.key, required this.dataList, required this.pageTitle});
//
//   @override
//   Widget build(BuildContext context) {
//     int totalMjpjayCount =
//         dataList.fold(0, (sum, item) => sum + item.mjpjayCount);
//     int totalNonMjpjayCount =
//         dataList.fold(0, (sum, item) => sum + item.nonMjpjayCount);
//     int grandTotal = dataList.fold(0, (sum, item) => sum + item.total);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: CustomText(
//           text: pageTitle ?? "",
//           fontSize: 18.0,
//           fontFam: 'Lato',
//           fontWeight: FontWeight.w400,
//           textColor: Colors.black,
//           textAlign: TextAlign.start,
//         ),
//         leading: InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: Image.asset('assets/arrow-left.png')),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: DataTable(
//             headingRowColor: WidgetStateColor.resolveWith(
//                 (states) => AppColor.primaryBackgroundColor),
//             columnSpacing: 16.0,
//             columns: const [
//               DataColumn(label: Text('Sr No')),
//               DataColumn(label: Text('Unit Name')),
//               DataColumn(label: Text('MJPJAY Count')),
//               DataColumn(label: Text('Non-MJPJAY Count')),
//               DataColumn(label: Text('Total')),
//             ],
//             rows: [
//               ...dataList.asMap().entries.map((entry) {
//                 int index = entry.key + 1;
//                 DashInfoTotal dashInfo = entry.value;
//                 return DataRow(cells: [
//                   DataCell(Text(index.toString())),
//                   DataCell(
//                     SizedBox(
//                         width: 140,
//                         child: Text(dashInfo.unitName,
//                             overflow: TextOverflow.ellipsis)),
//                   ),
//                   DataCell(Text(dashInfo.mjpjayCount.toString())),
//                   DataCell(Text(dashInfo.nonMjpjayCount.toString())),
//                   DataCell(Text(dashInfo.total.toString())),
//                 ]);
//               }),
//               DataRow(cells: [
//                 const DataCell(Text('Total',
//                     style: TextStyle(fontWeight: FontWeight.bold))),
//                 const DataCell(Text('')),
//                 DataCell(Text("")),
//                 DataCell(Text("")),
//                 DataCell(Text(grandTotal.toString(),
//                     style: const TextStyle(fontWeight: FontWeight.bold))),
//               ]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DashInfoTotal {
//   final String unitName;
//   final int mjpjayCount;
//   final int nonMjpjayCount;
//   final int total;
//
//   DashInfoTotal({
//     required this.unitName,
//     required this.mjpjayCount,
//     required this.nonMjpjayCount,
//     required this.total,
//   });
//
//   factory DashInfoTotal.fromJson(Map<String, dynamic> json) {
//     return DashInfoTotal(
//       unitName: json['unitName'],
//       mjpjayCount: json['mjpjayCount'],
//       nonMjpjayCount: json['nonMjpjayCount'],
//       total: json['total'],
//     );
//   }
// }
