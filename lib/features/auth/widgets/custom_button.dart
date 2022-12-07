import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.enable,
    this.check = false,
  });
  final bool? enable;
  final String title;
  final Color? color;
  final Function() onPressed;
  final bool? check;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enable ?? true ? onPressed : () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.primaryColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: AppDecoration.primaryRadiusBorder,
        ),
      ),
      child: (check == false)
          ? Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
    );
  }
}
