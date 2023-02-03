import 'package:flutter/material.dart';

import '../utils/my_colors.dart';
import '../utils/my_images.dart';

class CustomAppBar extends StatefulWidget {
  final String? image;
  final String? leadingImage;
  final IconData? actionIcon;
  final VoidCallback? actionIconOnTap;
  final Color? leadingImageClr;
  final Color? imageClr;
  final IconData? iconData;
  final EdgeInsets? padding;
  final String? title;
  final Color? color;
  final Color? iconColor;
  final bool? skipp;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  const CustomAppBar(
      {Key? key,
      this.title,
      this.color,
      this.fontWeight,
      this.leadingImage,
      this.onTap,
      this.image,
      this.leadingImageClr,
      this.imageClr,
      this.actionIcon,
      this.actionIconOnTap,
      this.skipp,
      this.iconColor,
      this.iconData,
      this.padding})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(
        "${widget.title}",
        style: TextStyle(color: widget.color ?? MyColors.black),
      ),
      leading: GestureDetector(
          onTap: widget.onTap,
          child: GestureDetector(
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
                child: Image.asset(
                  widget.leadingImage ?? MyImages.user,
                  height: 30,
                  width: 30,
                ),
              ),
              /*ImageButton(
                      padding: EdgeInsets.only(
                          left: 20, top: 18, bottom: 11, right: 17),
                      image: widget.leadingImage ?? MyImages.arrowBack,
                      height: 20,
                      width: 20,
                      color: widget.leadingImageClr ?? MyColors.black,
                    ),*/
            ),
          )),
    );
  }
}
