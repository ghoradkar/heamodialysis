import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/investigation/model/test_details_model.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/machine_status/controller/machine_status_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class AddMachineCounter extends StatefulWidget {
  final List<TestDetailsModel>? testList;

  const AddMachineCounter({super.key, this.testList});

  @override
  State<AddMachineCounter> createState() => _AddMachineCounterState();
}

class _AddMachineCounterState extends State<AddMachineCounter> {
  final MachineStatusController machineController = Get.find();
  bool hasInternet = true;

  var userData;

  String? today;

  @override
  void initState() {
    getUserData();
    checkInternetAndLoadData();
    today = DateFormat('dd-MM-yyyy').format(DateTime.now());

    super.initState();
  }

  String formatDisplayDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(dateStr);
      return DateFormat("dd-MM-yyyy").format(parsedDate);
    } catch (e) {
      try {
        DateTime parsedDate = DateTime.parse(dateStr);
        return DateFormat("dd-MM-yyyy").format(parsedDate);
      } catch (e2) {
        return dateStr;
      }
    }
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));

    machineController.update();
    if (hasInternet) {}
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return hasInternet ?  Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Add Machine Counter",
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
      body: machineController.isLoading
          ?  Center(child: AddMachineCounterShimmer())
              : GetBuilder<MachineStatusController>(
                  init: machineController,
                  builder: (controller) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: machineController
                                  .addMachineCounterListModel?.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 20),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[50],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColor.borderColor)),
                                          padding: const EdgeInsets.only(
                                              top: 16,
                                              bottom: 16,
                                              left: 10,
                                              right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                children: [
                                                  const CustomText(
                                                      text: "Machine Name:",
                                                      fontSize: 14,
                                                      fontFam: "Lato",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textColor: Colors.black,
                                                      textAlign:
                                                          TextAlign.start),
                                                  CustomText(
                                                      // text: cardData.dialyserBarcodeSerialNo ?? '',
                                                      text: machineController
                                                              .addMachineCounterListModel?[
                                                                  index]
                                                              .machineName ??
                                                          '',
                                                      fontSize: 14,
                                                      fontFam: "Lato",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textColor: Colors.black,
                                                      textAlign:
                                                          TextAlign.start),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const CustomText(
                                                      text:
                                                          "Machine Serial No:",
                                                      fontSize: 14,
                                                      fontFam: "Lato",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textColor: Colors.black,
                                                      textAlign:
                                                          TextAlign.start),
                                                  CustomText(
                                                      // text: formatDateFromTimestamp(cardData.dialysisStartDate) ?? "",
                                                      text: machineController
                                                              .addMachineCounterListModel?[
                                                                  index]
                                                              .machineSerialNo ??
                                                          "",
                                                      fontSize: 14,
                                                      fontFam: "Lato",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      textColor: Colors.black,
                                                      textAlign:
                                                          TextAlign.start),
                                                ],
                                              ),
                                              // CustomTextField(
                                              //     // txtController:
                                              //     //     machineController
                                              //     //         .currentReading,
                                              //   initialValue: machineController
                                              //       .addMachineCounterListModel?[
                                              //   index]
                                              //       .todayReading,
                                              //     labelText:
                                              //         "Current Reading (Hours) $today",
                                              //     hintText:
                                              //         "Current Reading (Hours)",
                                              //     isRequired: false,
                                              //     keyBoardType:
                                              //         TextInputType.number,
                                              //     fillColor: Colors.white,
                                              //     isReadOnly: false,
                                              //     maxLines: 1,
                                              //     fontSize: 16),
                                              CustomTextField(
                                                // remove initialValue when using a controller
                                                txtController: machineController
                                                    .currentReadingCtrls[index],
                                                labelText:
                                                    "Current Reading (Hours) $today",
                                                hintText:
                                                    "Current Reading (Hours)",
                                                isRequired: false,
                                                keyBoardType:
                                                    TextInputType.number,
                                                fillColor: Colors.white,
                                                isReadOnly: false,
                                                maxLines: 1,
                                                fontSize: 16,
                                                onChanged: (val) {
                                                  machineController
                                                      .setTodayReading(
                                                          index, val);
                                                },
                                              ),

                                              CustomTextField(
                                                  initialValue: machineController
                                                          .addMachineCounterListModel?[
                                                              index]
                                                          .machineLastReading ??
                                                      '',
                                                  labelText:
                                                      "Last Reading (Hours) ${formatDisplayDate(machineController.machineCountList?[index].createdDate)}",
                                                  hintText:
                                                      "Last Reading (Hours)",
                                                  isRequired: false,
                                                  keyBoardType:
                                                      TextInputType.number,
                                                  fillColor: Colors.white,
                                                  isReadOnly: true,
                                                  maxLines: 1,
                                                  fontSize: 16),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor.primaryBackgroundColor,
                                              AppColor.secondaryColor
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }).paddingSymmetric(vertical: 0, horizontal: 14),
                        ),
                        CustomButton(
                          primColor: AppColor.primaryBackgroundColor,
                          secColor: AppColor.secondaryColor,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                          buttonText: 'Save',
                          path: 'assets/save-next.png',
                          callB: () async {
                            await machineController.addMachineCounter(
                                machineController.addMachineCounterListModel,
                                userData['unitId'].toString(),
                                userData['user_ID'].toString());
                          },
                          buttonWidth: 120,
                        ).paddingOnly(top: 16, bottom: 16)
                      ],
                    );
                  })

    ) : InternetIssue(
      onRetryPressed: () {
        checkInternetAndLoadData();
      },
    );
  }
}
