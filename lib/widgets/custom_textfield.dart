import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/common_dropdown_post_dialysis_model.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/route_list_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class CustomTableTextField extends StatelessWidget {
  final String? identification;
  final String hintText;
  final bool readOnly;

  final TextInputType keyBoardType;
  final TextEditingController txtController;
  final Color fillColor;

  final Function? onChanged;

  const CustomTableTextField(
      {super.key,
      required this.hintText,
      required this.keyBoardType,
      required this.txtController,
      required this.fillColor,
      this.onChanged,
      this.identification,
      required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 90,
      child: TextFormField(
        readOnly: readOnly,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(txtController.text);
          }
        },
        controller: txtController,
        keyboardType: keyBoardType,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 12.0,
              color: Color(0xff999999),
              fontFamily: "Lato",
              fontWeight: FontWeight.normal),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: AppColor.borderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: AppColor.borderColor,
            ),
          ),

        ),
        validator: (value) {
          return null;
        },
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String? identification;
  final String? errorM;
  final String hintText;
  final String? initialValue;
  final bool isRequired;
  final bool isReadOnly;
  final TextInputType keyBoardType;
  final TextEditingController? txtController;
  final Color fillColor;
  final int maxLines;
  final int? mazLenght;
  final Function? onChanged;
  final Function? onTap;
  final Widget? suffixIcon;
  final double fontSize;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.isRequired,
    required this.keyBoardType,
    required this.fillColor,
    required this.isReadOnly,
    required this.maxLines,
    this.onChanged,
    this.identification,
    this.mazLenght,
    this.onTap,
    this.suffixIcon,
    this.initialValue,
    this.txtController,
    this.errorM,
    required this.fontSize,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  int remainingCharacters = 0;

  @override
  void initState() {
    remainingCharacters = widget.mazLenght ?? 0;

    widget.txtController?.addListener(() {
      if (widget.labelText == "Reason for not registered on MJPJAY") {
        setState(() {
          remainingCharacters = (widget.mazLenght ?? 500) -
              (widget.txtController?.text.length ?? 0);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.txtController?.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];

    if (widget.labelText == "Mobile No" ||
        widget.labelText == "Referred Contact Number" ||
        widget.labelText == "Nephrologist Contact No" ||
        widget.labelText == "Contact No") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ];
    } else if (widget.labelText == "Pin Code") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ];
    } else if (widget.labelText == "ABHA No") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(14),
        AbhaIdInputFormatter(),
      ];
    } else if (widget.labelText == "Middle Name" ||
        widget.labelText == "First Name" ||
        widget.labelText == "Last Name") {
      inputFormatters = [
        UpperCaseTextFormatter(),
      ];
    } else if (widget.labelText == "Identification Number") {
      if (widget.identification == "Ration Card") {
        inputFormatters = [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ];
      } else if (widget.identification == "Licenece") {
        inputFormatters = [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(14),
        ];
      } else if (widget.identification == "Pan Card") {
        inputFormatters = [
          LengthLimitingTextInputFormatter(10),
          UpperCaseTextFormatter(),
        ];
      } else if (widget.identification == "Aadhaar Card") {
        inputFormatters = [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(12)
        ];
      }
    } else if (widget.labelText == "Email Id") {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9._%+-@]')),
        LowerTextFormatter()
      ];
    } else if (widget.labelText == "Oxygen Level" ||
        widget.labelText == "Venous Pressure" ||
        widget.labelText == "Blood Flow(QB)" ||
        widget.labelText == "Dialysate Flow(QD)" ||
        widget.labelText == "RRF Urine Vol") {
      inputFormatters = [FilteringTextInputFormatter.digitsOnly];
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Row(
              children: [
                // Text(widget.labelText, style: const TextStyle(fontSize: 16)),
                CustomText(
                    text: widget.labelText,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),
                if (widget.isRequired)
                  // Text(
                  //   ' *',
                  //   style: TextStyle(
                  //     color: AppColor.red,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  CustomText(
                      text: "*",
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      textColor: AppColor.red,
                      textAlign: TextAlign.start),
              ],
            ),
          ),
          TextFormField(
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            style: TextStyle(fontSize: widget.fontSize),
            maxLines: widget.maxLines,
            initialValue: widget.initialValue,
            maxLength: widget.mazLenght,
            readOnly: widget.isReadOnly,
            controller: widget.txtController,
            keyboardType: widget.keyBoardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              errorText: widget.errorM,
              fillColor: widget.fillColor,
              filled: true,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              hintStyle: const TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff999999),
                  fontFamily: "Lato",
                  fontWeight: FontWeight.normal),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
              // ✅ Add this errorBorder property
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.red, // Red border on all sides
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.red, // Red border when focused with error
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),

            ),
            validator: (value) {
              // Existing validations

              if (widget.isRequired) {
                if (value == null || value.isEmpty) {
                  return '${widget.labelText} is required';
                }

                if ((widget.labelText == "Mobile No" ||
                        widget.labelText == "Referred Contact Number" ||
                        widget.labelText == "Nephrologist Contact No") &&
                    !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                  return 'Please enter a valid ${widget.labelText}';
                }

                if (widget.labelText == "Email Id") {
                  final RegExp emailRegex =
                      RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                }

                if (widget.labelText == "Reason for not registered on MJPJAY") {
                  final trimmedValue = value.trim();
                  if (trimmedValue.isEmpty) {
                    return '${widget.labelText} is required';
                  }
                  if (trimmedValue.length > 500) {
                    return 'Maximum 500 characters allowed';
                  }
                }
              }

              // New validations for Identification types
              if (widget.labelText == "Identification Number") {
                if (widget.identification == "Ration Card" &&
                    (value?.length != 10 ||
                        !RegExp(r'^\d{10}$').hasMatch(value!))) {
                  return 'Please enter a 10-digit Ration Card number';
                } else if (widget.identification == "Licenece" &&
                    (value?.length != 14 ||
                        !RegExp(r'^\d{14}$').hasMatch(value!))) {
                  return 'Please enter a 14-digit';
                } else if (widget.identification == "Pan Card" &&
                    !RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(value ?? '')) {
                  return 'Please enter a valid PAN';
                } else if (widget.identification == "Aadhaar Card" &&
                    (value?.length != 12 ||
                        !RegExp(r'^\d{12}$').hasMatch(value!))) {
                  return 'Please enter a 12-digit';
                }
              }

              // Validation for ABHA No (non-required)
              if (widget.labelText == "ABHA No" &&
                  value != null &&
                  value.isNotEmpty &&
                  value.length < 17) {
                return 'Please enter 17 digits';
              }

              if (widget.labelText == "Height (In Ft.)" &&
                  value != null &&
                  value.isNotEmpty &&
                  !RegExp(r"^\d{1,2}'\d{1,2}$").hasMatch(value)) {
                return "Please enter height in\n(e.g., 5'8)";
              }

              if (widget.labelText == "Final UFV" &&
                  value != null &&
                  value.isNotEmpty) {
                final parsedValue = double.tryParse(value);

                if (parsedValue == null) {
                  return "Enter a valid number";
                }

                if (parsedValue > 6.0) {
                  return "${widget.labelText} should not\ngreater than 6.0 ltrs";
                }
              }

              // if (widget.labelText == "Final UFV" &&
              //     value != null &&
              //     value.isNotEmpty &&
              //     int.parse(value) > 6) {
              //   return "${widget.labelText} should not\ngreater than 6.0 ltrs";
              // }

              if (widget.labelText == "Venous Pressure" &&
                  value != null &&
                  value.isNotEmpty &&
                  int.parse(value) > 350) {
                return "${widget.labelText} should\nnot greater than 350 ltrs";
              }
              if (widget.labelText == "Blood Flow(QB)" &&
                  value != null &&
                  value.isNotEmpty &&
                  int.parse(value) > 450) {
                return "${widget.labelText} should not\ngreater than 450 ltrs";
              }

              if (widget.labelText == "Dialysate Flow(QD)" &&
                  value != null &&
                  value.isNotEmpty &&
                  int.parse(value) > 800) {
                return "${widget.labelText} should\nnot greater than 800 ltrs";
              }

              return null;
            },
          ),
          if (widget.labelText == "Reason for not registered on MJPJAY")
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4),
              child: Text(
                '$remainingCharacters characters remaining',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomTextFieldTemp extends StatefulWidget {
  final String labelText;
  final String? identification;
  final String? errorM;
  final String hintText;
  final String? initialValue;
  final bool isRequired;
  final bool isReadOnly;
  final TextInputType keyBoardType;
  final TextEditingController? txtController;
  final Color fillColor;
  final int maxLines;
  final Function? onChanged;
  final Function? onTap;
  final double fontSize;
  final ValueChanged<bool>? onUnitChanged;

  const CustomTextFieldTemp({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.isRequired,
    required this.keyBoardType,
    required this.fillColor,
    required this.isReadOnly,
    required this.maxLines,
    this.onChanged,
    this.identification,
    this.onTap,
    this.initialValue,
    this.txtController,
    this.errorM,
    required this.fontSize,
    this.onUnitChanged,
  });

  @override
  CustomTextFieldTempState createState() => CustomTextFieldTempState();
}

class CustomTextFieldTempState extends State<CustomTextFieldTemp> {
  bool isFahrenheit = true; // Track if Fahrenheit is selected

  void _toggleTemperatureUnit() {
    setState(() {
      isFahrenheit = !isFahrenheit;
      widget.onUnitChanged?.call(isFahrenheit);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];

    // Handle specific validation logic (e.g., phone number, PIN code, etc.)

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Row(
              children: [
                // Text(widget.labelText, style: const TextStyle(fontSize: 16)),
                CustomText(
                    text: widget.labelText,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),

                if (widget.isRequired)
                  // Text(
                  //   ' *',
                  //   style: TextStyle(
                  //     color: AppColor.red,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  const CustomText(
                      text: "*",
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      textColor: Colors.red,
                      textAlign: TextAlign.start),
              ],
            ),
          ),
          TextFormField(
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            style: TextStyle(fontSize: widget.fontSize),
            maxLines: widget.maxLines,
            initialValue: widget.initialValue,
            readOnly: widget.isReadOnly,
            controller: widget.txtController,
            keyboardType: widget.keyBoardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
                errorText: widget.errorM,
                fillColor: widget.fillColor,
                filled: true,
                hintText: isFahrenheit ? "Fahrenheit" : "Celsius",
                hintStyle: const TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff999999),
                  fontFamily: "Lato",
                  fontWeight: FontWeight.normal,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppColor.borderColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: AppColor.borderColor,
                  ),
                ),
                // Error state borders - ALL FOUR SIDES RED
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.red, // Red border on all sides
                    width: 1.0,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.red, // Red border when focused with error
                    width: 1.0,
                  ),
                ),
                suffixIcon: TextButton(
                    onPressed: () {
                      _toggleTemperatureUnit();
                    },
                    child: Text(
                      isFahrenheit ? "°F" : "°C",
                      style: TextStyle(color: AppColor.primaryBackgroundColor),
                    ))),
            validator: (value) {
              // Add existing validation logic here
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class DoubleTextField extends StatelessWidget {
  final String labelText;
  final String hintText1;
  final String hintText2;
  final bool isRequired;
  final bool isReadOnly;
  final TextInputType keyBoardType;
  final TextEditingController? txtController1;
  final TextEditingController? txtController2;
  final String? txtControllerInitial1;
  final String? txtControllerInitial2;
  final Color fillColor;
  final int maxLines;
  final Function onChange1;
  final Function onChange2;

  const DoubleTextField({
    super.key,
    required this.labelText,
    required this.hintText1,
    required this.hintText2,
    required this.isRequired,
    required this.keyBoardType,
    this.txtController1,
    this.txtController2,
    required this.fillColor,
    required this.isReadOnly,
    required this.maxLines,
    required this.onChange1,
    required this.onChange2,
    this.txtControllerInitial1,
    this.txtControllerInitial2,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];
    if (labelText == "Mobile No" ||
        labelText == "Referred Contact Number" ||
        labelText == "Nephrologist Contact No" ||
        labelText == "Contact No") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ];
    } else if (labelText == "Pin Code") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ];
    } else if (labelText == "ABHA Number") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(14),
        AbhaIdInputFormatter(),
      ];
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Row(
              children: [
                // Text(labelText, style: const TextStyle(fontSize: 16)),
                CustomText(
                    text: labelText,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),

                if (isRequired)
                  const CustomText(
                      text: "*",
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      textColor: Colors.red,
                      textAlign: TextAlign.start),

                // Text(
                //   ' *',
                //   style: TextStyle(
                //     color: AppColor.red,
                //     fontSize: 16,
                //   ),
                // ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  initialValue: txtControllerInitial1,
                  onChanged: (value) {
                    onChange1(value);
                  },
                  maxLines: maxLines,
                  readOnly: isReadOnly,
                  controller: txtController1,
                  keyboardType: keyBoardType,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    fillColor: fillColor,
                    filled: true,
                    hintText: hintText1,
                    hintStyle: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff999999),
                        fontFamily: "Lato",
                        fontWeight: FontWeight.normal),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColor.borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColor.borderColor,
                      ),
                    ),
                    // Error state borders - ALL FOUR SIDES RED
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.red, // Red border on all sides
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.red, // Red border when focused with error
                        width: 1.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (isRequired) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  initialValue: txtControllerInitial2,
                  onChanged: (value) {
                    onChange2(value);
                  },
                  maxLines: maxLines,
                  readOnly: isReadOnly,
                  controller: txtController2,
                  keyboardType: keyBoardType,
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                    fillColor: fillColor,
                    filled: true,
                    hintText: hintText2,
                    hintStyle: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff999999),
                        fontFamily: "Lato",
                        fontWeight: FontWeight.normal),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColor.borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColor.borderColor,
                      ),
                    ),
                    // Error state borders - ALL FOUR SIDES RED
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.red, // Red border on all sides
                        width: 1.0,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.red, // Red border when focused with error
                        width: 1.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (isRequired) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum CustomRadioButtons{yes,no,sendBack}

