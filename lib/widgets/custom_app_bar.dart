// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/my_colors.dart';
import '../utils/my_images.dart';

class CustomAppBar extends StatefulWidget {
  final String? leadingImage;
  final bool? centerTitle;
  final double? height;
  final double? width;
  final double? leadingWidth;
  final double? toolbarHeight;
  final String? title;
  final Color? color;
  final Widget? actions;
  final VoidCallback? onTap;
  const CustomAppBar({
    Key? key,
    this.title,
    this.color,
    this.leadingImage,
    this.onTap,
    this.height,
    this.width,
    this.actions,
    this.centerTitle,
    this.leadingWidth,
    this.toolbarHeight,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: widget.centerTitle ?? true,
      backgroundColor: Colors.white,
      leadingWidth: widget.leadingWidth ?? 56,
      toolbarHeight: widget.toolbarHeight ?? kToolbarHeight,
      title: Text(
        "${widget.title}",
        style: TextStyle(
            color: widget.color ?? MyColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 19),
      ),
      leading: GestureDetector(
          onTap: widget.onTap ??
              () {
                Navigator.pop(context);
              },
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: widget.leadingImage == ""
                ? SizedBox()
                : Image.asset(
                    widget.leadingImage ?? MyImages.backArrow,
                    height: widget.height ?? 30,
                    width: widget.width ?? 30,
                    color: widget.color,
                  ),
          )),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: widget.actions ?? SizedBox(),
        )
      ],
    );
  }
}
