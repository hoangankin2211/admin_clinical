import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_decoration.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    this.padding,
    this.style,
  });

  final Function() onPressed;
  final Widget label;
  final Widget icon;
  final EdgeInsets? padding;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: icon,
      label: label,
      style: style ??
          TextButton.styleFrom(
            padding: padding ??
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: AppDecoration.primaryRadiusBorder),
          ),
      onPressed: onPressed,
    );
  }
}
