import 'dart:math';

import 'package:admin_clinical/features/clinical_room/screens/clinical_room_screen.dart';
import 'package:admin_clinical/features/medicine/screens/medicine_screen.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/invoice_service.dart';
import 'package:admin_clinical/services/data_service/medicine_service.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../constants/app_colors.dart';
import '../../../models/doctor.dart';
import '../../../models/invoice.dart';
import '../../../models/medicine.dart';
import '../../../models/user.dart';
import '../../../services/auth_service/auth_service.dart';
import '../screens/overview_screen.dart';
import 'date_picker_controller.dart';

class OverviewController extends GetxController {
  final _auth = AuthService.instance;
  RxList<Doctor1> listDoctor = <Doctor1>[].obs;
  RxList<Medicine> listMedicine = <Medicine>[].obs;
  RxList<Data> dataPiechartMedicine = <Data>[].obs;
  RxList<Invoice> listInvoice = <Invoice>[].obs;
  User getUser() => _auth.user;
  DateRangePicker dateControllerTurnover = DateRangePicker(
      selectDateTemp1: DateTime.now(),
      selectDateTemp2: DateTime.now(),
      dateController: DateRangePickerController(),
      startDate: DateTime.now().obs,
      finishDate: DateTime.now().obs,
      allDateBetWeen: <DateTime>[].obs);
  DateRangePicker dateControllerPatient = DateRangePicker(
      selectDateTemp1: DateTime.now(),
      selectDateTemp2: DateTime.now(),
      dateController: DateRangePickerController(),
      startDate: DateTime.now().obs,
      finishDate: DateTime.now().obs,
      allDateBetWeen: <DateTime>[].obs);

  //chart

  RxList<Map<String, dynamic>> data_invoice_chart =
      <Map<String, dynamic>>[].obs;
  RxInt maxOfListInvoice = 0.obs;

  RxList<Map<String, dynamic>> data_patient_chart =
      <Map<String, dynamic>>[].obs;
  RxInt maxOfListPatient = 0.obs;

  fetchDataPatientChart() {
    data_patient_chart.clear();
    data_patient_chart.value = [
      for (var item in dateControllerPatient.allDateBetWeen)
        {
          'id': item.weekday,
          'Male': 0,
          'Female': 0,
        }
    ];
    data_patient_chart.sort((a, b) => a['id'].compareTo(b['id']));
    for (var item in HealthRecordService.listHealthRecord.values) {
      if (dateControllerPatient.checkDateInList(
          item.dateCreate, dateControllerPatient.allDateBetWeen)) {
        data_patient_chart[item.dateCreate.weekday - 1]['Male'] += 1;
      }
    }
    data_patient_chart[6]['id'] = 0;
    data_patient_chart.sort((a, b) => a['id'].compareTo(b['id']));
    maxOfListPatient.value = [
      for (var item in data_patient_chart)
        item['Male'] > item['Female'] ? item['Male'] : item['Female']
    ].reduce((v, e) => v > e ? v : e);
  }

  fetchDataInvoiceChart() {
    data_invoice_chart.clear();
    print(DateTime.now().weekday);
    data_invoice_chart.value = [
      for (var item in dateControllerTurnover.allDateBetWeen)
        {
          'id': item.weekday,
          'data': 0,
        }
    ];
    data_invoice_chart.sort((a, b) => a['id'].compareTo(b['id']));
    for (var data in InvoiceService.instance.listInvoice) {
      if (dateControllerTurnover.checkDateInList(
          data.createTime, dateControllerTurnover.allDateBetWeen)) {
        data_invoice_chart[data.createTime.weekday - 1]['data'] += data.amount;
      }
    }
    data_invoice_chart[6]['id'] = 0;
    data_invoice_chart.sort((a, b) => a['id'].compareTo(b['id']));

    // print(data_invoice_chart);
    maxOfListInvoice.value = [for (var item in data_invoice_chart) item['data']]
        .reduce((v, e) => v > e ? v : e);
  }

  List<Color> listColor = [
    Colors.green,
    Colors.yellow,
    AppColors.primaryColor,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.grey,
  ];

  RxInt sum = [
    for (var item in MedicineService.instance.listMedicine) item.amount
  ].reduce((previousValue, element) => previousValue + element).obs;

