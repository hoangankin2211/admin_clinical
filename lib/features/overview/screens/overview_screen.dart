import 'package:admin_clinical/features/overview/controller/overview_controller.dart';
import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:admin_clinical/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/statistic_patient_widget.dart';

// ignore: must_be_immutable
class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});

  final overviewController = Get.put(OverviewController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Dr.Stephen',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline2,
            ),
            const Text(
              'Have a nice at great work',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  'Recenet Patient',
                  style: Theme.of(context).textTheme.headline2,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('View more',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemBuilder: (context, index) => CurrentPatientTableRow(
                  name: overviewController.newPatientTableData[index]['name']!,
                  id: overviewController.newPatientTableData[index]['id']!,
                  date: overviewController.newPatientTableData[index]['date']!,
                  gender: overviewController.newPatientTableData[index]
                      ['gender']!,
                  diseases: overviewController.newPatientTableData[index]
                      ['diseases']!,
                  status: overviewController.newPatientTableData[index]
                      ['status']!,
                  avt: 'images/fake_avatar.jpg',
                  color: index == 0 ? Colors.blueGrey[50]! : Colors.white,
                ),
                itemCount: overviewController.newPatientTableData.length,
              ),
            ),
            StatisticPatient(
              width: constraints.maxWidth * 0.22,
            ),
          ],
        ),
      );
    });
  }
}

// ignore: must_be_immutable

