import 'package:flutter/material.dart';

import '../../../constants/app_decoration.dart';

class FormCard extends StatelessWidget {
  const FormCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: AppDecoration.primaryPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 0.3,
        ),
        borderRadius: AppDecoration.primaryRadiusBorder,
        boxShadow: AppDecoration.elevationContainer,
      ),
      child: child,
    );
  }
}
