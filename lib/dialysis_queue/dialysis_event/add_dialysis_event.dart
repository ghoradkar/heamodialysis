import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/dialysis_event_controller.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/add_edit_dialysis_event_req.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_list_model.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/patient_event_details.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/new_registration/model/institute/institute_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/model/get_machine_list/machine_data.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/model/problem_resolve/problem_data.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_shimmer_loader.dart';

class AddDialysisEvent extends StatefulWidget {
  // final RoIssueLogData? proLiItem;
  final bool isFrom;
  final PatientEventDetails? dialysisEventDet;
  final DialysisEventListModel? patientDet;

  const AddDialysisEvent(
      {super.key,
      required this.isFrom,
      this.dialysisEventDet,
      this.patientDet});

  @override
  State<AddDialysisEvent> createState() => AddDialysisEventState();
}

class AddDialysisEventState extends State<AddDialysisEvent> {
  final DialysisEventController dialysisEventController =
      Get.put(DialysisEventController());

  String formattedDate1 = '';
  String formattedDate2 = '';

  bool hasInternet = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var userData;

  InstituteDataModel? ins;

  MachineData? mac;

  ProblemData? prob;

  @override
  void initState() {
    // TODO: implement initState
    checkInternetAndLoadData();

    getUserData();
    super.initState();
  }

  getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
    userData;

