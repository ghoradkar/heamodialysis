import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import 'custom_shimmer_loader.dart';

/// Column sizing shared by the tables below.
///
/// The table is fit to the available width instead of scrolling horizontally:
///  - column 0 (Sr. No) stays intrinsic - it only holds a short index
///  - the last column (action button / status chip) stays intrinsic - its
///    child already has a fixed size
///  - every column in between flexes to share the remaining width and lets
///    long bilingual (EN / FR / EN+FR) text wrap onto multiple lines.
Map<int, TableColumnWidth> fitTableColumnWidths(int columnCount) {
  final widths = <int, TableColumnWidth>{};
  for (var i = 0; i < columnCount; i++) {
    final isFirst = i == 0;
    final isLast = i == columnCount - 1;
    widths[i] = (isFirst || isLast)
        ? const IntrinsicColumnWidth()
        : const FlexColumnWidth();
  }
  // With only 1-2 columns there is no "middle" column to flex; fall back to
  // intrinsic sizing so nothing is forced to zero width.
  if (columnCount <= 2) {
    for (var i = 0; i < columnCount; i++) {
      widths[i] = const IntrinsicColumnWidth();
    }
  }
  return widths;
}

/// French copy runs noticeably longer than English, so trim a point off the
/// body / header text when the active locale is French to buy wrapping room.
double localeScaledFontSize(BuildContext context, double base) {
  final code = Localizations.maybeLocaleOf(context)?.languageCode;
  return code == 'fr' ? base - 1 : base;
}

class RoundedCornerTable extends StatefulWidget {
  final List<String> l1;
  final List<dynamic> l2;
  final List<dynamic>? l3;
  final List<dynamic>? l4;
  final List<dynamic>? l5;
  final List<Widget>? lastColumnWidgets;
  final List<String> tableHeader;
  final Function(int index)? onButtonPressed;

  const RoundedCornerTable({
    super.key,
    required this.l1,
    required this.l2,
    this.l3,
    this.l4,
    this.l5,
    this.lastColumnWidgets,
    required this.tableHeader,
    this.onButtonPressed,
  });

  @override
  State<RoundedCornerTable> createState() => _RoundedCornerTableState();
}

class _RoundedCornerTableState extends State<RoundedCornerTable> {
  bool isLoading = true;

  @override
  void initState() {
    shwProgressIndicator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: buildShimmerLoader());

