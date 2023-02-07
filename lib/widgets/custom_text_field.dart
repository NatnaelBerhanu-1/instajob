// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
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

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final Color? color;
  final Color? fillColor;
  final Color? lblColor;
  final Color? hintColor;

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

class CustomUnderlineTxt extends StatelessWidget {
  final String? title;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  const CustomUnderlineTxt(
      {Key? key,
      this.title,
      this.color,
      this.size,
      this.onTap,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        "$title",
        style: TextStyle(
            fontSize: size ?? 15,
            fontWeight: fontWeight ?? FontWeight.w500,
            color: color ?? MyColors.blue,
            decoration: TextDecoration.underline),
      ),
    );
  }
}
