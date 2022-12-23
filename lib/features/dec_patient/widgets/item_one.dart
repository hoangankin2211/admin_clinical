import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class Item11 extends StatelessWidget {
  final String title;
  final IconData headerIcon;
  const Item11({
    Key? key,
    required this.title,
    required this.headerIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.primaryColor.withOpacity(0.2)),
      child: Row(children: [
        Icon(headerIcon, color: AppColors.primaryColor),
        Text(
          ' $title',
          style: const TextStyle(
            color: AppColors.headline1TextColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        )
      ]),
    );
  }
}
