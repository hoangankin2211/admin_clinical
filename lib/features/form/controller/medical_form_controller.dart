import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalFormController extends GetxController {
  void _showServiceDialog(Widget widget) {
    Get.dialog(widget);
  }

  List<Map<String, dynamic>> listIconAndLabel = [
    {
      'title': 'Service Indication',
      'icon': Icons.note_add_outlined,
      'dialog': Dialog(
        child: Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
            color: Colors.yellow,
          ),
        ),
      ),
    },
    {
      'title': 'Medicine Indication',
      'icon': Icons.note_add_outlined,
      'dialog': Dialog(
        child: Container(
          height: 300,
          width: 300,
          decoration: const BoxDecoration(
            color: Colors.red,
          ),
        ),
      ),
    },
  ];

  late final List<Widget> listServiceChoice = listIconAndLabel
      .map(
        (element) => TextButton.icon(
          onPressed: () => _showServiceDialog(element['dialog']),
          icon: Icon(element['icon']),
          label: Text(
            element['title'],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
      .toList();
}
