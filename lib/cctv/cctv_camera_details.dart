import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/cctv/cctv_controller.dart';
import 'package:heamodialysis/cctv/favourite_tab.dart';
import 'package:heamodialysis/cctv/live_tab.dart';
import 'package:heamodialysis/cctv/model/institude_wise_cctv.dart';
import 'package:heamodialysis/internet/no_internet_connectivity.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/date_picker.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_shimmer_loader.dart';

class CctvCameraDetails extends StatefulWidget {
  final InstitudeWiseCctv? institudeWiseCctv;
  final String? selectedState;
  final String? selectedDiv;
  final String? selectedDist;
  final String? selectedTaluka;
  final String? selectedInst;

  const CctvCameraDetails(
      {super.key,
      this.institudeWiseCctv,
      this.selectedState,
      this.selectedDiv,
      this.selectedDist,
      this.selectedTaluka,
      this.selectedInst});

  @override
  State<CctvCameraDetails> createState() => _CctvCameraDetailsState();
}

class _CctvCameraDetailsState extends State<CctvCameraDetails>
    with SingleTickerProviderStateMixin {
  final CctvController cctvCameraDetController = Get.find();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      cctvCameraDetController.update();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final now = DateTime.now();
      final formatter = DateFormat('yyyy/MM/dd');
      cctvCameraDetController.formattedFromDate = formatter.format(now);
      cctvCameraDetController.selectedFromDate = null;
      cctvCameraDetController.list.clear();
      setState(() {}); // trigger rebuild with cleared state
    });

    checkInternetAndLoadData();

    super.initState();
  }

  checkInternetAndLoadData() async {
    // Load user data (if needed)
    debugPrint("Checking internet and loading data...");

    // Check the internet connection
    var connectivityResult = await Connectivity().checkConnectivity();
    debugPrint("Connectivity status: $connectivityResult");
    if (connectivityResult == ConnectivityResult.none) {
      debugPrint("No internet connection");
    } else {
      debugPrint("Internet is available");
      cctvCameraDetController.hasInternet = true;
    }

    if (cctvCameraDetController.hasInternet) {
    } else {
      debugPrint("No internet connection."); // Debug print if no internet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(
            text: 'CCTV Camera Details',
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
        body: GetBuilder<CctvController>(
            init: cctvCameraDetController,
            builder: (controller) {
              return controller.hasInternet
                  ? controller.isLoading
                      ?  Center(child: buildShimmerLoader())
                      : Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 6),
                                child: Row(
                                  children: [
                                    const CustomText(
                                        text: "Institute Name : ",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start),
                                    Expanded(
                                      child: CustomText(
                                          text: widget.institudeWiseCctv
                                                  ?.unitName ??
                                              '',
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          textColor: Colors.black,
                                          textAlign: TextAlign.start),
                                    )
                                  ],
                                ),
                              ),
                            ).paddingOnly(
                                top: 6, left: 2, right: 2, bottom: 20),
                            TabBar(
                              controller: tabController,
                              dividerColor: Colors.transparent,
                              indicatorColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              indicatorPadding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.zero,
                              tabs: [
                                buildTab(0, "Live", "assets/live.png"),
                                buildTab(
                                    1, "Favourite", "assets/favourite.png"),
                              ],
                            ),

                            ///commented for now dont remove

                            if (tabController.index == 0)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: cctvCameraDetController
                                              .formattedFromDate ??
                                          '',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      textColor: Colors.black,
                                      textAlign: TextAlign.start),
                                  InkWell(
                                      onTap: () async {
                                        final DateTime? picked =
                                            await DatePickerHelper.selectDate(
                                                context);
                                        debugPrint("picked : $picked");
                                        if (picked != null) {
                                          // Update the selected date
                                          cctvCameraDetController
                                              .selectedFromDate = picked;

                                          // Format the date as "01-OCT-2024"
                                          DateFormat formatter =
                                              DateFormat('yyyy/MM/dd');
                                          cctvCameraDetController
                                                  .formattedFromDate =
                                              formatter.format(
                                                  cctvCameraDetController
                                                      .selectedFromDate!);
                                        }

                                        if (cctvCameraDetController
                                                .selectedFromDate !=
                                            null) {
                                          final selectedDate =
                                              cctvCameraDetController
                                                  .selectedFromDate!;

                                          // 00:00:00 start of selected date
                                          final DateTime startTime = DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day,
                                            0,
                                            0,
                                            0,
                                          );

                                          cctvCameraDetController.list.clear();

                                          for (int i = 0;
                                              i <
                                                  cctvCameraDetController
                                                      .cctvList.length;
                                              i++) {
                                            final playbackUrl =
                                                buildPlaybackUrl(
                                              cameraNumber: getCameraNumber(
                                                      cctvCameraDetController
                                                          .cctvList[i]) ??
                                                  0,
                                              startDateTime: startTime,
                                              duration:
                                                  const Duration(hours: 24),
                                            );
                                            cctvCameraDetController.list
                                                .add(playbackUrl);
                                          }

                                          setState(() {});
                                        }
                                      },
                                      child: Icon(
                                        Icons.calendar_month,
                                        color: AppColor.secondaryColor,
                                        size: 28,
                                      ))
                                ],
                              ).paddingSymmetric(horizontal: 6, vertical: 20),

                            Expanded(
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  LiveTab(
                                      selectedState: widget.selectedState,
                                      selectedDiv: widget.selectedDiv,
                                      selectedDist: widget.selectedDist,
                                      selectedTaluka: widget.selectedTaluka,
                                      selectedInst: widget.selectedInst),
                                  const FavouriteTab(),
                                ],
                              ),
                            )
                          ],
                        ).paddingSymmetric(horizontal: 10)
                  : InternetIssue(
                      onRetryPressed: () {
                        checkInternetAndLoadData();
                      },
                    );
            }));
  }

  int? getCameraNumber(String rtspUrl) {
    final match = RegExp(r'/c(\d+)/').firstMatch(rtspUrl);
    if (match != null) {
      return int.tryParse(match.group(1)!);
    }
    return null;
  }

  String buildPlaybackUrl({
    required int cameraNumber, // 1 to 4
    required DateTime startDateTime,
    required Duration duration, // how long to play
  }) {
    final startTimestamp = startDateTime.millisecondsSinceEpoch ~/ 1000;
    final endTimestamp = startTimestamp + duration.inSeconds;

    return 'rtsp://admin:labadmin%40123@117.212.159.94:554/c$cameraNumber/b$startTimestamp/e$endTimestamp/replay';
    // return 'rtsp://admin:lab%401234@61.0.43.177:554/c$cameraNumber/b$startTimestamp/e$endTimestamp/replay';
  }

  Widget buildTab(int index, String text, String path) {
    bool isSelected = tabController.index == index;
    return Container(
      width: 210,
      // height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 0.8, vertical: 6),
      decoration: BoxDecoration(
          // color: isSelected ? Colors.blue.shade200 : Colors.transparent,
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColor.primaryBackgroundColor,
                    AppColor.secondaryColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                ),
          borderRadius: setBorderRadiusIndexWise(index),
          border: Border.all(color: const Color(0xffE1E1E1))),
      // padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            path,
            color: isSelected ? Colors.white : Colors.grey,
          ),
          const SizedBox(
            width: 4,
          ),
          CustomText(
            text: text,
            fontSize: 12.0,
            fontFam: 'Lato',
            fontWeight: FontWeight.normal,
            textColor: isSelected ? Colors.white : const Color(0xff777777),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  setBorderRadiusIndexWise(index) {
    if (index == 0) {
      return const BorderRadius.only(
          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));
    } else if (index == 1) {
      // return BorderRadius.zero;
      return const BorderRadius.only(
          topRight: Radius.circular(10), bottomRight: Radius.circular(10));
    }
  }
}
