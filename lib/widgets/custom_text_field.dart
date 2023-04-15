// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../utils/my_colors.dart';

class IconTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final Color? color;
  final Color? fillColor;
  final Color? lblColor;
  final Color? hintColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLine;
  final int? maxLength;
  final TextEditingController? controller;
  final bool? autofocus;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatter;
  final ValueChanged? onChanged;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onPressed;
  final TextInputType? keyboardType;
  const IconTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.autofocus = false,
    this.obscureText,
    this.onPressed,
    this.color,
    this.validator,
    this.inputFormatter,
    this.onChanged,
    this.keyboardType,
    this.maxLine,
    this.prefixIcon,
    this.hintColor,
    this.suffixIcon,
    this.fillColor,
    this.readOnly,
    this.lblColor,
    this.maxLength,
    List? inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: MyColors.black,
      ),
      onChanged: onChanged,
      maxLines: maxLine,
      validator: validator,
      readOnly: readOnly ?? false,
      inputFormatters: inputFormatter,
      maxLength: maxLength,
      controller: controller,
      autofocus: autofocus!,
      obscureText: obscureText ?? false,
      cursorColor: MyColors.black,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        counterText: "",
        errorText: "",
        errorStyle: TextStyle(height: 0),
        contentPadding: EdgeInsets.only(left: 15, top: 25, bottom: 10),
        fillColor: fillColor ?? Colors.white,
        filled: true,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: MyColors.grey, width: 1.5),
        ),
        // prefixText: "+973",
        prefixIcon: prefixIcon ?? SizedBox(),
        suffixIcon: suffixIcon ?? SizedBox(),
        hintText: "$hint",
        hintStyle: TextStyle(
          color: hintColor ?? MyColors.grey,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
              color: color ?? MyColors.grey.withOpacity(.40), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: color ?? MyColors.blue, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
              color: color ?? MyColors.grey.withOpacity(.40), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
              color: color ?? MyColors.grey.withOpacity(.40), width: 1.5),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final Color? color;
  final Color? fillColor;
  final Color? lblColor;
  final Color? hintColor;
  final Widget? suffixIcon;
  final int? maxLine;
  final int? maxLength;
  final TextEditingController? controller;
  final bool? autofocus;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatter;
  final ValueChanged? onChanged;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onPressed;
  final TextInputType? keyboardType;
  const CustomTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.autofocus = false,
    this.obscureText,
    this.onPressed,
    this.color,
    this.validator,
    this.inputFormatter,
    this.onChanged,
    this.keyboardType,
    this.maxLine,
    this.hintColor,
    this.fillColor,
    this.readOnly,
    this.lblColor,
    this.maxLength,
    List? inputFormatters,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? SizedBox()
            : Text(
                "$label",
                style: TextStyle(
                    color: lblColor ?? MyColors.grey,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400),
              ),
        SizedBox(height: 9),
        TextFormField(
          style: TextStyle(
            color: MyColors.black,
          ),
          onChanged: onChanged,
          onTap: onPressed,
          maxLines: maxLine,
          validator: validator,
          readOnly: readOnly ?? false,
          inputFormatters: inputFormatter,
          maxLength: maxLength,
          controller: controller,
          autofocus: autofocus!,
          obscureText: obscureText ?? false,
          cursorColor: MyColors.black,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: suffixIcon ?? SizedBox(),
            counterText: "",
            contentPadding: EdgeInsets.only(left: 15, top: 25, bottom: 10),
            fillColor: fillColor ?? Colors.white,
            filled: true,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: MyColors.grey, width: 1.5),
            ),
            // prefixText: "+973",

            hintText: "$hint",
            hintStyle: TextStyle(
              color: hintColor ?? MyColors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                  color: color ?? MyColors.grey.withOpacity(.40), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: color ?? MyColors.blue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: color ?? MyColors.grey, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomPhonePickerTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  CustomPhonePickerTextField({Key? key, this.controller, this.label})
      : super(key: key);
  InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.grey.withOpacity(.50), width: 1.5),
      borderRadius: BorderRadius.circular(10));
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? SizedBox()
            : Text(
                "$label",
                style: TextStyle(
                    color: MyColors.grey,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400),
              ),
        SizedBox(height: 9),
        InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) async {
            print(number);
            // setState(() {
            //   isoCode = number.isoCode!;
            //   dialCode = number.dialCode!;
            //   print("CONRTY COSDDFDDDF   $dialCode");
            // });
          },
          onInputValidated: (val) {
            if (val == true) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
            // setState(() {
            //   isValid = val;
            // });
            print("VAL  ::: $val");
            // print("ISVALID ::: $isValid");
          },
          errorMessage: "",

          autoValidateMode: AutovalidateMode.always,
          selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              leadingPadding: 10,
              setSelectorButtonAsPrefixIcon: true,
              showFlags: false),
          ignoreBlank: false,
          // keyboardType: TextInputType.number,
          keyboardType: Platform.isIOS
              ? TextInputType.numberWithOptions(signed: true, decimal: true)
              : TextInputType.number,
          formatInput: false,
          initialValue: PhoneNumber(isoCode: "IN"),
          textFieldController: controller,
          inputDecoration: InputDecoration(
            isDense: true,
            fillColor: MyColors.white,
            filled: true,
            contentPadding: EdgeInsets.all(8),
            hintText: "",
            hintStyle: TextStyle(fontSize: 13),
            border: border,
            enabledBorder: border,
            errorBorder: border,
            focusedErrorBorder: border,
            focusedBorder: border,
          ),
          cursorColor: MyColors.black,
        ),
      ],
    );
  }
}