class CustomRadioField extends StatelessWidget {
  final String text;
  final bool isRequired;
  final Function radioCallB1;
  final Function radioCallB2;
  final Function(CustomRadioButtons?)? radioCallB3;
  final CustomRadioButtons groupVal;
  final String firstRadioText;
  final String secondRadioText;
  final String? thirdRadioText;
  final bool showThirdOption;

  const CustomRadioField({
    super.key,
    required this.isRequired,
    required this.radioCallB1,
    required this.radioCallB2,
    this.radioCallB3,
    required this.groupVal,
    required this.text,
    required this.firstRadioText,
    required this.secondRadioText,
    this.thirdRadioText,
    this.showThirdOption = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (text.isNotEmpty)
          CustomText(
            text: text,
            fontSize: 14.0,
            fontFam: 'Lato',
            fontWeight: FontWeight.normal,
            textColor: Colors.black,
            textAlign: TextAlign.center,
          ),
        if (isRequired)
          Text(
            ' *',
            style: TextStyle(
              color: AppColor.red,
              fontSize: 16,
            ),
          ),
        if (text.isNotEmpty)
          const SizedBox(
            width: 30,
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
              activeColor: AppColor.secondaryColor,
              value: CustomRadioButtons.yes,
              groupValue: groupVal,
              onChanged: (CustomRadioButtons? value) {
                radioCallB1(value);
              },
            ),
            CustomText(
              text: firstRadioText,
              fontSize: 14.0,
              fontFam: 'Lato',
              fontWeight: FontWeight.normal,
              textColor: Colors.black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(width: 30),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
              activeColor: AppColor.secondaryColor,
              value: CustomRadioButtons.no,
              groupValue: groupVal,
              onChanged: (CustomRadioButtons? value) {
                radioCallB2(value);
              },
            ),
            CustomText(
              text: secondRadioText,
              fontSize: 14.0,
              fontFam: 'Lato',
              fontWeight: FontWeight.normal,
              textColor: Colors.black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(width: 20),
        // Third Radio Button

        // Third Radio Button
        if (thirdRadioText != null && showThirdOption)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
              activeColor: AppColor.secondaryColor,
              value: CustomRadioButtons.sendBack,
              groupValue: groupVal,
              onChanged: (CustomRadioButtons? value) {
                radioCallB3!(value);
              },
            ),
            CustomText(
              text: thirdRadioText!,
              fontSize: 14.0,
              fontFam: 'Lato',
              fontWeight: FontWeight.normal,
              textColor: Colors.black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}

class LookupRadioGroup extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<CommonDropDownPostDialysisModel> items;
  final int? groupValue; // selected lookupDetId
  final ValueChanged<CommonDropDownPostDialysisModel?> onChanged;

  const LookupRadioGroup({
    super.key,
    required this.label,
    required this.isRequired,
    required this.items,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: label,
          fontSize: 14,
          fontFam: 'Lato',
          fontWeight: FontWeight.normal,
          textColor: Colors.black,
          textAlign: TextAlign.start,
        ),
        if (isRequired)
          const Text(' *', style: TextStyle(color: Colors.red, fontSize: 16)),
        const SizedBox(width: 12),
        Wrap(
          spacing: 30,
          children: items.map((it) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<int>(
                  activeColor: AppColor.secondaryColor,
                  value: it.lookupDetId,
                  groupValue: groupValue,
                  onChanged: (id) {
                    onChanged(it);
                  },
                ),
                Text(it.lookupDetDescEn),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

class MyCustomDropdown extends StatelessWidget {
  final String labelText;
  final bool isRequired;
  final bool? isViewProfile;
  final String hint;
  final List<dynamic> items;
  final Function senValue;
  final Color filledColor;

  final String? selectedItem;

  const MyCustomDropdown(
      {super.key,
      required this.labelText,
      required this.items,
      required this.hint,
      required this.isRequired,
      required this.senValue,
      required this.filledColor,
      this.selectedItem,
      this.isViewProfile});

  @override
  Widget build(BuildContext context) {
    bool allNotNull = items.every((element) => element != null);
    List<String> dummy = ['select'];
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0, 8.h, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8.w, 0, 8.h, 8.h),
            child: Row(
              children: [
                CustomText(
                    text: labelText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),
                if (isRequired)
                  CustomText(
                      text: "*",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                      textColor: Colors.red,
                      textAlign: TextAlign.start),
              ],
            ),
          ),
          DropdownButtonFormField(
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColor.primaryBackgroundColor,
            ),
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: filledColor,
              hintStyle: TextStyle(
                  fontSize: 12.0.sp,
                  color: const Color(0xff999999),
                  fontFamily: "Lato",
                  fontWeight: FontWeight.normal),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
              // ✅ Add this errorBorder property for red border on validation error
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.red, // Red border on all sides
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.red, // Red border when focused with error
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
            ),
            initialValue: selectedItem,
            items: allNotNull
                ? items
                    .map((item) => DropdownMenuItem(
                          value: item,
                          // child: Text(item),
                          child: CustomText(
                            text: item ?? '',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ).paddingOnly(top: 2.h, bottom: 2.h),
                        ))
                    .toList()
                : dummy
                    .map((items) => DropdownMenuItem(
                          value: items,
                          child: CustomText(
                            text: items,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ).paddingOnly(top: 4.h, bottom: 4.h),
                          // child: Text(items).paddingOnly(top: 4, bottom: 4),
                        ))
                    .toList(),
            onChanged: isViewProfile == true
                ? null
                : (value) {
                    senValue(value);
                  },
            validator: isRequired
                ? (value) {
                    if (value == null) {
                      return "$labelText is required";
                    }
                    return null;
                  }
                : null,
          )
        ],
      ),
    );
  }
}

