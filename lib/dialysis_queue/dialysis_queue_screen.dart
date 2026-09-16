import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/screen/post_dialysis_screen.dart';
import 'package:heamodialysis/dialysis_queue/pre_dialysis/pre_dialysis_list/screen/pre_dialysis_screen.dart';
import '../utils/color_constants.dart';
import '../widgets/custom_shimmer_loader.dart';
import '../widgets/custom_text.dart';
import 'consumable_entry/consumable.dart';
import 'dialysis_event/screen/dialysis_event_list.dart';
import 'hd_chart/screen/hd_chart_list.dart';
import 'investigation/screen/investigation_queue.dart';

class DialysisQueueScreen extends StatefulWidget {
  const DialysisQueueScreen({super.key});

  @override
  State<DialysisQueueScreen> createState() => _DialysisQueueScreenState();
}

class _DialysisQueueScreenState extends State<DialysisQueueScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        }
        );
      }
    }
    );
  }

  List<Map<String, dynamic>> _options(BuildContext context) => [
        {"title": context.l10n.dqPreDialysis, "icon": "assets/preDialysis.png", "color": const Color(0xFFDDF5FF)},
        {"title": context.l10n.dqPostDialysis, "icon": "assets/postDialysis.png", "color": const Color(0xFFFFE7E7)},
        {"title": context.l10n.dqDialysisEvent, "icon": "assets/dialysisEvent.png", "color": const Color(0xFFFFF9D7)},
        {"title": context.l10n.dqInvestigation, "icon": "assets/Investigation.png", "color": const Color(0xFFedfff5)},
        {"title": context.l10n.dqConsumableEntry, "icon": "assets/Consumable.png", "color": const Color(0xFFE3EDFF)},
        {"title": context.l10n.dqHdChart, "icon": "assets/HD Chart.png", "color": const Color(0xFFF8EFFA)},
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
          ),
        ),
        title: CustomText(
          text: context.l10n.drawerDialysisQueue,
          fontSize: 18.0,
          fontFam: 'Lato',
          fontWeight: FontWeight.w400,
          textColor: Colors.white, textAlign:TextAlign.start,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Image.asset(
            'assets/arrow-left.png',
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          decoration: BoxDecoration(
         //   border: Border.all(color: Colors.blueAccent, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(14),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: isLoading ? 6 : _options(context).length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, index) {
              if (isLoading) {
                return DialysisShimmer();
              }
              return buildOptionCard(_options(context)[index], index);
            },
          ),
        ),
      ),
    );
  }

  Widget buildOptionCard(Map<String, dynamic> data, int index) {
    return InkWell(
      onTap: () {
        /// 🔥 Same navigation logic as Drawer
        if (index == 0) {
          Get.to(() => const PreDialysisScreen());
        } else if (index == 1) {
          Get.to(() => const PostDialysisScreen());
        } else if (index == 2) {
          Get.to(() => const DialysisEventList());
        } else if (index == 3) {
          Get.to(() => const InvestigationQueue());
        } else if (index == 4) {
          Get.to(() => const ConsumableScreen());
        } else if (index == 5) {
          Get.to(() => const HdChartList());
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: data["color"],
          borderRadius: BorderRadius.circular(14),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.shade50,
          //     spreadRadius: 0,
          //     blurRadius: 0,
          //     offset: const Offset(3, 3), // shadow direction
          //   ),
          // ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              data["icon"],
              width: 42,
              height: 42,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                data["title"],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
