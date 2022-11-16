import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class DoctorMainScreen extends StatelessWidget {
  const DoctorMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.headline1TextColor.withOpacity(0.2),
                    blurRadius: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(),
          ),
        ],
      ),
    );
  }
}
