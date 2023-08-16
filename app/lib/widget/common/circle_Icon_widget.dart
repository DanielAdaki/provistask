// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  double height;
  double width;
  double iconSize;
  Color? backgroundColor;
  Color? iconColor;
  String? messageTooltip;

  CircleIconButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      this.height = 50,
      this.width = 50,
      this.iconSize = 13,
      this.backgroundColor = const Color.fromARGB(255, 224, 224, 224),
      this.iconColor = Colors.black,
      this.messageTooltip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: iconColor,
        iconSize: iconSize,
      ),
    );
  }
}
