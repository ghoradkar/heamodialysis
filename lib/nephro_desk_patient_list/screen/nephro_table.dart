import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/nephro_desk_patient_list/controller/nephro_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

class NephroTable extends StatefulWidget {
  final List<String> relationList;
  final List<String> l1;
  final List<TextEditingController> l3;
  final List<bool> l4;
  final bool readOnly;
  final List<String> tableHeader;
  final Function(int index)? onButtonPressed;

  const NephroTable({
    super.key,
    required this.l1,
    required this.l3,
    this.onButtonPressed,
    required this.l4,
    required this.tableHeader,
    required this.relationList,
    required this.readOnly,
  });

  @override
  State<NephroTable> createState() => NephroTableState();
}

class NephroTableState extends State<NephroTable> {
  final NephroController nephroController = Get.find<NephroController>();

  @override
  void initState() {
    if (widget.readOnly == true) {
      if (nephroController.selectedItemsPerRow.isEmpty ||
          nephroController.selectedItemsPerRow.length != widget.l1.length) {
        nephroController.selectedItemsPerRow =
            List.generate(widget.l1.length, (_) => []);
      }
    } else {
      nephroController.selectedItemsPerRow =
          List.generate(widget.l1.length, (_) => []);
    }

    nephroController.checkBoxValues = List.from(widget.l4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      // defaultColumnWidth: const IntrinsicColumnWidth(),
      columnWidths: const {
        0: FixedColumnWidth(100),
        1: FixedColumnWidth(80),
        2: FixedColumnWidth(50),
        3: FixedColumnWidth(120),
      },
      children: [
        widget.l1.isNotEmpty
            ? _buildRoundedTableRow(widget.tableHeader)
            : TableRow(children: [
                Center(
                    child: CustomText(
                        text: context.l10n.commonNoDataFound,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        textColor: Colors.black,
                        textAlign: TextAlign.center)),
              ]),
        for (int i = 0; i < widget.l1.length; i++) _buildTableRow(i),
      ],
    );
  }

  TableRow _buildTableRow(int index) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.w),
            // child: Text(widget.l1[index]),
            child: CustomText(
                text: widget.l1[index],
                fontSize: 10.sp,
                fontWeight: FontWeight.normal,
                textColor: Color(0xFF484848),
                textAlign: TextAlign.center),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: CustomTableTextField(
              readOnly: widget.readOnly,
              txtController: widget.l3[index],
              onChanged: (value) {},
              hintText: context.l10n.regHintEnter,
              keyBoardType: TextInputType.number,
              fillColor: Colors.white,
            ),
          ),
        ),
        TableCell(
          child: Checkbox(
            side: BorderSide(
              color: Color(0xFFADADAD),
              width: 1.5,
            ),
            checkColor: Colors.white,
            value: nephroController.checkBoxValues.isNotEmpty
                ? nephroController.checkBoxValues[index]
                : false,
            onChanged: (value) {
              if (widget.readOnly != true) {
                setState(() {
                  nephroController.checkBoxValues[index] = value!;
                });
              }
            },
          ),
        ),
        TableCell(
          key: UniqueKey(),
          child: DropdownButtonHideUnderline(
            child: AbsorbPointer(
              absorbing: widget.readOnly,
              child: Container(
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFADADAD),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton2(
                  isExpanded: true,
                  buttonStyleData: ButtonStyleData(
                    height: 40,
                    width: 100,
                    padding: EdgeInsets.only(right: 0.w, left: 5),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    // maxHeight: 300,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                  ),
                  hint: CustomText(
                      text: nephroController.selectedItemsPerRow[index].isEmpty
                          ? "Select"
                          : nephroController.selectedItemsPerRow[index]
                              .join(', '),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                      textColor: AppColor.grey,
                      textAlign: TextAlign.center),
                  items: widget.relationList.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          final isSelected = nephroController
                              .selectedItemsPerRow[index]
                              .contains(item);
                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  nephroController.selectedItemsPerRow[index]
                                      .remove(item);
                                } else {
                                  nephroController.selectedItemsPerRow[index]
                                      .add(item);
                                }
                              });
                              this.setState(() {}); // Update UI
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  side: BorderSide(
                                    color: Colors.grey.shade300, // border color
                                    width: 1.5,
                                  ),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (isSelected) {
                                        nephroController
                                            .selectedItemsPerRow[index]
                                            .remove(item);
                                      } else {
                                        nephroController
                                            .selectedItemsPerRow[index]
                                            .add(item);
                                      }
                                    });
                                    this.setState(() {}); // Update UI
                                  },
                                ),
                                CustomText(
                                    text: item,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.normal,
                                    textColor: Colors.black,
                                    textAlign: TextAlign.start)
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                  onChanged: (_) {},
                  selectedItemBuilder: (context) {
                    return widget.relationList.map((item) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: nephroController.selectedItemsPerRow[index]
                              .map((selectedItem) => Chip(
                                    // label: Text(selectedItem),
                                    label: CustomText(
                                        text: selectedItem,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.center),
                                    onDeleted: () {
                                      setState(() {
                                        nephroController
                                            .selectedItemsPerRow[index]
                                            .remove(selectedItem);
                                      });
                                    },
                                  ))
                              .toList(),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildRoundedTableRow(List<String> data) {
    return TableRow(
      children: data.map((header) {
        return TableCell(
          child: Container(
              // height: ,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
              alignment: Alignment.center,
              child: CustomText(
                  text: header,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.black,
                  textAlign: TextAlign.center)

              // Text(
              //   header,
              //   style: const TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),

              ),
        );
      }).toList(),
    );
  }

  getSelectedCheckboxes() {
    List<String> selected = nephroController.getSelectedItems(widget.l1);
    debugPrint("Selected Checkboxes: $selected");
  }
}
