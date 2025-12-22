import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class DashInfoTableTechnician extends StatelessWidget {
  final List<Map<String, dynamic>> patients;
  final String? pageTitle;
  final Function? showData;

  const DashInfoTableTechnician({
    super.key,
    required this.patients,
    required this.pageTitle,
    this.showData,
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
      body: patients.isNotEmpty
          ? Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.resolveWith(
                      (states) => AppColor.primaryBackgroundColor,
                    ),
                    columnSpacing: 14.0,
                    columns: <DataColumn>[
                      buildHeader('Sr. No'), // New "Sr. No" column
                      buildHeader('Scheme'),
                      buildHeader('Session Count'),
                      buildHeader('View Patient'),
                    ],
                    rows: List<DataRow>.generate(
                      patients.length,
                      (index) {
                        final patient = patients[index];
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(Text((index + 1).toString())), // Sr. No

                            DataCell(Text(patient.containsKey('mjpjayCount')
                                ? 'MJPJY'
                                : 'Non MJPJY')),
                            DataCell(Text(patient.containsKey('mjpjayCount')
                                ? patient['mjpjayCount'].toString()
                                : patient['nonMjpjyCount'].toString())),
                            DataCell(TextButton(
                              onPressed: () {
                                showData!(patient.containsKey('mjpjayCount')
                                    ? 'MJP'
                                    : 'NMJ');
                              },
                              child: const Text("Show Data"),
                            ))
                          ],
                        );
                      },
                    ),
                  ).paddingSymmetric(vertical: 4, horizontal: 8),
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
