import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/ro_maintenance/ro_desinfect_details/screens/ro_disinfection_details.dart';
import 'package:heamodialysis/ro_maintenance/ro_log_sheet/screens/ro_log_sheet_list.dart';
import 'package:heamodialysis/ro_maintenance/ro_machine_issue_log/screens/ro_machine_issue_log.dart';

import '../utils/color_constants.dart';
import '../widgets/custom_text.dart';
import 'daily_ro_log_sheet/screens/daily_ro_logsheet_list.dart';

class RoMaintenanceScreen extends StatelessWidget {
  const RoMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": "assets/rodisinfection.png",
        "label": "RO Disinfection\nDetails",
        "color": const Color(0xffD4F1F4),
        "page": const RoDisinfectionDetails(),
      },
      {
        "icon": "assets/romachineissuelogs.png",
        "label": "RO Machine\nIssue Logs",
        "color": const Color(0xffFFE3E3),
        "page": const RoMachineIssueLogs(),
      },
      {
        "icon": "assets/ROMachineLogSheet.png",
        "label": "RO Machine\nLog Sheet",
        "color": const Color(0xffFFF4CC),
        "page": const RoLogSheetList(),
      },
      {
        "icon": "assets/DailyROLogSheet.png",
        "label": "Daily RO\nLog Sheet",
        "color": const Color(0xffE3FCEC),
        "page": const DailyRoLogSheetScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
        ),
        title: const CustomText(
          text: 'RO Maintenance',
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
            int crossAxis = constraints.maxWidth < 350 ? 2 : 3;
            return GridView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: menuItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxis,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return InkWell(
                  onTap: () => Get.to(item["page"]),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: item["color"],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 5,
                          child: Image.asset(
                            item["icon"],
                            fit: BoxFit.contain,
                            height: constraints.maxWidth < 350 ? 60 : 70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          flex: 3,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CustomText(
                              text: item["label"],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black,
                              textAlign: TextAlign.center,
                            ),
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