    addCard();
  }

  checkInternetAndLoadData() async {
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    // setState(() {
    hasInternet = (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
    // });
    dialysisEventController.update();

    if (hasInternet) {
      if (widget.isFrom == false) {
        await dialysisEventController.getIncidentSubType(
            widget.dialysisEventDet?.lookupDetIdIncidentType);
      }
    }

    dialysisEventController.update();
  }

  String convertDateFormat(String? dateStr) {
    // Parse the date string in 'dd-MM-yyyy' format
    if (dateStr != null && dateStr.isNotEmpty) {
      DateTime dateTime = DateFormat('dd-MM-yyyy').parse(dateStr);
      // Format it to 'yyyy-MM-dd' format
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } else {
      return "";
    }
  }

  String convertToTime(String isoDateTime) {
    // Parse the ISO string to DateTime
    DateTime dateTime = DateTime.parse(isoDateTime);

    // Format to 'HH:mm:ss' for time
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  void addCard() {
    // Create a fresh cardData for the new card
    AddEditDialysisEventReq newCard = AddEditDialysisEventReq(
      incidentT:
          widget.isFrom == false ? widget.dialysisEventDet?.lookupDetEng : null,
      incidentSubT: widget.isFrom == false
          ? widget.dialysisEventDet?.incidentSubTypeName
          : null,
      dialysisEventDetID: widget.isFrom == false
          ? widget.dialysisEventDet?.dialysisEventDetID
          : 0,
      unitId: userData['unitId'],
      patientId: widget.patientDet?.patientId,
      treatmentId: widget.patientDet?.treatmentId,
      eventDateTime: widget.isFrom == false
          ? convertToTime(widget.dialysisEventDet!.date!)
          : null,
      lookupDetIdIncidentSubType: widget.isFrom == false
          ? widget.dialysisEventDet?.lookupDetIdIncidentSubType
          : null,
      // Ensure reset for new card
      lookupDetIdIncidentType: widget.isFrom == false
          ? widget.dialysisEventDet?.lookupDetIdIncidentType
          : null,

      // Ensure reset for new card
      eventAction:
          widget.isFrom == false ? widget.dialysisEventDet?.eventAction : null,
      eventDescription: widget.isFrom == false
          ? widget.dialysisEventDet?.eventDescription
          : null,
      createdBy: userData['ui'],
      actionTaken:
          widget.isFrom == false ? widget.dialysisEventDet?.actionTaken : null,
      date: convertDateFormat(formatDate(widget.dialysisEventDet?.date)),
    );

    // Add the new card to the list
    dialysisEventController.cardList.add(newCard);

    // Trigger UI update
    setState(() {});
  }

  void removeCard(int index) {
    if (dialysisEventController.cardList.length > 1) {
      dialysisEventController.cardList.removeAt(index);
      setState(() {});
    }
  }

  String formatDate(String? dateTimeStr) {
    if (dateTimeStr != null) {
      DateTime dateTime = DateTime.parse(dateTimeStr);
      // Format the date as "dd-MM-yyyy"
      return DateFormat("dd-MM-yyyy").format(dateTime);
    } else {
      return "";
    }
  }

  String formatTime(String? dateTimeStr) {
    if (dateTimeStr != null) {
      DateTime dateTime = DateTime.parse(dateTimeStr);
      // Format the time as "hh:mm:ss"
      return DateFormat("HH:mm:ss").format(dateTime);
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.isFrom ? "Add Dialysis Event" : "Edit Dialysis Event",
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
      body: GetBuilder<DialysisEventController>(
          init: dialysisEventController,
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                    ?  Center(child: buildShimmerLoader())
                    : SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              ...dialysisEventController.cardList
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int index = entry.key;
                                AddEditDialysisEventReq? cardData = entry.value;

                                final String? selectedIncidentT =
                                    dialysisEventController.incidentList.any(
                                            (incident) =>
                                                incident.lookupDetId ==
                                                cardData
                                                    .lookupDetIdIncidentType)
                                        ? cardData.incidentT
                                        : null;

                                final String? selectedSubIncidentT =
                                    dialysisEventController.incidentSubTypeList
                                            .any((incident) =>
                                                incident.lookupDetId ==
                                                cardData
                                                    .lookupDetIdIncidentSubType)
                                        ? cardData.incidentSubT
                                        : null;

                                return AddEditDialysisEventCard(
                                  cardData: cardData,
                                  selectedIncidentT: selectedIncidentT,
                                  selectedSubIncidentT: selectedSubIncidentT,
                                  time: widget.isFrom
                                      ? cardData.time
                                      : cardData.eventDateTime,
                                  date: cardData.date,
                                  selectTime: () {
                                    selectTime(cardData);
                                  },
                                  dateCallBack: () {
                                    pickInspectionDate(cardData);
                                  },
                                  eventDisCallBack: (value) {
                                    cardData.eventDescription = value;
                                  },
                                  actionTCallBack: (value) {
                                    cardData.actionTaken = value;
                                    cardData.eventAction = value;
                                  },
                                  incidentList: controller.incidentList
                                      .map((e) => e.lookupDetValue!)
                                      .toList(),
                                  incidentSubList: controller
                                      .incidentSubTypeList
                                      .map((e) => e.lookupDetValue!)
                                      .toList(),
                                  incidentCallBack: (value) async {
                                    dialysisEventController.selectedIncident =
                                        controller.incidentList.firstWhere(
                                            (e) => e.lookupDetValue == value);
                                    cardData.incidentT = dialysisEventController
                                        .selectedIncident?.lookupDetValue;
                                    cardData.lookupDetIdIncidentType =
                                        dialysisEventController
                                            .selectedIncident?.lookupDetId;
                                    cardData.createdBy = 1;
                                    cardData.dialysisEventDetID = 0;

                                    await controller.getIncidentSubType(
                                        dialysisEventController
                                            .selectedIncident?.lookupDetId);

                                    controller.update();
                                  },
                                  incidentSubCallBack: (value) {
                                    dialysisEventController
                                            .selectedIncidentSub =
                                        controller.incidentSubTypeList
                                            .firstWhere((e) =>
                                                e.lookupDetValue == value);
                                    cardData.createdBy = 1;
                                    cardData.dialysisEventDetID = 0;
                                    cardData.incidentSubT =
                                        dialysisEventController
                                            .selectedIncidentSub
                                            ?.lookupDetValue;
                                    cardData.lookupDetIdIncidentSubType =
                                        dialysisEventController
                                            .selectedIncidentSub?.lookupDetId;

                                    controller.update();
                                  },
                                  addCard: () {
                                    addCard();
                                  },
                                  removeCard: () {
                                    removeCard(index);
                                  },
                                );
                              }),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButton(
                                    isLoading: controller.isLoading,
                                    buttonText: 'Save',
                                    path: 'assets/save-ro-disinfec.png',
                                    callB: () async {
                                      if (formKey.currentState?.validate() ??
                                          false) {
                                        await controller.saveDialysisEvent(
                                            userData['ui'],
                                            userData['unitId']);
                                      }
                                    },
                                    buttonWidth: 100.w,
                                    primColor: AppColor.primaryBackgroundColor,
                                    secColor: AppColor.secondaryColor,
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                  ),
                                  CustomButton(
                                    buttonText: 'Reset',
                                    path: 'assets/refresh.png',
                                    callB: () {},
                                    buttonWidth: 100.w,
                                    primColor: Colors.grey,
                                    secColor: Colors.grey,
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                  ),
                                  CustomButton(
                                    buttonText: 'Cancel',
                                    path: 'assets/cancel.png',
                                    callB: () {
                                      Get.back();
                                    },
                                    buttonWidth: 100.w,
                                    primColor: AppColor.red,
                                    secColor: AppColor.red,
                                    textColor: Colors.white,
                                    iconColor: Colors.white,
                                  ),
                                ],
                              ).paddingOnly(top: 20.h, bottom: 20.h)
                            ],
                          ),
                        ),
                      )
                : InternetIssue(
                    onRetryPressed: () {
                      checkInternetAndLoadData();
                    },
                  );
          }),
    );
  }

  Future<void> pickInspectionDate(AddEditDialysisEventReq? cardData) async {
    final DateTime? picked = await DatePickerHelper.selectDate(context);
    if (picked != null) {
      // setState(() {

      DateFormat formatter = DateFormat('yyyy-MM-dd');
      // DateFormat formatter = DateFormat('dd-MM-yyyy');
      formattedDate1 = formatter.format(picked);
      // dialysisEventController.issueDateController.text = formattedDate1;
      cardData?.date = formattedDate1;
      // cardData?.eventDateTime = formattedDate1;
      // });
      setState(() {});
    }
  }

  selectTime(AddEditDialysisEventReq cardData) async {
    var pickedTime = await DatePickerHelper.selectTime(context);
    // dialysisEventController.time.text = pickedTime!;
    cardData.time = pickedTime!;
    cardData.eventDateTime = pickedTime;

    setState(() {});
  }
}

