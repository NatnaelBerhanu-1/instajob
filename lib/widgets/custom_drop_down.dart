// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class CustomDropdown extends StatelessWidget {
  final ValueChanged? onChanged;
  final List<DropdownMenuItem>? list;
  final value;
  final FormFieldValidator? validator;
  final bool? isExpanded;
  final Widget? hintText;
  final double? iconSize;
  final Color? iconColor;
  final Color? bgColor;
  final Color? borderColor;
  final Color? errorBorderColor;
  final AutovalidateMode? autovalidateMode;
  const CustomDropdown({
    Key? key,
    this.onChanged,
    this.list,
    this.value,
    this.hintText,
    this.iconSize,
    this.borderColor,
    this.errorBorderColor,
    this.iconColor,
    this.isExpanded,
    this.bgColor,
    this.validator, 
    this.autovalidateMode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:
          BorderSide(color: borderColor ?? MyColors.greyTxt.withOpacity(.15)),
    );
    var errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:
          BorderSide(color: errorBorderColor ?? MyColors.red.withOpacity(.9)),
    );
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
          autovalidateMode: AutovalidateMode.always,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              errorStyle: TextStyle(height: 0),
              focusedErrorBorder: errorBorder,
              enabledBorder: border,
              border: border,
              errorBorder: errorBorder,
              focusedBorder: border),
          elevation: 6,
          isDense: true,
          validator: validator,
          hint: hintText,
          isExpanded: isExpanded ?? true,
          onChanged: onChanged!,
          value: value,
          // iconSize: 30.0,
          icon: Padding(
            padding: const EdgeInsets.only(left: 00.0),
            child: Icon(
              Icons.arrow_drop_down,
              size: iconSize ?? 27,
              color: iconColor ?? MyColors.grey,
            ),
          ),
          items: list),
    );
  }
}
