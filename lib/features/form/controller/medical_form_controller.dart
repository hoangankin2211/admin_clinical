import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/service_indication_dialog.dart';

class MedicalFormController extends GetxController {
  void _showServiceDialog(Widget widget) {
    Get.dialog(widget);
  }

  void onChoiceServiceChange(bool value, int index) {
    if (value) {
      (rowServiceIndicationData.elementAt(index)['isSelected'] as RxBool)
          .value = value;
      resultIndicationRowData.add(
        {
          'id': "123",
          'name': 'Sieu am am dao',
          'departmentID': '63456',
          'amount': '2',
          'departmentCharge': 'Clinical Department',
          'pricePerUnit': '1.000.000',
          'amountPrice': '2.000.000'
        },
      );
    } else {
      (rowServiceIndicationData.elementAt(index)['isSelected'] as RxBool)
          .value = value;
      resultIndicationRowData.removeAt(0);
    }
    update(['resultService']);
  }

  List<Map<String, dynamic>> listIconAndLabel = [
    {
      'title': 'Service Indication',
      'icon': Icons.note_add_outlined,
      'dialog': const ServiceIndicationDialog()
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
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: () => _showServiceDialog(element['dialog']),
          icon: Icon(element['icon']),
          label: Text(
            element['title'],
            style: TextStyle(
              color: Colors.blueGrey[700],
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
      .toList();

  final List<Map<String, dynamic>> resultIndicationRowData = [
    {
      'id': "ID",
      'name': 'Name',
      'departmentID': 'Department ID',
      'amount': 'Amount',
      'departmentCharge': 'Department Charge',
      'pricePerUnit': 'Price Per Unit',
      'amountPrice': 'Amount Money'
    },
    // {
    //   'id': "123",
    //   'name': 'Sieu am am dao',
    //   'departmentID': '63456',
    //   'amount': '2',
    //   'departmentCharge': 'Clinical Department',
    //   'pricePerUnit': '1.000.000',
    //   'amountPrice': '2.000.000'
    // },
  ];

  final List<Map<String, dynamic>> rowServiceIndicationData = [
    {
      'isSelected': false.obs,
      'id': "ID",
      'name': 'Name',
      'departmentID': 'Department ID'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
    {
      'isSelected': false.obs,
      'id': "123",
      'name': 'Sieu am am dao',
      'departmentID': '63456'
    },
  ];
}
