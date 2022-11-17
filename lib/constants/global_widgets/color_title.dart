import 'package:flutter/material.dart';

import '../app_colors.dart';

class ColorTitle extends StatelessWidget {
  final String title;
  final Color color;
  const ColorTitle({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          width: 15,
          height: 15,
        ),
        Text(
          " $title",
          style: const TextStyle(
              color: AppColors.primarySecondColor,
              fontWeight: FontWeight.bold,
              fontSize: 15.0),
        )
      ],
    );
  }
}