    return Table(
      defaultColumnWidth: const FlexColumnWidth(),
      columnWidths: fitTableColumnWidths(widget.tableHeader.length),
      defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
      children: [
        widget.l1.isNotEmpty
            ? _buildRoundedTableRow(widget.tableHeader)
            : TableRow(children: [
                CustomText(
                  text: context.l10n.commonNoDataFound,
                  fontSize: 16,
                  textColor: Colors.black,
                  textAlign: TextAlign.center,
                  fontFam: "Lato",
                  fontWeight: FontWeight.normal,
                ).paddingOnly(left: 8, bottom: 4)
              ]),
        for (int i = 0; i < widget.l1.length; i++)
          if (widget.l1.isNotEmpty) _buildTableRow(i),
      ],
    );
  }

  shwProgressIndicator() async {
    await Future.delayed(const Duration(seconds: 0));
    setState(() {
      isLoading = false;
    });
  }

  TableRow _buildRoundedTableRow(List<String> data) {
    return TableRow(
      children: List.generate(
        data.length,
        (index) {
          return TableCell(
            verticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft:
                      index == 0 ? const Radius.circular(10.0) : Radius.zero,
                  topRight: index == data.length - 1
                      ? const Radius.circular(10.0)
                      : Radius.zero,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6),
                child: CustomText(
                  text: data[index],
                  fontSize: localeScaledFontSize(context, 10),
                  textColor: Colors.black,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  fontFam: 'Lato',
                  softWrap: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TableRow _buildTableRow(int index) {
    final lastCol = widget.tableHeader.length - 1;
    final values = <dynamic>[
      widget.l1[index],
      widget.l2[index],
      if (widget.l3 != null) widget.l3?[index],
      if (widget.l4 != null) widget.l4?[index],
      if (widget.l5 != null) widget.l5?[index],
    ];

    return TableRow(
      key: UniqueKey(),
      children: List.generate(
        widget.tableHeader.length,
        (i) {
          return TableCell(
            key: UniqueKey(),
            verticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: i == lastCol
                    ? GestureDetector(
                        onTap: () => widget.onButtonPressed?.call(index),
                        child: widget.lastColumnWidgets?[index] ??
                            const SizedBox.shrink(),
                      )
                    : CustomText(
                        text: (i < values.length ? values[i] : '').toString(),
                        fontSize: localeScaledFontSize(context, 10),
                        textColor: Colors.black,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.normal,
                        fontFam: 'Lato',
                        softWrap: true,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PrescriptionTableData extends StatefulWidget {
  final List<String> l1;
  final List<dynamic> l2;
  final List<dynamic>? l3;
  final List<dynamic>? l4;
  final List<Widget>? lastColumnWidgets;
  final List<String> tableHeader;
  final Function(int index)? onButtonPressed;

  const PrescriptionTableData(
      {super.key,
      required this.l1,
      required this.l2,
      this.l3,
      required this.tableHeader,
      this.lastColumnWidgets,
      this.onButtonPressed,
      this.l4});

  @override
  State<PrescriptionTableData> createState() => _PrescriptionTableDataState();
}

class _PrescriptionTableDataState extends State<PrescriptionTableData> {
  bool isLoading = true;

  @override
  void initState() {
    shwProgressIndicator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: buildShimmerLoader());

    return Table(
      defaultColumnWidth: const FlexColumnWidth(),
      columnWidths: fitTableColumnWidths(widget.tableHeader.length),
      defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
      children: [
        widget.l1.isNotEmpty
            ? _buildRoundedTableRow(widget.tableHeader)
            : TableRow(children: [
                CustomText(
                  text: context.l10n.commonNoDataFound,
                  fontSize: 16,
                  textColor: Colors.black,
                  textAlign: TextAlign.center,
                  fontFam: "Lato",
                  fontWeight: FontWeight.normal,
                ).paddingOnly(left: 8, bottom: 4)
              ]),
        for (int i = 0; i < widget.l1.length; i++)
          if (widget.l1.isNotEmpty) _buildTableRow(i),
      ],
    );
  }

  shwProgressIndicator() async {
    await Future.delayed(const Duration(seconds: 0));
    setState(() {
      isLoading = false;
    });
  }

  TableRow _buildRoundedTableRow(List<String> data) {
    return TableRow(
      children: List.generate(
        data.length,
        (index) {
          return TableCell(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft:
                      index == 0 ? const Radius.circular(10.0) : Radius.zero,
                  topRight: index == data.length - 1
                      ? const Radius.circular(10.0)
                      : Radius.zero,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                child: CustomText(
                  text: data[index],
                  fontSize: localeScaledFontSize(context, 12),
                  textColor: Colors.black,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  fontFam: 'Lato',
                  softWrap: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TableRow _buildTableRow(int index) {
    final lastCol = widget.tableHeader.length - 1;
    final values = <dynamic>[
      widget.l1[index],
      widget.l2[index],
      if (widget.l3 != null) widget.l3?[index],
      if (widget.l4 != null) widget.l4?[index],
    ];

    return TableRow(
      key: UniqueKey(),
      children: List.generate(
        widget.tableHeader.length,
        (i) {
          return TableCell(
            key: UniqueKey(),
            verticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: i == lastCol
                    ? GestureDetector(
                        onTap: () => widget.onButtonPressed?.call(index),
                        child: widget.lastColumnWidgets?[index] ??
                            const SizedBox.shrink(),
                      )
                    : CustomText(
                        text: (i < values.length ? values[i] : '').toString(),
                        fontSize: localeScaledFontSize(context, 12),
                        textColor: Colors.black,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.normal,
                        fontFam: 'Lato',
                        softWrap: true,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
