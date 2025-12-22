import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class NewDashCard extends StatelessWidget {
  final String? firstCount;
  final String? secondCount;
  final String? pendingCount;
  final String? complateCount;
  final String? firstCountText;
  final String? secondCountText;
  final String iconPath;
  final bool? isVisiableRow;
  final bool? isVisiableCol;
  final bool? isInfoVisible;
  final Function? onInfoClick;
  final double cardHeight;

  const NewDashCard(
      {super.key,
      this.firstCount,
      this.secondCount,
      this.firstCountText,
      this.secondCountText,
      required this.iconPath,
      this.isVisiableRow,
      this.pendingCount,
      this.complateCount,
      this.isVisiableCol,
      this.onInfoClick,
      this.isInfoVisible,
      required this.cardHeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: (0.4)), // Shadow color
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(1, 1),
              ),
            ],
            color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // Align items vertically in the center
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Space between each child
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              // Center contents vertically
              children: [
                CustomText(
                    text: firstCount ?? "",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                    textAlign: TextAlign.start).paddingOnly(bottom: 20),
                CustomText(
                    text: firstCountText ?? "",
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),
              ],
            ).paddingSymmetric(horizontal: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              // Center contents vertically
              children: [
                CustomText(
                    text: secondCount ?? "",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black,
                    textAlign: TextAlign.start).paddingOnly(bottom: 20),
                CustomText(
                    text: secondCountText ?? "",
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),
              ],
            ).paddingSymmetric(horizontal: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              // Center contents vertically
              children: [
                Image.asset(iconPath).paddingOnly(bottom: 20),
                InkWell(
                    onTap: () {
                      if (onInfoClick != null) {
                        onInfoClick!();
                      }
                    },
                    child: Image.asset(
                      'assets/info.png',
                      color: AppColor.primaryBackgroundColor,
                      width: 24,
                      height: 24,
                    )),
              ],
            ).paddingSymmetric(horizontal: 10)
          ],
        ).paddingAll(8.0),
      ),
    );
  }
}
