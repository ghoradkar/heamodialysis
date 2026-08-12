import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/patient_health_trends/screen/patient_hemoglobin_tracking/patient_hemoglobin_list_screen.dart';
import 'package:heamodialysis/patient_health_trends/screen/dialysis_investigation_report/patient_dialysis_invest_screen.dart';
import 'package:heamodialysis/patient_health_trends/screen/dialysis_vital_chart/patient_dialysis_vital_screen.dart';

import '../../utils/color_constants.dart';
import '../../widgets/custom_shimmer_loader.dart';
import '../../widgets/custom_text.dart';

class PatientHealthTrendsScreen extends StatefulWidget {
  const PatientHealthTrendsScreen({super.key});

  @override
  State<PatientHealthTrendsScreen> createState() =>
      _PatientHealthTrendsScreenState();
}

class _PatientHealthTrendsScreenState extends State<PatientHealthTrendsScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  final List<Map<String, dynamic>> menuItems = [
    {
      "icon": "assets/Dialysis.png",
      "label": "Dialysis Vital Chart",
      "color": Color(0xffD4F1F4),
      "page": () => const PatientDialysisVitalScreen(),
    },
    {
      "icon": "assets/DialysisInvestigationResultChart.png",
      "label": "Dialysis Investigation Result Chart",
      "color": Color(0xffFFE3E3),
      "page": () => const PatientDialysisInvestScreen(),
    },
    {
      "icon": "assets/Hemoglobin.png",
      "label": "Hemoglobin Tracking Report",
      "color": Color(0xffFFF4CC),
      "page": () => const PatientHemoglobinScreen(),
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
        ),
        title: const CustomText(
          text: 'Patient Health Trends',
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.white,
          textAlign: TextAlign.start,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Image.asset('assets/arrow-left.png', color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.85,
              ),

              itemBuilder: (context, index) {
                final item = menuItems[index];

                if (isLoading) {
                  return PatientHealthTrendsShimmer();
                }

                return InkWell(
                  onTap: () => Get.to(item["page"]()),
                  child: Container(
                    decoration: BoxDecoration(
                      color: item["color"],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(10),

                    child:Column(
                    mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Image.asset(
                            item["icon"],
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: CustomText(
                            text: item["label"],
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                ),
                );
              },
            );
          },
        ),
      ),

    );
  }
}
