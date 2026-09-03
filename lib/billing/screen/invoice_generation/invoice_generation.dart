import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/billing/controller/invoice_approval_controller.dart';
import 'package:heamodialysis/billing/model/invoice_approval_model.dart';
import 'package:heamodialysis/billing/model/send_for_approval_req.dart';
import 'package:heamodialysis/billing/screen/invoice_approval/service_certificate.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';


class InvoiceGeneration extends StatefulWidget {
  const InvoiceGeneration({super.key});

  @override
  State<InvoiceGeneration> createState() => InvoiceGenerationState();
}

class InvoiceGenerationState extends State<InvoiceGeneration> {
  final InvoiceApprovalController invoiceApprovalController =
      Get.put(InvoiceApprovalController());

  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Invoice No',
    'Invoice Month',
    'Invoice Amount'
  ];

  var userData;

  List<String>? yearList;
  List<String> monthList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  String? selectedYear;

  String? selectedMonth;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    super.initState();
  }

  String getMonthNumber(String monthName) {
    int index = monthList.indexOf(monthName);
    return index != -1 ? (index + 1).toString() : "Invalid Month";
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    invoiceApprovalController.update();
    if (hasInternet) {
      DateTime now = DateTime.now();
      String year = now.year.toString();
      String month = now.month.toString().padLeft(2, '0');

      yearList = getLastThreeYears();

      await invoiceApprovalController.getInvoiceList(int.parse(month),
          int.parse(year), userData['unitId'], userData['user_ID']);
    }
  }

  List<String> getLastThreeYears() {
    int currentYear = DateTime.now().year;
    return List.generate(3, (index) => (currentYear - index).toString());
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  CustomText(
          text: "INVOICE Generation",
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
        actions: [
          InkWell(
            onTap: () async {
              bool hasTrueValue = invoiceApprovalController
                  .invoiceApprovalModel!
                  .any((item) => item.isSelected);

              if (hasTrueValue) {
                DateTime now = DateTime.now();
                String year = now.year.toString();
                String month = now.month.toString().padLeft(2, '0');
                List<TtInvoiceStatewiseBean> list = [];
                for (int i = 0;
                    i < invoiceApprovalController.invoiceApprovalModel!.length;
                    i++) {
                  list.add(TtInvoiceStatewiseBean(
                      invoiceStateId: invoiceApprovalController
                          .invoiceApprovalModel![i].invoiceStateId,
                      serviceCode: 'ISN',
                      billStatus: 'INA',
                      levelValue: 'LVL2'));
                }

                invoiceApprovalController
                    .sendForApprovalReq.ttInvoiceStatewiseBean = list;
                invoiceApprovalController.sendForApprovalReq.invoiceStateId =
                    list.first.invoiceStateId;
                invoiceApprovalController.sendForApprovalReq.serviceCode =
                    'ISN';
                invoiceApprovalController.sendForApprovalReq.billStatus = 'INA';
                invoiceApprovalController.sendForApprovalReq.levelValue =
                    'LVL2';
                invoiceApprovalController.sendForApprovalReq.unitId =
                    userData['unitId'];
                invoiceApprovalController.sendForApprovalReq.userIdd =
                    userData['user_ID'];
                await invoiceApprovalController.sendForApproval(
                    int.parse(month),
                    int.parse(year),
                    userData['unitId'],
                    userData['user_ID']);
              }
            },
            child: CustomText(
                text: "Generate",
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                textColor: AppColor.primaryBackgroundColor,
                textAlign: TextAlign.center),
          ).paddingOnly(right: 2.w),
          InkWell(
            child: Image.asset(
              "assets/filter-line.png",
              color: AppColor.primaryBackgroundColor,
            ),
            onTap: () {
              filterInvoice();
            },
          ).paddingOnly(right: 10.w),
        ],
      ),
      body: GetBuilder<InvoiceApprovalController>(
          init: invoiceApprovalController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: invoiceApprovalController
                            .invoiceApprovalModel?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InvoiceApprovalCard(
                            index: index,
                            roList: invoiceApprovalController
                                .invoiceApprovalModel?[index],
                            cardItemDetailsList: cardItemDetailsList,
                            callB1: (index) {
                              var body = {
                                "invNo": invoiceApprovalController
                                    .invoiceApprovalModel?[index].invNo,
                                "userId": userData['user_ID']
                              };

                              controller.viewInvoiceReport(
                                  body, "Invoice Report");
                            },
                            callB2: (index) async {
                              var body = {
                                "invNo": invoiceApprovalController
                                    .invoiceApprovalModel?[index].invNo,
                                "userId": userData['user_ID']
                              };
                              controller.viewInvoiceSummary(
                                  body, "Invoice Summary");
                            },
                            check: (value) {
                              invoiceApprovalController
                                  .invoiceApprovalModel?[index]
                                  .isSelected = value;
                              setState(() {});
                            },
                            callB3: (index) {
                              var body = {
                                "invNo": invoiceApprovalController
                                    .invoiceApprovalModel?[index].invNo,
                                "userId": userData['user_ID']
                              };

                              controller.viewMavCalculation(
                                  body, "MAV Calculations");
                            },
                            callB4: (index) {
                              Get.to(ServiceCertificateScreen(
                                invoiceApprovalModel: invoiceApprovalController
                                    .invoiceApprovalModel?[index],
                              ));
                            },
                          ).paddingSymmetric(horizontal: 8.w);
                        },
                      )
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }

  filterInvoice() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding:  EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: const Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 0.5), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   CustomText(
                          text: "Filter Invoice",
                          fontSize: 16.sp,
                          fontFam: "Lato",
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                          textAlign: TextAlign.start)
                      .paddingSymmetric(vertical: 4.h),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Image.asset(
                        "assets/cancel.png",
                        width: 24.w,
                        height: 24.h,
                        color: AppColor.primaryBackgroundColor,
                      )),
                ],
              ),
              MyCustomDropdown(
                items: monthList,
                labelText: 'Month',
                hint: 'Month',
                isRequired: false,
                senValue: (value) {
                  selectedMonth = value;
                  invoiceApprovalController.update();
                },
                filledColor: Colors.white,
              ),
              MyCustomDropdown(
                items: yearList ?? [],
                labelText: 'Year',
                hint: 'Year',
                isRequired: false,
                senValue: (value) {
                  selectedYear = value;
                  invoiceApprovalController.update();
                },
                filledColor: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          padding:  EdgeInsets.symmetric(vertical: 8.h),
                          alignment: Alignment.center,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.red,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/cancel.png"),
                               CustomText(
                                  text: "Cancel",
                                  fontSize: 16.sp,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.normal,
                                  textColor: Colors.white,
                                  textAlign: TextAlign.start),
                            ],
                          )),
                    ),
                  ).paddingOnly(top: 20.h),
                   SizedBox(
                    width: 14.w,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () async {
                        Get.back();
                        String month = getMonthNumber(selectedMonth!);

                        await invoiceApprovalController.getInvoiceList(
                            int.parse(month),
                            int.parse(selectedYear!),
                            userData['unitId'],
                            userData['user_ID']);
                        setState(() {});
                      },
                      child: Container(
                          padding:  EdgeInsets.symmetric(vertical: 8.h),
                          alignment: Alignment.center,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                AppColor.primaryBackgroundColor,
                                AppColor.secondaryColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              CustomText(
                                  text: "Search",
                                  fontSize: 16.sp,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.normal,
                                  textColor: Colors.white,
                                  textAlign: TextAlign.start),
                            ],
                          )),
                    ),
                  ).paddingOnly(top: 20.h),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class InvoiceApprovalCard extends StatelessWidget {
  final InvoiceApprovalModel? roList;
  final List<String> cardItemDetailsList;
  final Function callB1;
  final Function callB2;
  final Function callB3;
  final Function callB4;
  final Function check;
  final int index;

  const InvoiceApprovalCard({
    super.key,
    this.roList,
    required this.cardItemDetailsList,
    required this.callB1,
    required this.callB2,
    required this.index,
    required this.check,
    required this.callB3,
    required this.callB4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      // padding: const EdgeInsets.only(left: 4),
      // width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    patientDetailsCard(
                        cardItemDetailsList[0], roList?.invNo ?? "-"),
                    patientDetailsCard(cardItemDetailsList[1],
                        "${roList?.monthName} ${roList?.year}"),
                    patientDetailsCard(
                        cardItemDetailsList[2], "${roList?.invoiceAmount}"),
                  ],
                ),
              ),
              Checkbox(
                activeColor: AppColor.primaryBackgroundColor,
                value: roList?.isSelected, // Boolean value for checkbox state
                onChanged: (bool? newValue) {
                  check(newValue);
                },
              ),
            ],
          ).paddingOnly(left: 8.w, bottom: 4.h, top: 8.h),
          Container(
            // width: 70,

            // padding: EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: AppColor.darkBlue,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                patientCardActions(
                  "Invoice\nReport",
                  () {
                    callB1(index);
                  },
                ),
                 SizedBox(
                  width: 8.w,
                ),
                patientCardActions(
                  "Invoice\nSummary",
                  () {
                    callB2(index);

                  },
                ),
                patientCardActions(
                  "MAV\nCalculation",
                  () {
                    callB3(index);
                  },
                ),
                patientCardActions(
                  "Service\nCertificate",
                  () {
                    callB4(index);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ).paddingSymmetric(vertical: 4.h, horizontal: 4.w);
  }

  Widget patientDetailsCard(String text, String? details) {
    return Row(
      children: [
        CustomText(
                text: "$text :",
                fontSize: 13.sp,
                fontFam: "Lato",
                fontWeight: FontWeight.normal,
                textColor: Colors.black,
                textAlign: TextAlign.start)
            .paddingSymmetric(vertical: 2),
        Expanded(
          child: CustomText(
              text: details ?? "",
              fontSize: 13.sp,
              fontFam: "Lato",
              fontWeight: FontWeight.normal,
              textColor: Colors.grey,
              textAlign: TextAlign.start),
        ),
      ],
    );
  }

  dateConversion(inputDate) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(inputDate);
    String convertedDate = DateFormat('yyyy-MM-dd').format(date);
    return convertedDate;
  }

  Widget patientCardActions(String text, Function callB) {
    return InkWell(
        onTap: () {
          callB();
        },
        child: CustomText(
            text: text,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            textColor: Colors.white,
            textAlign: TextAlign.center));
  }
}
