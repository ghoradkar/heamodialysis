import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:heamodialysis/dialysis_queue/post_dialysis/model/common_dropdown_post_dialysis_model.dart';
import 'package:heamodialysis/l10n/l10n.dart';
import 'package:heamodialysis/nephro_desk_patient_list/model/route_list_model.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

/// Stable, locale-independent identifiers for [CustomTextField] / [DoubleTextField].
///
/// Screens should pass the localized string to `labelText` (for display) and the
/// matching constant here to `fieldKey` (for input-formatter / validation logic).
/// When `fieldKey` is omitted the widget falls back to `labelText`, so
/// not-yet-localized call sites keep working unchanged.
class FieldKeys {
  static const mobileNo = 'Mobile No';
  static const referredContactNumber = 'Referred Contact Number';
  static const nephrologistContactNo = 'Nephrologist Contact No';
  static const contactNo = 'Contact No';
  static const pinCode = 'Pin Code';
  static const abhaNo = 'ABHA No';
  static const abhaNumber = 'ABHA Number';
  static const middleName = 'Middle Name';
  static const firstName = 'First Name';
  static const lastName = 'Last Name';
  static const identificationNumber = 'Identification Number';
  static const emailId = 'Email Id';
  static const oxygenLevel = 'Oxygen Level';
  static const venousPressure = 'Venous Pressure';
  static const bloodFlowQb = 'Blood Flow(QB)';
  static const dialysateFlowQd = 'Dialysate Flow(QD)';
  static const rrfUrineVol = 'RRF Urine Vol';
  static const reasonNotRegisteredMjpjay = 'Reason for not registered on MJPJAY';
  static const heightInFt = 'Height (In Ft.)';
  static const finalUfv = 'Final UFV';
}

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

  /// Locale-independent identity used for input-formatter and validation
  /// logic. Falls back to [labelText] when not supplied. See [FieldKeys].
  final String? fieldKey;
  final String? identification;
  final String? errorM;
  final String hintText;
  final TextStyle? labelStyle;
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
    this.fieldKey,
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
    this.labelStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  int remainingCharacters = 0;

  /// Locale-independent field identity for logic branching.
  String get _fieldId => widget.fieldKey ?? widget.labelText;

  @override
  void initState() {
    remainingCharacters = widget.mazLenght ?? 0;

    widget.txtController?.addListener(() {
      if (_fieldId == "Reason for not registered on MJPJAY") {
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

    if (_fieldId == "Mobile No" ||
        _fieldId == "Referred Contact Number" ||
        _fieldId == "Nephrologist Contact No" ||
        _fieldId == "Contact No") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ];
    } else if (_fieldId == "Pin Code") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ];
    } else if (_fieldId == "ABHA No") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(14),
        AbhaIdInputFormatter(),
      ];
    } else if (_fieldId == "Middle Name" ||
        _fieldId == "First Name" ||
        _fieldId == "Last Name") {
      inputFormatters = [
        UpperCaseTextFormatter(),
      ];
    } else if (_fieldId == "Identification Number") {
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
    } else if (_fieldId == "Email Id") {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9._%+-@]')),
        LowerTextFormatter()
      ];
    } else if (_fieldId == "Oxygen Level" ||
        _fieldId == "Venous Pressure" ||
        _fieldId == "Blood Flow(QB)" ||
        _fieldId == "Dialysate Flow(QD)" ||
        _fieldId == "RRF Urine Vol") {
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
                Flexible(
                  child: CustomText(
                      text: widget.labelText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: const Color(0xFF515151),
                      textAlign: TextAlign.start),
                ),
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
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red,
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
              final l10n = context.l10n;
              // Existing validations

              if (widget.isRequired) {
                if (value == null || value.isEmpty) {
                  return l10n.fieldRequired(widget.labelText);
                }

                if ((_fieldId == "Mobile No" ||
                        _fieldId == "Referred Contact Number" ||
                        _fieldId == "Nephrologist Contact No") &&
                    !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                  return l10n.fieldInvalid(widget.labelText);
                }

                if (_fieldId == "Email Id") {
                  final RegExp emailRegex =
                      RegExp(r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$');
                  if (!emailRegex.hasMatch(value)) {
                    return l10n.validationInvalidEmail;
                  }
                }

                if (_fieldId == "Reason for not registered on MJPJAY") {
                  final trimmedValue = value.trim();
                  if (trimmedValue.isEmpty) {
                    return l10n.fieldRequired(widget.labelText);
                  }
                  if (trimmedValue.length > 500) {
                    return l10n.validationMaxLength(500);
                  }
                }
              }

              // New validations for Identification types
              if (_fieldId == "Identification Number") {
                if (widget.identification == "Ration Card" &&
                    (value?.length != 10 ||
                        !RegExp(r'^\d{10}$').hasMatch(value!))) {
                  return l10n.validationDigits(10);
                } else if (widget.identification == "Licenece" &&
                    (value?.length != 14 ||
                        !RegExp(r'^\d{14}$').hasMatch(value!))) {
                  return l10n.validationDigits(14);
                } else if (widget.identification == "Pan Card" &&
                    !RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(value ?? '')) {
                  return l10n.validationInvalidPan;
                } else if (widget.identification == "Aadhaar Card" &&
                    (value?.length != 12 ||
                        !RegExp(r'^\d{12}$').hasMatch(value!))) {
                  return l10n.validationDigits(12);
                }
              }

              // Validation for ABHA No (non-required)
              if (_fieldId == "ABHA No" &&
                  value != null &&
                  value.isNotEmpty &&
                  value.length < 17) {
                return l10n.validationMinDigits(17);
              }

              if (_fieldId == "Height (In Ft.)" &&
                  value != null &&
                  value.isNotEmpty &&
                  !RegExp(r"^\d{1,2}'\d{1,2}$").hasMatch(value)) {
                return l10n.validationHeightFormat;
              }

              if (_fieldId == "Final UFV" &&
                  value != null &&
                  value.isNotEmpty) {
                final parsedValue = double.tryParse(value);

                if (parsedValue == null) {
                  return l10n.validationInvalidNumber;
                }

                if (parsedValue > 6.0) {
                  return l10n.validationMaxLitres(widget.labelText, '6.0');
                }
              }

              if (_fieldId == "Venous Pressure" &&
                  value != null &&
                  value.isNotEmpty &&
                  int.parse(value) > 350) {
                return l10n.validationMaxLitres(widget.labelText, '350');
              }
              if (_fieldId == "Blood Flow(QB)" &&
                  value != null &&
                  value.isNotEmpty &&
                  int.parse(value) > 450) {
                return l10n.validationMaxLitres(widget.labelText, '450');
              }

              if (_fieldId == "Dialysate Flow(QD)" &&
                  value != null &&
                  value.isNotEmpty &&
                  int.parse(value) > 800) {
                return l10n.validationMaxLitres(widget.labelText, '800');
              }

              return null;
            },
          ),
          if (_fieldId == "Reason for not registered on MJPJAY")
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4),
              child: Text(
                context.l10n.charactersRemaining(remainingCharacters),
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
                Flexible(
                  child: CustomText(
                      text: widget.labelText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: const Color(0xFF515151),
                      textAlign: TextAlign.start),
                ),

                if (widget.isRequired)
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
                hintText: isFahrenheit
                    ? context.l10n.unitFahrenheit
                    : context.l10n.unitCelsius,
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

  /// Locale-independent identity for input-formatter logic. Falls back to
  /// [labelText]. See [FieldKeys].
  final String? fieldKey;

  const DoubleTextField({
    super.key,
    required this.labelText,
    this.fieldKey,
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
    final fieldId = fieldKey ?? labelText;
    List<TextInputFormatter> inputFormatters = [];
    if (fieldId == "Mobile No" ||
        fieldId == "Referred Contact Number" ||
        fieldId == "Nephrologist Contact No" ||
        fieldId == "Contact No") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ];
    } else if (fieldId == "Pin Code") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ];
    } else if (fieldId == "ABHA Number") {
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(14),
        AbhaIdInputFormatter(),
      ];
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 11, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: Row(
              children: [
                // Text(labelText, style: const TextStyle(fontSize: 16)),
                Flexible(
                  child: CustomText(
                      text: labelText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: const Color(0xFF515151),
                      textAlign: TextAlign.start),
                ),

                if (isRequired)
                  CustomText(
                      text: "*",
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      textColor: AppColor.red,
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
              Expanded(
                flex: 5,
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
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                    hintText: hintText1,
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
                        return context.l10n.commonRequiredField;
                      }
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 4,
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
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                    hintText: hintText2,
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
                        return context.l10n.commonRequiredField;
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

enum CustomRadioButtons { yes, no, sendBack }

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
    // Scale the whole radio row down to fit - the label and the Yes/No option
    // texts are longer in French / bilingual mode.
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
              fontSize: 15,
            ),
          ),
        if (text.isNotEmpty)
          const SizedBox(
            width: 20,
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
              fontSize: 13.0,
              fontFam: 'Lato',
              fontWeight: FontWeight.normal,
              textColor: Colors.black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(width: 15),
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
              fontSize: 13.0,
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
      ),
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
        Flexible(
          child: CustomText(
            text: label,
            fontSize: 14,
            fontFam: 'Lato',
            fontWeight: FontWeight.normal,
            textColor: Colors.black,
            textAlign: TextAlign.start,
          ),
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
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Row(
              children: [
                Flexible(
                  child: CustomText(
                      text: labelText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: const Color(0xFF515151),
                      textAlign: TextAlign.start),
                ),
                if (isRequired)
                  CustomText(
                      text: "*",
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      textColor: AppColor.red,
                      textAlign: TextAlign.start),
              ],
            ),
          ),
          DropdownButtonFormField2(
            isExpanded: true,
            iconStyleData: IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColor.primaryBackgroundColor,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              offset: const Offset(0, -4),
            ),
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: "Lato",
                fontWeight: FontWeight.normal),
            hint: CustomText(
                text: hint,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                textColor: const Color(0xff999999),
                textAlign: TextAlign.start),
            decoration: InputDecoration(
              filled: true,
              fillColor: filledColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: AppColor.borderColor,
                ),
              ),
            ),
            value: selectedItem,
            items: allNotNull
                ? items
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: CustomText(
                            text: item ?? '',
                            fontSize: 16,
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
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            textColor: Colors.black,
                            textAlign: TextAlign.start,
                          ).paddingOnly(top: 4.h, bottom: 4.h),
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
                      return context.l10n.fieldRequired(labelText);
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
                Flexible(
                  child: CustomText(
                      text: labelText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: const Color(0xFF515151),
                      textAlign: TextAlign.start),
                ),
                if (isRequired)
                  CustomText(
                      text: "*",
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      textColor: AppColor.red,
                      textAlign: TextAlign.start)
              ],
            ),
          ),
          DropdownButtonFormField2(
            isExpanded: true,
            iconStyleData: IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColor.primaryBackgroundColor,
              ),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              offset: const Offset(0, -4),
            ),
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: "Lato",
                fontWeight: FontWeight.normal),
            hint: CustomText(
                text: hint,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                textColor: const Color(0xff999999),
                textAlign: TextAlign.start),
            decoration: InputDecoration(
              filled: true,
              fillColor: filledColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
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
                borderSide: const BorderSide(
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
            value: selectedItem,
            items: allNotNull
                ? items
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: CustomText(
                              text: item.routename!,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              textColor: Colors.black,
                              textAlign: TextAlign.start),
                        ))
                    .toList()
                : dummy
                    .map((items) => DropdownMenuItem(
                          value: items,
                          child: CustomText(
                              text: items,
                              fontSize: 16,
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
                      return context.l10n.fieldRequired(labelText);
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
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textColor: const Color(0xFF515151),
                textAlign: TextAlign.start),
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
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Row(
              children: [
                Flexible(
                  child: CustomText(
                      text: labelText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: const Color(0xFF515151),
                      textAlign: TextAlign.start),
                ),
                if (isRequired)
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
            initialValue: initialValue,
            readOnly: true,
            style: const TextStyle(fontSize: 16, fontFamily: "Lato"),
            controller: selectedDate,
            decoration: InputDecoration(
              fillColor: filledColor,
              filled: true,
              hintText: hint,
              hintStyle: const TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff999999),
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
                      return context.l10n.fieldRequired(labelText);
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
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Row(
              children: [
                Flexible(
                  child: CustomText(
                      text: labelText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: const Color(0xFF515151),
                      textAlign: TextAlign.start),
                ),
                if (isRequired)
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
            initialValue: initialValue,
            readOnly: false,
            // Allow manual input
            style: const TextStyle(fontSize: 16, fontFamily: "Lato"),
            controller: selectedDate,
            decoration: InputDecoration(
              fillColor: filledColor,
              filled: true,
              hintText: hint,
              hintStyle: const TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff999999),
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
                      return context.l10n.fieldRequired(labelText);
                    }

                    // Validate the date format (dd-MM-yyyy)
                    // final dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
                    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                    if (!dateRegex.hasMatch(value)) {
                      return context.l10n.validationDateFormat;
                    }

                    // Check if the date is valid
                    try {
                      DateFormat('dd/MM/yyyy').parseStrict(value);
                    } catch (e) {
                      return context.l10n.validationInvalidDate;
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

  const CustomDocUploadField({
    super.key,
    required this.labelText,
    required this.hint,
    required this.isRequired,
    required this.callB,
    required this.selectedDate,
    required this.filledColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasFile = selectedDate.text.isNotEmpty;

    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label
          Row(
            children: [
              Flexible(
                child: CustomText(
                  text: labelText,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textColor: const Color(0xFF515151),
                  textAlign: TextAlign.start,
                ),
              ),
              if (isRequired)
                CustomText(
                    text: "*",
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    textColor: AppColor.red,
                    textAlign: TextAlign.start),
            ],
          ),

          SizedBox(height: 8.h),

          /// Upload Container
          InkWell(
            onTap: () {
              callB(); // pickFile function
            },
            child: Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              child: Center(
                child: hasFile
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(selectedDate.text),
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/upload.png',
                            height: 36,
                            color: AppColor.primaryBackgroundColor,
                          ),
                          SizedBox(height: 10.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: hint,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontFamily: "Lato",
                                  ),
                                ),
                                if (isRequired)
                                  TextSpan(
                                    text: " *",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),

          /// Selected file name (optional below image)
          if (hasFile)
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Text(
                selectedDate.text.split('/').last, // just file name
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

          /// Error text
          if (!hasFile && isRequired)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                context.l10n.fieldRequired(labelText),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 11.sp,
                ),
              ),
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
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: isLoading == true
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              // Keep the designed width - a long (bilingual "EN / FR") label
              // wraps onto a second line rather than shrinking or overflowing.
              : CustomText(
                  text: buttonText,
                  fontSize: 12.sp,
                  fontFam: "Lato",
                  fontWeight: FontWeight.normal,
                  textColor: textColor,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
                ),
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
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
          alignment: Alignment.center,
          width: buttonWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                primColor,
                secColor
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: isLoading == true
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              // Keep the designed width - a long (bilingual "EN / FR") label
              // wraps onto a second line rather than shrinking or overflowing.
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      alignment: Alignment.center,
                      path,
                      color: iconColor,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Flexible(
                      child: CustomText(
                          text: buttonText,
                          fontSize: 12.sp,
                          fontFam: "Lato",
                          fontWeight: FontWeight.normal,
                          textColor: textColor,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
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
