import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/dash_info_data.dart';
import 'package:heamodialysis/dashboard/model/event_details_id.dart';
import 'package:heamodialysis/dashboard/model/total_dialysis_patient_model.dart';
import 'package:heamodialysis/dashboard/screen/super_admin/total_invoice_amount_model.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class DashInfoTableAdmin extends StatelessWidget {
  final List<DashInfoData> patients;
  final String? pageTitle;
  final Function? showPopUp;
  final bool? isEvent;

  const DashInfoTableAdmin(
      {super.key,
      required this.patients,
      required this.pageTitle,
      this.showPopUp,
      this.isEvent});

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
                  child: Center(
                    child: DataTable(
                      headingRowColor: WidgetStateColor.resolveWith(
                          (states) => AppColor.primaryBackgroundColor),
                      columnSpacing: 20.0,
                      columns: <DataColumn>[
                        buildHeader(context.l10n.colSrNo),
                        buildHeader(isEvent == true
                            ? context.l10n.colType
                            : context.l10n.colInstituteName),
                        buildHeader(isEvent == true
                            ? context.l10n.colCount
                            : context.l10n.colTotalPatientRegister),
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
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  isEvent == true
                                      ? patient.totalEvent.toString()
                                      : patient.totalPatRegister?.toString() ??
                                          "0",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ).paddingSymmetric(vertical: 4, horizontal: 4),
                  ),
                ),
              ),
            )
          : Center(
              child: CustomText(
                  text: context.l10n.commonNoDataFound,
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

class DashInfoTableEvent extends StatelessWidget {
  final List<EventDetailsId> patients;
  final String? pageTitle;

  const DashInfoTableEvent(
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
                        buildHeader(context.l10n.colSrNo),
                        buildHeader(context.l10n.colEventName),
                        buildHeader(context.l10n.colEventCount),
                      ],
                      rows: patients.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final patient = entry.value;
                        return DataRow(cells: <DataCell>[
                          DataCell(Text(index.toString())),
                          DataCell(Text(patient.eventName ?? '')),
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                patient.eventCount?.toString() ?? "0",
                                style: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ).paddingSymmetric(vertical: 4, horizontal: 4),
                  ),
                ),
              ),
            )
          : Center(
              child: CustomText(
                  text: context.l10n.commonNoDataFound,
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

class DashInfoTableAbha extends StatelessWidget {
  final List<DashInfoData> patients;
  final String? pageTitle;
  final Function? onClick;

  const DashInfoTableAbha({
    super.key,
    required this.patients,
    required this.pageTitle,
    this.onClick,
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
          child: Image.asset('assets/arrow-left.png'),
        ),
      ),
      body: patients.isNotEmpty
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width),
                  child: DataTable(
                  headingRowColor: WidgetStateProperty.resolveWith(
                    (states) => AppColor.primaryBackgroundColor,
                  ),
                  columnSpacing: MediaQuery.of(context).size.width * 0.1 / 3,
                  columns: <DataColumn>[
                    buildHeader(context.l10n.colSrNo),
                    buildHeader(context.l10n.colInstituteName),
                    buildHeader(context.l10n.colAbhaNo),
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
                            onClick!(patient.unitId);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              patient.abhaRegCount != null
                                  ? patient.abhaRegCount.toString()
                                  : "",
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ]);
                  }).toList(),
                ).paddingSymmetric(vertical: 4, horizontal: 8),
                ),
              ),
            )
          : Center(
              child: CustomText(
                text: context.l10n.commonNoDataFound,
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

class TotalDialysisPatient extends StatelessWidget {
  final List<TotalDialysisPatientModel> patients;
  final String? pageTitle;
  final String? pageTitleSecond;
  final bool showTreatment;
  final bool showAbha;

  const TotalDialysisPatient(
      {super.key,
      required this.patients,
      required this.pageTitle,
      this.pageTitleSecond,
      required this.showTreatment,
      required this.showAbha});

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
          ? Column(
              children: [
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
                ).paddingOnly(left: 6, right: 4),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: WidgetStateColor.resolveWith(
                            (states) => AppColor.primaryBackgroundColor),
                        columnSpacing: 16.0,
                        columns: <DataColumn>[
                          buildHeader(context.l10n.colSrNo),
                          buildHeader(context.l10n.colInstituteName),
                          buildHeader(context.l10n.colPatientId),
                          buildHeader(context.l10n.colPatientName),
                          if (showTreatment) buildHeader(context.l10n.colTreatmentId),
                          buildHeader(context.l10n.colSchemeName),
                          if (showAbha) buildHeader(context.l10n.colAbhaNo),
                          buildHeader(context.l10n.colViralLoadStatus),
                          // buildHeader('Dialysis Date')
                        ],
                        rows: patients.asMap().entries.map((entry) {
                          final index = entry.key + 1;
                          final patient = entry.value;
                          return DataRow(cells: <DataCell>[
                            DataCell(Text(index.toString())),
                            DataCell(Text(patient.unitName ?? '')),
                            DataCell(Text(patient.patientId.toString())),
                            DataCell(Text("${patient.fName} ${patient.lName}")),
                            if (showTreatment)
                              DataCell(Text(patient.treatmentId != null
                                  ? patient.treatmentId.toString()
                                  : "")),
                            DataCell(Text(patient.schemeName ?? "")),
                            if (showAbha)
                              DataCell(Text(patient.abhNo != null
                                  ? patient.abhNo.toString()
                                  : "")),

                            DataCell(Text(patient.procedreType ?? "")),
                            // const DataCell(Text("")),
                          ]);
                        }).toList(),
                      ).paddingSymmetric(vertical: 4, horizontal: 8),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: CustomText(
                  text: context.l10n.commonNoDataFound,
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

class TotalDialysisPatientId extends StatelessWidget {
  final List<TotalDialysisPatientModel> patients;
  final String? pageTitle;
  final String? pageTitleSecond;

  const TotalDialysisPatientId(
      {super.key,
      required this.patients,
      required this.pageTitle,
      this.pageTitleSecond});

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
          ? Column(
              children: [
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
                ).paddingOnly(left: 6, right: 4),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: WidgetStateColor.resolveWith(
                            (states) => AppColor.primaryBackgroundColor),
                        columnSpacing: 16.0,
                        columns: <DataColumn>[
                          buildHeader(context.l10n.colSrNo),
                          buildHeader(context.l10n.colInstituteName),
                          buildHeader(context.l10n.colPatientId),
                          buildHeader(context.l10n.colPatientName),
                          // buildHeader('Treatment Id'),
                          buildHeader(context.l10n.colSchemeName),

                          buildHeader(context.l10n.colAbhaNo),
                          buildHeader(context.l10n.colViralLoadStatus),
                          // buildHeader('Dialysis Date'),
                        ],
                        rows: patients.asMap().entries.map((entry) {
                          final index = entry.key + 1;
                          final patient = entry.value;
                          return DataRow(cells: <DataCell>[
                            DataCell(Text(index.toString())),
                            DataCell(Text(patient.unitName ?? '')),
                            DataCell(Text(patient.patientId.toString())),
                            DataCell(Text("${patient.fName} ${patient.lName}")),
                            // const DataCell(Text("")),
                            DataCell(Text(patient.schemeName ?? "")),

                            DataCell(Text(patient.abhNo ?? "")),
                            DataCell(Text(patient.procedreType ?? "")),
                            // const DataCell(Text("--")),
                            // const DataCell(Text("")),
                          ]);
                        }).toList(),
                      ).paddingSymmetric(vertical: 4, horizontal: 8),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: CustomText(
                  text: context.l10n.commonNoDataFound,
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

class AbhaCountIdTable extends StatelessWidget {
  final List<DashInfoData> patients;
  final String? pageTitle;
  final String? pageTitleSecond;

  const AbhaCountIdTable(
      {super.key,
      required this.patients,
      required this.pageTitle,
      this.pageTitleSecond});

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
          ? Column(
              children: [
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
                ).paddingOnly(left: 6, right: 4),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: WidgetStateColor.resolveWith(
                            (states) => AppColor.primaryBackgroundColor),
                        columnSpacing: 16.0,
                        columns: <DataColumn>[
                          buildHeader(context.l10n.colSrNo),
                          buildHeader(context.l10n.colInstituteName),
                          buildHeader(context.l10n.colPatientId),
                          buildHeader(context.l10n.colPatientName),
                          // buildHeader('Treatment Id'),
                          buildHeader(context.l10n.colSchemeName),
                          buildHeader(context.l10n.colAbhaNo),
                        ],
                        rows: patients.asMap().entries.map((entry) {
                          final index = entry.key + 1;
                          final patient = entry.value;
                          return DataRow(cells: <DataCell>[
                            DataCell(Text(index.toString())),
                            DataCell(Text(patient.unitName ?? '')),
                            DataCell(Text(patient.patientId.toString())),
                            DataCell(Text("${patient.fName} ${patient.lName}")),
                            // const DataCell(Text("")),
                            (patient.schemeId != null && patient.schemeId != 0)
                                ? DataCell(Text(patient.schemeId == 10
                                    ? context.l10n.dashSchemeMjpjay
                                    : context.l10n.dashSchemeNonMjpjay))
                                : const DataCell(Text('--')),
                            // DataCell(Text(patient.abhNo ?? "")),
                            DataCell(Text(patient.abhNo ?? "")),
                            // const DataCell(Text("")),
                          ]);
                        }).toList(),
                      ).paddingSymmetric(vertical: 4, horizontal: 8),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: CustomText(
                  text: context.l10n.commonNoDataFound,
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

class TotalPatientRegistration extends StatelessWidget {
  final List<TotalInvoiceAmountModel> patients;
  final String? pageTitle;
  final Function? showPopUp;

  const TotalPatientRegistration(
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
                  child: Center(
                    child: DataTable(
                      headingRowColor: WidgetStateColor.resolveWith(
                          (states) => AppColor.primaryBackgroundColor),
                      columnSpacing: 20.0,
                      columns: <DataColumn>[
                        buildHeader(context.l10n.colSrNo),
                        buildHeader(context.l10n.colInvoiceAmount),
                        buildHeader(context.l10n.colMonthYear),
                      ],
                      rows: patients.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final patient = entry.value;
                        return DataRow(cells: <DataCell>[
                          DataCell(Text(index.toString())),
                          DataCell(Text(
                              patient.totalInvoiceAmount.toString())),
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                patient.months?.toString() ?? "0",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ).paddingSymmetric(vertical: 4, horizontal: 4),
                  ),
                ),
              ),
            )
          : Center(
              child: CustomText(
                  text: context.l10n.commonNoDataFound,
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
