import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/package_list_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/nephro_controller.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:heamodialysis/widgets/custom_textfield.dart';

class ChoosePackage extends StatefulWidget {
  final Function onAdd;
  final String label;
  final String? selectedVal;
  final Function? getBack;
  final List<PackageListModel>? choosePackageListModel;

  const ChoosePackage(
      {super.key,
      required this.onAdd,
      this.choosePackageListModel,
      required this.label,
      this.selectedVal,
      this.getBack});

  @override
  State<ChoosePackage> createState() => _ChoosePackageState();
}

class _ChoosePackageState extends State<ChoosePackage> {
  final NephroController nephroController = Get.find<NephroController>();

  @override
  void initState() {
    nephroController.selectedTestsController.text = widget.selectedVal ?? "";
    nephroController.selectedPackage = null;
    super.initState();
  }

  /// Updates the selected test names in the text field
  void _updateSelectedTests() {
    final selectedItems = widget.choosePackageListModel
            ?.where((item) => item.isSelected)
            .map((item) => item.packageName)
            .toList() ??
        [];

    setState(() {
      nephroController.selectedTestsController.text = selectedItems.join(", ");
      widget.onAdd(nephroController.selectedTestsController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          onTap: () {
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
                          offset: const Offset(
                              0, 0.5), // changes position of shadow
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
                                    text:
                                        "Investigation Test Scheduling Details",
                                    fontSize: 16,
                                    fontFam: "Lato",
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black,
                                    textAlign: TextAlign.start)
                                .paddingSymmetric(vertical: 4),
                            InkWell(
                                onTap: () {
                                  widget.getBack!();
                                },
                                child: Image.asset(
                                  "assets/cancel.png",
                                  width: 24,
                                  height: 24,
                                  color: AppColor.primaryBackgroundColor,
                                )),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.choosePackageListModel?.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      activeColor:
                                          AppColor.primaryBackgroundColor,
                                      value: widget
                                          .choosePackageListModel?[index]
                                          .isSelected,
                                      // Boolean value for checkbox state
                                      onChanged: (bool? newValue) {
                                        widget.choosePackageListModel?[index]
                                            .isSelected = newValue!;
                                        setState(() {});
                                        _updateSelectedTests();
                                      },
                                    ),
                                    CustomText(
                                        text: widget
                                                .choosePackageListModel?[index]
                                                .packageName ??
                                            "",
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        textColor: Colors.black,
                                        textAlign: TextAlign.start)
                                  ],
                                );
                              }),
                        ),
                        CustomButton(
                          buttonText: 'Add to Test',
                          path: 'assets/save-ro-disinfec.png',
                          callB: () {
                            Get.back();
                          },
                          buttonWidth: 140,
                          primColor: AppColor.primaryBackgroundColor,
                          secColor: AppColor.secondaryColor,
                          textColor: Colors.white,
                          iconColor: Colors.white,
                        )
                      ],
                    ),
                  );
                });
              },
            );
          },
          labelText: widget.label,
          // initialValue: widget.selectedVal,

          hintText: 'Select',
          isRequired: false,
          keyBoardType: TextInputType.text,
          txtController: nephroController.selectedTestsController,
          fillColor: Colors.white,
          isReadOnly: true,
          maxLines: 1,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppColor.primaryBackgroundColor,
          ),

          fontSize: 16,
        )
      ],
    );
  }
}

class CheckBoxList {
  String? checkTitle;
  String? imgPath;
  bool? isSelected;
  Color? firstColor;
  Color? secondColor;

  CheckBoxList(this.checkTitle, this.isSelected,
      {this.imgPath, this.firstColor, this.secondColor});
}
