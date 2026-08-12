import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/dash_info_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class DashInfoTable extends StatelessWidget {
  final List<DashInfoData> patients;
  final String? pageTitle;

  const DashInfoTable({
    super.key,
    required this.patients,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: pageTitle ?? "",
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
      body:patients.isNotEmpty
    ? SingleChildScrollView(
    scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(AppColor.primaryBackgroundColor),
            columnSpacing: 21.0,
            columns: <DataColumn>[
              buildHeader('Sr. No'),
              buildHeader('Patient ID'),
              buildHeader('Patient Name'),
              buildHeader('ABH No'),
            ],
            rows: List<DataRow>.generate(
              patients.length,
                  (index) {
                final patient = patients[index];
                return DataRow(
                  color: MaterialStateProperty.resolveWith((states) =>
                  index.isEven ? Colors.grey.shade200 : Colors.white
                  ),
                  cells: <DataCell>[
                    DataCell(Text((index + 1).toString())),
                    DataCell(Text(patient.patientId.toString())),
                    DataCell(Text(patient.fullName)),
                    DataCell(Text(patient.abhNo ?? "")),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    )
        : const Center(
    child: CustomText(
    text: "No Data",
    fontSize: 16,
    fontWeight: FontWeight.normal,
    textColor: Colors.black,
    textAlign: TextAlign.center,
    ),
    ),

    );
  }

  buildHeader(String title) {
    return DataColumn(
      label: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}


class DashInfoTable1 extends StatelessWidget {
  final List<String> l1;
  final List<dynamic> l2;
  final List<dynamic> l3;
  final List<String> tableHeader;
  final Function(int index)? onButtonPressed;
  final String? pageTitle;

  const DashInfoTable1({
    super.key,
    required this.l1,
    required this.l2,
    required this.l3,
    required this.tableHeader,
    this.onButtonPressed,
    this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        text: pageTitle ?? "",
        fontSize: 18.0,
        fontFam: 'Lato',
        fontWeight: FontWeight.w400,
        textColor: Colors.black,
        textAlign: TextAlign.start,
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: [
            l1.isNotEmpty
                ? _buildRoundedTableRow(tableHeader)
                : TableRow(children: [
                    const CustomText(
                      text: "Data Not available",
                      fontSize: 14.0,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                      fontFam: "Lato",
                      fontWeight: FontWeight.normal,
                    ).paddingOnly(left: 8, bottom: 4)
                  ]),
            for (int i = 0; i < l1.length; i++)
              l1.isNotEmpty
                  ? _buildTableRow(i)
                  : TableRow(children: [
                      const CustomText(
                        text: "",
                        fontSize: 14.0,
                        textColor: Colors.black,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.normal,
                        fontFam: 'Lato',
                      ).paddingOnly(left: 8, bottom: 4)
                    ]),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  TableRow _buildRoundedTableRow(List<String> data) {
    return TableRow(
      children: List.generate(
        data.length,
        (index) => TableCell(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.secondaryColor, // Background color of the header
              borderRadius: BorderRadius.only(
                topLeft: index == 0 ? const Radius.circular(10.0) : Radius.zero,
                topRight: index == data.length - 1
                    ? const Radius.circular(10.0)
                    : Radius.zero,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white, // Text color for the header
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(int index) {
    return TableRow(
      children: List.generate(
        tableHeader.length,
        (i) => TableCell(
          verticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      [l1[index], l2[index], l3[index]][i].toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