  List<Data> data1 = [
    Data(
        name: 'Thuoc 1',
        percents: (10 / 80 * 100).round().toDouble(),
        color: Colors.green,
        imagePath: 'assets/images/doctor1.png'),
    Data(
      name: 'Thuoc 2',
      percents: (10 / 80 * 100).round().toDouble(),
      color: AppColors.primaryColor,
      imagePath: 'assets/images/doctor2.png',
    ),
    Data(
      name: 'Thuoc 3',
      percents: (2 / 80 * 100).round().toDouble(),
      color: Colors.yellow,
      imagePath: 'assets/images/doctor3.png',
    ),
    Data(
      name: 'Thuoc 4',
      percents: (18 / 80 * 100).round().toDouble(),
      color: Colors.red,
      imagePath: 'assets/images/doctor3.png',
    ),
    Data(
      name: 'Thuoc 5',
      percents: (17 / 80 * 100).round().toDouble(),
      color: Colors.purple,
      imagePath: 'assets/images/doctor3.png',
    ),
    Data(
      name: 'Thuoc 6',
      percents: (3 / 80 * 100).round().toDouble(),
      color: Colors.pink,
      imagePath: 'assets/images/doctor3.png',
    ),
    Data(
      name: 'Thuoc 7',
      percents: (5 / 80 * 100).round().toDouble(),
      color: Colors.grey,
      imagePath: 'assets/images/doctor3.png',
    ),
    Data(
      name: 'Thuoc 7',
      percents: (15 / 80 * 100).round().toDouble(),
      color: Colors.grey,
      imagePath: 'assets/images/doctor3.png',
    ),
  ];
  List<Map<String, String>> newPatientTableData = [
    {
      'name': 'Patient Name',
      'id': 'Patient Id',
      'date': 'Date',
      'gender': 'Gender',
      'diseases': 'Diseases',
      'status': 'Status'
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120483',
      'date': '13/11/2022',
      'gender': 'male',
      'diseases': 'Diabetes',
      'status': 'Out-Patient',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120484',
      'date': '13/11/2022',
      'gender': 'male',
      'diseases': 'Diabetes',
      'status': 'Out-Patient',
    },
    {
      'name': 'Hoang Ankin',
      'id': '20120485',
      'date': '13/11/2022',
      'gender': 'male',
      'diseases': 'Diabetes',
      'status': 'Out-Patient',
    },
  ];

  List<Map<String, dynamic>> listDataSurvey = [
    {
      "title": "Total Doctor",
      "icon": Icons.person,
      "color": Colors.blue,
      "data": 0.0,
    },
    {
      "title": "New Patient",
      "icon": Icons.people,
      "color": Colors.orange,
      "data": 0,
    },
    {
      "title": "Clinical Room",
      "icon": Icons.medical_services_outlined,
      "color": Colors.yellow,
      "data": 5,
    },
    {
      "title": "Turnover",
      "icon": Icons.attach_money_outlined,
      "color": const Color.fromARGB(255, 69, 239, 174),
      "data": 0,
    },
    {
      "title": "Pending Invoice",
      "icon": Icons.money_off_csred_outlined,
      "color": Colors.red[300],
      "data": 0,
    },
  ];
  @override
  void onInit() {
    super.onInit();
    listDoctor = DataService.instance.listDoctor;
    listInvoice = InvoiceService.instance.listInvoice;
    listMedicine = MedicineService.instance.listMedicine;

    sum.value = [
      for (var item in MedicineService.instance.listMedicine) item.amount
    ].reduce((previousValue, element) => previousValue + element);

    listMedicine.sort((a, b) => a.amount.compareTo(b.amount));

    dataPiechartMedicine.value = [
      for (int i = 0; i < MedicineService.instance.listMedicine.length; i++)
        Data(
            imagePath: 'assets/images/doctor2.png',
            name: MedicineService.instance.listMedicine[i].name,
            percents: (MedicineService.instance.listMedicine[i].amount /
                    sum.value *
                    100)
                .round()
                .toDouble(),
            color: listColor[i % 7]),
    ];

    for (var element in listDataSurvey) {
      if (element['title'] == "Total Doctor") {
        element['data'] = DataService.instance.listDoctor.length;
      } else if (element['title'] == "New Patient") {
        HealthRecordService.listHealthRecord.forEach((key, value) {
          if (value.dateCreate.day == DateTime.now().day &&
              value.dateCreate.month == DateTime.now().month &&
              value.dateCreate.year == DateTime.now().year) {
            element['data']++;
          }
        });
      } else if (element['title'] == "Clinical Room") {
      } else if (element['title'] == "Turnover") {
        for (var invoice in InvoiceService.instance.listInvoice) {
          if (invoice.createTime.day == DateTime.now().day &&
              invoice.createTime.month == DateTime.now().month &&
              invoice.createTime.year == DateTime.now().year) {
            element['data'] += invoice.amount;
          }
        }
      } else if (element['title'] == "Pending Invoice") {
        element['data'] = listInvoice.length;

        for (var invoice in listInvoice) {
          if (invoice.status == 0) {
            element['data']--;
          }
        }
      }
    }
    dateControllerTurnover.getStartDateAndFinishDate();
    print(dateControllerTurnover.allDateBetWeen);
    fetchDataInvoiceChart();

    dateControllerPatient.getStartDateAndFinishDate();
    fetchDataPatientChart();
  }

  List<Data> getDataPieChartMedicine() => [
        for (int i = 0; i < MedicineService.instance.listMedicine.length; i++)
          Data(
              imagePath: 'assets/images/doctor2.png',
              name: MedicineService.instance.listMedicine[i].name,
              percents: (MedicineService.instance.listMedicine[i].amount /
                      sum.value *
                      100)
                  .round()
                  .toDouble(),
              color: listColor[i % 7]),
      ];
}
