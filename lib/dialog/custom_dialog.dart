// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_job/bloc/global_cubit/global_cubit.dart';
import 'package:insta_job/utils/my_images.dart';
import 'package:insta_job/widgets/custom_button/custom_img_button.dart';

import '../bloc/global_cubit/global_state.dart';
import '../utils/my_colors.dart';
import '../widgets/custom_cards/custom_common_card.dart';

class CustomDialog extends StatefulWidget {
  final VoidCallback? okOnTap;
  final VoidCallback? cancelOnTap;
  final String? desc;
  final String? desc1;
  final String? title;
  final Color? cancelTxtFontClr;
  final String? headerImagePath;
  final Color? descFontColor;
  final double? descFontSize;
  final bool showLoadingState;
  final String? confirmBtnLabel;
  final bool popAfterOnTap;
  CustomDialog({
    Key? key,
    this.okOnTap,
    this.desc,
    this.title,
    this.desc1,
    this.cancelOnTap,
    this.cancelTxtFontClr,
    this.headerImagePath,
    this.descFontColor,
    this.descFontSize,
    this.showLoadingState = false,
    this.confirmBtnLabel,
    this.popAfterOnTap = false
  }) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  // int? selectedIndex;
  int? index;
  String headerImagePath = ''; //TODO: revisit
  late final Color? descFontColor;
  late final double? descFontSize;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    headerImagePath = widget.headerImagePath ?? MyImages.logout;
    descFontColor = widget.descFontColor ?? MyColors.grey;
    descFontSize = widget.descFontSize ?? 14;
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    var selectedIndex = context.watch<GlobalCubit>().sIndex;
    return Dialog(
      insetPadding: EdgeInsets.all(55),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: MyColors.white,
      child: SizedBox(
        // height: size.height * 0.20,
        // width: size.width * 0.25,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,
            children: [
              ImageButton(
                image: headerImagePath,
                padding: EdgeInsets.zero,
                height: 60,
                width: 70,
              ),
              SizedBox(height: 10,),
              CommonText(text: widget.title ??"Are you sure!"),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CommonText(
                  text: widget.desc1 ?? "You want to LogOut",
                  fontColor: descFontColor,
                  fontSize: descFontSize,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: isLoading ? CircularProgressIndicator(
                    strokeWidth: 2,
                  ) : Text(""),
                ),
              ),
              BlocBuilder<GlobalCubit, InitialState>(builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCommonCard(
                      onTap:
                          () {
                            widget.cancelOnTap?.call();
                            index = 1;
                            print('INDEX1 ------  $selectedIndex');
                            context.read<GlobalCubit>().changeIndex(index);
                            Navigator.pop(context);
                          },
                      bgColor:
                          selectedIndex == 1 ? MyColors.blue : MyColors.white,
                      borderColor: MyColors.blue,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 30),
                        child: CommonText(
                          text: "No",
                          fontColor: selectedIndex == 1
                              ? MyColors.white
                              : MyColors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    CustomCommonCard(
                      onTap: widget.okOnTap != null ? () {
                        if (widget.showLoadingState) {
                          setState(() {
                            isLoading = true;
                          });
                        }
                        widget.okOnTap!();
                        if(widget.popAfterOnTap) {
                          Navigator.pop(context);
                        }
                      } :
                          () {
                            index = 2;
                            print('INDEX2 ------  $selectedIndex');
                            context.read<GlobalCubit>().changeIndex(index);
                            Navigator.pop(context);
                          },
                      bgColor:
                          selectedIndex == 2 ? MyColors.blue : MyColors.white,
                      borderColor: MyColors.blue,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 30),
                        child: CommonText(
                          text: widget.confirmBtnLabel ?? "Yes",
                          fontColor: selectedIndex == 2
                              ? MyColors.white
                              : MyColors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

buildDialog(context, Widget widget, {bool barrierDismissible = false}) {
  return showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return widget;
      });
}

class YearPickerDialog extends StatelessWidget {
  final ValueChanged<DateTime> onChange;
  const YearPickerDialog({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Year"),
      content: SizedBox(
        width: 300,
        height: 300,
        child: YearPicker(
          firstDate: DateTime(DateTime.now().year - 100, 1),
          lastDate: DateTime(DateTime.now().year),
          initialDate: DateTime.now(),
          selectedDate: DateTime.now(),
          onChanged: onChange,
        ),
      ),
    );
  }
}
