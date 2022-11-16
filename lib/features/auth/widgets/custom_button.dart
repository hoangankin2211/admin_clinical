import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
  });
  final String title;
  final Color? color;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.primaryColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: AppDecoration.primaryRadiusBorder,
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
