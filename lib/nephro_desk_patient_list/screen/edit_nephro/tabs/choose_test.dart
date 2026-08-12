import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/choose_package_list_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

class ChooseTests extends StatefulWidget {
  final Function(String) onAdd;
  final String label;
  final ChoosePackageListModel? choosePackageListModel;
  final String? initialVal;

  const ChooseTests({
    super.key,
    required this.onAdd,
    this.choosePackageListModel,
    required this.label,
    this.initialVal,
  });

  @override
  State<ChooseTests> createState() => _ChooseTestsState();
}

class _ChooseTestsState extends State<ChooseTests> {
  TextEditingController selectedTestsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedTestsController.text = widget.initialVal ?? "";
  }

  /// Updates the selected test names in the text field
  void _updateSelectedTests() {
    final selectedItems = widget.choosePackageListModel?.parsedData
            ?.where((item) => item.isSelected)
            .map((item) => item.packageName)
            .toList() ??
        [];

    setState(() {
      selectedTestsController.text = selectedItems.join(", ");
      widget.onAdd(selectedTestsController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          labelText: widget.label,
          hintText: 'Select',
          isRequired: false,
          keyBoardType: TextInputType.text,
          txtController: selectedTestsController,
          fillColor: Colors.white,
          isReadOnly: true,
          maxLines: 1,
          suffixIcon: IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Container(
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
                      height: MediaQuery.sizeOf(context).height / 2.5,
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 0.5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "Investigation Test Scheduling Details",
                                fontSize: 16,
                                fontFam: "Lato",
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                                textAlign: TextAlign.start,
                              ).paddingSymmetric(vertical: 4),
                              InkWell(
                                onTap: () {
                                  widget.choosePackageListModel?.parsedData
                                      ?.forEach((e) {
                                    e.isSelected = false;
                                  });
                                  setState(() {});
                                  Get.back();
                                },
                                child: Image.asset(
                                  "assets/cancel.png",
                                  width: 24,
                                  height: 24,
                                  color: AppColor.primaryBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget
                                  .choosePackageListModel?.parsedData?.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      activeColor:
                                          AppColor.primaryBackgroundColor,
                                      value: widget.choosePackageListModel
                                              ?.parsedData?[index].isSelected ??
                                          false,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          widget
                                              .choosePackageListModel
                                              ?.parsedData?[index]
                                              .isSelected = newValue!;
                                        });

                                        // Update text field instantly
                                        _updateSelectedTests();
                                      },
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        text: widget
                                                .choosePackageListModel
                                                ?.parsedData?[index]
                                                .packageName ??
                                            "",
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                },
              );
            },
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColor.primaryBackgroundColor,
            ),
          ),
          fontSize: 16,
        ),
      ],
    );
  }
}
