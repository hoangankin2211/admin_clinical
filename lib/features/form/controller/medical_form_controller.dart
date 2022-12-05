import 'package:admin_clinical/features/form/screens/medicine_indication_dialog.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/health_record.dart';
import '../../../models/medicine.dart';
import '../screens/service_indication_dialog.dart';

class MedicalFormController extends GetxController {
  void _showServiceDialog(Widget widget) {
    Get.dialog(widget);
  }

  final List<Map<String, dynamic>> examField = [
    {
      'title': 'Clinical Examination',
      'maxLine': 4,
      'textController': TextEditingController(),
    },
    {
      'title': 'Symptom',
      'maxLine': 4,
      'textController': TextEditingController(),
    },
    {
      'title': 'Diagnostic',
      'maxLine': 4,
      'textController': TextEditingController(),
    },
    {
      'title': 'Conclusion and Treatment',
      'maxLine': 4,
      'textController': TextEditingController(),
    },
  ];

  final List<Map<String, dynamic>> measureField = [
    {
      'title': 'Weight',
      'maxLine': 1,
      'textController': TextEditingController(),
    },
    {
      'title': 'Height',
      'maxLine': 1,
      'textController': TextEditingController(),
    },
    {
      'title': 'Heartbeat',
      'maxLine': 1,
      'textController': TextEditingController(),
    },
    {
      'title': 'Temperature',
      'maxLine': 1,
      'textController': TextEditingController(),
    },
    {
      'title': 'Blood Pressure',
      'maxLine': 1,
      'textController': TextEditingController(),
    },
    {
      'title': 'Allergy',
      'maxLine': 2,
      'textController': TextEditingController(),
    },
  ];

  Future<bool> createNewHealthRecord(BuildContext context) async {
    try {
      Map<String, dynamic> newRecord = HealthRecord(
        dateCreate: DateTime.now(),
        departmentId: 'departmentId',
        doctorId: 'doctorId',
        totalMoney: 0,
        allergy:
            (measureField[5]['textController'] as TextEditingController).text,
        bloodPressure: double.parse(
            (measureField[4]['textController'] as TextEditingController).text),
        clinicalExamination:
            (examField[0]['textController'] as TextEditingController).text,
        conclusionAndTreatment:
            (examField[3]['textController'] as TextEditingController).text,
        diagnostic:
            (examField[2]['textController'] as TextEditingController).text,
        heartBeat: double.parse(
            (measureField[2]['textController'] as TextEditingController).text),
        height: double.parse(
            (measureField[5]['textController'] as TextEditingController).text),
        id: (measureField[5]['textController'] as TextEditingController).text,
        medicines: null,
        note: (measureField[5]['textController'] as TextEditingController).text,
        services: null,
        symptom:
            (measureField[5]['textController'] as TextEditingController).text,
        temperature: double.parse(
            (measureField[5]['textController'] as TextEditingController).text),
        weight: double.parse(
            (measureField[5]['textController'] as TextEditingController).text),
      ).toMap();

      final response =
          await HealthRecordService.insertHealthRecord(newRecord, context);
      return true;
    } catch (e) {
      print('createNewHealthRecord: $e');
      return false;
    }
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
