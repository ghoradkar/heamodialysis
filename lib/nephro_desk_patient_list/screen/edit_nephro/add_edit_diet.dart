import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/model/nephro_list.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/diet_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/temp_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/custom_webview.dart';
import 'package:intl/intl.dart';

import '../../../widgets/custom_shimmer_loader.dart';


class AddEditDiet extends StatefulWidget {
  final NephroList? proLiItem;
  final GetListOfOpdDietDto? dietDetails;
  final bool? isEdit;
  final dynamic userData;

  const AddEditDiet(
      {super.key,
      this.proLiItem,
      this.isEdit,
      this.userData,
      this.dietDetails});

  @override
  State<AddEditDiet> createState() => _AddEditDietState();
}

class _AddEditDietState extends State<AddEditDiet> {
  final NephroController nephroController = Get.put(NephroController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool hasInternet = true;

  var userData;

  Pattemplist? selectedempObj;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    checkInternetAndLoadData();
    super.initState();
  }

  getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    nephroController.update();
    if (hasInternet) {
      await nephroController.getTempList();
      if (widget.isEdit == true) {
        selectedempObj = nephroController.tempList
            ?.firstWhere((e) => e.tempname == widget.dietDetails?.templateName);
        nephroController.selectedTemp = selectedempObj?.tempname;

        if (widget.dietDetails?.fromDate != null &&
            widget.dietDetails?.toDate != null) {
          DateTime from = DateTime.parse(widget.dietDetails!.fromDate!);
          DateTime to = DateTime.parse(widget.dietDetails!.toDate!);

          int differenceInDays = to.difference(from).inDays;

          debugPrint("Number of days: $differenceInDays");
          nephroController.days = differenceInDays.toString();

          // Also set the dates in the controller for edit mode
          nephroController.fromDateDiet = widget.dietDetails!.fromDate;
          nephroController.toDateDiet = widget.dietDetails!.toDate;
        }
      }
    }
    // setState(() {});
    nephroController.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.isEdit == true
              ? context.l10n.nephroEditDiet
              : context.l10n.nephroAddDiet,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              nephroController.selectedTemp = null;
              selectedempObj = null;
              Get.back();
            },
            child: Image.asset('assets/arrow-left.png')),
      ),
      body: GetBuilder<NephroController>(
        init: nephroController,
        builder: (controller) {
          return hasInternet
              ? controller.isLoading
                  ? Center(child: buildShimmerLoader())
                  : Form(
                      key: formKey,
                      child: Column(
                        // Change from SingleChildScrollView to Column
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.borderColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Column(
                              children: [
                                MyCustomDropdown(
                                  labelText: context.l10n.nephroTemplate,
                                  items: controller.tempList
                                          ?.map((e) => e.tempname)
                                          .toList() ??
                                      [],
                                  hint: context.l10n.regHintSelect,
                                  isRequired: true,
                                  senValue: (value) {
                                    selectedempObj = controller.tempList
                                        ?.firstWhere(
                                            (e) => e.tempname == value);
                                    nephroController.selectedTemp = value;
                                    controller.update();
                                  },
                                  filledColor: Colors.white,
                                  selectedItem: nephroController.selectedTemp,
                                ),
                                MyCustomDropdown(
                                  selectedItem: nephroController.days,
                                  labelText: context.l10n.commonDays,
                                  items: const [
                                    '15',
                                    '30',
                                    '45',
                                    '60',
                                    '75',
                                    '90'
                                  ],
                                  hint: context.l10n.regHintSelect,
                                  isRequired: true,
                                  senValue: (value) {
                                    nephroController.days = value;
                                    // Get current date
                                    DateTime fromDate = DateTime.now();

                                    // Calculate toDate by adding the selected days
                                    int daysToAdd =
                                        int.tryParse(value ?? '0') ?? 0;
                                    DateTime toDate =
                                        fromDate.add(Duration(days: daysToAdd));

                                    // Format the dates
                                    String formattedFromDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(fromDate);
                                    String formattedToDate =
                                        DateFormat('yyyy-MM-dd').format(toDate);

                                    // Store the dates in the controller
                                    nephroController.fromDateDiet =
                                        formattedFromDate;
                                    nephroController.toDateDiet =
                                        formattedToDate;

                                    controller.update();
                                  },
                                  filledColor: Colors.white,
                                ),
                              ],
                            ),
                          ).paddingSymmetric(vertical: 10, horizontal: 10),

                          // THIS PART TAKES ALL REMAINING SPACE
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                // color:Colors.grey,
                                border: Border.all(color: AppColor.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: CustomWebview(
                                  htmlText: selectedempObj?.tempdata ?? '',
                                ),
                              ),
                            ).paddingSymmetric(vertical: 10, horizontal: 10),
                          ),

                          CustomButton(
                            isLoading: controller.isLoading,
                            buttonText: context.l10n.commonSave,
                            path: 'assets/save-ro-disinfec.png',
                            callB: controller.isLoading
                                ? null
                                : () async {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      var body = {
                                        "dietMasterId": widget.isEdit == true
                                            ? widget.dietDetails
                                                    ?.dietMasterId ??
                                                0
                                            : 0,
                                        "templateId": selectedempObj?.idpattemp,
                                        "specializationId": 0,
                                        "templateName":
                                            selectedempObj?.tempname,
                                        "templateData":
                                            selectedempObj?.tempdata,
                                        "fromDate":
                                            nephroController.fromDateDiet,
                                        "toDate": nephroController.toDateDiet,
                                        "createdDateTime": null,
                                        "updatedDateTime": null,
                                        "deletedBy": null,
                                        "deleted": "N",
                                        "createdBy": selectedempObj?.createdBy,
                                        "updatedBy": selectedempObj?.createdBy,
                                        "deletedDateTime": null,
                                        "unitId": userData['unitId'].toString(),
                                        "userId": userData['user_ID'],
                                        "listOfOPDDietDTO": null,
                                        "patientId":
                                            widget.proLiItem?.patientId,
                                        "treatmentId":
                                            widget.proLiItem?.treatmentId
                                      };

                                      debugPrint("==== ADD/EDIT DIET UI ====");
                                      debugPrint(
                                          "Is Edit Mode: ${widget.isEdit}");
                                      debugPrint(
                                          "Diet Details: ${widget.dietDetails?.toJson()}");
                                      debugPrint(
                                          "dietMasterId from widget: ${widget.dietDetails?.dietMasterId}");
                                      debugPrint(
                                          "dietMasterId in body: ${body['dietMasterId']}");
                                      debugPrint(
                                          "fromDate: ${body['fromDate']}");
                                      debugPrint("toDate: ${body['toDate']}");
                                      debugPrint("===========================");

                                      await controller.saveTemplate(
                                          body, widget.proLiItem?.treatmentId);
                                      nephroController.selectedTemp = null;
                                      selectedempObj = null;
                                      nephroController.days = null;
                                    }
                                  },
                            buttonWidth: 100,
                            primColor: AppColor.primaryBackgroundColor,
                            secColor: AppColor.secondaryColor,
                            textColor: Colors.white,
                            iconColor: Colors.white,
                          ).paddingOnly(top: 20, bottom: 20),
                        ],
                      ),
                    )
              : InternetIssue(
                  onRetryPressed: () {
                    checkInternetAndLoadData();
                  },
                );
        },
      ),
    );
  }

  dateConversion(inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}
