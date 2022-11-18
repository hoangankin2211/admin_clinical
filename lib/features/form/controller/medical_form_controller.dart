import 'dart:ui';

import 'package:admin_clinical/features/form/screens/medical_examination_tab.dart';
import 'package:admin_clinical/features/form/screens/medicine_indication_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/medicine.dart';
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
      'dialog': MedicineIndicationDialog(),
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

  final List<Medicine> medicines = [
    Medicine(
      id: UniqueKey().toString(),
      name: 'nacl 0.9 500ml',
      price: 10000,
      provider: 'United State',
      unit: '1 box',
      type: 'Headache',
    ),
    Medicine(
      id: UniqueKey().toString(),
      name: 'nacl 0.9 500ml',
      price: 10000,
      provider: 'United State',
      unit: '1 box',
      type: 'Headache',
    ),
    Medicine(
      id: UniqueKey().toString(),
      name: 'nacl 0.9 500ml',
      price: 10000,
      provider: 'United State',
      unit: '1 box',
      type: 'Headache',
    ),
    Medicine(
      id: UniqueKey().toString(),
      name: 'nacl 0.9 500ml',
      price: 10000,
      provider: 'United State',
      unit: '1 box',
      type: 'Headache',
    ),
    Medicine(
      id: UniqueKey().toString(),
      name: 'nacl 0.9 500ml',
      price: 10000,
      provider: 'United State',
      unit: '1 box',
      type: 'Headache',
    ),
  ];

  final Rx<List<Medicine>> listMedicineIndicator = Rx<List<Medicine>>([]);

  void onChoiceMedicineChange(bool value, String id) {
    int? index;
    for (int i = 0; i < medicines.length; i++) {
      if (medicines.elementAt(i).id.compareTo(id) == 0) {
        index = i;
        break;
      }
    }
    if (index == null) return;
    Medicine temp = medicines.elementAt(index);
    if (value) {
      listMedicineIndicator.value.add(Medicine(
        type: temp.type,
        id: temp.id,
        name: temp.name,
        price: temp.price,
        provider: temp.provider,
        unit: temp.unit,
      ));
      print("added");
    } else {
      listMedicineIndicator.value
          .removeWhere((element) => element.id.compareTo(temp.id) == 0);
    }
    print(medicines.length);
    update(['ResultMedicineTableRow']);
  }

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
