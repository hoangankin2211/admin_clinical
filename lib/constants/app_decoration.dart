import 'package:flutter/material.dart';

class AppDecoration {
  static final primaryRadiusBorder = BorderRadius.circular(10);
  static const spaceBetweenElementForm = SizedBox(height: 50);
  static final elevationContainer = [
    BoxShadow(
        offset: const Offset(0, 1), color: Colors.grey[200]!, blurRadius: 2)
  ];
}

class AppWidget {
  static const List<Map<String, dynamic>> listNavigatorTab = [
    {
      'label': 'Overview',
      'icon': Icons.dashboard_outlined,
    },
    {
      'label': 'Patient',
      'icon': Icons.person_outline,
    },
    {
      'label': 'Payment',
      'icon': Icons.payment_outlined,
    },
    {
      'label': 'Medical Form',
      'icon': Icons.note_add_outlined,
    },
    {
      'label': 'Setting',
      'icon': Icons.settings_outlined,
    },
  ];
}
