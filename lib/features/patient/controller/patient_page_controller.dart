import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PatientPageController extends GetxController {
  final Rx<List<Map<String, String>>> data = Rx<List<Map<String, String>>>([
    {
      'name': 'Patient Name',
      'id': 'Id',
      'date': 'Date',
      'gender': 'Gender',
      'diseases': 'Diseases',
      'status': 'Status',
      'payment': 'Payment',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120481',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120482',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120483',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120484',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120485',
      'date': DateFormat().add_yMd().format(DateTime.now()).toString(),
      'gender': 'Male',
      'diseases': 'Nothing',
      'status': 'Out-Patient',
      'payment': 'Private Cash',
    },
  ]);

  void applyEntries(int value) {
    if (value >= 1 && value <= data.value.length - 1) {
      numberOfEntries.value = value + 1;
    }
  }

  void removeEntries(int index) {
    numberOfEntries.value--;
    data.value.removeAt(index);
  }

  late var numberOfEntries =
      (data.value.length - 1 > 5 ? 6 : data.value.length).obs;
}
