// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';
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
  final double? borderRadius;
  final int? maxLine;
  final int? maxLength;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
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
    this.borderRadius,
    this.textCapitalization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12)),
      borderSide: BorderSide(color: color ?? MyColors.lightgrey, width: 1),
    );
    return TextFormField(
      onTap: onPressed,
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
      // textCapitalization: TextCapitalization.sentences,
      obscureText: obscureText ?? false,
      cursorColor: MyColors.black,
      keyboardType: keyboardType ?? TextInputType.text,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
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
          borderSide: BorderSide(color: color ?? MyColors.grey, width: 1),
        ),
        // prefixText: "+973",
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: "$hint",
        hintStyle: TextStyle(
          color: hintColor ?? MyColors.userFont,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12)),
          borderSide: BorderSide(color: color ?? MyColors.blue, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12)),
          borderSide: BorderSide(color: color ?? MyColors.blue, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12)),
          borderSide: BorderSide(color: color ?? MyColors.blue, width: 1),
        ),
        errorBorder: border,
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
  final double? borderRadius;
  final int? maxLine;
  final int? maxLength;
  final TextEditingController? controller;
  final bool? autofocus;
  final TextCapitalization? textCapitalization;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatter;
  final ValueChanged? onChanged;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onPressed;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final Function(String? value)? onFiledSubmitted;
  final FocusNode? focusNode;

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
    this.suffixIcon,
    this.borderRadius,
    this.textCapitalization,
    this.autovalidateMode,
    this.onFiledSubmitted,
    this.focusNode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12)),
      borderSide: BorderSide(color: color ?? MyColors.lightgrey, width: 1),
    );
    debugPrint('validator: $validator');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? SizedBox()
            : Text(
                "$label",
                style: TextStyle(color: lblColor ?? MyColors.grey, fontSize: 13.5, fontWeight: FontWeight.w400),
              ),
        SizedBox(height: 5),
        TextFormField(
          focusNode: focusNode,
          style: TextStyle(color: MyColors.black, fontSize: 14),
          autovalidateMode: autovalidateMode,
          onChanged: onChanged,
          onTap: onPressed,
          onFieldSubmitted: onFiledSubmitted,
          maxLines: maxLine,
          validator: validator,
          readOnly: readOnly ?? false,
          inputFormatters: inputFormatter,
          maxLength: maxLength,
          controller: controller,
          textCapitalization: textCapitalization ?? TextCapitalization.sentences,
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
            border: border,
            // errorStyle: TextStyle(height: 0),
            // prefixText: "+973",
            hintText: "$hint",
            hintStyle: TextStyle(
              color: hintColor ?? MyColors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
            focusedErrorBorder: border,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border,
          ),
        ),
      ],
    );
  }
}


class CustomMoneyTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final Color? color;
  final Color? fillColor;
  final Color? lblColor;
  final Color? hintColor;
  final Widget? suffixIcon;
  final double? borderRadius;
  final int? maxLine;
  final int? maxLength;
  final TextEditingController? controller;
  final bool? autofocus;
  final TextCapitalization? textCapitalization;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatter;
  final ValueChanged? onChanged;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onPressed;
  final TextInputType? keyboardType;

  const CustomMoneyTextField({
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
    this.suffixIcon,
    this.borderRadius,
    this.textCapitalization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12)),
      borderSide: BorderSide(color: color ?? MyColors.lightgrey, width: 1),
    );
    debugPrint('validator: $validator');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? SizedBox()
            : Text(
                "$label",
                style: TextStyle(color: lblColor ?? MyColors.grey, fontSize: 13.5, fontWeight: FontWeight.w400),
              ),
        if (label != null && label!.isNotEmpty) SizedBox(height: 5),
        TextFormField(
          style: TextStyle(
            color: MyColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
          onChanged: onChanged,
          onTap: onPressed,
          maxLines: maxLine,
          validator: validator,
          readOnly: readOnly ?? false,
          inputFormatters: inputFormatter,
          maxLength: maxLength,
          controller: controller,
          textCapitalization: textCapitalization ?? TextCapitalization.sentences,
          autofocus: autofocus!,
          obscureText: obscureText ?? false,
          cursorColor: MyColors.black,
          // keyboardType: keyboardType ?? TextInputType.text,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.only(left: 15, top: 25, bottom: 10),
            fillColor: fillColor ?? Colors.white,
            filled: true,
            isDense: true,
            border: border,
            // errorStyle: TextStyle(height: 0),
            // prefixText: "+973",
            hintText: "$hint",
            hintStyle: TextStyle(
              color: hintColor ?? MyColors.grey,
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
            focusedErrorBorder: border,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border,
          ),
        ),
      ],
    );
  }
}

class CustomPhonePickerTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<bool>? onInputValidated;
  final ValueChanged<PhoneNumber>? onInputChanged;
  final PhoneNumber initialValue;
  final ImageButton? prefixIcon; //todo: define in the widget
  final String? hintText;
  final SelectorConfig? selectorConfig;
  final Color? labelColor;
  final AutovalidateMode? autovalidateMode;

  CustomPhonePickerTextField(
      {Key? key,
      this.controller,
      this.label,
      this.validator,
      this.onInputValidated,
      this.onInputChanged,
      required this.initialValue,
      this.prefixIcon,
      this.hintText,
      this.selectorConfig, 
      this.labelColor,
      this.autovalidateMode})
      : super(key: key);
  InputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.lightgrey, width: 1), borderRadius: BorderRadius.circular(10));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? SizedBox()
            : Text(
                "$label",
                style: TextStyle(color: labelColor ?? MyColors.grey, fontSize: 13.5, fontWeight: FontWeight.w400),
              ),
        SizedBox(height: 9),
        InternationalPhoneNumberInput(
          onInputChanged: onInputChanged,
          onInputValidated: onInputValidated,
          errorMessage: "",
          validator: validator,
          // autoValidateMode: AutovalidateMode.always,
          autoValidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          selectorConfig: selectorConfig ?? const SelectorConfig(
              selectorType: PhoneInputSelectorType.DIALOG,
              leadingPadding: 10,
              setSelectorButtonAsPrefixIcon: true,
              showFlags: false),
          ignoreBlank: false,
          // keyboardType: TextInputType.number,
          keyboardType:
              Platform.isIOS ? TextInputType.numberWithOptions(signed: true, decimal: true) : TextInputType.number,
          formatInput: false,
          initialValue: initialValue,
          textFieldController: controller,
          inputDecoration: InputDecoration(
            // prefixIcon:
            // ImageButton(
            //   image: MyImages.phone,
            //   padding: EdgeInsets.zero,
            // ),
            isDense: true,
            fillColor: MyColors.white,
            filled: true,
            contentPadding: EdgeInsets.all(8),
            hintText: hintText ?? "",
            hintStyle: TextStyle(fontSize: 13),
            border: border,
            enabledBorder: border,
            errorBorder: border,
            disabledBorder: border,
            focusedErrorBorder: border,
            focusedBorder: border,
          ),
          cursorColor: MyColors.black,
        ),
      ],
    );
  }
}
