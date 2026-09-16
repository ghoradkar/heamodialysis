import 'package:flutter/material.dart';
import 'package:heamodialysis/dashboard/widget/dash_info_table_total.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/utils/color_constants.dart';

class TableBillGeneration extends StatelessWidget {
  final List<DashInfoSubHeader> invoiceData;
  final List<String> tableHeader;

  const TableBillGeneration({
    super.key,
    required this.invoiceData,
    required this.tableHeader,
  });

  @override
  Widget build(BuildContext context) {
    // Get the width of the screen
    final double screenWidth = MediaQuery.of(context).size.width;

    return invoiceData.isEmpty
        ? Center(child: Text(context.l10n.commonNoDataFound))
        : Container(
      decoration:  BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColor.borderColor, width: 1), // Left border
          right: BorderSide(color: AppColor.borderColor, width: 1), // Right border
          bottom: BorderSide(color: AppColor.borderColor, width: 1), // Bottom border
        ),
      ),
      child: SizedBox(
        height: 300, // Specify the height for the table
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical, // Enable vertical scrolling
            child: DataTable(
            headingRowColor: WidgetStateProperty.resolveWith(
                  (states) => AppColor.primaryBackgroundColor,
            ),
            columns: [
              DataColumn(
                label: SizedBox(
                  width: screenWidth * 0.4, // Dynamic width based on screen size
                  child: Text(
                    tableHeader[0],
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ), // Generated
              DataColumn(
                label: SizedBox(
                  width: screenWidth * 0.4, // Dynamic width based on screen size
                  child: Text(
                    tableHeader[1],
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ), // Pending
            ],
            rows: List<DataRow>.generate(
              invoiceData.length,
                  (index) {
                final data = invoiceData[index];
                return DataRow(
                  cells: [
                    DataCell(
                      Container(
                        decoration:  BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: AppColor.borderColor, // Border between columns
                              width: 1,
                            ),
                          ),
                        ),
                        width: screenWidth * 0.4, // Dynamic width based on screen size
                        child: Text(
                          data.generatedInvoiceUnitName ?? 'N/A',
                          overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                          maxLines: 1, // Limit to one line
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: screenWidth * 0.4, // Dynamic width based on screen size
                        child: Text(
                          data.pendingInvoiceUnitName ?? 'N/A',
                          overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                          maxLines: 1, // Limit to one line
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            ),
          ),
        ),
      ),
    );
  }
}

// class TableBillGeneration extends StatelessWidget {
//   final List<DashInfoSubHeader> invoiceData;
//   final List<String> tableHeader;
//
//   const TableBillGeneration({
//     super.key,
//     required this.invoiceData,
//     required this.tableHeader,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Get the width of the screen
//     final double screenWidth = MediaQuery.of(context).size.width;
//
//     return invoiceData.isEmpty
//         ? const Center(child: Text('No data available'))
//         : SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         headingRowColor: WidgetStateColor.resolveWith(
//                 (states) => AppColor.primaryBackgroundColor),
//         columns: [
//           DataColumn(
//             label: SizedBox(
//               width: screenWidth * 0.4, // Dynamic width based on screen size
//               child: Text(
//                 tableHeader[0],
//                 textAlign: TextAlign.start,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ), // Generated
//           DataColumn(
//             label: SizedBox(
//               width: screenWidth * 0.4, // Dynamic width based on screen size
//               child: Text(
//                 tableHeader[1],
//                 textAlign: TextAlign.start,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ), // Pending
//         ],
//         rows: List<DataRow>.generate(
//           invoiceData.length,
//               (index) {
//             final data = invoiceData[index];
//             return DataRow(
//               cells: [
//                 DataCell(
//                   SizedBox(
//                     width: screenWidth * 0.4, // Dynamic width based on screen size
//                     child: Text(
//                       data.generatedInvoiceUnitName ?? 'N/A',
//                       overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
//                       maxLines: 1, // Limit to one line
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),
//                 DataCell(
//                   SizedBox(
//                     width: screenWidth * 0.4, // Dynamic width based on screen size
//                     child: Text(
//                       data.pendingInvoiceUnitName ?? 'N/A',
//                       overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
//                       maxLines: 1, // Limit to one line
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