class MyCustomDropdownObject extends StatelessWidget {
  final String labelText;
  final bool isRequired;
  final bool? isViewProfile;
  final String hint;
  final List<Listroutemasters> items;
  final Function senValue;
  final Color filledColor;

  final Listroutemasters? selectedItem;

  const MyCustomDropdownObject(
      {super.key,
      required this.labelText,
      required this.items,
      required this.hint,
      required this.isRequired,
      required this.senValue,
      required this.filledColor,
      this.selectedItem,
      this.isViewProfile});

  @override
  Widget build(BuildContext context) {
    bool allNotNull = items.every((element) => element != null);
    List<String> dummy = ['select'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Row(
              children: [
                // Text(
                //   labelText,
                //   style: const TextStyle(fontSize: 16),
                // ),
                CustomText(
                    text: labelText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),
                if (isRequired)
                  // Text(
                  //   ' *',
                  //   style: TextStyle(
                  //     color: AppColor.red,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  CustomText(
                      text: "*",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      textColor: Colors.red,
                      textAlign: TextAlign.start)
              ],
            ),
          ),
          DropdownButtonFormField(
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: AppColor.primaryBackgroundColor,
            ),
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: filledColor,
              hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xff999999),
                  fontFamily: "Lato",
                  fontWeight: FontWeight.normal),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
              // ✅ Add this errorBorder property
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.red, // Red border when focused with error
                  width: 1.0,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
            ),
            initialValue: selectedItem,
            items: allNotNull
                ? items
                    .map((item) => DropdownMenuItem(
                          value: item,
                          // child: Text(item.routename!),
                          child: CustomText(
                              text: item.routename!,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              textColor: Colors.black,
                              textAlign: TextAlign.start),
                        ))
                    .toList()
                : dummy
                    .map((items) => DropdownMenuItem(
                          value: items,
                          // child: Text(items),
                          child: CustomText(
                              text: items,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                              textColor: Colors.black,
                              textAlign: TextAlign.start),
                        ))
                    .toList(),
            onChanged: isViewProfile == true
                ? null
                : (value) {
                    senValue(value);
                  },
            validator: isRequired
                ? (value) {
                    if (value == null) {
                      return "$labelText is required";
                    }
                    return null;
                  }
                : null,
          )
        ],
      ),
    );
  }
}

