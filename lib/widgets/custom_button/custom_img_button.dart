import 'package:flutter/cupertino.dart';

class ImageButton extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Function()? onTap;
  const ImageButton(
      {Key? key,
      this.image,
      this.height,
      this.width,
      this.onTap,
      this.padding,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Image.asset(
          "$image",
          height: height ?? 24,
          width: width ?? 24,
          color: color,
        ),
      ),
    );
  }
}
