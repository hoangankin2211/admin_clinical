import 'package:admin_clinical/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AppDecoration {
  static final primaryRadiusBorder = BorderRadius.circular(10);
  static const spaceBetweenElementForm = SizedBox(height: 50);
  static final elevationContainer = [
    BoxShadow(
        offset: const Offset(0, 1), color: Colors.grey[200]!, blurRadius: 2)
  ];

  static final primaryBorder = Border.all(
    color: Colors.blue[100]!,
    width: 1,
  );

  static const primarySecondBorder = BorderSide(
    color: Colors.blueGrey,
    width: 0.3,
  );

  static final primaryDecorationContainer = BoxDecoration(
    color: Colors.white,
    border: Border.all(
      color: Colors.grey,
      width: 0.2,
    ),
    borderRadius: AppDecoration.primaryRadiusBorder,
  );
  static final primaryDecorationContainer1 = BoxDecoration(
    color: Colors.white,
    border: Border.all(
      color: Colors.grey,
      width: 0.2,
    ),
    boxShadow: const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 7.0,
      )
    ],
    borderRadius: AppDecoration.primaryRadiusBorder,
  );
  static const primaryPadding = EdgeInsets.all(15);
}

class AppWidget {
  static const primaryDivider = Divider(
    height: 3,
    color: AppColors.primarySecondColor,
    thickness: 0.2,
  );
}
