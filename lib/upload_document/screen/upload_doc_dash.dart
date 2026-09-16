import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/upload_document/screen/feedback/feedback_upload_document_screen.dart';
import 'package:heamodialysis/upload_document/screen/feedback_form/feedback_form_screen.dart';
import 'package:heamodialysis/upload_document/screen/hd_chart/he_chart_upload_document_screen.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_shimmer_loader.dart';
import 'package:heamodialysis/widgets/custom_text.dart';


class UploadDocDashScreen extends StatefulWidget {
  const UploadDocDashScreen({super.key});

  @override
  State<UploadDocDashScreen> createState() => _UploadDocDashScreenState();
}

class _UploadDocDashScreenState extends State<UploadDocDashScreen> {
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
        {"title": context.l10n.uploadHdChart, "icon": "assets/HD Chart.png", "color": const Color(0xFFFFE7E7)},
        {"title": "Old FeedBack Form", "icon": "assets/feedback.png", "color": const Color(0xFFDDF5FF)},
        {"title": "Feedback Form", "icon": "assets/feedback.png", "color": const Color(0xFFDDF5FF)},
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
          text: context.l10n.uploadDocuments,
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
              childAspectRatio: 0.83,
            ),
            itemBuilder: (context, index) {
              if (isLoading) {
                return DialysisShimmer();
              }
              return buildOptionCard(_options(context)[index],index);
            },
          ),
        ),
      ),
    );
  }

  Widget buildOptionCard(Map<String, dynamic> data, int index) {
    return InkWell(
      onTap: () {

        if (index == 0) {
          Get.to(() => const HdChartUploadDocScreen());
        } else if (index == 1) {
          Get.to(() => const FeedbackUploadDocScreen());
        } else if (index == 2) {
          Get.to(() => const FeedbackFormScreen());
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: data["color"],
          borderRadius: BorderRadius.circular(14),

        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              data["icon"],
              width: 45,
              height: 45,
            ),
            SizedBox(height: 12),
            Text(
              data["title"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            )
          ],
        ),
      ),
    );
  }

}
