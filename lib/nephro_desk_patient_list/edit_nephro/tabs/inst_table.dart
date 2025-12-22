import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

import '../../../widgets/custom_shimmer_loader.dart';

class InstTable extends StatefulWidget {
  final List<bool> l1;
  final List<String> l2;
  final List<String> l3;
  final List<bool> l4;
  final List<String> l5;
  final List<String> tableHeader;
  final Function(int index)? onButtonPressed;
  final Function? onChecked;
  final Function? onEdit;
  final Function? onDelete;

  const InstTable(
      {super.key,
      required this.l1,
      required this.l2,
      required this.l3,
      this.onButtonPressed,
      required this.tableHeader,
      this.onChecked,
      required this.l4,
      this.onEdit,
      required this.l5,
      this.onDelete});

  @override
  State<InstTable> createState() => _InstTableState();
}

class _InstTableState extends State<InstTable> {
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
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Table(
                      children: [
                        widget.l2.isNotEmpty
                            ? _buildRoundedTableRow(widget.tableHeader)
                            : TableRow(children: [
                                const CustomText(
                                  text: "Data Not available",
                                  fontSize: 12.0,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.normal,
                                ).paddingOnly(left: 8, bottom: 4)
                              ]),
                        for (int i = 0; i < widget.l2.length; i++)
                          widget.l2.isNotEmpty
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
                    ).paddingSymmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
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
        (index) => TableCell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: index == 0 ? const Radius.circular(10.0) : Radius.zero,
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
                fontWeight: FontWeight.normal,
                textColor: Colors.black,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(int index) {
    return TableRow(
      children: List.generate(
        widget.tableHeader.length,
        (i) {
          Widget cellContent;

          // First column (Sr.No)
          if (i == 0) {
            cellContent = Text(
              (index + 1).toString(), // Sr.No
              textAlign: TextAlign.center,
            );
          }
          // Second column (Instruction)
          else if (i == 1) {
            cellContent =
                CustomText(
                  text: widget.l2[index],
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  textColor: Colors.black,
                  textAlign: TextAlign.center,
                );
            //     Text(
            //   widget.l2[index],
            //   textAlign: TextAlign.center,
            // );
          }
          // Third column (Action - Checkbox)
          else if (i == 2) {
            cellContent = Checkbox(
              value: widget.l1[index],
              onChanged: (bool? newValue) {
                // Notify the parent widget
                if (widget.onChecked != null) {
                  widget.onChecked!([index, newValue]);
                }
              },
            );
          } else if (i == 3) {
            cellContent = IconButton(
              onPressed: () {
                // Notify the parent widget
                if (widget.onEdit != null) {
                  widget.onEdit!(index);
                }
              },
              icon: const Icon(Icons.edit),
            );
          } else if (i == 4) {
            cellContent = IconButton(
              onPressed: () {
                // Notify the parent widget
                if (widget.onDelete != null) {
                  widget.onDelete!(index);
                }
              },
              icon: const Icon(
                Icons.delete_outline_outlined,
                color: Colors.red,
              ),
            );
          } else {
            cellContent = const Text(
              "N/A",
              textAlign: TextAlign.center,
            );
          }

          return TableCell(
            verticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.borderColor),
              ),
              child: cellContent,
            ),
          );
        },
      ),
    );
  }
}

class InstructionsTable extends StatefulWidget {
  final List<String> l1;
  final List<String> l2;
  final List<String> l3;
  final List<String> tableHeader;
  final Function(int index)? onButtonPressed;
  final Function? onChecked;
  final Function? onAdd;

  const InstructionsTable(
      {super.key,
      required this.l1,
      required this.l2,
      required this.l3,
      this.onButtonPressed,
      required this.tableHeader,
      this.onChecked,
      this.onAdd});

  @override
  State<InstructionsTable> createState() => InstructionsTableState();
}

class InstructionsTableState extends State<InstructionsTable> {
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
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Table(
                      children: [
                        widget.l2.isNotEmpty
                            ? _buildRoundedTableRow(widget.tableHeader)
                            : TableRow(children: [
                                const CustomText(
                                  text: "Data Not available",
                                  fontSize: 12.0,
                                  textColor: Colors.black,
                                  textAlign: TextAlign.start,
                                  fontFam: "Lato",
                                  fontWeight: FontWeight.normal,
                                ).paddingOnly(left: 8, bottom: 4)
                              ]),
                        for (int i = 0; i < widget.l2.length; i++)
                          widget.l2.isNotEmpty
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
                    ).paddingSymmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
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
        (index) => TableCell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: index == 0 ? const Radius.circular(10.0) : Radius.zero,
                topRight: index == data.length - 1
                    ? const Radius.circular(10.0)
                    : Radius.zero,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(int index) {
    return TableRow(
      children: List.generate(
        widget.tableHeader.length,
        (i) {
          Widget cellContent;

          // First column (Sr.No)
          if (i == 0) {
            cellContent = Text(
              (index + 1).toString(), // Sr.No
              textAlign: TextAlign.center,
            );
          }
          // Second column (Instruction)
          else if (i == 1) {
            cellContent = Text(
              widget.l2[index],
              textAlign: TextAlign.center,
            );
          }
          // Third column (Action - Checkbox)
          else if (i == 2) {
            cellContent = InkWell(
              child: Icon(
                Icons.delete_outline_outlined,
                color: AppColor.red,
              ),
              onTap: () {
                // Notify the parent widget
                if (widget.onChecked != null) {
                  widget.onChecked!(index);
                }
              },
            );
          } else {
            cellContent = const Text(
              "N/A",
              textAlign: TextAlign.center,
            );
          }

          return TableCell(
            verticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.borderColor),
              ),
              child: cellContent,
            ),
          );
        },
      ),
    );
  }
}
