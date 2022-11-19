import 'package:flutter/material.dart';

import '../app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? backgroundColor;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: (backgroundColor) ?? AppColors.primaryColor,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