class SearchableDropDown extends StatelessWidget {
  final bool isViewPatient;
  final dynamic selectedItem;
  final List<dynamic> list;
  final Function onChanged;
  final Function onSearched;
  final String hintText;

  const SearchableDropDown(
      {super.key,
      required this.isViewPatient,
      this.selectedItem,
      required this.list,
      required this.onChanged,
      required this.onSearched,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(4.w, 8.h, 8.w, 8.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
                text: hintText,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
                textColor: Colors.black,
                textAlign: TextAlign.left),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.h),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.borderColor)),
            child: CustomDropdown.searchRequest(
              decoration: CustomDropdownDecoration(
                closedSuffixIcon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColor.primaryBackgroundColor,
                ),
                expandedSuffixIcon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColor.primaryBackgroundColor,
                ),
              ),
              enabled: isViewPatient,
              initialItem: selectedItem,
              hintText: hintText,
              closeDropDownOnClearFilterSearch: true,
              items: list,
              onChanged: (value) {
                onChanged(value);
              },
              futureRequest: (searched) {
                return onSearched(searched);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDateField extends StatelessWidget {
  final String labelText;
  final String hint;
  final bool isRequired;
  final Function callB;
  final TextEditingController? selectedDate;
  final String? initialValue;
  final Color filledColor;
  final bool dontDhowPrefix;
  final bool? isViewProfile;

  const CustomDateField(
      {super.key,
      required this.labelText,
      required this.hint,
      required this.isRequired,
      required this.callB,
      this.selectedDate,
      required this.filledColor,
      required this.dontDhowPrefix,
      this.isViewProfile,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0, 8.h, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8.h, 8.w, 8.h),
            child: Row(
              children: [
                CustomText(
                    text: labelText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),
                if (isRequired)
                  Text(
                    ' *',
                    style: TextStyle(
                      color: AppColor.red,
                      fontSize: 16.sp,
                    ),
                  ),
              ],
            ),
          ),
          TextFormField(
            initialValue: initialValue,
            readOnly: true,
            style: TextStyle(fontSize: 12.sp, fontFamily: "Lato"),
            controller: selectedDate,
            decoration: InputDecoration(
              fillColor: filledColor,
              filled: true,
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 12.0.sp,
                  color: const Color(0xff999999),
                  fontFamily: "Lato",
                  fontWeight: FontWeight.normal),
              suffixIcon: dontDhowPrefix
                  ? const SizedBox.shrink()
                  : Icon(
                      Icons.calendar_month,
                      color: AppColor.primaryBackgroundColor,
                    ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
              // Error state borders - ALL FOUR SIDES RED
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red, // Red border on all sides
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red, // Red border when focused with error
                  width: 1.0,
                ),
              ),
            ),
            onTap: isViewProfile == true
                ? null
                : () {
                    callB();
                  },
            validator: isRequired
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return "$labelText is required";
                    }
                    return null;
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class CustomDOBField extends StatelessWidget {
  final String labelText;
  final String hint;
  final bool isRequired;
  final Function callB;
  final TextEditingController? selectedDate;
  final String? initialValue;
  final Color filledColor;
  final bool dontDhowPrefix;
  final bool? isViewProfile;

  const CustomDOBField({
    super.key,
    required this.labelText,
    required this.hint,
    required this.isRequired,
    required this.callB,
    this.selectedDate,
    required this.filledColor,
    required this.dontDhowPrefix,
    this.isViewProfile,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8.h, 8.w, 8.h),
            child: Row(
              children: [
                CustomText(
                    text: labelText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),
                if (isRequired)
                  Text(
                    ' *',
                    style: TextStyle(
                      color: AppColor.red,
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
          ),

          TextFormField(
            initialValue: initialValue,
            readOnly: false,
            // Allow manual input
            style: TextStyle(fontSize: 12.sp, fontFamily: "Lato"),
            controller: selectedDate,
            decoration: InputDecoration(
              fillColor: filledColor,
              filled: true,
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xff999999),
                  fontFamily: "Lato",
                  fontWeight: FontWeight.normal),
              suffixIcon: dontDhowPrefix
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: Icon(
                        Icons.calendar_month,
                        color: AppColor.primaryBackgroundColor,
                      ),
                      onPressed: () {
                        // Open date picker only when calendar icon is tapped
                        callB();
                      },
                    ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
              // Error state borders - ALL FOUR SIDES RED
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red, // Red border on all sides
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red, // Red border when focused with error
                  width: 1.0,
                ),
              ),
            ),

            validator: isRequired
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return "$labelText is required";
                    }

                    // Validate the date format (dd-MM-yyyy)
                    // final dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
                    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                    if (!dateRegex.hasMatch(value)) {
                      return 'Please enter the date in the format dd/MM/yyyy';
                    }

                    // Check if the date is valid
                    try {
                      DateFormat('dd/MM/yyyy').parseStrict(value);
                    } catch (e) {
                      return 'Invalid date. Please check the format';
                    }
                    return null;
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class CustomDocUploadField extends StatelessWidget {
  final String labelText;
  final String hint;
  final bool isRequired;
  final Function callB;
  final TextEditingController selectedDate;
  final Color filledColor;

  const CustomDocUploadField(
      {super.key,
      required this.labelText,
      required this.hint,
      required this.isRequired,
      required this.callB,
      required this.selectedDate,
      required this.filledColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 0, 8.h, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8.h, 8.w, 8.h),
            child: Row(
              children: [
                CustomText(
                    text: labelText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    textColor: Colors.black,
                    textAlign: TextAlign.start),
                if (isRequired)
                  Text(
                    ' *',
                    style: TextStyle(
                      color: AppColor.red,
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
          ),
          TextFormField(
            readOnly: true,
            controller: selectedDate,
            decoration: InputDecoration(
              fillColor: filledColor,
              filled: true,
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 12.0.sp,
                  color: const Color(0xff999999),
                  fontFamily: "Lato",
                  fontWeight: FontWeight.normal),
              suffix: Image.asset(
                'assets/upload.png',
                color: AppColor.primaryBackgroundColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
              // Error state borders - ALL FOUR SIDES RED
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red, // Red border on all sides
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red, // Red border when focused with error
                  width: 1.0,
                ),
              ),
            ),
            onTap: () {
              callB();
            },
            validator: isRequired
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return "$labelText is required";
                    }
                    return null;
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class CustomButtonWithoutIcon extends StatelessWidget {
  final String buttonText;
  final Function? callB;
  final double buttonWidth;
  final Color primColor;
  final Color secColor;
  final Color textColor;
  final bool? isLoading;

  const CustomButtonWithoutIcon(
      {super.key,
      required this.buttonText,
      required this.callB,
      required this.buttonWidth,
      required this.primColor,
      required this.secColor,
      required this.textColor,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callB!();
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
          alignment: Alignment.center,
          width: buttonWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                primColor,
                secColor
                // AppColor.primaryBackgroundColor,
                // AppColor.secondaryColor
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: isLoading == true
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : CustomText(
                  text: buttonText,
                  fontSize: 12.sp,
                  fontFam: "Lato",
                  fontWeight: FontWeight.normal,
                  textColor: textColor,
                  textAlign: TextAlign.center)),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final String path;
  final Function? callB;
  final double buttonWidth;
  final Color primColor;
  final Color secColor;
  final Color textColor;
  final Color iconColor;
  final bool? isLoading;

  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.path,
      required this.callB,
      required this.buttonWidth,
      required this.primColor,
      required this.secColor,
      required this.textColor,
      required this.iconColor,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callB!();
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
          alignment: Alignment.center,
          width: buttonWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                primColor,
                secColor
                // AppColor.primaryBackgroundColor,
                // AppColor.secondaryColor
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: isLoading == true
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      alignment: Alignment.center,
                      path,
                      color: iconColor,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                        text: buttonText,
                        fontSize: 12.sp,
                        fontFam: "Lato",
                        fontWeight: FontWeight.normal,
                        textColor: textColor,
                        textAlign: TextAlign.center),
                  ],
                )),
    );
  }
}

class AbhaIdInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final buffer = StringBuffer();
    int dashPositions = 0;

    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 6 || i == 10) {
        buffer.write('-');
        dashPositions++;
      }
      buffer.write(text[i]);
    }

    final selectionIndex = newValue.selection.end + dashPositions;
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class CustomCheckboxGroup extends StatelessWidget {
  final String title;
  final ValueChanged<bool?>? onChangedFirst;
  final ValueChanged<bool?>? onChangedSecond;
  final bool firstValue;
  final bool secondValue;

  const CustomCheckboxGroup(
      {super.key,
      required this.title,
      required this.onChangedFirst,
      required this.onChangedSecond,
      required this.firstValue,
      required this.secondValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8.h, 0, 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
            child: CustomText(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              textColor: Colors.black,
              textAlign: TextAlign.start,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Checkbox(value: firstValue, onChanged: onChangedFirst),
                    CustomText(
                      text: '1st',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Checkbox(value: secondValue, onChanged: onChangedSecond),
                    CustomText(
                      text: '2nd',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
