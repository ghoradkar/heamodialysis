import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dashboard/technician/institutewise_dashboard_screen.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/edit_post_dialysis_screen.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/post_dialysis_controller.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/pre_dialysis_list/pre_dialysis_screen.dart';
import 'package:heamodialysis/registered_patient_list/model/already_regidtered_patient/patient_data.dart';
import 'package:heamodialysis/registered_patient_list/model/search_patient_dropdown/search_data.dart';
import 'package:heamodialysis/schedular/screens/patient_history_schedular.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/shared_pref_constants.dart';
import 'package:heamodialysis/utils/shared_preference.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../widgets/custom_shimmer_loader.dart';

class PostDialysisScreen extends StatefulWidget {
  const PostDialysisScreen({super.key});

  @override
  State<PostDialysisScreen> createState() => _PostDialysisScreenState();
}

class _PostDialysisScreenState extends State<PostDialysisScreen> {
  final PostDialysisController postDialysisController =
  Get.put(PostDialysisController());


  bool hasInternet = true;

  List<String> cardItemDetailsList = [
    'Patient Id',
    'Patient Name',
    'Patient Age',
    'Mobile Number',
    'Last Dialysis Session Under Scheme',
    'Viral Load Status'

  ];

  SearchedData? dropDownValue;
  SearchedData? dropDownValue2;


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
    postDialysisController.refreshUi();
    if (hasInternet) {
      await postDialysisController.getPostDialysisList(
          'POD', '', int.parse(userData['unitId'].toString()));
      await postDialysisController.searchByDropDownList();

      // await postDialysisController.searchByDropDownList();
      if (postDialysisController.searchByModel?.data != null ||
          postDialysisController.searchByModel!.data!.isNotEmpty) {
        dropDownValue = postDialysisController.searchByModel!.data!.first;
        postDialysisController.refreshUi();
      }
    }
  }

  Future<void> getUserData() async {
    userData = await SharedPref().read(const SharedPrefConstant().kUserData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Post Dialysis Patient List',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
            onTap: () {
              Get.off(const InstituteWiseDashboardScreen());
            },
            child: Image.asset('assets/arrow-left.png')),
        actions: [

          InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(
                              0, 0.5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                                text: "Search",
                                fontSize: 16,
                                fontFam: "Lato",
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                                textAlign: TextAlign.start)
                                .paddingSymmetric(vertical: 4),
                            InkWell(
                                onTap: () {
                                  dropDownValue = null;
                                  postDialysisController.valueController.text = "";
                                  Get.back();
                                },
                                child: Image.asset(
                                  "assets/cancel.png",
                                  width: 24,
                                  height: 24,
                                  color: AppColor.primaryBackgroundColor,
                                )),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                text: "Search By",
                                fontSize: 16,
                                fontFam: "Lato",
                                fontWeight: FontWeight.normal,
                                textColor: Color(0xff515151),
                                textAlign: TextAlign.start)
                                .paddingOnly(top: 10, bottom: 4),
                            Container(
                              // width: 180,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: const Color(0xFFE1E1E1)),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                              child: DropdownButton<SearchedData>(
                                isExpanded: true,
                                value: dropDownValue,
                                hint: const Text("select"),
                                onChanged: (SearchedData? newValue) {
                                  dropDownValue = newValue!;
                                  postDialysisController.update();
                                },
                                items: postDialysisController.searchByModel?.data
                                    ?.map<DropdownMenuItem<SearchedData>>(
                                        (SearchedData value) {
                                      return DropdownMenuItem<SearchedData>(
                                        value: value,
                                        child: Text(value.lookupDetDescEn ?? ""),
                                      );
                                    }).toList(),
                                underline: const SizedBox(),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColor.primaryBackgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                              text: "Value",
                              fontSize: 16,
                              fontFam: "Lato",
                              fontWeight: FontWeight.normal,
                              textColor: Color(0xff515151),
                              textAlign: TextAlign.start),
                        ).paddingOnly(top: 10, bottom: 4),
                        TextField(
                            controller: postDialysisController.valueController,
                            decoration: const InputDecoration(
                              labelText: 'Patient Id, name, mobile no etc.',
                              labelStyle: TextStyle(color: Color(0xFFE1E1E1)),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFFE1E1E1)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFFE1E1E1)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                              ),
                            )),
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
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                    alignment: Alignment.center,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.red,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset("assets/cancel.png"),
                                        const CustomText(
                                            text: "Cancel",
                                            fontSize: 16,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: Colors.white,
                                            textAlign: TextAlign.start),
                                      ],
                                    )),
                              ),
                            ).paddingOnly(top: 20),
                            const SizedBox(
                              width: 14,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  postDialysisController
                                      .getPostDialysisList(
                                      dropDownValue?.lookupDetValue ?? "",
                                      postDialysisController.valueController.text,
                                      int.parse(userData['unitId']));
                                  Get.back();
                                },
                                child: Container(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                    alignment: Alignment.center,
                                    width: 100,
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
                                    child: const Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                        CustomText(
                                            text: "Search",
                                            fontSize: 16,
                                            fontFam: "Lato",
                                            fontWeight: FontWeight.normal,
                                            textColor: Colors.white,
                                            textAlign: TextAlign.start),
                                      ],
                                    )),
                              ),
                            ).paddingOnly(top: 20),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset("assets/filter-line.png"),
            ),
          ),
          const SizedBox(
            width: 2,
          ),
        ],
      ),
      body: GetBuilder<PostDialysisController>(
          init: PostDialysisController(),
          builder: (controller) {
            return hasInternet
                ? controller.isLoading
                ?  Center(child: buildShimmerLoader())
                : PreDialysisCardList(
              patientList:
              controller.postDialysisListModel?.data ?? [],
              cardItemDetailsList: cardItemDetailsList,
              isSecondColumnVisiable: false,
              isfromPredialysis: true,
              path1: "assets/file-list.png",
              path3: "assets/eye.png",
              path5: "assets/edit.png",
              callB1: (index) {
                PatientData patientData = PatientData(
                  patientId: controller
                      .postDialysisListModel!.data![index].patientId,
                  patientName: controller
                      .postDialysisListModel!.data![index].fName,
                  treatmentId: controller
                      .postDialysisListModel!.data![index].treatmentId,
                  age: controller
                      .postDialysisListModel!.data![index].age,
                );
                Get.to(() => PatientHistorySchedular(
                  patientData: patientData,
                ));

              },
              callB5: (index) {
                Get.to(() => EditPostDialysisScreen(
                  postDialysisData: controller
                      .postDialysisListModel!.data![index],
                  callB: () {},
                ));
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
}
