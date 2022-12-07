import 'package:admin_clinical/features/medicine/screens/medicine_screen.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:admin_clinical/services/data_service/invoice_service.dart';
import 'package:admin_clinical/services/data_service/medicine_service.dart';
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

class OverviewController extends GetxController {
  final _auth = AuthService.instance;
  RxList<Doctor1> listDoctor = <Doctor1>[].obs;
  RxList<Medicine> listMedicine = <Medicine>[].obs;
  RxList<Data> dataPiechartMedicine = <Data>[].obs;
  RxList<Invoice> listInvoice = <Invoice>[].obs;
  User getUser() => _auth.user;

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

  @override
  void onInit() {
    super.onInit();
    listDoctor = DataService.instance.listDoctor;
    // listDoctor.sort((a, b) => a.)
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

  ///chart
}
