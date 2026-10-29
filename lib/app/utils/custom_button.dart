import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_colors.dart';


class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Function() onPressed;
  final String title;
  String? icon;
  final double iconSize;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  CustomButton({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.onPressed,
    this.icon,
    this.backgroundColor = AppColors.inputFieldBorderColor,
    this.textColor = AppColors.white,
    this.borderColor = AppColors.inputFieldBorderColor,
    this.iconSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    EdgeInsetsGeometry edgeInsets = EdgeInsets.all(0);
    if (width == null || height == null) {
      edgeInsets = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0);
    }
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: edgeInsets,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(62),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(color: textColor),
              ),
              // _buildIcon(_theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(ThemeData theme) {
    if (icon != null) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
        ),
        child: SvgPicture.asset(
          icon ?? "",
          width: 20,
        ),
      );
    }

    return SizedBox();
  }
}