class AddEditDialysisEventCard extends StatelessWidget {
  final Function selectTime;
  final Function dateCallBack;
  final Function addCard;
  final String? selectedIncidentT;
  final String? selectedSubIncidentT;
  final String? time;
  final String? date;
  final Function removeCard;
  final Function(String)? incidentCallBack;
  final Function(String)? incidentSubCallBack;
  final Function(String)? eventDisCallBack;
  final Function(String)? actionTCallBack;
  final List<String>? incidentList;
  final List<String>? incidentSubList;
  final AddEditDialysisEventReq? cardData;

  const AddEditDialysisEventCard({
    super.key,
    required this.selectTime,
    this.incidentList,
    required this.incidentCallBack,
    this.incidentSubList,
    required this.incidentSubCallBack,
    required this.addCard,
    required this.removeCard,
    this.cardData,
    required this.dateCallBack,
    this.selectedIncidentT,
    this.selectedSubIncidentT,
    this.time,
    this.date,
    this.eventDisCallBack,
    this.actionTCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CustomDateField(
            key: UniqueKey(),
            labelText: 'Pre Dialysis Date',
            hint: 'Select Date',
            isRequired: false,
            callB: () {
              dateCallBack();
            },
            initialValue: date,
            // selectedDate: issueDateController,
            filledColor: Colors.white,
            dontDhowPrefix: false,
          ),
          CustomDateField(
            key: UniqueKey(),
            labelText: 'Time',
            hint: 'Select',
            isRequired: true,
            callB: selectTime,
            initialValue: time,
            filledColor: Colors.white,
            dontDhowPrefix: false,
          ),
          MyCustomDropdown(
            key: UniqueKey(),
            selectedItem: selectedIncidentT,
            labelText: 'Dialysis Incident Type',
            items: incidentList!,
            hint: 'Select',
            isRequired: true,
            senValue: (value) {
              if (incidentCallBack != null) {
                incidentCallBack!(value);
              }
            },
            filledColor: Colors.white,
          ),
          MyCustomDropdown(
            key: UniqueKey(),
            selectedItem: selectedSubIncidentT,
            labelText: 'Dialysis Incident sub Type',
            items: incidentSubList!,
            hint: 'Select',
            isRequired: false,
            senValue: (value) {
              if (incidentSubCallBack != null) {
                incidentSubCallBack!(value);
              }
            },
            filledColor: Colors.white,
          ),
          CustomTextField(
            key: UniqueKey(),
            labelText: 'Event Description',
            hintText: 'Enter',
            isRequired: false,
            keyBoardType: TextInputType.text,
            initialValue: cardData?.eventDescription,
            fillColor: Colors.white,
            isReadOnly: false,
            maxLines: 1,
            onChanged: (value) {
              if (eventDisCallBack != null) {
                eventDisCallBack!(value);
              }
            },
            fontSize: 16.sp,
          ),
          CustomTextField(
            key: UniqueKey(),
            labelText: 'Action Taken',
            hintText: 'Enter',
            isRequired: false,
            keyBoardType: TextInputType.text,
            initialValue: cardData?.actionTaken,
            fillColor: Colors.white,
            isReadOnly: false,
            maxLines: 1,
            onChanged: (value) {
              if (actionTCallBack != null) {
                actionTCallBack!(value);
              }
            },
            fontSize: 16.sp,
          ),
           SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  addCard();
                },
                icon: const Icon(Icons.add_circle_outline),
                color: Colors.green,
              ),
              IconButton(
                onPressed: () {
                  removeCard();
                },
                icon: const Icon(Icons.remove_circle_outline),
                color: AppColor.red,
              )
            ],
          )
        ],
      ),
    ).paddingSymmetric(horizontal: 8.w, vertical: 4.h);
  }
}
