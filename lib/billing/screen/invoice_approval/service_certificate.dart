import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/billing/controller/invoice_approval_controller.dart';
import 'package:heamodialysis/billing/model/invoice_approval_model.dart';
import 'package:heamodialysis/billing/model/service_certificate_model.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/api_urls.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/image_viewer.dart';


class ServiceCertificateScreen extends StatefulWidget {
  final InvoiceApprovalModel? invoiceApprovalModel;

  const ServiceCertificateScreen({super.key, this.invoiceApprovalModel});

  @override
  State<ServiceCertificateScreen> createState() =>
      ServiceCertificateScreenState();
}

class ServiceCertificateScreenState extends State<ServiceCertificateScreen> {
  final InvoiceApprovalController invoiceApprovalController = Get.find();

  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Institute Name',
    'Certificate Number',
    'Certificate Month',
    'Certificate Amount',
    'Expected Dialysis Count',
    'Actual Dialysis Count',
    'Minimum Guarantee',
  ];

  var userData;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    super.initState();
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
      // await invoiceApprovalController.getInvoiceList(int.parse(month),
      //     int.parse(year), userData['unitId'], userData['ui']);
      await invoiceApprovalController.serviceCertificate(
          widget.invoiceApprovalModel?.invNo, "Service Certificate's Details");
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  CustomText(
          text: "Service Certificate's Details",
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
                            .filteredCertificates.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InvoiceApprovalCard(
                            index: index,
                            roList: invoiceApprovalController
                                .filteredCertificates[index],
                            cardItemDetailsList: cardItemDetailsList,
                            callB1: (index) {
                              Get.to(Scaffold(
                                appBar: AppBar(
                                  title:  CustomText(
                                      text: "View Service Certificate",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start),
                                ),
                                body: PdfViewer(
                                    fileUrl:
                                        '${ApiConstants.ipPort}/HAEMODIALYSIS/Images/${invoiceApprovalController.filteredCertificates[index].serCerFilePath}'),
                              ));
                            },
                            check: (value) {
                              invoiceApprovalController
                                  .filteredCertificates[index]
                                  .isSelected = value;
                              setState(() {});
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

  void filterData(String query) {
    if (query.isEmpty) {
      invoiceApprovalController.filteredCertificates =
          List.from(invoiceApprovalController.serviceCertificateModel ?? []);
    } else {
      invoiceApprovalController.filteredCertificates = invoiceApprovalController
              .serviceCertificateModel
              ?.where((item) =>
                  (item.unitName?.toLowerCase() ?? "")
                      .contains(query.toLowerCase()) ||
                  (item.invoiceNo?.toLowerCase() ?? "")
                      .contains(query.toLowerCase()) ||
                  (item.billMonth?.toLowerCase() ?? "")
                      .contains(query.toLowerCase()) ||
                  (item.year?.toString().toLowerCase() ?? "")
                      .contains(query.toLowerCase()) ||
                  (item.nhmAmount?.toString().toLowerCase() ?? "")
                      .contains(query.toLowerCase()) ||
                  (item.expectedDialysisCyclesTot?.toString().toLowerCase() ??
                          "")
                      .contains(query.toLowerCase()) ||
                  (item.actualNoOfDialysisCyclesConductedTot
                              ?.toString()
                              .toLowerCase() ??
                          "")
                      .contains(query.toLowerCase()) ||
                  (item.differenceTot?.toString().toLowerCase() ?? "")
                      .contains(query.toLowerCase()))
              .toList() ??
          [];
    }
    setState(() {});
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
                      .paddingSymmetric(vertical: 4),
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
              CustomTextField(
                txtController: invoiceApprovalController.searchController,
                labelText: "Search",
                hintText: 'Search',
                isRequired: false,
                keyBoardType: TextInputType.text,
                fillColor: Colors.white,
                isReadOnly: false,
                maxLines: 1,
                fontSize: 15.sp,
                // onChanged: (query) {
                //   filterData(query);
                // },
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
                        // await invoiceApprovalController.serviceCertificate(
                        //     widget.invoiceApprovalModel?.invNo,
                        //     "Service Certificate's Details");

                        filterData(
                            invoiceApprovalController.searchController.text);

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
  final ServiceCertificateModel? roList;
  final List<String> cardItemDetailsList;
  final Function callB1;
  final Function check;
  final int index;

  const InvoiceApprovalCard({
    super.key,
    this.roList,
    required this.cardItemDetailsList,
    required this.callB1,
    required this.index,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffF8F8F8),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 0.5), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          /// 🔹 Left side content (Patient details)
          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(left: 8.w, bottom: 4.h, top: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  patientDetailsCard(
                      cardItemDetailsList[0], roList?.unitName ?? "-"),
                  patientDetailsCard(cardItemDetailsList[1],
                      "${roList?.invoiceNo} ${roList?.year}"),
                  patientDetailsCard(cardItemDetailsList[2],
                      "${roList?.billMonth} ${roList?.year.toString()}"),
                  patientDetailsCard(cardItemDetailsList[3],
                      "${roList?.nhmAmount.toString()}"),
                  patientDetailsCard(cardItemDetailsList[4],
                      "${roList?.expectedDialysisCyclesTot.toString()}}"),
                  patientDetailsCard(cardItemDetailsList[5],
                      "${roList?.actualNoOfDialysisCyclesConductedTot.toString()}"),
                  patientDetailsCard(cardItemDetailsList[6],
                      "${roList?.differenceTot.toString()}"),
                ],
              ),
            ),
          ),

          /// 🔹 Right side (Eye icon container)
          Expanded(
            flex: 0, // Ensures it only takes necessary width
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.darkBlue,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
              ),
              child: Center(
                child: patientCardActions(
                  () {
                    callB1(index);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
          textAlign: TextAlign.start,
        ).paddingSymmetric(vertical: 2),
        Expanded(
          child: CustomText(
            text: details ?? "",
            fontSize: 13.sp,
            fontFam: "Lato",
            fontWeight: FontWeight.normal,
            textColor: Colors.grey,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget patientCardActions(Function callB) {
    return InkWell(
      onTap: () {
        callB();
      },
      child:  const Icon(
        Icons.remove_red_eye_outlined,
        color: Colors.white,
      ).paddingSymmetric(vertical: 8.h,horizontal: 8.w),
    );
  }
}
