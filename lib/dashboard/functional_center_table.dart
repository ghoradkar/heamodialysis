import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/dash_info_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class FunctionalCenterTable extends StatelessWidget {
  final List<DashInfoData> patients;
  final String? pageTitle;

  const FunctionalCenterTable(
      {super.key, required this.patients, required this.pageTitle});

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
      body: patients.isNotEmpty
          ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor: WidgetStateColor.resolveWith(
                    (states) => AppColor.primaryBackgroundColor),
            columnSpacing: 10.0,
            columns: <DataColumn>[
              buildHeader('Sr. No'), // Add Serial Number column header
              buildHeader('District Name'),
              buildHeader('Institute Name'),
              buildHeader('Machine Count'),
              buildHeader('Commencement Date'),
              buildHeader('Patient Registered'),
              buildHeader('Session Done')
            ],
            rows: patients.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final patient = entry.value;
              return DataRow(cells: <DataCell>[
                DataCell(Text(index.toString())),
                DataCell(Text(patient.districtName ?? '')),
                DataCell(
                  SizedBox(
                    width: 150, // Set the desired width here
                    child: Text(
                      patient.unitName ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                DataCell(Text(patient.machineCount.toString())),
                DataCell(Text(patient.commertialDate ?? "")),
                DataCell(Text(patient.totalPatRegister.toString())),
                DataCell(Text(patient.totalsession.toString())),
              ]);
            }).toList(),
          ).paddingSymmetric(vertical: 4, horizontal: 8),
        ),
      )
          : const Center(
        child: CustomText(
            text: "No Data",
            fontSize: 16,
            fontWeight: FontWeight.normal,
            textColor: Colors.black,
            textAlign: TextAlign.center),
      ),
    );
  }

  buildHeader(String title) {
    return DataColumn(
      label: Text(
        title,
        style:
        const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
