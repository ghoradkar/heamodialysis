import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/dialysis_queue/dialysis_event/model/dialysis_event_detaisl_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

// import '../../dashboard/model/nephro_list.dart';

class ExpandableCardDetails extends StatelessWidget {
  // final NephroList? patientData;
  final DialysisEventDetaislModel? patientData;
  final bool? isExpanded;
  final Function? isExpand;
  final String? currentStat;

  const ExpandableCardDetails({
    super.key,
    this.isExpand,
    this.isExpanded,
    this.patientData,
    this.currentStat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                AppColor.primaryBackgroundColor.withValues(alpha: 0.2),
                AppColor.secondaryColor.withValues(alpha: 0.2)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: const Icon(
                    Icons.account_circle,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: CustomText(
                    text: "${context.l10n.colPatientId} : ",
                    fontSize: 12.0,
                    fontFam: 'Lato',
                    fontWeight: FontWeight.w400,
                    textColor: Colors.black,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: CustomText(
                    text: patientData?.patientId.toString() ?? "-",
                    fontSize: 12.0,
                    fontFam: 'Lato',
                    fontWeight: FontWeight.w400,
                    textColor: Colors.grey,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      if (isExpand != null) {
                        isExpand!(!isExpanded!);
                      }
                    },
                    icon: isExpanded == true
                        ? const Icon(Icons.arrow_circle_up_outlined)
                        : const Icon(Icons.arrow_circle_down))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 43.0, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _detailRow(context, context.l10n.colPatientName,
                      patientData?.patientName?.toString() ?? "-"),
                  _detailRow(context, context.l10n.nephroPatientMobileNo,
                      patientData?.patientNo ?? "-"),
                  _detailRow(context, context.l10n.commonAge,
                      patientData?.age.toString() ?? "-"),
                  Visibility(
                    visible: isExpanded == true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _detailRow(context, context.l10n.nephroMachineNo, "-"),
                        _detailRow(context, context.l10n.schedBedNo,
                            patientData?.bedNo ?? '-'),
                        _detailRow(context,
                            context.l10n.nephroRegistrationDate, "-"),
                        _detailRow(
                            context, context.l10n.colRelativeContact, "-"),
                        _detailRow(
                            context,
                            context.l10n.nephroNephrologistName,
                            patientData?.nephrologistName ?? '-'),
                        _detailRow(context, context.l10n.nephroRelativeName,
                            patientData?.relativeName ?? "-"),
                        _detailRow(
                            context,
                            context.l10n.nephroRegistrationDate,
                            patientData?.regDate != null
                                ? patientData!.regDate.toString()
                                : "-"),
                        _detailRow(
                            context,
                            context.l10n.commonStatus,
                            currentStat == "true"
                                ? context.l10n.commonCompleted
                                : context.l10n.dashPending),
                        _detailRow(context, context.l10n.nephroBmi,
                            patientData?.bmi.toString() ?? '-'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// "Label : value" on one line. Both halves are [Flexible] so long bilingual
  /// (EN / FR) labels wrap instead of overflowing to the right.
  Widget _detailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: CustomText(
              text: "$label : ",
              fontSize: 12.0,
              fontFam: 'Lato',
              fontWeight: FontWeight.w400,
              textColor: Colors.black,
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: CustomText(
              text: value.isEmpty ? "-" : value,
              fontSize: 12.0,
              fontFam: 'Lato',
              fontWeight: FontWeight.w400,
              textColor: Colors.grey,
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  getDate(timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Format it to dd/MM/yyyy
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
