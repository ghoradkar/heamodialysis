import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import 'custom_shimmer_loader.dart';

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
    return isLoading
        ?  Center(child: buildShimmerLoader())
        : Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              widget.l1.isNotEmpty
                  ? _buildRoundedTableRow(widget.tableHeader)
                  : TableRow(children: [
                      const CustomText(
                        text: "Data Not available",
                        fontSize: 16,
                        textColor: Colors.black,
                        textAlign: TextAlign.center,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                      ).paddingOnly(left: 8, bottom: 4)
                    ]),
              for (int i = 0; i < widget.l1.length; i++)
                widget.l1.isNotEmpty
                    // ? _buildTableRow([widget.l1[i], widget.l2[i], widget.l3[i],widget.lastColumnWidgets[i]])
                    ? _buildTableRow(i)
                    : TableRow(children: [
                        const CustomText(
                          text: "",
                          fontSize: 2.0,
                          textColor: Colors.black,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.normal,
                          fontFam: 'Lato',
                        ).paddingOnly(left: 8, bottom: 4)
                      ]),
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
          debugPrint("Cell: ${data[index]}");
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
                  padding: const EdgeInsets.all(8.0),
                  child:

                      CustomText(
                    text: data[index],
                    fontSize: 12,
                    textColor: Colors.black,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.normal,
                    fontFam: 'Lato',
                  )),
            ),
          );
        },
      ),
    );
  }

  TableRow _buildTableRow(int index) {
    return TableRow(
      key: UniqueKey(),
      children: List.generate(
        widget.tableHeader.length,
        (i) {
          // debugPrint("Cell Data:  ${widget.l1}  ${widget.l2}  ${widget.l3} ${widget.l4} - Len: ${widget.tableHeader}");
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
                child: i == (widget.tableHeader.length - 1)
                    ? GestureDetector(
                        onTap: () {
                          // Trigger the callback with the index
                          if (widget.onButtonPressed != null) {
                            widget.onButtonPressed!(index);
                          }
                        },
                        child: widget.lastColumnWidgets?[index] ??
                            Container(), // Use widget directly
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              child:
                                  CustomText(
                            text: [
                              widget.l1[index],
                              widget.l2[index],
                              if (widget.l3 != null) widget.l3?[index],
                              if (widget.l4 != null) widget.l4?[index],
                              if (widget.l5 != null) widget.l5?[index],
                            ][i]
                                .toString(),
                            fontSize: 12,
                            textColor: Colors.black,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.normal,
                            fontFam: 'Lato',
                          )),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
      // decoration: BoxDecoration(color: getColor(isPastDate)
      // ),
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
    return isLoading
        ?  Center(child: buildShimmerLoader())
        : Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              widget.l1.isNotEmpty
                  ? _buildRoundedTableRow(widget.tableHeader)
                  : TableRow(children: [
                      const CustomText(
                        text: "Data Not available",
                        fontSize: 16,
                        textColor: Colors.black,
                        textAlign: TextAlign.center,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                      ).paddingOnly(left: 8, bottom: 4)
                    ]),
              for (int i = 0; i < widget.l1.length; i++)
                widget.l1.isNotEmpty
                    // ? _buildTableRow([widget.l1[i], widget.l2[i], widget.l3[i],widget.lastColumnWidgets[i]])
                    ? _buildTableRow(i)
                    : TableRow(children: [
                        const CustomText(
                          text: "",
                          fontSize: 2.0,
                          textColor: Colors.black,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.normal,
                          fontFam: 'Lato',
                        ).paddingOnly(left: 8, bottom: 4)
                      ]),
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
          debugPrint("Cell: ${data[index]}");
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
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: data[index],
                  fontSize: 12,
                  textColor: Colors.black,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.normal,
                  fontFam: 'Lato',
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TableRow _buildTableRow(int index) {
    return TableRow(
      key: UniqueKey(),
      children: List.generate(
        widget.tableHeader.length,
        (i) {
          if (i == (widget.tableHeader.length - 1)) {
            debugPrint("Cell Len: ${widget.tableHeader}");
            debugPrint("Cell Data:  ${[
              widget.l1[index],
              widget.l2[index],
              if (widget.l3 != null) widget.l3?[index],
              if (widget.l4 != null) widget.l4?[index]
            ][i].toString()}");
          }
          // debugPrint("Cell Data:  ${widget.l1}  ${widget.l2}  ${widget.l3} ${widget.l4} - Len: ${widget.tableHeader}");
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
                child:  i == (widget.tableHeader.length - 1)
                    ? GestureDetector(
                  onTap: () {
                    // Trigger the callback with the index
                    if (widget.onButtonPressed != null) {
                      widget.onButtonPressed!(index);
                    }
                  },
                  child: widget.lastColumnWidgets?[index] ??
                      Container(), // Use widget directly
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: CustomText(
                      text: [
                        widget.l1[index],
                        widget.l2[index],
                        if (widget.l3 != null) widget.l3?[index],
                        if (widget.l4 != null) widget.l4?[index]
                      ][i]
                          .toString(),
                      fontSize: 12,
                      textColor: Colors.black,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.normal,
                      fontFam: 'Lato',
                    )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      // decoration: BoxDecoration(color: getColor(isPastDate)
      // ),
    );
  }
}
