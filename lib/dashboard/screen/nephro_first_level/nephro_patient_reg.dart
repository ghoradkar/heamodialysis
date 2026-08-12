
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/dash_info_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class DashInfoTableNephro extends StatelessWidget {
  final List<DashInfoData> patients;
  final String? pageTitle;
  final Function? showPopUp;

  const DashInfoTableNephro(
      {super.key,
        required this.patients,
        required this.pageTitle,
        this.showPopUp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: pageTitle ?? "",
          fontSize: 18.sp,
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
            child: Center(
              child: DataTable(
                headingRowColor: WidgetStateColor.resolveWith(
                        (states) => AppColor.primaryBackgroundColor),
                columnSpacing: 20.0,
                columns: <DataColumn>[
                  buildHeader('Sr. No'),
                  buildHeader(
                      'Institute Name'),
                  buildHeader('Total Patient Register'),
                ],
                rows: patients.asMap().entries.map((entry) {
                  final index = entry.key + 1;
                  final patient = entry.value;
                  return DataRow(cells: <DataCell>[
                    DataCell(Text(index.toString())),
                    DataCell(Text(patient.unitName ?? '')),
                    DataCell(
                      InkWell(
                        onTap: () {
                          showPopUp!(patient.unitId);
                        },
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 6.h,horizontal: 6.w),
                          child: Text(
                           patient.patientAdded.toString(),
                            style:  TextStyle(
                              color: Colors.blue,
                              fontSize: 16.sp,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]);
                }).toList(),
              ).paddingSymmetric(vertical: 4.h, horizontal: 4.w),
            ),
          ),
        ),
      )
          :  Center(
        child: CustomText(
            text: "No Data",
            fontSize: 16.sp,
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
